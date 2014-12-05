//
//  LoginViewControllerDelegate.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/4/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginViewControllerDelegate <NSObject>

- (void)dismissAndPresentVerificationWithPasscode;

@end
