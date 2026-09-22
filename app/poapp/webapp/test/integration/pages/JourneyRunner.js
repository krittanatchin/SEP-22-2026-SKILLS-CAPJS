sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"poapp/test/integration/pages/POSrvList.gen",
	"poapp/test/integration/pages/POSrvObjectPage.gen",
	"poapp/test/integration/pages/POItemSrvObjectPage.gen"
], function (JourneyRunner, POSrvListGenerated, POSrvObjectPageGenerated, POItemSrvObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('poapp') + '/test/flp.html#app-preview',
        pages: {
			onThePOSrvListGenerated: POSrvListGenerated,
			onThePOSrvObjectPageGenerated: POSrvObjectPageGenerated,
			onThePOItemSrvObjectPageGenerated: POItemSrvObjectPageGenerated
        },
        async: true
    });

    return runner;
});

