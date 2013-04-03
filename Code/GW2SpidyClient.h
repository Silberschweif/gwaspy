//
//  GW2SpidyClient.h
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 12/14/12.
//
//

#import <RestKit/RestKit.h>

#define Spidy   [GW2SpidyManager sharedManager]

@class GW2SpidyItem;
@interface GW2SpidyClient : AFHTTPClient
+ (NSNumber *)APIVersion;
@end


@interface GW2SpidyManager : RKObjectManager

#pragma mark -
#pragma mark Singleton Override
//---------------------------------------------------
+ (GW2SpidyManager *)sharedManager;

#pragma mark -
#pragma mark Properties
@property (assign, readonly, nonatomic) BOOL cacheAllItems;
@end


#pragma mark -
#pragma mark Experimental Endpoints
//---------------------------------------------------
@interface GW2SpidyManager (Endpoints)
// Synchronous
- (GW2SpidyItem *)searchByID:(NSInteger)objectID;
- (GW2SpidyItem *)searchByID:(NSInteger)objectID error:(NSError **)error;

// Asynchrounous
- (void)searchByID:(NSInteger)objectID completion:(void (^)(NSError *, id))completion;

// Download item images
- (void)imageForItem:(GW2SpidyItem *)item completion:(void (^)(id))completion;
@end