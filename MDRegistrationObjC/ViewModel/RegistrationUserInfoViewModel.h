//
//  RegistrationUserInfoViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "RegistrationViewControllerDelegate.h"
#import "MDViewModelServices.h"

@interface RegistrationUserInfoViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *nextCommand;

// write to this property
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *phoneNumber;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@property (nonatomic,weak) id <RegistrationViewControllerDelegate> delegate;


@end
