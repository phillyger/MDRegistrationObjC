//
//  RegistrationPageViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/2/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "RegistrationPageViewController.h"

@interface RegistrationPageViewController ()
- (void)loadNextPage;
@end

@implementation RegistrationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
          self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(loadNextPage)];
}

- (void)loadNextPage
{
    NSLog(@"Run next page...");
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

@end
