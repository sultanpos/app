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
'''
    ]
  ];
}