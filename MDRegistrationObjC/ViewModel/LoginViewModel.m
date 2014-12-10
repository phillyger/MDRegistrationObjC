//
//  LoginViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "LoginViewModel.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"

@interface LoginViewModel ()

@property (weak, nonatomic) id<MDViewModelServices> services;
@property (nonatomic) UIAlertView *alertView;

@property(nonatomic, strong) RACSignal *usernameValidSignal;
@property(nonatomic, strong) RACSignal *passwordValidSignal;
@property(nonatomic, strong) RACSignal *allUserInfoValidSignal;

@end

@implementation LoginViewModel

- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
    }
    return self;
}

- (RACSignal *)login:(NSDictionary*)userInfo {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //        @weakify(self);
        
        [[[[self.services getMDRegistrationService] authenticate:userInfo]
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

-(void)subscribeToLogin:(NSDictionary*)userInfo
{
    [[self login:userInfo] subscribeNext:^(NSDictionary *responseDict) {
        NSLog(@"hello");
        NSLog(@"%@", responseDict);
        
        NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];
        
        if ([outcomeCode intValue] == 200000) {
            
            NSLog(@"good to go");
            
            [self.delegate shouldGotoMainStoryboard];
            
        } else {
            NSLog(@"stop");
            [self.delegate shouldShowLoginFailureAlert];
            
        }
        
        
    } error:^(NSError *error) {
        NSLog(@"stop");
        [self.delegate shouldShowLoginFailureAlert];
    } completed:^{
        // do nothing
    }];
    
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
//        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithEnabled:self.allUserInfoValidSignal signalBlock:^RACSignal *(id input) {
//            @strongify(self);
            
            NSLog(@"%@", input);
            NSDictionary *userInfo = @{@"username":self.username, @"password":self.password};
            [self subscribeToLogin:userInfo ];
            
            return [RACSignal empty];
        }];
    }
    return _loginCommand;
}

- (RACSignal *)usernameValidSignal {
    if (!_usernameValidSignal) {
        _usernameValidSignal = [RACObserve(self, username) map:^id(NSString *email) {
            return @([email isValidEmail]);
        }];
    }
    return _usernameValidSignal;
}

- (RACSignal *)passwordValidSignal {
    if (!_passwordValidSignal) {
        _passwordValidSignal = [RACObserve(self, password) map:^id(NSString *password) {
            return @(password.length > 1);
        }];
    }
    return _passwordValidSignal;
}


///Only enable the create account button when each field is filled out correctly.
-(RACSignal *)allUserInfoValidSignal {
    return [RACSignal combineLatest:@[self.usernameValidSignal, self.passwordValidSignal]
                             reduce:^(NSNumber *username, NSNumber *passwordName) {
                                 return @((username.boolValue && passwordName.boolValue));
                             }];
    
}


@end
