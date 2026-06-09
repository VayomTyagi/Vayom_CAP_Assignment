namespace com.epm;
using { cuid, managed, Currency, Country} from '@sap/cds/common';


// ─── SUPPLIERS ───────────────────────────────────
entity Suppliers : cuid, managed {
  supplierName  : String(100);
  contactPerson : String(100);
  email         : String(255);
  phone         : String(20);
  city          : String(100);
  country       : Country;
  isActive      : Boolean default true;
  products      : Association to many Products on products.supplier = $self;
}

// ─── CATEGORIES ──────────────────────────────────
entity Categories : cuid, managed {
  categoryName  : String(100);
  description   : String(500);
  products      : Association to many Products on products.category = $self;
}

// ─── PRODUCTS ────────────────────────────────────
entity Products : cuid, managed {
  productName   : String(100);
  description   : String(500);
  price         : Decimal(10,2);
  currency      : Currency;
  stock         : Integer default 0;
  minStock      : Integer default 10;
  rating        : Decimal(2,1);
  supplier      : Association to Suppliers;
  category      : Association to Categories;
  isAvailable   : Boolean default true;
}

// ─── CUSTOMERS ───────────────────────────────────
entity Customers : cuid, managed {
  customerName  : String(100);
  email         : String(255);
  phone         : String(20);
  city          : String(100);
  country       : Country;
  creditLimit   : Decimal(12,2) default 100000;
  orders        : Association to many SalesOrders on orders.customer = $self;
}

// ─── SALES ORDERS ────────────────────────────────
entity SalesOrders : cuid, managed {
  orderNumber    : String(20);
  customer       : Association to Customers;
  orderDate      : Date;
  grossAmount    : Decimal(12,2);
  netAmount      : Decimal(12,2);
  taxAmount      : Decimal(10,2);
  currency       : Currency;
  status         : String(20) default 'New';
  items          : Composition of many SalesOrderItems on items.order = $self;
}

// ─── SALES ORDER ITEMS ───────────────────────────
entity SalesOrderItems : cuid {
  order          : Association to SalesOrders;
  product        : Association to Products;
  quantity       : Integer;
  unitPrice      : Decimal(10,2);
  netAmount      : Decimal(12,2);
  currency       : Currency;
}

// ─── PURCHASE ORDERS ─────────────────────────────
entity PurchaseOrders : cuid, managed {
  poNumber      : String(20);
  supplier      : Association to Suppliers;
  orderDate     : Date;
  expectedDate  : Date;
  grossAmount   : Decimal(12,2);
  netAmount     : Decimal(12,2);
  taxAmount     : Decimal(10,2);
  currency      : Currency;
  status        : String(20) default 'Draft';
  notes         : String(500);
  items         : Composition of many PurchaseOrderItems on items.purchaseOrder = $self;
}

// ─── PURCHASE ORDER ITEMS ────────────────────────
entity PurchaseOrderItems : cuid {
  purchaseOrder : Association to PurchaseOrders;
  product       : Association to Products;
  quantity      : Integer;
  unitPrice     : Decimal(10,2);
  netAmount     : Decimal(12,2);
  currency      : Currency;
}