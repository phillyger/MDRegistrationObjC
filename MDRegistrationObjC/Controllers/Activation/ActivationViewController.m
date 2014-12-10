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

@interface ActivationViewController ()

@property(nonatomic, strong) ActivationViewModel *viewModel;
@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

@end


@implementation ActivationViewController

- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"No Code" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModal)];
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

- (void)shouldGotoVerification
{
    
}

- (void)bindViewModel:(id)viewModel
{
    self.activationButton.rac_command = self.viewModel.activateCommand;
    RAC(self.viewModel, activationToken) = self.activationTokenTextField.rac_textSignal;

}

@end
