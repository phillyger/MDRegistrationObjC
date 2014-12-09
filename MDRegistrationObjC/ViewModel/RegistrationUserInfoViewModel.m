//
//  RegistrationUserInfoViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "RegistrationUserInfoViewModel.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"


@interface RegistrationUserInfoViewModel ()
@property (weak, nonatomic) id<MDViewModelServices> services;

@property(nonatomic, strong) RACSignal *usernameValidSignal;
@property(nonatomic, strong) RACSignal *firstNameValidSignal;
@property(nonatomic, strong) RACSignal *lastNameValidSignal;
@property(nonatomic, strong) RACSignal *phoneNumberValidSignal;

@end

@implementation RegistrationUserInfoViewModel


- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
//        [self mapNextCommandStateToStatusMessage];
    }
    return self;
}


- (void)mapNextCommandStateToStatusMessage {
    RACSignal *startedMessageSource = [self.nextCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
        return NSLocalizedString(@"Sending request...", nil);
    }];
    
    RACSignal *completedMessageSource = [self.nextCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
        return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
            return event.eventType == RACEventTypeCompleted;
        }] map:^id(id value) {
            return NSLocalizedString(@"Thanks", nil);
        }];
    }];
    
    RACSignal *failedMessageSource = [[self.nextCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
        return NSLocalizedString(@"Error :(", nil);
    }];
    
    RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
}


- (RACCommand *)nextCommand {
    if (!_nextCommand) {
        @weakify(self);
        _nextCommand = [[RACCommand alloc] initWithEnabled:self.usernameValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            return [self checkIsAvailable:self.username];
            
            //			return [RACSignal empty];
        }];
    }
    return _nextCommand;
}

- (RACSignal *)checkIsAvailable:(NSString *)username {
    
    @weakify(self);
    
    
    return [[[self.services getMDRegistrationService] isAvailable:username]
            doNext:^(RACTuple *JSONAndHeaders) {
                @strongify(self);
                
                NSArray *tupleList =[JSONAndHeaders allObjects];
                NSLog(@"%@", tupleList.lastObject);
                NSDictionary *responseDict = tupleList.lastObject;
                
                NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];
                
                if ([outcomeCode intValue] == 200000) {
                    
                    NSLog(@"good to go");
                    [self.delegate shouldLoadNextPage];
                } else {
                    NSLog(@"stop");
                }
            }];
    
}



- (RACSignal *)usernameValidSignal {
    if (!_usernameValidSignal) {
        _usernameValidSignal = [RACObserve(self, username) map:^id(NSString *email) {
            return @([email isValidEmail]);
        }];
    }
    return _usernameValidSignal;
}

@end