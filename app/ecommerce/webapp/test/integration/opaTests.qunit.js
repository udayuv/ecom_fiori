sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ecom/ecommerce/test/integration/FirstJourney',
		'ecom/ecommerce/test/integration/pages/ProductsList',
		'ecom/ecommerce/test/integration/pages/ProductsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ecom/ecommerce') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage
                }
            },
            opaJourney.run
        );
    }
);