//
//  VerificationViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/12/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "VerificationViewModel.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"

@interface VerificationViewModel ()
@property (weak, nonatomic) id<MDViewModelServices> services;

@property(nonatomic, strong) RACSignal *allVerifyInfoValidSignal;
@property(nonatomic, strong) RACSignal *dobCompletnessValidSignal;
@property(nonatomic, strong) RACSignal *memberIdValidSignal;
@property(nonatomic, strong) RACSignal *usernameValidSignal;
@property(nonatomic, strong) RACSignal *firstNameValidSignal;
@property(nonatomic, strong) RACSignal *lastNameValidSignal;
@property(nonatomic, strong) RACSignal *zipValidSignal;
@property(nonatomic, strong) RACSignal *dobMMValidSignal;
@property(nonatomic, strong) RACSignal *dobDDValidSignal;
@property(nonatomic, strong) RACSignal *dobYYYYValidSignal;
@end

@implementation VerificationViewModel


- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
        //        [self mapNextCommandStateToStatusMessage];
    }
    return self;
}


- (RACSignal *)verify:(NSDictionary*)userInfo {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //        @weakify(self);
        
        [[[[self.services getMDRegistrationService] verify:userInfo]
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


-(void)subscribeToVerify:(NSDictionary*)userInfo
{
    [[self verify:userInfo] subscribeNext:^(NSDictionary *responseDict) {

        NSLog(@"%@", responseDict);
        
        NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];
        
        if ([outcomeCode intValue] == 200000) {
            
            NSLog(@"good to go");
            
            [self.delegate shouldOpenMainStoryboard];
            
        } else {
            NSLog(@"stop");
            [self.delegate shouldShowVerificationFailureAlert];
            
        }
        
        
    } error:^(NSError *error) {
        NSLog(@"stop");
        [self.delegate shouldShowVerificationFailureAlert];
    } completed:^{
        // do nothing
    }];
    
}

- (RACCommand *)verifyCommand {
    if (!_verifyCommand) {
        @weakify(self);
        _verifyCommand = [[RACCommand alloc] initWithEnabled:self.allVerifyInfoValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            
//            NSDictionary *userInfo = @{@"username":username, @"password":password, @"activationToken":self.activationToken};
            
             NSDictionary *userInfo = @{
                @"memberId": self.memberId,
                @"firstName": self.firstName,
                @"lastName": self.lastName,
                @"username": self.username,
                @"zip": self.zip,
                @"birthDate": self.birthDate };
            
            [self subscribeToVerify:userInfo];
            
            return [RACSignal empty];
        }];
    }
    return _verifyCommand;
}

- (RACSignal *)memberIdValidSignal {
    if (!_memberIdValidSignal) {
        _memberIdValidSignal = [RACObserve(self, memberId) map:^id(NSString *memberId) {
            return @(memberId.length > 5);
        }];
    }
    return _memberIdValidSignal;
}

- (RACSignal *)usernameValidSignal {
    if (!_usernameValidSignal) {
        _usernameValidSignal = [RACObserve(self, username) map:^id(NSString *email) {
            return @([email isValidEmail]);
        }];
    }
    return _usernameValidSignal;
}

- (RACSignal *)firstNameValidSignal {
    if (!_firstNameValidSignal) {
        _firstNameValidSignal = [RACObserve(self, firstName) map:^id(NSString *firstName) {
            return @(firstName.length > 1);
        }];
    }
    return _firstNameValidSignal;
}

- (RACSignal *)lastNameValidSignal {
    if (!_lastNameValidSignal) {
        _lastNameValidSignal = [RACObserve(self, lastName) map:^id(NSString *lastName) {
            return @(lastName.length > 1);
        }];
    }
    return _lastNameValidSignal;
}

- (RACSignal *)zipValidSignal {
    if (!_zipValidSignal) {
        _zipValidSignal = [RACObserve(self, zip) map:^id(NSString *zip) {
            return @(zip.length == 5);
        }];
    }
    return _zipValidSignal;
}

- (RACSignal *)dobMMValidSignal {
    if (!_dobMMValidSignal) {
        _dobMMValidSignal = [RACObserve(self, dobMM) map:^id(NSString *dobMM) {
            return @(dobMM.length == 2);
        }];
    }
    return _dobMMValidSignal;
}

- (RACSignal *)dobDDValidSignal {
    if (!_dobDDValidSignal) {
        _dobDDValidSignal = [RACObserve(self, dobDD) map:^id(NSString *dobDD) {
            return @(dobDD.length == 2);
        }];
    }
    return _dobDDValidSignal;
}

- (RACSignal *)dobYYYYValidSignal {
    if (!_dobYYYYValidSignal) {
        _dobYYYYValidSignal = [RACObserve(self, dobYYYY) map:^id(NSString *dobYYYY) {
            return @(dobYYYY.length == 4);
        }];
    }
    return _dobYYYYValidSignal;
}

///test that the DOB fields are filled out correctly.
-(RACSignal *)dobCompletnessValidSignal {
    return [RACSignal combineLatest:@[self.dobDDValidSignal, self.dobMMValidSignal, self.dobYYYYValidSignal]
                             reduce:^(NSNumber *dobDD, NSNumber *dobMM, NSNumber *dobYYYY) {
                                 return @((dobDD.boolValue && dobMM.boolValue && dobYYYY.boolValue));
                             }];
    
}

///Only enable the verify account button when each field is filled out correctly.
-(RACSignal *)allVerifyInfoValidSignal {
    return [RACSignal combineLatest:@[self.dobCompletnessValidSignal, self.usernameValidSignal, self.firstNameValidSignal, self.lastNameValidSignal, self.zipValidSignal, self.memberIdValidSignal]
                             reduce:^(NSNumber *dob, NSNumber *username, NSNumber *firstName, NSNumber *lastName, NSNumber *zip, NSNumber *memberId) {
                                 return @((dob.boolValue && username.boolValue && firstName.boolValue && lastName.boolValue && zip.boolValue && memberId.boolValue));
                             }];
    
}







@end
