//
//  RegistrationNewAndConfirmedViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "RegistrationNewAndConfirmedViewModel.h"
#import "AFHTTPRequestOperationManager+RACSupport.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDRegistrationAPIClient.h"
#import "MDViewModelServicesImpl.h"

@interface RegistrationNewAndConfirmedViewModel ()
@property (weak, nonatomic) id<MDViewModelServices> services;

@property(nonatomic, strong) RACSignal *passwordNewValidSignal;
@property(nonatomic, strong) RACSignal *passwordConfirmedNewValidSignal;

@end

@implementation RegistrationNewAndConfirmedViewModel



- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
    }
    return self;
}

- (RACCommand *)nextCommand {
    if (!_nextCommand) {
//        @weakify(self);
        _nextCommand = [[RACCommand alloc] initWithEnabled:self.passwordsValidSignal signalBlock:^RACSignal *(id input) {
//            @strongify(self);
            
            [self.delegate shouldLoadNextPage];
            return [RACSignal empty];
        }];
    }
    return _nextCommand;
}

- (RACSignal *)passwordNewValidSignal {
    if (!_passwordNewValidSignal) {
        _passwordNewValidSignal = [RACObserve(self, passwordNew) map:^id(NSString *password) {
            NSLog(@"passwordNewValidSignal: %@",@(password.length > 1));
            return @(password.length > 1);
        }];
    }
    return _passwordNewValidSignal;
}


- (RACSignal *)passwordConfirmedNewValidSignal {
    if (!_passwordConfirmedNewValidSignal) {
        _passwordConfirmedNewValidSignal = [RACObserve(self, passwordConfirmedNew) map:^id(NSString *password) {
            NSLog(@"passwordConfirmedNewValidSignal: %@",@(password.length > 1));
            return @(password.length > 1);
        }];
    }
    return _passwordConfirmedNewValidSignal;
}



//-(BOOL)isValidAnswer:(NSString*)answer
//{
//    NSLog(@"Output: %@", @(answer.length > 1));
//    return @(answer.length > 1);
//}

///Only enable the create account button when each field is filled out correctly.
-(RACSignal *)allPasswordsEnteredSignal {
    return [RACSignal combineLatest:@[self.passwordNewValidSignal, self.passwordConfirmedNewValidSignal]
                             reduce:^(NSNumber *passwordNew, NSNumber *passwordConfirmedNew) {
                                 return @((passwordNew.boolValue && passwordConfirmedNew.boolValue));
                             }];
    
}

-(RACSignal *)passwordsNewAndConfirmedMatchSignal {
    return [RACSignal combineLatest:@[RACObserve(self, passwordNew), RACObserve(self, passwordConfirmedNew)]
                             reduce:^(NSString *passwordNew, NSString *passwordConfirmedNew) {
                                 return @(([passwordConfirmedNew isEqualToString:passwordNew]));
                             }];
    
}

-(RACSignal *)passwordsValidSignal {
    return [RACSignal combineLatest:@[self.allPasswordsEnteredSignal, self.passwordsNewAndConfirmedMatchSignal]
                             reduce:^(NSNumber *allPasswordsEntered, NSNumber *passwordsNewAndConfirmedMatch) {
                                 return @((allPasswordsEntered.boolValue && passwordsNewAndConfirmedMatch.boolValue));
                             }];
    
}



@end
