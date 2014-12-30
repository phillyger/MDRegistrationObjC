//
//  LoginViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 11/24/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewControllerDelegate.h"
#import "MDReactiveView.h"

@interface LoginViewController : UIViewController <LoginViewControllerDelegate, MDReactiveView, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end
