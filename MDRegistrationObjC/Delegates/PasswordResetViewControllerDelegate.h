//
//  PasswordResetControllerDelegate.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/5/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@protocol PasswordResetViewControllerDelegate <NSObject>

- (void)shouldSetSignalOnRightNavItemButton:(RACCommand*)command;

- (void)shouldLoadNextPage;
- (void)shouldLoadPreviousPage;
- (void)shouldSubmitPasswordReset;
- (void)shouldDismissController;

@end
