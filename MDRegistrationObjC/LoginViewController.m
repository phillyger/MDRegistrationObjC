//
//  LoginViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 11/24/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"
#import "RegistrationViewController.h"
#import "LoginViewModel.h"

#import "VerificationViewController.h"
#import "ActivationViewController.h"

static UIStoryboard *main;
static NSString * const kMDRegistrationAPIBaseURLString = @"http://localhost:8099/app/rest";
static NSString *kMainStoryboardiPad = @"Main";

@interface LoginViewController ()

@property (nonatomic)RegistrationViewController *registerVC;
@property (nonatomic)VerificationViewController *verifyVC;
@property (nonatomic)ActivationViewController *activationVC;

@property(nonatomic, strong) LoginViewModel *viewModel;
@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

@end

@implementation LoginViewController

+(void)load
{
    main = [UIStoryboard storyboardWithName:kMainStoryboardiPad bundle:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self initializeViewModel];
}

- (void)initializeViewModel
{
    self.viewModelServices = [[MDViewModelServicesImpl alloc] init];
    self.viewModel = [[LoginViewModel alloc] initWithServices:self.viewModelServices ];
    self.viewModel.delegate = self;
    [self bindViewModel:self.viewModel];
    
}


- (void)openMainStoryboard {
    
    UIViewController *initialDashboardController = [main instantiateInitialViewController];
    initialDashboardController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:initialDashboardController animated:YES completion:nil];
}

- (void)shouldPresentActivationModalWithUserInfo:(NSDictionary*)userInfo
{
    NSLog(@"shouldPresentActivationModalWithUserInfo...");
    
    [self performSegueWithIdentifier:@"LoginSegueActivation" sender:userInfo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LoginSegueRegistration"]) {

        UINavigationController *regNavVC = (UINavigationController*)segue.destinationViewController;
        self.registerVC = regNavVC.childViewControllers.firstObject;
        self.registerVC.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"LoginSegueActivation"]) {
        
        UINavigationController *activationNavVC = (UINavigationController*)segue.destinationViewController;
        
        self.activationVC = (ActivationViewController*)activationNavVC.childViewControllers.firstObject;
        self.activationVC.userInfo = (NSDictionary*)[sender copy];
    }
}

#pragma mark - Delegation methods
- (void)shouldGotoMainStoryboard
{
    [self openMainStoryboard];
}

- (void)shouldShowLoginFailureAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unauthorized"  message:@"We were unable to validate your credentials. Please re-enter your credentials" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)bindViewModel:(id)viewModel
{

    self.loginButton.rac_command = self.viewModel.loginCommand;
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    
}

@end
