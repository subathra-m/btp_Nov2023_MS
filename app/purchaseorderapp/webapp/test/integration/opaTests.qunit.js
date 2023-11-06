sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/cap/fiori/purchaseorderapp/test/integration/FirstJourney',
		'com/cap/fiori/purchaseorderapp/test/integration/pages/POsList',
		'com/cap/fiori/purchaseorderapp/test/integration/pages/POsObjectPage',
		'com/cap/fiori/purchaseorderapp/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/cap/fiori/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);