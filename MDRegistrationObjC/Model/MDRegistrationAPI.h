//
//  MDRegistrationAPI.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>

@protocol MDRegistrationAPI <NSObject>

- (RACSignal *)isAvailable:(NSString *)username;

- (RACSignal *)questionsByAccount:(NSString *)username;

- (RACSignal *)resetPassword:(NSDictionary *)userInfo;

- (RACSignal *)register:(NSDictionary *)userInfo;

- (RACSignal *)authenticate:(NSDictionary *)userInfo;

- (RACSignal *)activate:(NSDictionary *)userInfo;

- (RACSignal *)verify:(NSDictionary *)userInfo;

@end
