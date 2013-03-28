//
//  GW2SpidyClient.h
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 12/14/12.
//
//

#import <RestKit/RestKit.h>

#define Spidy   [GW2SpidyManager sharedManager]

@interface GW2SpidyClient : AFHTTPClient
+ (NSNumber *)APIVersion;
@end


@interface GW2SpidyManager : RKObjectManager

#pragma mark -
#pragma mark Singleton Override
//---------------------------------------------------
+ (GW2SpidyManager *)sharedManager;
@end

@interface GW2SpidyManager (Endpoints)
- (void)temp;
- (void)temp_1;
@end