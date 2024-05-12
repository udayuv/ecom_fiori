# Getting Started

Welcome to your new project. which has been created using command `cds init ecommerce`

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

To know how to Build a Business Application Using CAP for Java [click](https://developers.sap.com/mission.cap-java-app.html)

## 01 Creating Models
In the db folder, create a new `schema.cds` file.
Paste the following code snippet in the product.cds file.

```namespace sap.ecom.product; 

using {cuid, managed} from '@sap/cds/common';

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
 * Common Datatype for Product and Category
 */
type Name           :   String(30);
type Description    :   String(1000);
type ImageLink      :   String(100);
```

## 02 Adding Service creating csv file
### Creating Service
It’s a good practice in CAP to create single-purpose services. Hence, let’s define a ProductService to show product list to customers.
To create the service definition:
In the srv folder, create a new `productservice.cds` file. Paste the following code snippet in the `productService.cds` file:
```
using { sap.ecom.product as ecom } from '../db/schema';

service ProductService { 
    entity Products as projection on ecom.Product;
    entity Category as projection on ecom.Category;
}
```

### Generate comma-separated values (CSV) templates
Generate comma-separated values (CSV) templates using command cds add data, it will create csv templates, here you can add test data to verify
Also the template will by default bring every column, if you don't want to provide value to the column remove it, and keep the one which shouldn't be null

#### Category csv
```
ID,name
21ca608d-6bcd-4231-aae1-44c5ad134d67,Smartphones
0584aefa-3608-4f34-993f-b7b5d1fe75d7,Laptops
```
#### Product csv
```
ID,name,description,price,rating,stock,category_ID,discount
1007033a-8a4c-4de4-9c9e-7d6d8ce75f67,iPhone 9,An apple mobile which is nothing like apple,549,3.69,94,21ca608d-6bcd-4231-aae1-44c5ad134d67,12.96
a2359186-7806-4168-a4c5-0f2ae99db707,iPhone x,Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ,899,4.0,34,21ca608d-6bcd-4231-aae1-44c5ad134d67,17.96
62148a9b-6238-4ef2-b7ca-3fef4a67e0d1,Samsung Universe 9,Samsung's new variant which goes beyond Galaxy to the Universe,1249,4.09,36,21ca608d-6bcd-4231-aae1-44c5ad134d67,15.46
280290e9-c594-4487-b82c-409eccd54254,MacBook Pro,MacBook Pro 2021 with mini-LED display may launch between September,1749,4.57,83,0584aefa-3608-4f34-993f-b7b5d1fe75d7,11.02
212a7668-9ca7-4598-a3da-fbe42fab817c,Samsung Galaxy Book,"Samsung Galaxy Book S (2020) Laptop With Intel Lakefield Chip, 8GB of RAM Launched",1499,3.25,50,0584aefa-3608-4f34-993f-b7b5d1fe75d7,4.15
97c1f5c9-8f7a-44ab-8541-5088b8c7fc47,Microsoft Surface Laptop 4,Style and speed. Stand out on HD video calls backed by Studio Mics. Capture ideas on the vibrant touchscreen,1499,4.43,68,0584aefa-3608-4f34-993f-b7b5d1fe75d7,10.23
```

## 04 Configure the List View Page
#### Adapt Filter
To add adapt filter on list page we use SelectionFields on the entity to which we want to add, here we have used Products in `annotations.cds`

```
annotate service.Products with @(
    UI.SelectionFields : [
        rating,
        name,
        discount,
        category_ID,
    ]
);
```

Similarly to add i18n language have given the label

```
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
```

Also it needs to be maintained in i18n.properties file too which is under _i18n folder.
```
#XFLD,120: Label for a filter field
discount=Discount

#XFLD,120: Label for a filter field
pname=Product Name

#XFLD,120: Label for a filter field
rating=Rating

#XFLD,120: Label for a filter field
category=Category
```
#### Value Help

1. For **Category** filters, in the **Display Type** dropdown menu, select `Value Help`. A popup shows up
2. In the Define Value Help Properties for Category popup:
    - Choose the dropdown menu in the `Value Description Property field` and select `name`.
    - Choose the dropdown menu in the `Text Arragment` as `Text Only` because we don't want to show the id
    - Choose Apply.

```
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
```

### Auto Load and Responsive
to make the list table to load automatically and list page table as responsive
We can add the below code to manifest.json to ProductList section
```
    "initialLoad": "Enabled",
    "controlConfiguration": {
    "@com.sap.vocabularies.UI.v1.LineItem": {
        "tableSettings": {
        "type": "ResponsiveTable"
        }
    }
```

## Configure the Object Page
1. Make sure the SAP Fiori page editor is open. If you closed it, choose the **Open Page Map** option in the **Application Info**
2. In the **Incident Object Page** tile, choose the Pencil icon next to the title.
3. Choose **Header** and in the **Title** dropdown menu, select **title**. It will update the title on the object page
```
annotate service.Products with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
```
4. In the **Description** Type dropdown menu, select **Property**. A popup opens. In the **Define Property popup**, choose the **dropdown** menu in the Description field and select required field, it will show a decription below the title
```
UI.HeaderInfo : {
        ...
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : description,
        },
    }
```
5. In the Icon URL field, enter `sap-icon://alert`. will show on the title header.
```
    UI.HeaderInfo : {
        ...,
        TypeImageUrl : 'sap-icon://alert',
    }
```
#### Add Overview section
1. Choose **Sections** and then choose the Plus icon to add more sections. Choose Add Group Section.
2. In the Add Group Section popup:
    - Enter Overview in the Label field.
    - Choose the Globe icon to generate a translatable text key.
    - Choose Add.

It will add the below code to annotations.cds under `UI.Facet`
```
    {
        $Type : 'UI.CollectionFacet',
        Label : '{i18n>overview}',
        ID : 'i18noverview',
        Facets : [
        ],
    }
```

##### Add Details subsection
Navigate to Sections → Overview → Subsections.

Choose the Plus icon to add more sections and choose Add Form Section.

3.  In the **Add Form Section** popup:
    - Enter Details in the **Label** field.
    - Choose the Globe icon to generate a translatable text key.
    - Choose Add.

#### Configure fields
1. Choose **Sections** → **General Information** and choose the Globe icon in the Label field for General Information to generate a translatable text key.
2. Navigate to **Sections** → **General Information** → **Form** → **Fields** and delete the description,thumbnail and images fields.
3. Navigate to **Sections**, drag the **General Information** and drop it in the **Overview** → **Subsections** node.
4. Navigate to **Sections** → **Overview** → **Subsections** → **Details** → **Form** → **Fields**, choose the Plus icon to add more fields, and then choose **Add Basic Fields**.
4. In the Add Basic Fields popup
    - From the dropdown menu in the Fields field, select **status_code**, and **category_Id**.
    - Choose **Add**.
5. For the **Status** field, select `status/descr` in the **Text** dropdown menu and then select Value Help in the Display Type dropdown menu. A popup opens.
6. In the Define Value Help Properties for Status popup:
    - Select **Status** in the Value Source Entity dropdown menu.
    - Select **code** in the Value Source Property dropdown menu.
    - Select **descr** in the Value Description Property dropdown menu.
    - Leave the default values for the rest of the properties and choose Apply.


### Enable draft with `@odata.draft.enabled`
Enabling a draft for an entity allows the users to edit the entities. To enable a draft for an entity exposed by a service, follow these steps:

1. Open the srv/productservice.cds file.
2. Annotate the file with @odata.draft.enabled like this:
```
using { sap.ecom.product as ecom } from '../db/schema';

service ProductService { 
    entity Products as projection on ecom.Product;
    @readonly
    entity Category as projection on ecom.Category;
}

annotate ProductService.Products with @odata.draft.enabled; 
```

### Variant Management
variantManagement defines how the variant management of page personalizations is controlled.
- None - No variant management by default.
- Control - Individual personalizations for each control.

Make the change in manifest.json file value can be `Page/Control`
```
"variantManagement": "Control",
```

### Rating
Since we want to add Rating in our list table hence replace Rating with this to the UI.LineItem and GeneralInformation Fieldgroup
```
{
    $Type : 'UI.DataFieldForAnnotation',
    Target : '@UI.DataPoint#rating',
}
```
here we have kept the type as DataFieldForAnnotation and target is pointing to a Datapoint which is on product and used for Visualization of a single point of data, typically a number; may also be textual, e.g. a status value for more info [DataPointType](https://github.com/SAP/odata-vocabularies/blob/8d9f4484c4b47d80faf090abecfa184dcc4468b7/vocabularies/UI.md#DataPointType)

annotate service.Products with @(
    UI.DataPoint #rating : {
        Value : rating,
        Visualization : #Rating,
        TargetValue : 5,
    }
);

