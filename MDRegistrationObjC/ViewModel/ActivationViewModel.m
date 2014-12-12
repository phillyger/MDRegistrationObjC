//
//  ActivationViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "ActivationViewModel.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"
#import "SSKeychain.h"

static  NSString *const SERVICE_NAME=@"incircle.medecision.com";

@interface ActivationViewModel ()

@property (weak, nonatomic) id<MDViewModelServices> services;
@property (nonatomic) UIAlertView *alertView;

@property(nonatomic, strong) RACSignal *activationCodeValidSignal;


@end

@implementation ActivationViewModel

- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
    }
    return self;
}

- (RACSignal *)activate:(NSDictionary*)userInfo {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //        @weakify(self);
        
        [[[[self.services getMDRegistrationService] activate:userInfo]
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

-(void)subscribeToActivate:(NSDictionary*)userInfo
{
    [[self activate:userInfo] subscribeNext:^(NSDictionary *responseDict) {
        NSLog(@"hello");
        NSLog(@"%@", responseDict);
        
        NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];
        
        if ([outcomeCode intValue] == 200000) {
            
            NSLog(@"good to go");
            
//           [self.delegate shouldTransitionToVerification];
            
        } else {
            NSLog(@"stop");
            [self.delegate shouldShowActivationFailureAlert];
            
        }
        
        
    } error:^(NSError *error) {
        NSLog(@"stop");
        [self.delegate shouldShowActivationFailureAlert];
    } completed:^{
        // do nothing
    }];
    
}

- (RACCommand *)activateCommand {
    if (!_activateCommand) {
        //        @weakify(self);
        _activateCommand = [[RACCommand alloc] initWithEnabled:self.activationCodeValidSignal signalBlock:^RACSignal *(id input) {
            //            @strongify(self);
            
            NSLog(@"%@", input);
            
            // Access that token when needed
            // Get the stored data before the view loads
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *username = [defaults objectForKey:@"username"];
            if (username!=nil) {
                NSString *password = [SSKeychain passwordForService:SERVICE_NAME account:username];

                NSDictionary *userInfo = @{@"username":username, @"password":password, @"activationToken":self.activationToken};
               [self subscribeToActivate:userInfo];
            }
            return [RACSignal empty];
        }];
    }
    return _activateCommand;
}

- (RACSignal *)activationCodeValidSignal {
    if (!_activationCodeValidSignal) {
        _activationCodeValidSignal = [RACObserve(self, activationToken) map:^id(NSString *code) {
            return @(code.length == 4);
        }];
    }
    return _activationCodeValidSignal;
}


@end
