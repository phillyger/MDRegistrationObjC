//
//  RegistrationViewControllerDelegate.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@protocol RegistrationViewControllerDelegate <NSObject>
- (void)shouldSetSignalOnRightNavItemButton:(RACCommand*)command;

- (void)shouldLoadNextPage;
- (void)shouldLoadPreviousPage;
- (void)shouldSubmitRegistration;
- (void)shouldDismissController;

- (void)shouldShowRegistrationSuccessAlert;
- (void)shouldShowRegistrationFailureAlert;

@end
