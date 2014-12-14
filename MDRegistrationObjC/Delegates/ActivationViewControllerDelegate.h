//
//  ActivationViewControllerDelegate.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActivationViewControllerDelegate <NSObject>


- (void)shouldGotoVerification;
- (void)shouldShowActivationFailureAlert;
- (void)shouldTransitionToVerification;
- (void)shouldAddAuthorizationTokenToRequestHeader:(NSString*)token;

@end
