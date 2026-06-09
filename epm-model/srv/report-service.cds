using { com.epm.views as vdb } from '../db/views';

service ReportService {

    @readonly entity ProductCatalog as projection on vdb.ProductCatalog;
    @readonly entity OrderReport    as projection on vdb.OrderSummary;
    @readonly entity LowStockAlert  as projection on vdb.LowStockProducts;

}