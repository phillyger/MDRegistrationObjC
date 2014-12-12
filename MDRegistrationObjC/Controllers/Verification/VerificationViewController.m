//
//  VerificationViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/4/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "VerificationViewController.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"
#import "VerificationViewModel.h"

@interface VerificationViewController ()

@property(nonatomic, strong) VerificationViewModel *viewModel;
@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

@end

@implementation VerificationViewController

- (void)viewDidLoad
{
    
    self.navigationItem.hidesBackButton = YES;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Verify" style:UIBarButtonItemStyleBordered target:self action:nil];

    [self initializeViewModel];
    
}

- (void)closeModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initializeViewModel
{
    self.viewModelServices = [[MDViewModelServicesImpl alloc] init];
    self.viewModel = [[VerificationViewModel alloc] initWithServices:self.viewModelServices ];
    self.viewModel.delegate = self;
    [self bindViewModel:self.viewModel];
    
}

- (void)submit
{
    NSLog(@"Submit verification...");
}

- (void)bindViewModel:(id)viewModel
{
    RAC(self.viewModel, birthDate) = [RACSignal
     combineLatest:@[self.dobDDTextField.rac_textSignal, self.dobMMTextField.rac_textSignal, self.dobYYYYTextField.rac_textSignal]
     reduce:(id)^id(NSString *dobDD, NSString *dobMM, NSString *dobYYYY){
         return [NSString stringWithFormat:@"%@-%@-%@", dobMM, dobDD, dobYYYY];
     }];
    
    
    RAC(self.viewModel, memberId) = self.memberIdTextField.rac_textSignal;
    RAC(self.viewModel, firstName) = self.firstNameTextField.rac_textSignal;
    RAC(self.viewModel, lastName) = self.lastNameTextField.rac_textSignal;
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, zip) = self.zipTextField.rac_textSignal;
    RAC(self.viewModel, dobMM) = self.dobMMTextField.rac_textSignal;
    RAC(self.viewModel, dobDD) = self.dobDDTextField.rac_textSignal;
    RAC(self.viewModel, dobYYYY) = self.dobYYYYTextField.rac_textSignal;
    
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.verifyCommand;
}

- (void)shouldShowVerificationFailureAlert
{
    
}


@end
