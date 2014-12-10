//
//  LoginViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "MDViewModelServices.h"
#import "LoginViewControllerDelegate.h"

@interface LoginViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *loginCommand;

// write to these properties
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;

@property (nonatomic,weak) id <LoginViewControllerDelegate> delegate;

@end
