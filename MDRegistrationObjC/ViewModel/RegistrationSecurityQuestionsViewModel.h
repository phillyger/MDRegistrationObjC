//
//  RegistrationSecurityQuestionsViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "RegistrationViewControllerDelegate.h"
#import "MDViewModelServices.h"

@interface RegistrationSecurityQuestionsViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *nextCommand;
@property(nonatomic, strong) RACCommand *tapSecQuestionLabelCommand;

// write to these property

@property(nonatomic, strong) NSArray *questions;

@property(nonatomic, strong) NSString *username;

@property(nonatomic, strong) NSString *answer1;
@property(nonatomic, strong) NSString *answer2;
@property(nonatomic, strong) NSString *answer3;

@property(nonatomic, strong) NSString *question1;
@property(nonatomic, strong) NSString *question2;
@property(nonatomic, strong) NSString *question3;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@property (nonatomic,weak) id <RegistrationViewControllerDelegate> delegate;
@end
