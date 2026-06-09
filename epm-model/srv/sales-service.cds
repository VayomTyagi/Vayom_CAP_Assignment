using {com.epm as db}  from '../db/schema';

service SalesService {

    entity Products as projection on db.Products {
        ID,
        productName,
        description,
        price,
        currency,
        stock,
        rating,
        category
    };
    
    entity Categories         as projection on db.Categories;
    entity Customers          as projection on db.Customers;
    entity SalesOrders        as projection on db.SalesOrders;
    entity SalesOrderItems    as projection on db.SalesOrderItems;

}