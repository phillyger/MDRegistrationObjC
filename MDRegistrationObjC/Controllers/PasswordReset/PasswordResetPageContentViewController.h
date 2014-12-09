//
//  PasswordResetPageContentViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/3/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordResetViewControllerDelegate.h"
#import "RegistrationPageContentTableViewController.h"
#import "MDReactiveView.h"

@interface PasswordResetPageContentViewController : UIViewController <MDReactiveView>

@property (nonatomic)RegistrationPageContentTableViewController *securityQuestions;
@property NSUInteger pageIndex;


@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic,weak) id <PasswordResetViewControllerDelegate> delegate;

@property (assign)NSInteger currentIndex;

@end
