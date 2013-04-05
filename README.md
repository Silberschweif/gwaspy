# gwaspy
## An Objective-C client for *gw2spidy.com*

Using `gwaspy`, you can query all of gw2spidy.com in your Mac or iOS applications.

### Basic Usage

Assuming you have the follwing code:

	// Synchronously get item info
    GW2SpidyItem *item = [Spidy searchByID:29175];
    printf("%s\n\n", [item description].UTF8String);

Outputs the following:

	--------------------------------------------------------------------------------------------------------------
	[#29175] The Hunter
	--------------------------------------------------------------------------------------------------------------
	| offerPriceChangeWithinLastHour          : 0
	| subTypeID                               : 10
	| demandCount                             : 929
	| salePriceChangeWithinLastHour           : 0
	| maxOfferUnitPrice                       : 6250000
	| objectID                                : 29175
	| priceLastChangedDate                    : 2013-04-05 21:19:30 +0000
	| imageURLString                          : https://dfach8bufmqqv.cloudfront.net/gw2/img/content/ba3c7546.png
	| typeID                                  : 18
	| quantityAvailable                       : 5
	| gw2dbExternalID                         : 63495
	| restrictionLevel                        : 80
	| minSaleUnitPrice                        : 6999999
	| name                                    : The Hunter
	| rarity                                  : 5
	--------------------------------------------------------------------------------------------------------------
