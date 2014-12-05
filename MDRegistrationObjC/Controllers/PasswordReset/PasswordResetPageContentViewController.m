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

@interface PasswordResetPageContentViewController ()
@property (nonatomic) BOOL usernameIsValid;

@property(nonatomic, strong) UsernameViewModel *viewModel;

@end

@implementation PasswordResetPageContentViewController


#pragma mark - Life cycle methods



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [UsernameViewModel new];
    self.viewModel.delegate = self.delegate;
    
    [self bindWithViewModel];
    
//    [[self.usernameTextField.rac_textSignal map:^id(NSString *text) {
//        return [self isValidUsername:text] ?
//        [UIColor whiteColor] : [UIColor yellowColor];
//    }]
//     subscribeNext:^(UIColor *color) {
//         self.usernameTextField.backgroundColor = color;
//     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindWithViewModel {
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    
    
    [self.delegate shouldSetSignalOnRightNavItemButton:self.viewModel.usernameCommand];

    
//    self.navigationController.navigationItem.rightBarButtonItem.rac_command = ;
//    RAC(self.statusLabel, text) = RACObserve(self.viewModel, statusMessage);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
