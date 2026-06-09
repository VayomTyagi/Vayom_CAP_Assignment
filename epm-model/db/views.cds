namespace com.epm.views;
using { com.epm.Products, com.epm.SalesOrders } from './schema';


entity ProductCatalog as select from Products {
  ID,
  productName,
  description,
  price,
  currency,
  rating,
  stock,
  (price * 0.82) as priceExTax : Decimal(10,2),
  (price * 0.18) as taxAmount  : Decimal(10,2),
  supplier.supplierName as supplierName,
  category.categoryName as categoryName,
  case
    when stock > 20 then 'In Stock'
    when stock > 0  then 'Low Stock'
    else 'Out of Stock'
  end as availability : String(20)
} where isAvailable = true;

// View: Order Summary (flattened for reports)
entity OrderSummary as select from SalesOrders {
  ID,
  orderNumber,
  orderDate,
  grossAmount,
  netAmount,
  taxAmount,
  status,
  customer.customerName as customerName,
  customer.email        as customerEmail,
  customer.city         as customerCity
};

// View: Low Stock Alert
entity LowStockProducts as select from Products {
  ID,
  productName,
  stock,
  minStock,
  supplier.supplierName as supplierName,
  supplier.email        as supplierEmail,
  supplier.phone        as supplierPhone
} where stock <= minStock and isAvailable = true;