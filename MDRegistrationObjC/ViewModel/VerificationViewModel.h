//
//  VerificationViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/12/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "VerificationViewControllerDelegate.h"
#import "MDViewModelServices.h"

@interface VerificationViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *verifyCommand;

// write to these property
@property(nonatomic, strong) NSString *memberId;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *zip;
@property(nonatomic, strong) NSString *dobMM;
@property(nonatomic, strong) NSString *dobDD;
@property(nonatomic, strong) NSString *dobYYYY;
@property(nonatomic, strong) NSString *birthDate;

@property (nonatomic,weak) id <VerificationViewControllerDelegate> delegate;

@end
