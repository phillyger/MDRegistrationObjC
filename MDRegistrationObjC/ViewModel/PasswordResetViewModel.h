//
//  PasswordResetViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "MDViewModelServices.h"
#import "PasswordResetViewControllerDelegate.h"

@interface PasswordResetViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

-(void)subscribeToResetPassword:(NSDictionary*)userInfo;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@property (nonatomic,weak) id <PasswordResetViewControllerDelegate> delegate;

@end
