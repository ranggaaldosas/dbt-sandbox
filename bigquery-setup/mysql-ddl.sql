-- -----------------------------------------------------
-- Table `customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customers` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company VARCHAR(255),
  last_name VARCHAR(255),
  first_name VARCHAR(255),
  email_address VARCHAR(255),
  job_title VARCHAR(255),
  business_phone VARCHAR(50),
  home_phone VARCHAR(50),
  mobile_phone VARCHAR(50),
  fax_number VARCHAR(50),
  address VARCHAR(255),
  city VARCHAR(100),
  state_province VARCHAR(100),
  zip_postal_code VARCHAR(50),
  country_region VARCHAR(100),
  web_page VARCHAR(255),
  notes TEXT,
  attachments TEXT
);

-- -----------------------------------------------------
-- Table `employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employees` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company VARCHAR(255),
  last_name VARCHAR(255),
  first_name VARCHAR(255),
  email_address VARCHAR(255),
  job_title VARCHAR(255),
  business_phone VARCHAR(50),
  home_phone VARCHAR(50),
  mobile_phone VARCHAR(50),
  fax_number VARCHAR(50),
  address VARCHAR(255),
  city VARCHAR(100),
  state_province VARCHAR(100),
  zip_postal_code VARCHAR(50),
  country_region VARCHAR(100),
  web_page VARCHAR(255),
  notes TEXT,
  attachments TEXT
);

-- -----------------------------------------------------
-- Table `privileges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `privileges` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  privilege_name VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `employee_privileges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee_privileges` (
  employee_id INT,
  privilege_id INT,
  PRIMARY KEY (employee_id, privilege_id),
  FOREIGN KEY (employee_id) REFERENCES employees(id),
  FOREIGN KEY (privilege_id) REFERENCES privileges(id)
);

-- -----------------------------------------------------
-- Table `inventory_transaction_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_transaction_types` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  type_name VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `shippers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shippers` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company VARCHAR(255),
  last_name VARCHAR(255),
  first_name VARCHAR(255),
  email_address VARCHAR(255),
  job_title VARCHAR(255),
  business_phone VARCHAR(50),
  home_phone VARCHAR(50),
  mobile_phone VARCHAR(50),
  fax_number VARCHAR(50),
  address VARCHAR(255),
  city VARCHAR(100),
  state_province VARCHAR(100),
  zip_postal_code VARCHAR(50),
  country_region VARCHAR(100),
  web_page VARCHAR(255),
  notes TEXT,
  attachments TEXT
);

-- -----------------------------------------------------
-- Table `orders_tax_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders_tax_status` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tax_status_name VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `orders_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders_status` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  status_name VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id INT,
  customer_id INT,
  order_date DATETIME,
  shipped_date DATETIME,
  shipper_id INT,
  ship_name VARCHAR(255),
  ship_address VARCHAR(255),
  ship_city VARCHAR(100),
  ship_state_province VARCHAR(100),
  ship_zip_postal_code VARCHAR(50),
  ship_country_region VARCHAR(100),
  shipping_fee FLOAT,
  taxes FLOAT,
  payment_type VARCHAR(255),
  paid_date DATETIME,
  notes TEXT,
  tax_rate FLOAT,
  tax_status_id INT,
  status_id INT,
  FOREIGN KEY (employee_id) REFERENCES employees(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  FOREIGN KEY (shipper_id) REFERENCES shippers(id),
  FOREIGN KEY (tax_status_id) REFERENCES orders_tax_status(id),
  FOREIGN KEY (status_id) REFERENCES orders_status(id)
);

-- -----------------------------------------------------
-- Table `products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `products` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_ids VARCHAR(255),
  product_code VARCHAR(100),
  product_name VARCHAR(255),
  description TEXT,
  standard_cost FLOAT,
  list_price FLOAT,
  reorder_level INT,
  target_level INT,
  quantity_per_unit VARCHAR(100),
  discontinued TINYINT,
  minimum_reorder_quantity INT,
  category VARCHAR(100),
  attachments TEXT
);

-- -----------------------------------------------------
-- Table `purchase_order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `purchase_order_status` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  status VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `suppliers` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company VARCHAR(255),
  last_name VARCHAR(255),
  first_name VARCHAR(255),
  email_address VARCHAR(255),
  job_title VARCHAR(255),
  business_phone VARCHAR(50),
  home_phone VARCHAR(50),
  mobile_phone VARCHAR(50),
  fax_number VARCHAR(50),
  address VARCHAR(255),
  city VARCHAR(100),
  state_province VARCHAR(100),
  zip_postal_code VARCHAR(50),
  country_region VARCHAR(100),
  web_page VARCHAR(255),
  notes TEXT,
  attachments TEXT
);

-- -----------------------------------------------------
-- Table `purchase_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `purchase_orders` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_id INT,
  created_by INT,
  submitted_date DATETIME,
  creation_date DATETIME,
  status_id INT,
  expected_date DATETIME,
  shipping_fee FLOAT,
  taxes FLOAT,
  payment_date DATETIME,
  payment_amount FLOAT,
  payment_method VARCHAR(255),
  notes TEXT,
  approved_by INT,
  approved_date DATETIME,
  submitted_by INT,
  FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
  FOREIGN KEY (status_id) REFERENCES purchase_order_status(id)
);

-- -----------------------------------------------------
-- Table `inventory_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_transactions` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  transaction_type INT,
  transaction_created_date DATETIME,
  transaction_modified_date DATETIME,
  product_id INT,
  quantity INT,
  purchase_order_id INT,
  customer_order_id INT,
  comments TEXT,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id)
);

-- -----------------------------------------------------
-- Table `invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `invoices` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  invoice_date DATETIME,
  due_date DATETIME,
  tax FLOAT,
  shipping FLOAT,
  amount_due FLOAT,
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- -----------------------------------------------------
-- Table `order_details_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_details_status` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  status VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_details` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity FLOAT,
  unit_price FLOAT,
  discount FLOAT,
  status_id INT,
  date_allocated DATETIME,
  purchase_order_id INT,
  inventory_id INT,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (status_id) REFERENCES order_details_status(id)
);

-- -----------------------------------------------------
-- Table `purchase_order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `purchase_order_details` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  purchase_order_id INT,
  product_id INT,
  quantity FLOAT,
  unit_cost FLOAT,
  date_received DATETIME,
  posted_to_inventory TINYINT,
  inventory_id INT,
  FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- -----------------------------------------------------
-- Table `sales_reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sales_reports` (
  group_by VARCHAR(255),
  display VARCHAR(255),
  title VARCHAR(255),
  filter_row_source VARCHAR(255),
  default_column VARCHAR(255)
);

-- -----------------------------------------------------
-- Table `strings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `strings` (
  string_id INT AUTO_INCREMENT PRIMARY KEY,
  string_data TEXT
);
