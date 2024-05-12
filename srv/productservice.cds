using { sap.ecom.product as ecom } from '../db/schema';

service ProductService { 
    entity Products as projection on ecom.Product;
    @readonly
    entity Category as projection on ecom.Category;
}