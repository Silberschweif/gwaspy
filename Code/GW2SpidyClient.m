//
//  GW2SpidyClient.m
//  GW2SpidyCore
//
//  Created by Kevin Vitale on 12/14/12.
//
//

#import "GW2SpidyClient.h"
#import "GW2SpidyItem.h"

// Constants
//---------------------------------------------------
static NSString * const GW2SpidyBaseURLString       = @"http://www.gw2spidy.com/";
static NSString * const GW2SpidyLocalHostURLString  = @"http://127.0.0.1";
static NSString * const GW2SpidyJSONResponseFormat  = @"json";
static NSString * const GW2SpidyCSVResponseFormat   = @"csv";
static float GW2SPIDY_API_VERSION                   = 0.9f;

#pragma mark -
#pragma mark Private Implementation
//---------------------------------------------------
@interface GW2SpidyClient ()
- (NSString *)basePath;
- (NSString *)constructPath:(NSString *)path;
+ (GW2SpidyClient *)sharedClient;
@end


#pragma mark -
#pragma mark GW2SpidyClient
//---------------------------------------------------
@implementation GW2SpidyClient

#pragma mark -
#pragma mark Initialization
//---------------------------------------------------
- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:GW2SpidyBaseURLString]];
    if(self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    }
    return self;
}

#pragma mark -
#pragma mark Property Overrides
//---------------------------------------------------
- (NSString *)basePath {
    return [NSString stringWithFormat:@"api/v%@/%@/", [GW2SpidyClient APIVersion], GW2SpidyJSONResponseFormat];
}
- (NSString *)constructPath:(NSString *)path {
    return [[self basePath] stringByAppendingPathComponent:path];
}
+ (NSNumber *)APIVersion {
    return @(GW2SPIDY_API_VERSION);
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
    return [super requestWithMethod:method
                               path:[self constructPath:path]
                         parameters:parameters];
}


#pragma mark -
#pragma mark Singleton
//---------------------------------------------------
+ (GW2SpidyClient *)sharedClient {
    static dispatch_once_t onceToken;
    static GW2SpidyClient *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GW2SpidyClient alloc] init];
    });
    
    return instance;
}
@end



#pragma mark -
#pragma mark GW2SpidyManager
//---------------------------------------------------
@interface GW2SpidyManager ()
@property (assign, readwrite, nonatomic) BOOL cacheAllItems;
@property (copy, nonatomic) NSArray *allItems;
- (void)registerSpidyResourceClass:(Class)resourceClass;
@end
@implementation GW2SpidyManager
#pragma mark -
#pragma mark Initialization
//---------------------------------------------------
- (id)init {
    self = [super initWithHTTPClient:[GW2SpidyClient sharedClient]];
    if(self) {
        [self registerSpidyResourceClass:nil];
        [self setCacheAllItems:YES];
    }
    return self;
}

#pragma mark -
#pragma mark Singleton
//---------------------------------------------------
+ (GW2SpidyManager *)sharedManager {
    static dispatch_once_t onceToken;
    static GW2SpidyManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GW2SpidyManager alloc] init];
    });
    
    return instance;
}

#pragma mark -
#pragma mark Register Resources
//---------------------------------------------------
- (void)registerSpidyResourceClass:(Class)resourceClass {
    
    NSString *pathPattern = @"/item/:objectID";
    
    RKMapping *mapping = [GW2SpidyItem mappingObject];
    RKResponseDescriptor *rd = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                       pathPattern:[(GW2SpidyClient *)self.HTTPClient constructPath:pathPattern]
                                                                           keyPath:@"result"
                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self addResponseDescriptor:rd];
    
    
    RKRoute *route = [RKRoute routeWithClass:[GW2SpidyItem class]
                                 pathPattern:pathPattern
                                      method:RKRequestMethodGET];
    [self.router.routeSet addRoute:route];
}
@end




#pragma mark -
#pragma mark Endpoints Categories
//---------------------------------------------------
@implementation GW2SpidyManager (Endpoints)
- (GW2SpidyItem *)searchByID:(NSInteger)objectID {
    return [self searchByID:objectID error:nil];
}
- (GW2SpidyItem *)searchByID:(NSInteger)objectID error:(NSError *__autoreleasing *)error {
    GW2SpidyItem *item = [GW2SpidyItem item];
    item.objectID = @(objectID);
    
    NSURLRequest *request = [self requestWithObject:item
                                             method:RKRequestMethodGET
                                               path:nil
                                         parameters:nil];
    RKHTTPRequestOperation *httpRequest = [[RKHTTPRequestOperation alloc] initWithRequest:request];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithHTTPRequestOperation:httpRequest
                                                                                     responseDescriptors:self.responseDescriptors];
    [operation start];
    [operation waitUntilFinished];
    if(error) *error = operation.error;
    return operation.mappingResult.array.lastObject;
    
}
- (void)searchByID:(NSInteger)objectID completion:(void (^)(NSError *, id))completion {
    void (^finalCompletion)(NSError *, id) = ^ (NSError *error, id object) {
        if(completion)
            completion(error, object);
    };
    
    // Search it up!
    GW2SpidyItem *item = [GW2SpidyItem item];
    item.objectID = @(objectID);
    [self getObject:item
               path:nil
         parameters:nil
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                finalCompletion(nil, [[mappingResult array] lastObject]);
            }
            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                finalCompletion(error, nil);
            }];
}
- (void)imageForItem:(GW2SpidyItem *)item completion:(void (^)(id image))completion {
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[item imageURLString]]];
    AFImageRequestOperation *imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:imageRequest
                                                                                                success:^(NSImage *image) {
                                                                                                    if(completion)
                                                                                                        completion(image);
                                                                                                }];
    [imageOperation start];
}
@end