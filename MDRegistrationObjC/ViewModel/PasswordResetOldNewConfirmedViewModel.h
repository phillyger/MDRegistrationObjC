//
//  PasswordResetOldNewConfirmedViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "PasswordResetViewControllerDelegate.h"
#import "MDViewModelServices.h"

@interface PasswordResetOldNewConfirmedViewModel : NSObject

- (instancetype)initWithUsername:(NSString*)username withServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *nextCommand;

@property(nonatomic, strong) NSString *username;

@property(nonatomic, strong) NSString *passwordOld;
@property(nonatomic, strong) NSString *passwordNew;
@property(nonatomic, strong) NSString *passwordConfirmedNew;

@property (nonatomic,weak) id <PasswordResetViewControllerDelegate> delegate;

@end
