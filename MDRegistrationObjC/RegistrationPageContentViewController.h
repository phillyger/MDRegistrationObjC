//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegistrationPageContentTableViewController;

//@interface PageContentViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@interface RegistrationPageContentViewController : UIViewController

@property (nonatomic)RegistrationPageContentTableViewController *securityQuestions;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UITextField *passwordNew;

@end
