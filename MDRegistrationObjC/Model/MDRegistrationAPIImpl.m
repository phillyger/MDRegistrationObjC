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

/**
 *  Checks if a username already exists.
 *
 *  @param username The unique username value
 *
 *  @return RACSignal A signal that sends an response indicating if the username is available for selection.
 */
- (RACSignal *)isAvailable:(NSString *)username {
    
    NSDictionary *body = @{@"email": username ?: @""};
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:@"available"];
    return [[[[MDRegistrationAPIClient sharedClient] rac_GET:fullEndPointUri parameters:body] logError] replayLazily];
    
}

/**
 *  Returns a list of questions associated with user account
 *
 *  @param username The unique username value
 *
 *  @return RACSignal A signal that sends a response upon successful fetch.
 */
- (RACSignal *)questionsByAccount:(NSString *)username
{
    NSString *const pathUri = @"account/%@/questions";
    
    NSString *path = [NSString stringWithFormat:pathUri, username];
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:path];
    
    return [[[[MDRegistrationAPIClient sharedClient] rac_GET:fullEndPointUri parameters:nil] logError] replayLazily];

}

/**
 *  Resets the password for the current user
 *
 *  @param userInfo The unique username value
 *
 *  @return RACSignal A signal that sends a response upon successful post.
 */
- (RACSignal *)resetPassword:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"account/reset_password";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
//    NSLog(@"%@", userInfo);

    
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
    
}

/**
 *  Registers a new user account
 *
 *  @param userInfo An NSDictionary of user information
 *
 *  @return RACSignal A signal that sends a response upon successful post.
 */
- (RACSignal *)register:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"register";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
    //    NSLog(@"%@", userInfo);
    
    
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
}

/**
 *  Authenicates a given user
 *
 *  @param userInfo An NSDictionary of user information
 *
 *  @return RACSignal A signal that sends a response upon successful post.
 */
- (RACSignal *)authenticate:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"authenticate";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
    //    NSLog(@"%@", userInfo);
    
    
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
}

/**
 *  Activates a user account
 *
 *  @param userInfo An NSDictionary of user information
 *
 *  @return RACSignal A signal that sends a response upon successful post.
 */
- (RACSignal *)activate:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"activate";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
    //    NSLog(@"%@", userInfo);
    
    
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
}


/**
 *  Activates a user account
 *
 *  @param userInfo An NSDictionary of user information
 *
 *  @return RACSignal A signal that sends a response upon successful post.
 */
- (RACSignal *)verify:(NSDictionary *)userInfo
{
    NSString *const pathUri = @"secure/verify";
    
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:pathUri];
    
    NSLog(@"headers: %@", [[[MDRegistrationAPIClient sharedClient] requestSerializer] HTTPRequestHeaders]);
    return [[[[MDRegistrationAPIClient sharedClient] rac_POST:fullEndPointUri parameters:userInfo] logError] replayLazily];
}




@end
