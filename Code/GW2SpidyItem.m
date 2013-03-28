//
//  GW2SpidyItem.m
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 1/7/13.
//
//

#import "GW2SpidyItem.h"
#import <RestKit/RestKit.h>

#pragma mark -
#pragma mark GW2SpidyItem
//---------------------------------------------------
@implementation GW2SpidyItem
@synthesize rarity,
            restrictionLevel,
            imageURLString,
            typeID,
            subTypeID,
            priceLastChangedDate,
            maxOfferUnitPrice,
            minSaleUnitPrice,
            offerAvailability,
            saleAvailability,
            gw2dbExternalID,
            salePriceChangeWithinLastHour,
            offerPriceChangeWithinLastHour;

#pragma mark -
#pragma mark Description
//---------------------------------------------------
- (NSString *)description {
    NSMutableString *description = [NSMutableString new];
    for(NSString *attribute in [[[self class] mappingAttributes] allValues]) {
        [description appendFormat:@"\n%@: %@\n", attribute, [self valueForKey:attribute]];
    }
    
    return description;
}

#pragma mark -
#pragma mark Mapping Object
//---------------------------------------------------
+ (NSDictionary *)mappingAttributes {
    static NSDictionary *attributes = nil;
    
    if(!attributes) {
        NSMutableDictionary *baseAttributes = [[super mappingAttributes] mutableCopy];
        [baseAttributes addEntriesFromDictionary:@{
         @"rarity"              : @"rarity",
         @"restriction_level"   : @"restrictionLevel",
         @"img"                 : @"imageURLString",
         @"type_id"             : @"typeID",
         @"sub_type_id"         : @"subTypeID",
         @"price_last_changed"  : @"priceLastChangedDate",
         @"max_offer_unit_price": @"maxOfferUnitPrice",
         @"min_sale_unit_price" : @"minSaleUnitPrice",
         @"offer_availability"  : @"offerAvailability",
         @"gw2db_external_id"   : @"gw2dbExternalID",
         @"sale_price_change_last_hour"     : @"salePriceChangeWithinLastHour",
         @"offer_price_change_last_hour"    : @"offerPriceChangeWithinLastHour"
         }];
        
        attributes = [baseAttributes copy];
    }
    
    return attributes;
}

#pragma mark -
#pragma mark Mapping Object
//---------------------------------------------------
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}

#pragma mark -
#pragma mark Request/Response Descriptors
//---------------------------------------------------
+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[[self class] mappingObject]
                                                   pathPattern:@"api/v0.9/json/item/:objectID"
                                                       keyPath:@"result"
                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

#pragma mark -
#pragma mark Class Constructors
+ (GW2SpidyItem *)item {
    return [[self class] new];
}
@end