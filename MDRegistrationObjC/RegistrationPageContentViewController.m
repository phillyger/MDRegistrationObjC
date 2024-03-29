//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RegistrationPageContentViewController.h"
#import "RegistrationPageContentTableViewController.h"
#import "RegistrationViewController.h"

#import "RegistrationUserInfoViewModel.h"
#import "RegistrationNewAndConfirmedViewModel.h"
#import "RegistrationSecurityQuestionsViewModel.h"

#import "MDViewModelServicesImpl.h"
#import "STPhoneFormatter.h"

@interface RegistrationPageContentViewController ()

@property (strong)RACSignal *phoneNumberSignal;

@property(nonatomic, strong) id viewModel;
@property(nonatomic, strong) RegistrationUserInfoViewModel *viewModelUserInfo;      // screen #1
@property(nonatomic, strong) RegistrationNewAndConfirmedViewModel *viewModelPwdNewAndConfirmed; // screen #2
@property(nonatomic, strong) RegistrationSecurityQuestionsViewModel *viewModelSecQuestions; // screen #3

@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

@end

@implementation RegistrationPageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
//    self.titleLabel.text = self.titleText;
        self.viewModelServices = [[MDViewModelServicesImpl alloc] init];
    
//     self.usernameTextField.delegate = self;
//    self.firstNameTextField.delegate = self;
//    self.lastNameTextField.delegate = self;
//    self.phoneNumberTextField.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d", (int)self.currentIndex);
    
    
    switch ((int)self.currentIndex) {
        case 0:
            //            self.viewModelUsername = [UsernameViewModel new];
            self.viewModelUserInfo = [[RegistrationUserInfoViewModel alloc]
                                      initWithServices:self.viewModelServices];
            self.viewModelUserInfo.delegate = self.delegate;
            self.viewModel = self.viewModelUserInfo;
            break;
        case 1:
            
            self.viewModelPwdNewAndConfirmed = [[RegistrationNewAndConfirmedViewModel alloc]
                                          initWithServices:self.viewModelServices];
            self.viewModelPwdNewAndConfirmed.delegate = self.delegate;
            self.viewModel = self.viewModelPwdNewAndConfirmed;
            break;
            
        case 2:
            self.viewModelSecQuestions = [[RegistrationSecurityQuestionsViewModel alloc]
                                                initWithServices:self.viewModelServices];
            self.viewModelSecQuestions.delegate = self.delegate;
            self.viewModel = self.viewModelSecQuestions;
            break;
            
            
        default:
            break;
    }
    
    [self bindViewModel:self.viewModel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"RegistrationSegueSecurityQuestions"]) {
        
        self.securityQuestions = (RegistrationPageContentTableViewController*)segue.destinationViewController;
    }
    
}

#pragma mark - Delegate Methods
- (void)bindViewModel:(id)viewModel
{
    
    if ([self.viewModel isKindOfClass:[RegistrationUserInfoViewModel class]])
    {
        [self bindViewModelUserInfo:(RegistrationUserInfoViewModel *)self.viewModel];
    }
    else if ([self.viewModel isKindOfClass:[RegistrationNewAndConfirmedViewModel class]])
    {
        [self bindviewModelPwdNewAndConfirmedPassword:(RegistrationNewAndConfirmedViewModel *)self.viewModel];
    }
    else if ([self.viewModel isKindOfClass:[RegistrationSecurityQuestionsViewModel class]])
    {
        [self bindViewModelSecQuestions:(RegistrationSecurityQuestionsViewModel *)self.viewModel];
    }
    
    
}

#pragma mark - Custom Methods
- (void)bindViewModelUserInfo:(RegistrationUserInfoViewModel*)viewModel
{
    
    if (self.delegate && self.viewModelUserInfo.nextCommand) {
        [self.delegate shouldSetSignalOnRightNavItemButton:self.viewModelUserInfo.nextCommand];
    }
    

    
    RAC(self.viewModelUserInfo, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModelUserInfo, firstName) = self.firstNameTextField.rac_textSignal;
    RAC(self.viewModelUserInfo, lastName) = self.lastNameTextField.rac_textSignal;
    _phoneNumberSignal = self.phoneNumberTextField.rac_textSignal;
    RAC(self.viewModelUserInfo, phoneNumber) = _phoneNumberSignal;
    RAC(self.statusLabel, text) = RACObserve(self.viewModelUserInfo, statusMessage);
        self.phoneNumberTextField.delegate = self;
}

- (void)bindViewModelSecQuestions:(RegistrationSecurityQuestionsViewModel*)viewModel
{
    
    if (self.delegate && self.viewModelSecQuestions.nextCommand) {
        [self.delegate shouldSetSignalOnRightNavItemButton:self.viewModelSecQuestions.nextCommand];
    }
    
    self.viewModelSecQuestions.question1 = self.securityQuestions.question1Label.text;
    self.viewModelSecQuestions.question2 = self.securityQuestions.question2Label.text;
    self.viewModelSecQuestions.question3 = self.securityQuestions.question3Label.text;
    
    RAC(self.securityQuestions.question1Label,text) = RACObserve(self.viewModelSecQuestions, question1);
    RAC(self.securityQuestions.question2Label,text) = RACObserve(self.viewModelSecQuestions, question2);
    RAC(self.securityQuestions.question3Label,text) = RACObserve(self.viewModelSecQuestions, question3);
    
    
    RAC(self.viewModelSecQuestions, answer1) = self.securityQuestions.answer1TextField.rac_textSignal;
    RAC(self.viewModelSecQuestions, answer2) = self.securityQuestions.answer2TextField.rac_textSignal;
    RAC(self.viewModelSecQuestions, answer3) = self.securityQuestions.answer3TextField.rac_textSignal;
    
    
    //    RAC(self.statusLabel, text) = RACObserve(self.viewModelUsername, statusMessage);
}

- (void)bindviewModelPwdNewAndConfirmedPassword:(RegistrationNewAndConfirmedViewModel*)viewModel
{
    
    if (self.delegate && self.viewModelPwdNewAndConfirmed.nextCommand) {
        [self.delegate shouldSetSignalOnRightNavItemButton:self.viewModelPwdNewAndConfirmed.nextCommand];
    }
    
    RAC(self.viewModelPwdNewAndConfirmed, passwordNew) = self.passwordNewTextField.rac_textSignal;
    RAC(self.viewModelPwdNewAndConfirmed, passwordConfirmedNew) = self.passwordConfirmedNewTextField.rac_textSignal;
    
    //    RAC(self.statusLabel, text) = RACObserve(self.viewModelUsername, statusMessage);
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneNumberTextField) {
        BOOL phoneNumberHasChanged = [[STPhoneFormatter phoneFormatter] phoneNumberMustChangeInRange:range replacementString:string];
        
//        if ([[STPhoneFormatter phoneFormatter] isValid]) {
//            NSLog(@"Is Valid");
////            self.viewModelUserInfo.phoneNumber = textField.text;
//
//
//        }
        
        if (phoneNumberHasChanged) {
            textField.text = [[STPhoneFormatter phoneFormatter] formattedPhoneNumber];
        }
        [_phoneNumberSignal subscribeNext:^(id x) {
            self.viewModelUserInfo.phoneNumber = textField.text;
        }];
        
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


@end
