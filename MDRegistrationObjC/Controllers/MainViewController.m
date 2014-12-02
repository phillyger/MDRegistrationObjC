//
//  MainViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/2/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "MainViewController.h"
static UIStoryboard *login;
static NSString *kLoginStoryboardiPad = @"Login";

@implementation MainViewController

+(void)load
{
    login = [UIStoryboard storyboardWithName:kLoginStoryboardiPad bundle:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(openLoginStoryboard)];
}


- (void)openLoginStoryboard {
    
    UIViewController *initialDashboardController = [login instantiateInitialViewController];
    initialDashboardController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:initialDashboardController animated:YES completion:nil];
}
@end
