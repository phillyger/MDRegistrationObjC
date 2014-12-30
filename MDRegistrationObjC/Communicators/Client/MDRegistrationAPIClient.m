//
//  MDRegistrationAPIClient.m
//  Every1Here
//
//  Created by Ger O'Sullivan on 2/2/13.
//  Copyright (c) 2013 Brilliant Age. All rights reserved.
//

#import "MDRegistrationAPIClient.h"
//#import "CommonUtilities.h"


//static NSString * const kMDRegistrationAPIBaseURLString = @"http://localhost:8099/app/rest";
//static NSString * const kMDRegistrationAPIBaseURLString = @"http://clvdv-rapid-2:8085/app/rest";
static NSString * const kMDRegistrationAPIBaseURLString = @"http://localhost:8085/app/rest";
static NSString * const kMDRegistrationAPICharset = @"utf-8";
static NSString * const kMDRegistrationJSONMimeType = @"application/json";

/**
 *   RegistrationAPI - DEV keys
 *
 **/

static NSString * const kMDRegistrationAPIRESTApiKeyName = @"x-md-client-key";
static NSString * const kMDRegistrationAPIAuthTokenKeyName = @"x-md-token";
static NSString * const kMDRegistrationAPIRESTApiKeyValue = @"APIKEY123";


@implementation MDRegistrationAPIClient


+ (instancetype)sharedClient {
    static MDRegistrationAPIClient *_sharedClient = nil;
     static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MDRegistrationAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kMDRegistrationAPIBaseURLString]];
//        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    [self.requestSerializer setValue:kMDRegistrationAPIRESTApiKeyValue
                  forHTTPHeaderField:kMDRegistrationAPIRESTApiKeyName];
    
    [self startReachabilityMonitoring];

    return self;
}

- (void)startReachabilityMonitoring
{
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager managerForDomain:kMDRegistrationAPIBaseURLString];
  
    AFNetworkReachabilityManager *manager = [self reachabilityManager];
    
//    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
//    }];
    
    NSOperationQueue *operationQueue = [self operationQueue];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));

                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection Found"
                                                                message:@"The application requires an internet connection. Please check your device settings."
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];

                [alert show];

                
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager startMonitoring];
}

- (NSString *)appendPathVarToEndPointUri:(NSString*)path
{
    NSString *clientBaseUrl = [[self baseURL] absoluteString];
    return [clientBaseUrl stringByAppendingString:path];
}


- (void)setAuthorizationTokenHeaderWithToken:(NSString *)token
{
//    [self.requestSerializer.HTTPRequestHeaders setValue:kMDRegistrationAPIAuthTokenKeyName forKey:token];
    
    [[self requestSerializer] setValue:token forHTTPHeaderField:kMDRegistrationAPIAuthTokenKeyName];
}


@end
