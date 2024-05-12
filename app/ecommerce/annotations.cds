using ProductService as service from '../../srv/productservice';
using from '../../db/schema';

annotate service.Products with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>pname}',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>pDesc}',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>price}',
            Value : price,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>rating}',
            Value : rating,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>stock}',
            Value : stock,
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>status}',
            Criticality : status.criticality,
        },
    ]
);
annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'price',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'rating',
                Value : rating,
            },
            {
                $Type : 'UI.DataField',
                Label : 'stock',
                Value : stock,
            },
            {
                $Type : 'UI.DataField',
                Label : 'images',
                Value : images,
            },
            {
                $Type : 'UI.DataField',
                Label : 'discount',
                Value : discount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'thumbnail',
                Value : thumbnail,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
annotate service.Products with @(
    UI.SelectionFields : [
        name,
        discount,
        category_ID,
        status_code,
    ]
);
annotate service.Products with {
    rating @Common.Label : '{i18n>rating}'
};
annotate service.Products with {
    name @Common.Label : '{i18n>pname}'
};
annotate service.Products with {
    discount @Common.Label : '{i18n>discount}'
};
annotate service.Products with {
    category @Common.Label : '{i18n>category}'
};
annotate service.Products with {
    category @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Category',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : category_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Category with {
    ID @Common.Text : {
            $value : name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Products with {
    status @Common.Label : '{i18n>status}'
};
annotate service.Products with {
    status @Common.ValueListWithFixedValues : true
};
annotate service.Status with {
    code @Common.Text : descr
};
