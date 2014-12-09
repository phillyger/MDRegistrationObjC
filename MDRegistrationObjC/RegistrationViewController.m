//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RegistrationViewController.h"
#import "MDRegistrationAPIClient.h"
#import "AFHTTPRequestOperationManager.h"

#import "LoginViewController.h"
#import "SVProgressHUD.h"

@interface RegistrationViewController ()

@property (assign)NSInteger maxPages;
@property (assign)NSInteger currentIndex;


- (void)loadNextPage;
- (void)loadPreviousPage;

@property (nonatomic, strong) NSArray *contentViewControllers;

@end

@implementation RegistrationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    
    // set current index
    self.currentIndex = 0;
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationPageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(loadNextPage)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closePage)];
    
    self.contentViewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationContent1ViewController"], [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationContent2ViewController"], [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationContent3ViewController"]];
    
    self.maxPages = self.contentViewControllers.count;

    
 
    [self.pageViewController setViewControllers:@[self.contentViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    // Configure page controller
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.backgroundColor = [UIColor whiteColor];
    self.pageControl.numberOfPages = _maxPages;
    self.pageControl.currentPage = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBarButtons
{
    
    if ((_currentIndex) != _maxPages) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(loadNextPage)];
        
    }
    
    if ((_currentIndex+1) == _maxPages) {
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleBordered target:self action:@selector(submit)];
        
    }
    
    if (_currentIndex == 0 ) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closePage)];
    }
    
    
    if (_currentIndex > 0 ) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(loadPreviousPage)];
    }
    
}

- (NSDictionary*)buildPayload
{
    
    NSLog(@"Submit this content:" );

    // Create new mutable dictionary
    NSMutableDictionary *mutableDict = [NSMutableDictionary new];
    
    // Controller #1
    RegistrationPageContentViewController *vc = (RegistrationPageContentViewController*)self.contentViewControllers[0];
    
    NSDictionary *dict1 = @{
    @"firstName": vc.firstName.text,
    @"lastName": vc.lastName.text,
    @"username": vc.username.text };

        [mutableDict addEntriesFromDictionary:dict1];
    
    // Controller #2
    vc = (RegistrationPageContentViewController*)self.contentViewControllers[1];
    NSDictionary *dict2 = @{@"password": vc.passwordNew.text};
    [mutableDict addEntriesFromDictionary:dict2];
    
    
      // Controller #3
     vc = (RegistrationPageContentViewController*)self.contentViewControllers[2];
    
    RegistrationPageContentTableViewController *secQuestionsVc = (RegistrationPageContentTableViewController *)vc.securityQuestions;
    
    
    NSDictionary *securityQuestion1Dict = @{@"question": [[secQuestionsVc question1Label] text],
                                            @"answer":[[secQuestionsVc answer1TextField] text]};
    NSDictionary *securityQuestion2Dict = @{@"question": [[secQuestionsVc question2Label] text],
                                            @"answer":[[secQuestionsVc answer2TextField] text]};
    NSDictionary *securityQuestion3Dict = @{@"question": [[secQuestionsVc question3Label] text],
                                            @"answer":[[secQuestionsVc answer3TextField] text]};
    
    NSArray *securityQuestionsList = @[securityQuestion1Dict, securityQuestion2Dict, securityQuestion3Dict];
    
    NSDictionary *dict3 = @{@"securityQuestions":securityQuestionsList};

    
    
        [mutableDict addEntriesFromDictionary:dict3];
    
    NSLog(@"%@", mutableDict);
    
    return [mutableDict copy];
}

- (NSDictionary*)buildPayloadMock
{
    return @{@"firstName" : @"Ger",
             @"lastName" : @"O'Sullivan",
             @"password" : @"test1",
             @"securityQuestions" :  @[
                             @{
                                 @"answer" : @"Dublin",
                                 @"question" : @"What city where you born in?"
                             },
                             @{
                                 @"answer" : @"Meyers",
                                 @"question" : @"What was your first pet's name?"
                             },
                             @{
                                 @"answer" : @"Mini",
                                 @"question" : @"What is the make of your first car?"
                             }
                             ],
             @"username" : @"ger@brilliantage.com"
             };
    
}
- (void)submit {
    
//    NSDictionary *parameters = [self buildPayloadMock];
    NSDictionary *parameters = [self buildPayload];
    NSString *fullEndPointUri = [[MDRegistrationAPIClient sharedClient] appendPathVarToEndPointUri:@"register"];
    
    NSError *error = nil;
    NSMutableURLRequest *request;
    
    
    
    request = [[[MDRegistrationAPIClient sharedClient] requestSerializer] requestWithMethod:@"POST" URLString:fullEndPointUri parameters:parameters error:&error];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", [operation responseString]);
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Complete!"  message:@"Your registration was successful. We have sent an activation code to the phone number you registered with. Please use this activation code to..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        

        
        NSLog(@"Transition");
        
        __weak RegistrationViewController *weakSelf = self;
        
        [weakSelf dismissViewControllerAnimated:YES completion:^{
           
            [[weakSelf delegate] dismissAndPresentVerificationWithPasscode];
            
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unauthorized"  message:@"We were unable to register your account. Please contact your system admin." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }];
    
    
    
    [SVProgressHUD show];

    
    
    [operation start];
    
}

- (void)loadNextPage
{
    
    _currentIndex++;
    
    self.pageControl.currentPage = _currentIndex;
    
    [self setNavigationBarButtons];
    
    [self moveToIndex:_currentIndex];

}

- (void)loadPreviousPage
{
    _currentIndex--;
    
    self.pageControl.currentPage = _currentIndex;
    
    [self setNavigationBarButtons];
    
    [self moveToIndex:_currentIndex];

}

- (void)moveToIndex:(NSInteger)index
{
    
    [self viewControllerAtIndex:index];
}

- (void)closePage
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit Registration" message:@"Are you sure you want to cancel setting up account access?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
//        NSLog(@"You have clicked No");
        
    }
}


- (RegistrationPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    if ((_maxPages == 0) || (index >= _maxPages)) {
        return nil;
    }
    
    [self.pageViewController setViewControllers:@[self.contentViewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _currentIndex = index;

    return self.contentViewControllers[index];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }

    return self.contentViewControllers[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    
    if (index >= self.contentViewControllers.count - 1) {
        return nil;
    }
    
    return self.contentViewControllers[index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.contentViewControllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return _currentIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // Find index of current page
    RegistrationPageContentViewController *currentViewController = (RegistrationPageContentViewController *)[self.pageViewController.viewControllers lastObject];
    _currentIndex = [self.contentViewControllers indexOfObjectIdenticalTo:currentViewController];
    
    [self setNavigationBarButtons];

    self.pageControl.currentPage = _currentIndex;
    
}

- (void)savePasscode:(NSString *)passcode
{
    NSLog(@"passcode: %@", passcode);
}

@end
