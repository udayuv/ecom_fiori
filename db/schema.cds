namespace sap.ecom.product; 

using {cuid, managed, sap.common.CodeList} from '@sap/cds/common';

/**
 * Product 
 */
entity Product : cuid,managed{
    name        :   Name;
    description :   Description;
    price       :   String;
    rating      :   Decimal;
    stock       :   Integer;
    category    :   Association to Category;
    status      :   Association to Status default 'N';
    images      :   ImageLink;
    discount    :   Decimal;
    thumbnail   :   ImageLink;
}

/**
 * Category for Products
 */
entity Category : cuid,managed{
    name    :   Name;
    product :   Association to many Product on product.category = $self;
}

/**
 * Status of Product
 */

entity Status : CodeList {
key code: String enum {
    new = 'N';
    out_of_stock = 'O'; 
    limited_stock = 'L'; 
    deprecated = 'D';
};
criticality : Integer;
}

/**
 * Common Datatype for Product and Category
 */
type Name           :   String(30);
type Description    :   String(1000);
type ImageLink      :   String(100);