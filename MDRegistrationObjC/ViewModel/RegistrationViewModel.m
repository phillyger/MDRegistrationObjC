//
//  RegistrationViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "RegistrationViewModel.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"


@interface RegistrationViewModel ()

@property (weak, nonatomic) id<MDViewModelServices> services;
@property (nonatomic) UIAlertView *alertView;

@end

@implementation RegistrationViewModel

- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
    }
    return self;
}



- (RACSignal *)submitRegister:(NSDictionary*)userInfo {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //        @weakify(self);
        
        [[[[self.services getMDRegistrationService] register:userInfo]
          map:^id(RACTuple *tuple) {
              return tuple.second;
          }]
         subscribeNext:^(NSDictionary *dict) {
             [subscriber sendNext:dict];
             [subscriber sendCompleted];
         }
         error:^(NSError *error) {
             NSLog(@"error:%@", error);
             [subscriber sendError:error];
         }
         ];
        // 6. When we are done, remvoe the reference to this request
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

-(void)subscribeToRegistration:(NSDictionary*)userInfo
{
    [[self submitRegister:userInfo] subscribeNext:^(NSDictionary *responseDict) {
        NSLog(@"hello");
        NSLog(@"%@", responseDict);
        
        NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];
        
        if ([outcomeCode intValue] == 200000) {
            
            NSLog(@"good to go");
            [self.delegate shouldShowRegistrationSuccessAlert];
            [self.delegate shouldDismissController];
            
        } else {
            NSLog(@"stop");
            [self.delegate shouldShowRegistrationFailureAlert];
            
        }
        
        
    } error:^(NSError *error) {
        NSLog(@"stop");
         [self.delegate shouldShowRegistrationFailureAlert];
    } completed:^{
        // do nothing
    }];
    
}

@end
