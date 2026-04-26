-- ╔══════════════════════════════════════════════════════╗
-- ║      BIG STEPS FASHION - Supabase Database Setup    ║
-- ║  Run this in Supabase SQL Editor (supabase.com)     ║
-- ╚══════════════════════════════════════════════════════╝

-- Products Table
CREATE TABLE IF NOT EXISTS products (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT NOT NULL,
  description TEXT,
  price       DECIMAL(10,2) NOT NULL DEFAULT 0,
  category    TEXT NOT NULL DEFAULT 'other',
  image_url   TEXT,
  stock       INTEGER DEFAULT 0,
  featured    BOOLEAN DEFAULT FALSE,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
  id                 UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  customer_name      TEXT NOT NULL,
  customer_email     TEXT NOT NULL,
  customer_phone     TEXT NOT NULL,
  delivery_address   TEXT,
  items              JSONB NOT NULL DEFAULT '[]',
  total              DECIMAL(10,2) NOT NULL DEFAULT 0,
  payment_reference  TEXT,
  status             TEXT DEFAULT 'pending',
  created_at         TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders   ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read products" ON products FOR SELECT USING (TRUE);
CREATE POLICY "Allow all product operations" ON products FOR ALL USING (TRUE) WITH CHECK (TRUE);
CREATE POLICY "Public can create orders" ON orders FOR INSERT WITH CHECK (TRUE);
CREATE POLICY "Allow all order operations" ON orders FOR ALL USING (TRUE) WITH CHECK (TRUE);

-- Sample Products
INSERT INTO products (name, description, price, category, stock, featured) VALUES
  ('Premium Ankara Shirt',   'Bold Ankara print shirt. High quality fabric with a modern cut.',   180.00, 'shirts',      20, TRUE),
  ('Classic White Oxford',   'Crisp white Oxford shirt for a clean professional look.',           120.00, 'shirts',      15, TRUE),
  ('Elegant Kente Dress',    'Handwoven Kente fabric dress. A celebration of Ghanaian heritage.', 350.00, 'dresses',      8, TRUE),
  ('Tailored Chinos',        'Slim-fit chinos with comfortable stretch.',                         140.00, 'trousers',    25, FALSE),
  ('Gold Chain Necklace',    '18K gold-plated chain necklace. Adds a luxury finish.',              95.00, 'accessories', 30, TRUE),
  ('Dashiki Top',            'Vibrant dashiki top with traditional embroidery.',                  110.00, 'traditional', 18, TRUE),
  ('Leather Derby Shoes',    'Handcrafted leather derby shoes. Elegant and durable.',             280.00, 'shoes',       10, FALSE),
  ('Batik Wrap Dress',       'Flowing batik print wrap dress with adjustable waist tie.',         220.00, 'dresses',     12, FALSE);

SELECT 'Database setup complete!' AS message;
