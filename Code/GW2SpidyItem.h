//
//  GW2SpidyItem.h
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 1/7/13.
//
//

#import "GW2SpidyObject.h"

#pragma mark -
#pragma mark GW2SpidyItem
//---------------------------------------------------
@interface GW2SpidyItem : GW2SpidyObject

#pragma mark -
#pragma mark Properties
//---------------------------------------------------
/// self.objectID (inherited)
/// self.name (inherited)
@property (copy, nonatomic) NSNumber *rarity;
@property (copy, nonatomic) NSNumber *restrictionLevel;
@property (copy, nonatomic) NSString *imageURLString;
@property (copy, nonatomic) NSNumber *typeID;
@property (copy, nonatomic) NSNumber *subTypeID;
@property (copy, nonatomic) NSDate   *priceLastChangedDate;
@property (copy, nonatomic) NSNumber *maxOfferUnitPrice;
@property (copy, nonatomic) NSNumber *minSaleUnitPrice;
@property (copy, nonatomic) NSNumber *offerAvailability;
@property (copy, nonatomic) NSNumber *saleAvailability;
@property (copy, nonatomic) NSNumber *gw2dbExternalID;
@property (copy, nonatomic) NSNumber *salePriceChangeWithinLastHour;
@property (copy, nonatomic) NSNumber *offerPriceChangeWithinLastHour;

#pragma mark -
#pragma mark Class Constructors
+ (GW2SpidyItem *)item;
@end
