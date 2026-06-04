-- =========================================
-- CREATE DATABASE
-- =========================================
CREATE DATABASE IF NOT EXISTS printing_shop;
USE printing_shop;

-- =========================================
-- CATEGORIES TABLE
-- =========================================
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- =========================================
-- PRODUCTS TABLE
-- =========================================
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) DEFAULT 0.00,
    image VARCHAR(255) DEFAULT NULL,
    description TEXT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id)
    REFERENCES categories(id)
    ON DELETE CASCADE
);

-- =========================================
-- INSERT CATEGORIES
-- =========================================
INSERT INTO categories (name) VALUES
('Business Cards'),
('Souvenirs'),
('Printing & stationery'),

-- =========================================
-- INSERT PRODUCTS
-- =========================================
INSERT INTO products (product_name, slug, category_id) VALUES

-- =========================================
-- BUSINESS CARDS
-- =========================================
('Painted Edge Cards', 'Painted-Edge-Business-Card.html', '20000', 'img/Edge_Painted_Business_Card-425.jpg', 'Painted edge card, is slightly thicker than a standard credit card, these printed luxury business cards look and feel exceptional', 1),
('Uncoated Cards', 'Uncoated-Business-Card.html', '14500', 'img/paper-bag-memo-1.jpg', 'Uncoated business card is more than just a simple piece of paper! The natural, textured surface of an uncoated card adds a unique touch', 1),
('Laminated Cards', 'Laminated-Business-Card.html', '11500', 'img/laminated-BC-4-880.jpg', 'Laminated business cards have a strong and lasting impressions. The added durability ensures that the card maintains its quality even after being carried around or exchanged frequently', 1),
('Frosted Plastic Cards', 'frosted-plastic-business-cards.html', '30500', 'img/Plastic_Business_Card2-177.jpg', 'Plastic business cards offer a sleek and modern look that stands out from traditional paper varieties. These are a type of business cards that feature a frosted or translucent finish', 1),
('Classic Cards', 'Classic-business-cards.html', '10500', 'img/Classic-business-cards-160-2.jpg', 'Classic business cards are printed on cardstock paper bearing information about a company, business or an individual. Generally, it includes the logo, name of company or business affiliation, contact information and social media icons', 1),
('Duplex Cards', 'Double-thick-duplex-cards.html', '25000', 'img/Double-thick-duplex-cards-1004-2.png', 'Our double thick duplex cards are made with high-quality materials that promise durability and a premium tactile experience', 1),
('Folded Cards', 'folded-Business-Card.html', '19500', 'img/Folded Business Cards.jpg', 'Folded business cards are best used as appointment cards, mini portfolio cards that showcase a range of services and products, and offer a versatile and sophisticated option for businesses looking to make a lasting impression', 1),
('Kraft Paper Cards', 'Kraft-paper-Business-Card.html', '30500', 'img/kraft-paper-business-card-mockup-766.jpg', 'With brown kraft business cards, get that natural organic and simple design-look of your brand and stay away from traditional styles. The thickness and durability makes cards perfect for carrying them at all times and impressing new connections', 1),
('Linen Texture Cards', 'Linen-texture-Business-Card.html', '30500', 'img/kraft-paper-business-card-mockup-766.jpg', 'linen business cards stand out with their classy and natural appearance. The surface texture gives a slightly crosshatch woven feel, which makes them easy to write on with pencil or pen', 1),
('Pearl Cards', 'Pearl-Business-Card.html', '17500', 'img/PearlBC-4-600x500-767.jpg', 'Pearl business cards are ideal for use in cosmetics and skincare industries, beauty salons and spas, premium jewelry productions, and other sectors alike', 1),
('Plastic Cards', 'plastic-Business-Card.html', '20500', 'img/Plastic_Business_Card2-177.jpg',  'A plastic business card feels and looks like a credit card, but it is thinner and customizable. A 16pt paper card is always a great choice for a classical card but if you want to leave an impression it is best to go with something different', 1),
('Raised Foil Cards', 'Raised-foil-Business-Card.html', '25500', 'img/Foil_Stamped_Business_Card-155.jpg', 'Foil business cards are particularly suitable for businesses and professionals in industries where image and first impressions are paramount. This includes luxury brands, high-end retailers, real estate professionals',1),
('Round Cards', 'Round-Business-Card.html', '29500', 'img/round-business-card-973-1.jpg', 'Round business cards are stylish alternatives to traditional rectangular business cards. They feature a circular shape, which sets them apart from the standard designs and adds a unique visual appeal', 1),
('Silk Cards', 'Silk-Business-Card.html', '25000', 'Silk business cards are premium business cards known for their smooth and silky texture, which sets them apart from standard cardstock cards. These cards are designed to convey sophistication and professionalism', 1),
('Soft Touch Cards', 'Soft-touch-business card.html', '30000', 'img/soft touch lamination-693.jpg', 'Soft Touch Business Cards are a premium type of business card known for their unique texture and luxurious feel. These business cards are designed using a special printing process that creates a velvety, smooth, and tactile surface', 1),
('Square Cards', 'Square-business card.html', '22000', 'img/square-business-card-975-1.jpg', 'Square Business Cards are a modern take on regular cards. They stand out with their unique shape and contemporary design. Made with good materials and printed carefully, these cards are not just for sharing contact details – they show your style and professionalism', 1),
('Triple Layered Cards', 'Tripple-layered-business card.html', '40500', 'img/Triple_Layered_Business_Card-448.jpg', 'Triple layer business cards are a premium and distinctive type of business card known for their unique construction. These cards consist of three layers of premium paper, creating a thicker and more substantial card', 1),
('Ultra Thick Cards', 'Ultra-thick-business card.html', '50000', 'Thick business cards are a premium option, designed with extra weight and thickness to create a lasting and memorable impression. Known for their substantial feel and impressive presence, these cards immediately convey a sense of quality and professionalism', 1),

