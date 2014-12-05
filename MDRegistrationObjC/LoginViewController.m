//
//  LoginViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 11/24/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "LoginViewController.h"
#import "MDRegistrationAPIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "RegistrationViewController.h"

#import "VerificationViewController.h"

static UIStoryboard *main;
static NSString * const kMDRegistrationAPIBaseURLString = @"http://localhost:8099/app/rest";
static NSString *kMainStoryboardiPad = @"Main";

@interface LoginViewController ()
- (IBAction)login:(UIButton *)sender;

@property (nonatomic)RegistrationViewController *registerVC;
@property (nonatomic)VerificationViewController *verifyVC;
@end

@implementation LoginViewController

+(void)load
{
    main = [UIStoryboard storyboardWithName:kMainStoryboardiPad bundle:nil];

}

- (IBAction)login:(UIButton *)sender {
    
    NSDictionary *parameters = @{@"username": @"ger@brilliantage.com", @"password":@"test1"};
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] fetchFullEndPointUri:@"authenticate"];

    NSError *error = nil;
    NSMutableURLRequest *request;
    
    request = [[[MDRegistrationAPIClient sharedClient] requestSerializer] requestWithMethod:@"POST" URLString:fullEndPointUri parameters:parameters error:&error];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", [operation responseString]);
        [self openMainStoryboard];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Outcome: %@", [operation responseString]);
        NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unauthorized"  message:@"We were unable to validate your credentials. Please re-enter your credentials" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }];
    
    [operation start];
    
}


- (void)openMainStoryboard {
    
    UIViewController *initialDashboardController = [main instantiateInitialViewController];
    initialDashboardController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:initialDashboardController animated:YES completion:nil];
}

- (void)dismissAndPresentVerificationWithPasscode
{
    NSLog(@"dismissAndPresentVerificationWithPasscode...");
    
    [self performSegueWithIdentifier:@"LoginSegueVerification" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LoginSegueRegistration"]) {

        UINavigationController *regNavVC = (UINavigationController*)segue.destinationViewController;
        self.registerVC = regNavVC.childViewControllers.firstObject;
        self.registerVC.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"LoginSegueVerification"]) {
        
        UINavigationController *verifyNavVC = (UINavigationController*)segue.destinationViewController;
        
        self.verifyVC = verifyNavVC.childViewControllers.firstObject;
        
        
        
//        [self presentViewController:verifyVC animated:YES completion:^{
//            [[LTHPasscodeViewController sharedUser] showLockScreenWithAnimation:YES
//                                                                     withLogout:NO
//                                                                 andLogoutTitle:nil];
//        }];
        
    }
}

@end
