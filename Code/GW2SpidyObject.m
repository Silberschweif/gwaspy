//
//  GW2SpidyObject.m
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 12/14/12.
//
//

#import "GW2SpidyObject.h"

#pragma mark -
#pragma mark GW2SpidyObject
//---------------------------------------------------
@implementation GW2SpidyObject
@synthesize objectID;
@synthesize name;

#pragma mark -
#pragma mark Mapping Object
//---------------------------------------------------
+ (NSDictionary *)mappingAttributes {
    return @{
        @"id"      : @"objectID",
        @"name"    : @"name"
    };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *objectMapping = [[RKObjectMapping alloc] initWithClass:[self class]];
    [objectMapping setSetDefaultValueForMissingAttributes:YES];
    [objectMapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    
    return objectMapping;
}
@end
