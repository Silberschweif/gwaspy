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
            demandCount,
            quantityAvailable,
            gw2dbExternalID,
            salePriceChangeWithinLastHour,
            offerPriceChangeWithinLastHour;

#pragma mark -
#pragma mark Description
//---------------------------------------------------
- (NSString *)description {
    NSUInteger stringLength = 0;
    NSMutableString *description = [NSMutableString string];
    for(NSString *attribute in [[[self class] mappingAttributes] allValues]) {
        NSString *string = [NSString stringWithFormat:@"| %@: %@\n", [attribute stringByPaddingToLength:40
                                                                                             withString:@" "
                                                                                        startingAtIndex:0], [self valueForKey:attribute]];
        [description appendString:string];
        stringLength = (stringLength < string.length ? string.length : stringLength);
    }
    
    NSString *dashedLineString = [@"" stringByPaddingToLength:stringLength
                                                   withString:@"-"
                                              startingAtIndex:0];
    [description insertString:[NSString stringWithFormat:@"\n%@\n[#%@] %@\n%@\n", dashedLineString, self.objectID, self.name, dashedLineString] atIndex:0];
    [description appendString:dashedLineString];
    
    return description;
}

#pragma mark -
#pragma mark Mapping Object
//---------------------------------------------------
+ (NSDictionary *)mappingAttributes {
    static NSDictionary *attributes = nil;
    
    if(!attributes) {
        NSMutableDictionary *baseAttributes = [NSMutableDictionary dictionary];
        [baseAttributes addEntriesFromDictionary:@{
         @"name"                : @"name",
         @"data_id"             : @"objectID",
         @"rarity"              : @"rarity",
         @"restriction_level"   : @"restrictionLevel",
         @"img"                 : @"imageURLString",
         @"type_id"             : @"typeID",
         @"sub_type_id"         : @"subTypeID",
         @"price_last_changed"  : @"priceLastChangedDate",
         @"max_offer_unit_price": @"maxOfferUnitPrice",
         @"min_sale_unit_price" : @"minSaleUnitPrice",
         @"offer_availability"  : @"demandCount",
         @"gw2db_external_id"   : @"gw2dbExternalID",
         @"sale_price_change_last_hour"     : @"salePriceChangeWithinLastHour",
         @"offer_price_change_last_hour"    : @"offerPriceChangeWithinLastHour",
         @"sale_availability"   : @"quantityAvailable"
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


#pragma mark -
#pragma mark All Items Response
@implementation GW2SpidyAllItemsResponse
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping setSetDefaultValueForMissingAttributes:YES];
    [mapping setSetNilForMissingRelationships:YES];
    [mapping addAttributeMappingsFromDictionary:@{@"count" : @"count"}];
    return mapping;
}
@end