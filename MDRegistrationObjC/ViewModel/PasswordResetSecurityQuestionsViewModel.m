//
//  PasswordResetSecurityQuestionsViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "PasswordResetSecurityQuestionsViewModel.h"
#import "AFHTTPRequestOperationManager+RACSupport.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDRegistrationAPIClient.h"
#import "MDViewModelServicesImpl.h"
#import "PasswordResetPageContentViewController.h"

@interface PasswordResetSecurityQuestionsViewModel ()
@property (weak, nonatomic) id<MDViewModelServices> services;

@property(nonatomic, strong) RACSignal *answer1ValidSignal;
@property(nonatomic, strong) RACSignal *answer2ValidSignal;
@property(nonatomic, strong) RACSignal *answer3ValidSignal;

@property(nonatomic, strong) RACSignal *allAnsweredSignal;

@end

@implementation PasswordResetSecurityQuestionsViewModel



- (instancetype)initWithUsername:(NSString*)username withServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        _username = username;
        
        [self initialize];

    }
    return self;
}

- (void)initialize
{
    [[self fetchQuestions:_username] subscribeNext:^(NSDictionary *response) {
        //            NSLog(@"hello");
        //            NSLog(@"%@", response);
        //            NSLog(@"%@", [response valueForKeyPath:@"data.question1"]);
        //            NSLog(@"%@", [response valueForKeyPath:@"data.question2"]);
        //            NSLog(@"%@", [response valueForKeyPath:@"data.question3"]);
        //
        self.question1 = [response valueForKeyPath:@"data.question1"];
        self.question2 = [response valueForKeyPath:@"data.question2"];
        self.question3 = [response valueForKeyPath:@"data.question3"];
        
        
    } completed:^{
        // do nothing
    }];
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
        _nextCommand = [[RACCommand alloc] initWithEnabled:self.allAnsweredSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            
//            return [self checkIsAvailable:self.username];
            [self.delegate shouldLoadNextPage];
            			return [RACSignal empty];
        }];
    }
    return _nextCommand;
}

- (RACSignal *)answer1ValidSignal {
    if (!_answer1ValidSignal) {
        _answer1ValidSignal = [RACObserve(self, answer1) map:^id(NSString *answer) {
            NSLog(@"answer1ValidSignal: %@",@(answer.length > 1));
            return @(answer.length > 1);
        }];
    }
    return _answer1ValidSignal;
}

- (RACSignal *)answer2ValidSignal {
    if (!_answer2ValidSignal) {
        _answer2ValidSignal = [RACObserve(self, answer2) map:^id(NSString *answer) {
            NSLog(@"answer2ValidSignal: %@",@(answer.length > 1));
            return @(answer.length > 1);
        }];
    }
    return _answer2ValidSignal;
}

- (RACSignal *)answer3ValidSignal {
    if (!_answer3ValidSignal) {
        _answer3ValidSignal = [RACObserve(self, answer3) map:^id(NSString *answer) {
            NSLog(@"answer3ValidSignal: %@",@(answer.length > 1));
            return @(answer.length > 1);
        }];
    }
    return _answer3ValidSignal;
}



//-(BOOL)isValidAnswer:(NSString*)answer
//{
//    NSLog(@"Output: %@", @(answer.length > 1));
//    return @(answer.length > 1);
//}

///Only enable the create account button when each field is filled out correctly.
-(RACSignal *)allAnsweredSignal {
    return [RACSignal combineLatest:@[self.answer1ValidSignal, self.answer2ValidSignal, self.answer3ValidSignal]
                      reduce:^(NSNumber *answer1, NSNumber *answer2, NSNumber *answer3) {
                          return @((answer1.boolValue && answer2.boolValue && answer3.boolValue));
                      }];
    
}


- (RACSignal *)fetchQuestions:(NSString *)username {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
//        @weakify(self);
        
        [[[[self.services getMDRegistrationService] questionsByAccount:username]
            map:^id(RACTuple *tuple) {
                return tuple.second;
            }]
            subscribeNext:^(NSDictionary *dict) {
                [subscriber sendNext:dict];
                [subscriber sendCompleted];
            }];
        // 6. When we are done, remvoe the reference to this request
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


@end
