//
//  PasswordResetPageContentViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/3/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordResetViewControllerDelegate.h"

@interface PasswordResetPageContentViewController : UIViewController

@property NSUInteger pageIndex;


@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (nonatomic,weak) id <PasswordResetViewControllerDelegate> delegate;

@end
