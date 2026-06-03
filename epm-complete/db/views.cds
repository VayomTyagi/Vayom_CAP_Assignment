namespace com.epm.views;
using { com.epm.Products, com.epm.SalesOrders } from './schema';


entity ProductCatalog as select from Products {
    ID,
    name,
    price,
    currency,
    supplier.name as supplierName,
    category.name as categoryName,
    stock,
    minStock,
    case
        when stock <= minStock then 'LOW STOCK'
        else 'AVAILABLE'
    end as stockStatus : String(20)
};


entity OrderReport as select from SalesOrders {
    ID,
    orderNumber,
    customer.name as customerName,
    netAmount,
    taxAmount,
    grossAmount as totalAmount,
    currency,
    orderDate,
    status
};


entity LowStockAlert as select from Products {
    ID,
    name,
    stock,
    minStock,
    supplier.name    as supplierName,
    supplier.contact as supplierContact,
    supplier.email   as supplierEmail,
    supplier.phone   as supplierPhone
}
where stock <= minStock;