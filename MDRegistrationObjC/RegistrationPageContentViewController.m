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


@interface RegistrationPageContentViewController ()

@property(nonatomic, strong) id viewModel;
@property(nonatomic, strong) RegistrationUserInfoViewModel *viewModelUsername;      // screen #1
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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d", (int)self.currentIndex);
    
    
    switch ((int)self.currentIndex) {
        case 0:
            //            self.viewModelUsername = [UsernameViewModel new];
            self.viewModelUsername = [[RegistrationUserInfoViewModel alloc]
                                      initWithServices:self.viewModelServices];
            self.viewModelUsername.delegate = self.delegate;
            self.viewModel = self.viewModelUsername;
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
    
}

@end
