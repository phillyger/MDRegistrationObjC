//
//  VerificationViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/4/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "VerificationViewController.h"
#import "LTHPasscodeViewController.h"

@implementation VerificationViewController

- (void)viewDidLoad
{
    
    [LTHPasscodeViewController sharedUser].enterPasscodeString= @"Enter Activation Code";
//    [LTHPasscodeViewController sharedUser].enablePasscodeString = @"Enter Activation Code";
//    [LTHPasscodeViewController sharedUser].enterNewPasscodeString = @"Enter Activation Code";
//    [LTHPasscodeViewController sharedUser].enterOldPasscodeString = @"Re-Enter Activation Code";

    [[LTHPasscodeViewController sharedUser] showLockScreenWithAnimation:YES
                                                                 withLogout:NO
                                                             andLogoutTitle:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleBordered target:self action:@selector(submit)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModal)];
}

- (void)closeModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submit
{
    NSLog(@"Submit verification...");
}


@end
