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


- (RACSignal *)questions:(NSString *)username;

@end