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
- (void)shouldDismissControllerWithUserInfo:(NSDictionary*)userInfo;

- (void)shouldShowRegistrationSuccessAlert;
- (void)shouldShowRegistrationFailureAlert;
- (void)shouldShowUserNotAvailableAlert;

-(void)shouldRegisterPasswordInKeychainWithUsername:(NSString*)username withPassword:(NSString*)password;

@end