-- =========================================
-- SOUVENIRS
-- =========================================
('Binded Jotter', 'Binded-cover jotter.html', '3500', 'img/binded-cover-jotter-1.jpg', 'Our A5 Perfect Binded Jotter Notepad is great for birthday souvenirs, wedding souvenirs, burial or funeral souvenirs, convocation & graduation jotters, Corporate gift items and events souvenirs', 2),
('Custom Paper Bag', 'custom-Paper-bag.html', '10000', 'img/paper-bag-1.jpg', 'Our quality Paper Bags are great for birthday souvenirs, wedding souvenirs, burial or funeral souvenirs, convocation & graduation jotters, Corporate gift items and events souvenirs', 2),
('Custom Hand Fan', 'custom-branded handfan.html', '150000', 'img/hand-fan-1.jpg', 'Customized PVC plastic hand fan are affordable, lightweight, and portable, making them easy to take with you wherever you go. So if you’re looking for an efficient way to beat the heat this summer while also saving money on your energy bill', 2),
('Custom Button Pins', 'custom-button-pin.html', '10000', 'img/Button-pins-1063-2.jpg', 'Each pin is made from high-quality silver metal, ensuring they are lightweight, sturdy, and resistant to wear. A polished gloss coating enhances colors, making your design pop while adding a sleek and professional appearance', 2),
('Courier Nylon Bags', 'currir-bag-nylon.html', '45000', 'img/Nylon-bag-2.jpg', 'Our courier delivery packaging nylon bag is great for packaging your product such as Hair, Clothe, T-shirts and lots more', 2),
('Embroidery Cap', 'monogram-embroidery-cap.html', '2000', 'img/branded-custom-quality-company-logo-branded-cap-monogram-embroidery-design-and-printing-in-lagos-abuja-nigeria.jpeg', Our custom Monogram design is suitable for all kinds of caps', 2),
('Embroidery Towel', 'embroidery-towel.html', '3500', 'img/customized-monogram-embroidery-towel-printing-in-lagos-nigeria.jpeg', 'Our custom Monogram design is suitable on Towels of all sizes such as bath towel, travel towel, face towel and related materials', 2),
('T-shirt Branding', 'T-shirt-printing.html', '5500', 'img/direct-to-film-982-2.jpg', 'Our custom T-shirt printing is suitable for your brand, events, companies, funerals and styles', 2),
('Desk Calendar', 'Desk-calendar.html', '150500', 'img/table-calendar-2.jpg', 'Each desk calendar is designed with a stable pop-up base, available in 18PT coated stock, 160# uncoated stock, or a rigid white board. These options ensure that your calendar remains sturdy, stylish, and durable, even in high-traffic environments like office desks and customer counters', 2),
('Soft-cover Jotter', 'Jotter-softcover.html', '2500', 'img/joter-1.jpg', 'Our A5 Wire O, Soft-cover Jotter notepad is great for birthday souvenirs, wedding souvenirs, burial or funeral souvenirs, convocation & graduation jotters, Corporate gift items and events souvenirs', 2),
('Hard-cover Jotter', 'Jotter-hardcover.html', '3500', 'img/jotter-softcover-1.jpg', 'Our A5 Wire O, Hard-cover Jotter notepad is great for birthday souvenirs, wedding souvenirs, burial or funeral souvenirs, convocation & graduation jotters, Corporate gift items and events souvenirs', 2),
('Custom Key-holder', 'custom-keyholder-printing.html', '130000', 'img/key-holder-2.jpg', 'Domed Metal Key Holders & Openers are perfect for party gifts, souvenirs and general promotional gifts. It serves as a Billboard on the move for your company', 2),
('Custom Diary', 'custom-dairy with box.html', '10500', 'img/Package-jotter-1.jpg', 'The packaging of the custom dairy offers vibrant designs and durable finishes that enhance your sourvenir's appeal while safeguarding them from wear and tears', 2),
('Wall Calendar', 'wall-calendar-printing.html', '160000', 'img/A2-wall-calendar.jpg', 'Our calendars come in versatile styles. From minimalist designs to bold and vibrant colors, we offer a variety of styles to suit your personal taste. Printed on high-quality materials, our calendars can be customized to meet your needs', 2),
('Wrist Band', 'wrist-band-printing.html', '5000', 'img/Wristband-2-600x500-792.jpg', 'Wrist-band are widely used in personal, professional, and academic settings. They play an important role in advertising and events gifts', 2),
('Leather Bag', 'leather-bag.html', '5500', 'img/sourvenir-bag-1.jpg', 'Our Custom Leather Bag is great for birthday souvenirs, wedding souvenirs, burial or funeral souvenirs, convocation & graduation jotters, Corporate gift items and events souvenirs',  2),
('Custom Party Cup', 'toast-cup.html', '5000', 'img/Coffee-Sleeves-4-932.jpg', 'Custom coffee cup sleeves often feature designs, logos, or branding elements. They provide coffee shops and businesses with an opportunity to display their branding and add a personal touch to the customer's experience',  2),
('Custom Tray', 'tray-uv-customization.html', '6000', 'img/sourvenir-tray-1.jpg', 'Our Sourvenir tray printing is great for birthday souvenirs, wedding souvenirs, burial or funeral souvenirs, convocation & graduation jotters, Corporate gift items and events souvenirs',  2),

-- =========================================
-- PRINTING & STATIONERY
-- =========================================
('Receipt Invoice Booklet', 'receipt-invoice-booklet.html', '3500', 'img/A6-small-size-receipt-customized-official-receipt-design-andd-printing-in-lagos-nigeria.jpeg', 'Our invoice/receipt booklet is great for business forms, invoice booklet, receipt booklet with duplicate', 3),
('Woven Labels Tags', 'cloth-tag-label.html', '55000', 'img/best-high-top-quality-clothing-hang-tags-label-cards-fashion-clothing-hang-tags-design-and-printing-in-lagos-nigeria-recommended-by-google.jpeg', 'Our custom branded embroidery clothing woven label is simple and unique. it is great for fashion designer's label , clothing brands label tag, boutique label tag', 3),
('Tri-fold Brochure', 'creative-trifold-brochure.html', '15000', 'img/custom-best-presentation-file-folder-lawyer-folder-letterhead-presentation-file-folder-design-and-printing-in-lagos-nigeria.jpg', ' Our unique custom A4 tri-fold brochure is great for Office brand identity, Company's Catalogue, Brand marketing, Business brochure, Product Advertisement brochure and lots more', 3),
('Funeral T-shirt', 'funeral-celebration-tshirt.html', '7500', 'img/best-quality-personalized-funeral-burial-celebration-of-life-funeral-burial-tshirt-printing-in-lagos-nigeria.jpg', 'Our customized partial branded funeral t-shirt is great for burial or funeral t-shirt, Polo for wake-keep program, Get the best quality Funeral T-shirts', 3),
('Book Publishing', 'book-publishing.html', ' 2500', 'img/custom-book-publishing-novel-reading-book-publishing-company-in-lagos-nigeria.jpeg', 'We publish a top quality papers and attractive cover to suit your desire', 3),
('Table Tent Card', 'table-tent-card-printing.html', '1350', 'img/best-quality-custom-table-tent-card-design-and-printing-in-lagos-nigeria.jpeg', 'Our custom table tent card is great for your food & drink menu table tent, payment scan qr code table tent & lots more', 3),
('Thank-you Card', 'thank-you-card.html', '19500', 'img/thank-you-card-custom-thankyoucard-business-company-thank-you-card-printing-in-lagos-abuja-nigeria.jpeg', 'Our custom business thank you card is simple and unique. it is also one of the best way of appreciating your clients for their support', 3),
('Wedding Program', 'wedding-programme-brochure.html', '2850', 'img/wedding-programme-brochure-pamphlet-design-and-printing.jpg', 'Our A4 wedding program pamphlet is great for traditional wedding program, church wedding program, reception program, order of services', 3),
('Branded Envelope', 'Business-envelop.html', '8500', 'img/Business-envelope-2-390.jpg', 'Our selection of envelope materials includes the versatile and smooth 70# Uncoated Text. This material is a top choice for a wide range of printing applications that demand a robust, uncoated finish', 3),
('Book Dust Jacket', 'Book-dust-jacket.html', '13000', 'img/book-dust-jacket-1037-3.png', 'Our dust jackets are crafted using 100# gloss text, a high-quality paper stock that offers. Superior Durability: Resists creasing and tearing, ensuring your books stay pristine. Enhanced Visual Appeal: The glossy surface brings out vibrant colors and sharp details for a polished look', 3),
('Certificate Printing', 'certificate-printing.html', '5000', 'img/custom-certificate-printing-1062-1.jpg', 'Celebrate accomplishments with our Certificate Printing services. Designed with premium materials and customizable finishes, our certificates offer a sophisticated way to honor achievements, showcase professionalism, and leave a lasting impression', 3),
('Posters', 'poster-printing.html', '45500', 'img src="img/laminated-poster-1-798.jpg" alt="Digital Printing and designing image', 'Poster paper is designed for creating posters, signs, and displays. It is typically thicker and sturdier than regular printing or copy paper, allowing it to withstand handling, hanging, and displaying. Poster paper comes in various weights and finishes, offering different levels of durability and aesthetic appeal', 3),
('Dine-in Menus', 'Dining-Menu.html', '12500', 'img/Dine-in-menu-1-600x500-771.jpg', 'offers an array of customization options for dine-in menu printing. With our easy-to-choose options you can create custom dine-in menus that reflect the best offers of your business in the best way', 3),
('Mail Postcards', 'Mail-Postcards.html', 'img/Direct_Mail_Postcards_1071_2-1071.jpg', '9500', 'Embrace endless possibilities for customization to suit your brand and purpose, including paper type, size, printed sides, finish, and raised spot UV to create the maximum impact', 3),
