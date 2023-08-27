class SqliteMigration {
  static List<List<String>> migrationScripts = [
    // version 1
    [
      '''CREATE TABLE unit (
	id INTEGER PRIMARY KEY,
	updated_at DATETIME not null,
	deleted_at DATETIME,
  name TEXT not null,
	description TEXT not null default ''
)
''',
      '''CREATE TABLE partner (
  id INTEGER PRIMARY KEY,
  updated_at DATETIME not null,
	deleted_at DATETIME,
  is_supplier INTEGER NOT NULL DEFAULT 0,
  is_customer INTEGER NOT NULL DEFAULT 0,
  number TEXT not null,
  name TEXT not null,
  address TEXT not null default '',
  phone TEXT not null default '',
  price_group_id INTEGER not null default 0,
  npwp TEXT not null default '',
  email TEXT not null default '',
  debt INTEGER not null default 0,
  credit INTEGER not null default 0
)
''',
      'CREATE INDEX partner_updated_at ON partner (updated_at)',
      '''CREATE TABLE category (
	id INTEGER PRIMARY KEY,
  updated_at DATETIME not null,
	deleted_at DATETIME,
  parent_id INTEGER,
  name TEXT not null,
  description TEXT not null default '',
  code TEXT not null default '',
  fullpath TEXT not null default '',
  is_default INTEGER not null default 0
)
''',
      '''CREATE TABLE price (
	id INTEGER PRIMARY KEY,
	updated_at DATETIME not null,
	deleted_at DATETIME,
  price_group_id INTEGER not null default 0,
  branch_id INTEGER NOT NULL DEFAULT 0,
  product_id INTEGER not null,
  price0 INTEGER not null default 0,
  count0 INTEGER not null default 0,
  discount_formula0 TEXT not null default '',
  discount0 INTEGER not null default 0,
  count1 INTEGER not null default 0,
  price1 INTEGER not null default 0,
  discount_formula1 TEXT not null default '',
  discount1 INTEGER not null default 0,
  count2 INTEGER not null default 0,
  price2 INTEGER not null default 0,
  discount_formula2 TEXT not null default '',
  discount2 INTEGER not null default 0,
  count3 INTEGER not null default 0,
  price3 INTEGER not null default 0,
  discount_formula3 TEXT not null default '',
  discount3 INTEGER not null default 0,
  count4 INTEGER not null default 0,
  price4 INTEGER not null default 0,
  discount_formula4 TEXT not null default '',
  discount4 INTEGER not null default 0
)
''',
      'CREATE INDEX price_updated_at ON price (updated_at)',
      'CREATE INDEX price_product_id ON price (product_id)',
      '''CREATE TABLE pricegroup (
	id INTEGER PRIMARY KEY,
	updated_at DATETIME not null,
	deleted_at DATETIME,
  name TEXT not null,
	description TEXT not null default '',
	public_description TEXT not null default '',
	is_default INTEGER not null default 0
)
''',
      '''CREATE TABLE product (
	id INTEGER PRIMARY KEY,
  parent_id INTEGER,
	updated_at DATETIME not null,
	deleted_at DATETIME,
  barcode TEXT NOT NULL DEFAULT '',
	name TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  main_image TEXT NOT NULL DEFAULT '',
  unit_id INTEGER,
  serial INTEGER not null default 0,
  product_type TEXT NOT NULL,
  category_id INTEGER,
  partner_id INTEGER,
  all_branch INTEGER NOT NULL default 1,
  calculate_stock INTEGER not null default 1,
  sellable INTEGER not null default 1,
  buyable INTEGER not null default 1,
  editable_price INTEGER not null default 0,
  use_sn INTEGER not null default 0
)
''',
      'CREATE INDEX product_updated_at ON product (updated_at)',
      'CREATE INDEX product_barcode ON product (barcode)',
      '''CREATE TABLE paymentmethod (
	id INTEGER PRIMARY KEY,
	updated_at DATETIME DEFAULT (datetime('now', 'localtime')),
	deleted_at DATETIME,
  branch_id INTEGER NOT NULL default 0,
  is_default BOOLEAN not null default 'f',
  method TEXT NOT NULL DEFAULT 'cash',
  name TEXT not null,
  additional TEXT NOT NULL default '',
  description TEXT NOT NULL DEFAULT ''
)
''',
      '''CREATE TABLE cashiersession (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
	  updated_at DATETIME DEFAULT (datetime('now', 'localtime')),
	  deleted_at DATETIME,
    sync_at DATETIME,
    branch_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    number TEXT NOT NULL,
    date_open DATETIME NOT NULL,
    date_close DATETIME,
    open_value INTEGER not null,
    close_value INTEGER not null default 0,
    calculated_value INTEGER not null default 0,
    difference INTEGER not null default 0,
    machine_id INTEGER,
    note TEXT not null default '',
    close_note TEXT not null default ''
)
''',
      '''CREATE TABLE sale (
	  id INTEGER PRIMARY KEY AUTOINCREMENT,
    updated_at DATETIME DEFAULT (datetime('now', 'localtime')),
    deleted_at DATETIME,
    branch_id INTEGER NOT NULL,
    partner_id INTEGER not null,
    date DATETIME NOT NULL,
    ref_number TEXT not null default '',
    number TEXT not null,
    type TEXT not null default 'normal',
    status TEXT not null default 'draft',
    stock_status TEXT not null default 'none',
    subtotal INTEGER not null default 0,
    discount_formula TEXT not null default '',
    discount INTEGER not null default 0,
    payment_paid INTEGER not null default 0,
    payment_residual INTEGER not null default 0,
    total INTEGER not null default 0,
    deadline DATETIME,
    user_id INTEGER not null,
    cashier_session_id INTEGER,
    sync_at DATETIME
)
''',
      '''CREATE TABLE saleitem (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sale_id INTEGER not null,
    batch INTEGER not null default 1,
    serial_stock_id INTEGER not null default 0,
    product_id INTEGER not null default 0,
    amount INTEGER not null default 0,
    buy_price INTEGER not null default 0,
    price INTEGER not null default 0,
    subtotal INTEGER not null default 0,
    discount_formula TEXT not null default '',
    discount INTEGER not null default 0,
    total INTEGER not null default 0,
    note TEXT not null default ''
)
''',
      '''CREATE TABLE payment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    updated_at DATETIME DEFAULT (datetime('now', 'localtime')),
    deleted_at DATETIME,
    date DATETIME NOT NULL,
    branch_id INTEGER NOT NULL default 0,
    payment_method_id bigint not null,
    number TEXT not null,
    ref_number TEXT not null default '',
    user_id INTEGER not null,
    type TEXT not null,
    refer TEXT not null,
    refer_id INTEGER not null default 0,
    amount INTEGER not null,
    payment INTEGER not null default 0,
    cashier_session_id INTEGER,
    note text not null,
    sync_at DATETIME
)
'''
    ]
  ];
}
