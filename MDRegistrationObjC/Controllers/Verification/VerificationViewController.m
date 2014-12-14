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
#import "CommonDateUtils.h"
#import "StoryboardUtils.h"

static int YYYY_MAX_VALUE = 1915;   // 100 years old
static int YYYY_MIN_VALUE = 1987;   // 18+ years old

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
         NSLog(@"%@",[NSString stringWithFormat:@"%@-%@-%@", dobYYYY, dobMM, dobDD]);
         return [NSString stringWithFormat:@"%@-%@-%@", dobYYYY, dobMM, dobDD];
     }];
    
    RAC(self.dobMMTextField, text) = [[[self.dobMMTextField.rac_textSignal map:^id(NSString *value) {
        return [value stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    }] map:^id(NSString *value) {
        if (value.length > 2) {
            return [value substringToIndex:2];
        } else {
            return value;
        }
    }] map:^id(NSString *value) {
        if ([value intValue] > 12 || (value.length == 2 && [value intValue] == 0)) {
            return @"";
        } else {
            return value;
        }
    }];
    
    RAC(self.dobDDTextField, text) = [[[self.dobDDTextField.rac_textSignal map:^id(NSString *value) {
        return [value stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    }] map:^id(NSString *value) {
        if (value.length > 2) {
            return [value substringToIndex:2];
        } else {
            return value;
        }
    }] map:^id(NSString *value) {
        if ([value intValue] > 31 || (value.length == 2 && [value intValue] == 0) ) {
            return @"";
        } else {
            return value;
        }
    }];
    
    RAC(self.dobYYYYTextField, text) = [[[self.dobYYYYTextField.rac_textSignal map:^id(NSString *value) {
        return [value stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    }] map:^id(NSString *value) {
        if (value.length > 4) {
            return [value substringToIndex:4];
        } else {
            return value;
        }
    }] map:^id(NSString *value) {
        if (value.length > 4 && ([value intValue] > YYYY_MIN_VALUE && [value intValue] < YYYY_MAX_VALUE) ) {
            return @"";
        } else {
            return value;
        }
    }];
    
    RAC(self.zipTextField, text) = [[self.zipTextField.rac_textSignal map:^id(NSString *value) {
        return [value stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    }] map:^id(NSString *value) {
        if (value.length > 5) {
            return [value substringToIndex:5];
        } else {
            return value;
        }
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verification Failure!"  message:@"We were unable to verify your account. Please contact your system admin." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)shouldGotoMainStoryboard
{
    [StoryboardUtils openMainStoryboardWithPresentingController:self];
}

@end
