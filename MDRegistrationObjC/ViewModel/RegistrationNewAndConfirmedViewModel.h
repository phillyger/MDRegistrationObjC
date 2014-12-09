//
//  RegistrationNewAndConfirmedViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "RegistrationViewControllerDelegate.h"
#import "MDViewModelServices.h"

@interface RegistrationNewAndConfirmedViewModel : NSObject


- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *nextCommand;

// write to this property
@property(nonatomic, strong) NSString *passwordNew;
@property(nonatomic, strong) NSString *passwordConfirmedNew;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@property (nonatomic,weak) id <RegistrationViewControllerDelegate> delegate;

@end
