//
//  Activation.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "ActivationViewController.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"
#import "RegistrationViewController.h"
#import "ActivationViewModel.h"
#import "MDRegistrationAPIClient.h"
#import "VerificationViewController.h"

@interface ActivationViewController ()

@property(nonatomic, strong) ActivationViewModel *viewModel;
@property(nonatomic, strong) VerificationViewController *verificationVC;
@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

@end


@implementation ActivationViewController

- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"No Code" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModal)];
    
    self.phoneNumberLabel.text = [self.userInfo valueForKey:@"phoneNumber"];
    
    [self initializeViewModel];
}

- (void)closeModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initializeViewModel
{
    self.viewModelServices = [[MDViewModelServicesImpl alloc] init];
    self.viewModel = [[ActivationViewModel alloc] initWithServices:self.viewModelServices ];
    self.viewModel.delegate = self;
    [self bindViewModel:self.viewModel];
    
}

#pragma mark - Delegation methods
- (void)shouldShowActivationFailureAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unauthorized"  message:@"We were unable to validate your activation code. Please re-enter your activation code." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)shouldTransitionToVerification
{
    [self performSegueWithIdentifier:@"ActivationSegueVerification" sender:nil];
}

- (void)bindViewModel:(id)viewModel
{
    RAC(self.activationTokenTextField, text) = [[self.activationTokenTextField.rac_textSignal map:^id(NSString *value) {
        return [value stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    }] map:^id(NSString *value) {
        if (value.length > 4) {
            return [value substringToIndex:4];
        } else {
            return value;
        }
    }];
    
    RAC(self.viewModel, activationToken) = self.activationTokenTextField.rac_textSignal;
    self.activationButton.rac_command = self.viewModel.activateCommand;
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"ActivationSegueVerification"]) {
        return YES;
    }
    
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"ActivationSegueVerification"]) {
        self.verificationVC = (VerificationViewController*)segue.destinationViewController;
        self.verificationVC.userInfo = [self.userInfo copy];
    }
}

- (void)shouldAddAuthorizationTokenToRequestHeader:(NSString *)token
{
    [[MDRegistrationAPIClient sharedClient] setAuthorizationTokenHeaderWithToken:token];
}

@end
