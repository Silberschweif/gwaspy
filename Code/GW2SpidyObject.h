//
//  GW2SpidyObject.h
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 12/14/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <RestKit/RestKit.h>

#pragma mark -
#pragma mark GW2SpidyObject
@interface GW2SpidyObject : NSObject

#pragma mark -
#pragma mark Properties
/// The object's unique identifier.
@property (nonatomic, copy) NSNumber *objectID;

/// The object's visible name.
@property (nonatomic, copy) NSString *name;

+ (NSDictionary *)mappingAttributes;
+ (RKObjectMapping *)mappingObject;
@end
