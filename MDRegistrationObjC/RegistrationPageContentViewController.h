//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewControllerDelegate.h"
#import "MDReactiveView.h"

@class RegistrationPageContentTableViewController;

@interface RegistrationPageContentViewController : UIViewController <MDReactiveView, UITextFieldDelegate>

@property (nonatomic)RegistrationPageContentTableViewController *securityQuestions;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmedNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordNewTextField;


@property (nonatomic,weak) id <RegistrationViewControllerDelegate> delegate;

@property (assign)NSInteger currentIndex;


@end
