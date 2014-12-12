//
//  RegistrationSecurityQuestionsViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "RegistrationSecurityQuestionsViewModel.h"
#import "AFHTTPRequestOperationManager+RACSupport.h"
#import "NSString+EmailAdditions.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDRegistrationAPIClient.h"
#import "MDViewModelServicesImpl.h"
#import "RegistrationPageContentViewController.h"

@interface RegistrationSecurityQuestionsViewModel ()
@property (weak, nonatomic) id<MDViewModelServices> services;

@property(nonatomic, strong) RACSignal *answer1ValidSignal;
@property(nonatomic, strong) RACSignal *answer2ValidSignal;
@property(nonatomic, strong) RACSignal *answer3ValidSignal;

@property(nonatomic, strong) RACSignal *question1ValidSignal;
@property(nonatomic, strong) RACSignal *question2ValidSignal;
@property(nonatomic, strong) RACSignal *question3ValidSignal;

@property(nonatomic, strong) RACSignal *allAnsweredSignal;

@end

@implementation RegistrationSecurityQuestionsViewModel


- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
        [self initialize];
        
    }
    return self;
}

- (void)initialize
{

    NSString *placeHolderText= @"Tap to select a question";
    self.question1 = placeHolderText;
    self.question2 = placeHolderText;
    self.question3 = placeHolderText;
        
        

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
            [self.delegate shouldSubmitRegistration];
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

- (RACSignal *)question1ValidSignal {
    if (!_question1ValidSignal) {
        _question1ValidSignal = [RACObserve(self, question1) map:^id(NSString *question) {
            NSLog(@"question1ValidSignal: %@",@(question.length > 1));
            return @(question.length > 1);
        }];
    }
    return _question1ValidSignal;
}

- (RACSignal *)question2ValidSignal {
    if (!_question2ValidSignal) {
        _question2ValidSignal = [RACObserve(self, question2) map:^id(NSString *question) {
            NSLog(@"question2ValidSignal: %@",@(question.length > 1));
            return @(question.length > 1);
        }];
    }
    return _question2ValidSignal;
}

- (RACSignal *)question3ValidSignal {
    if (!_question3ValidSignal) {
        _question3ValidSignal = [RACObserve(self, question3) map:^id(NSString *question) {
            NSLog(@"question3ValidSignal: %@",@(question.length > 1));
            return @(question.length > 1);
        }];
    }
    return _question3ValidSignal;
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
