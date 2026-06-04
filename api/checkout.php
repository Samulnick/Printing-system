<?php
/**
 * Checkout API - Process Orders
 * Handles order creation, validation, and database storage
 */

header('Content-Type: application/json');

require_once 'config.php';

// Get the action
$action = $_POST['action'] ?? '';

if ($action === 'create_order') {
    createOrder();
} else {
    sendResponse(false, 'Invalid action');
}

/**
 * Create and process order
 */
function createOrder() {
    global $conn;

    // Validate required fields
    $required_fields = ['fullName', 'email', 'phone', 'address', 'city', 'state', 'paymentMethod', 'cart', 'total'];
    
    foreach ($required_fields as $field) {
        if (empty($_POST[$field])) {
            sendResponse(false, "Field '{$field}' is required");
            return;
        }
    }

    // Get and validate data
    $fullName = sanitize($_POST['fullName']);
    $email = sanitize($_POST['email']);
    $phone = sanitize($_POST['phone']);
    $address = sanitize($_POST['address']);
    $city = sanitize($_POST['city']);
    $state = sanitize($_POST['state']);
    $paymentMethod = sanitize($_POST['paymentMethod']);
    $subtotal = floatval($_POST['subtotal']);
    $tax = floatval($_POST['tax']);
    $shipping = floatval($_POST['shipping']);
    $total = floatval($_POST['total']);

    // Parse cart items
    $cartItems = json_decode($_POST['cart'], true);
    if (!is_array($cartItems) || empty($cartItems)) {
        sendResponse(false, 'Cart is empty');
        return;
    }

    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        sendResponse(false, 'Invalid email address');
        return;
    }

    // Validate phone number
    if (!preg_match('/^[0-9+\-\s()]+$/', $phone)) {
        sendResponse(false, 'Invalid phone number');
        return;
    }

    // Generate unique order ID
    $order_id = generateOrderId();

    // Start transaction
    $conn->begin_transaction();

    try {
        // Insert order into orders table
        $sql_order = "INSERT INTO orders (order_id, customer_name, email, phone, address, city, state, payment_method, subtotal, tax, shipping, total, status, created_at) 
                      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW())";
        
        $stmt_order = $conn->prepare($sql_order);
        if (!$stmt_order) {
            throw new Exception('Error preparing statement: ' . $conn->error);
        }

        $stmt_order->bind_param(
            'ssssssssddds',
            $order_id,
            $fullName,
            $email,
            $phone,
            $address,
            $city,
            $state,
            $paymentMethod,
            $subtotal,
            $tax,
            $shipping,
            $total
        );

        if (!$stmt_order->execute()) {
            throw new Exception('Error inserting order: ' . $stmt_order->error);
        }

        $stmt_order->close();

        // Insert order items
        $sql_item = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity, subtotal) 
                     VALUES (?, ?, ?, ?, ?, ?)";
        
        $stmt_item = $conn->prepare($sql_item);
        if (!$stmt_item) {
            throw new Exception('Error preparing statement: ' . $conn->error);
        }

        foreach ($cartItems as $item) {
            $product_id = isset($item['id']) ? intval($item['id']) : 0;
            $product_name = sanitize($item['name']);
            $price = floatval($item['price']);
            $quantity = intval($item['quantity']);
            $item_subtotal = $price * $quantity;

            $stmt_item->bind_param(
                'sidsid',
                $order_id,
                $product_id,
                $product_name,
                $price,
                $quantity,
                $item_subtotal
            );

            if (!$stmt_item->execute()) {
                throw new Exception('Error inserting order item: ' . $stmt_item->error);
            }
        }

        $stmt_item->close();

        // Commit transaction
        $conn->commit();

        // Send success response
        sendResponse(true, 'Order placed successfully', [
            'order_id' => $order_id,
            'message' => 'Your order has been received. Check your email for confirmation.'
        ]);

        // Send confirmation email
        sendConfirmationEmail($email, $fullName, $order_id, $cartItems, $total);

    } catch (Exception $e) {
        // Rollback transaction on error
        $conn->rollback();
        sendResponse(false, 'Error processing order: ' . $e->getMessage());
    }
}

/**
 * Generate unique order ID
 * Format: ORD-TIMESTAMP-RANDOMSTRING
 */
function generateOrderId() {
    return 'ORD-' . time() . '-' . strtoupper(bin2hex(random_bytes(4)));
}

/**
 * Sanitize input data
 */
function sanitize($data) {
    global $conn;
    return $conn->real_escape_string(trim(strip_tags($data)));
}

/**
 * Send JSON response
 */
function sendResponse($success, $message, $data = null) {
    $response = [
        'success' => $success,
        'message' => $message
    ];

    if ($data) {
        $response = array_merge($response, $data);
    }

    echo json_encode($response);
    exit;
}

/**
 * Send confirmation email
 */
function sendConfirmationEmail($email, $name, $order_id, $items, $total) {
    $subject = 'Order Confirmation - PrintPro';
    
    $message = "
    <html>
    <head>
        <style>
            body { font-family: Arial, sans-serif; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background-color: #27ae60; color: white; padding: 20px; text-align: center; border-radius: 4px; }
            .content { margin: 20px 0; }
            .order-details { background-color: #f9f9f9; padding: 15px; margin: 20px 0; border-radius: 4px; }
            .item { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #ddd; }
            .total { font-weight: bold; font-size: 18px; color: #27ae60; }
            .footer { text-align: center; color: #666; margin-top: 30px; font-size: 12px; }
        </style>
    </head>
    <body>
        <div class='container'>
            <div class='header'>
                <h1>Order Confirmation</h1>
            </div>
            
            <div class='content'>
                <p>Dear " . htmlspecialchars($name) . ",</p>
                <p>Thank you for your order! We've received your purchase and will process it shortly.</p>
                
                <div class='order-details'>
                    <h3>Order Details</h3>
                    <p><strong>Order ID:</strong> " . htmlspecialchars($order_id) . "</p>
                    <p><strong>Order Date:</strong> " . date('F j, Y H:i:s') . "</p>
                    
                    <h3>Items</h3>";
                    
                    foreach ($items as $item) {
                        $message .= "<div class='item'>
                            <span>" . htmlspecialchars($item['name']) . " x " . $item['quantity'] . "</span>
                            <span>₦" . number_format($item['price'] * $item['quantity'], 2) . "</span>
                        </div>";
                    }
                    
                    $message .= "<div class='item total' style='border-bottom: 2px solid #27ae60;'>
                        <span>Total</span>
                        <span>₦" . number_format($total, 2) . "</span>
                    </div>
                </div>
                
                <p>You will receive another email when your order ships. You can track your package using the tracking number provided in that email.</p>
                
                <p>If you have any questions about your order, please contact us at:</p>
                <p>Email: info@printpro.com<br>
                   Phone: +234 (0) 123 456 789</p>
                
                <p>Thank you for choosing PrintPro!</p>
            </div>
            
            <div class='footer'>
                <p>&copy; 2026 PrintPro. All rights reserved.</p>
            </div>
        </div>
    </body>
    </html>";

    $headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-type: text/html; charset=UTF-8" . "\r\n";
    $headers .= "From: info@printpro.com" . "\r\n";

    // In production, uncomment the line below to send actual emails
    // mail($email, $subject, $message, $headers);

    // Log email for testing purposes
    error_log("Email sent to: $email\nSubject: $subject\nMessage: $message");
}

?>
