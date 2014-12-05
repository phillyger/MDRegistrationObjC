//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RegistrationPageContentViewController.h"
#import "RegistrationPageContentTableViewController.h"

@interface RegistrationPageContentViewController ()

//@property NSArray *pickerData;

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

@end
