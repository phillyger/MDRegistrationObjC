//
//  VerificationViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/4/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerificationViewControllerDelegate.h"
#import "MDReactiveView.h"

@interface VerificationViewController : UIViewController <VerificationViewControllerDelegate, MDReactiveView>


@property (weak, nonatomic) IBOutlet UITextField *memberIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobMMTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobDDTextField;
@property (weak, nonatomic) IBOutlet UITextField *dobYYYYTextField;


@end
