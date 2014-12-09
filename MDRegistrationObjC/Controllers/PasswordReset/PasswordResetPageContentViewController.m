//
//  PasswordResetPageContentViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/3/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "PasswordResetPageContentViewController.h"
#import <ReactiveCocoa.h>
#import "UsernameViewModel.h"
#import "PasswordResetViewController.h"
#import "PasswordResetSecurityQuestionsViewModel.h"
#import "MDViewModelServicesImpl.h"
#import "PasswordResetPageViewController.h"

@interface PasswordResetPageContentViewController ()
@property (nonatomic) BOOL usernameIsValid;

@property(nonatomic, strong) id viewModel;
@property(nonatomic, strong) UsernameViewModel *viewModelUsername;
@property(nonatomic, strong) PasswordResetSecurityQuestionsViewModel *viewModelSecQuestions;

@property(nonatomic, weak) PasswordResetPageViewController *parentVC;
@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

@end

@implementation PasswordResetPageContentViewController


#pragma mark - Life cycle methods



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModelServices = [[MDViewModelServicesImpl alloc] init];
    self.parentVC = (PasswordResetPageViewController*)self.parentViewController;

}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d", (int)self.currentIndex);
    

    switch ((int)self.currentIndex) {
        case 0:
//            self.viewModelUsername = [UsernameViewModel new];
            self.viewModelUsername = [[UsernameViewModel alloc]
                              initWithServices:self.viewModelServices];
            self.viewModelUsername.delegate = self.delegate;
            self.viewModel = self.viewModelUsername;
            break;
        case 1:
    
            self.viewModelSecQuestions = [[PasswordResetSecurityQuestionsViewModel alloc]
                              initWithUsername:[self.parentVC username] withServices:self.viewModelServices];
            self.viewModelSecQuestions.delegate = self.delegate;
            self.viewModel = self.viewModelSecQuestions;
            break;
        default:
            break;
    }
    
    [self bindViewModel:self.viewModel];
    

}

- (void)bindViewModel:(id)viewModel
{
    
    if ([self.viewModel isKindOfClass:[UsernameViewModel class]]) {
        [self bindViewModelUsername:(UsernameViewModel *)self.viewModel];
    } else {
        [self bindViewModelSecQuestions:(PasswordResetSecurityQuestionsViewModel *)self.viewModel];
    }
    

}

- (void)bindViewModelUsername:(UsernameViewModel*)viewModel
{
    
    if (self.delegate && self.viewModelUsername.nextCommand) {
        [self.delegate shouldSetSignalOnRightNavItemButton:self.viewModelUsername.nextCommand];
    }
    
    RAC(self.viewModelUsername, username) = self.usernameTextField.rac_textSignal;
    RAC(self.statusLabel, text) = RACObserve(self.viewModelUsername, statusMessage);
}

- (void)bindViewModelSecQuestions:(PasswordResetSecurityQuestionsViewModel*)viewModel
{
    
    if (self.delegate && self.viewModelSecQuestions.nextCommand) {
        [self.delegate shouldSetSignalOnRightNavItemButton:self.viewModelSecQuestions.nextCommand];
    }
    
    RAC(self.viewModelSecQuestions, answer1) = self.securityQuestions.answer1TextField.rac_textSignal;
     RAC(self.viewModelSecQuestions, answer2) = self.securityQuestions.answer2TextField.rac_textSignal;
     RAC(self.viewModelSecQuestions, answer3) = self.securityQuestions.answer3TextField.rac_textSignal;
    
//    RAC(self.statusLabel, text) = RACObserve(self.viewModelUsername, statusMessage);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"PasswordResetSegueSecurityQuestions"]) {
        
        self.securityQuestions = (RegistrationPageContentTableViewController*)segue.destinationViewController;
    }
    
}




@end
