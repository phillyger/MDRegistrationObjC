//
//  MDRegistrationAPIImpl.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "MDRegistrationAPIImpl.h"
#import "MDRegistrationAPIClient.h"

#import "AFHTTPRequestOperationManager+RACSupport.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"

@implementation MDRegistrationAPIImpl

- (RACSignal *)isAvailable:(NSString *)username {
    
    NSDictionary *body = @{@"email": username ?: @""};
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:@"available"];
    return [[[[MDRegistrationAPIClient sharedClient] rac_GET:fullEndPointUri parameters:body] logError] replayLazily];
    
}

- (RACSignal *)questions:(NSString *)username
{
    NSString *const pathUri = @"account/%@/questions";
    
    NSString *path = [NSString stringWithFormat:pathUri, username];
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:path];
    
    return [[[[MDRegistrationAPIClient sharedClient] rac_GET:fullEndPointUri parameters:nil] logError] replayLazily];

}

- (RACSignal *)resetPassword:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"account/reset_password";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
//    NSLog(@"%@", userInfo);

    
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
    
}

- (RACSignal *)register:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"register";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
    //    NSLog(@"%@", userInfo);
    
    
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
}



@end
