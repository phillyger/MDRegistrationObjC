//
//  LoginViewControllerDelegate.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/4/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)shouldPresentActivationModalWithUserInfo:(NSDictionary*)userInfo;
- (void)shouldGotoMainStoryboard;
- (void)shouldShowLoginFailureAlert;

@end
