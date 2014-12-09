//
//  PasswordResetViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/3/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "PasswordResetViewController.h"
#import "PasswordResetPageContentViewController.h"

@interface PasswordResetViewController ()

@property (assign)NSInteger maxPages;
@property (assign)NSInteger currentIndex;


- (BOOL)loadNextPage;
- (BOOL)loadPreviousPage;

@property (nonatomic, strong) NSArray *contentViewControllers;
@property (nonatomic) PasswordResetPageContentViewController *pwdResetPageContentVC;

@end

@implementation PasswordResetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create the data model
    
    // set current index
    self.currentIndex = 0;
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PasswordResetPageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(loadNextPage)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closePage)];
    
    self.contentViewControllers = @[[self.storyboard instantiateViewControllerWithIdentifier:@"PasswordResetContent1ViewController"], [self.storyboard instantiateViewControllerWithIdentifier:@"PasswordResetContent2ViewController"], [self.storyboard instantiateViewControllerWithIdentifier:@"PasswordResetContent3ViewController"]];
    
    
    [self.contentViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PasswordResetPageContentViewController *pageContentVC = (PasswordResetPageContentViewController*)obj;
        pageContentVC.delegate = self;
    }];
    
    NSLog(@"Nav Button Name: %@", self.navigationItem.rightBarButtonItem.title);
    
    self.maxPages = self.contentViewControllers.count;
    
    self.pwdResetPageContentVC = self.contentViewControllers[0];
    
    
    
    
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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleBordered target:self action:nil];
        
    }
    
    if (_currentIndex == 0 ) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closePage)];
    }
    
    
    if (_currentIndex > 0 ) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(loadPreviousPage)];
    }
    
}

- (BOOL)loadNextPage
{
    if (_currentIndex == 0) {
        self.pageViewController.username = [[(PasswordResetPageContentViewController*)self.contentViewControllers[0] usernameTextField] text];
    }
    
    _currentIndex++;

    self.pageControl.currentPage = _currentIndex;
    
    [self setNavigationBarButtons];
    
    [self moveToIndex:_currentIndex];
    
    return YES;
}

- (BOOL)loadPreviousPage
{
    _currentIndex--;
    
//    self.pageViewController.username = [[(PasswordResetPageContentViewController*)self.contentViewControllers[0] usernameTextField] text];
    
    self.pageControl.currentPage = _currentIndex;
    
    [self setNavigationBarButtons];
    
    [self moveToIndex:_currentIndex];
    
    return YES;
    
}

- (void)moveToIndex:(NSInteger)index
{
    
    [self viewControllerAtIndex:index];
}

- (void)closePage
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit Password Reset" message:@"Are you sure you want to cancel password account reset?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    
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


- (PasswordResetPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
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
    PasswordResetPageContentViewController *currentViewController = (PasswordResetPageContentViewController *)[self.pageViewController.viewControllers lastObject];
    _currentIndex = [self.contentViewControllers indexOfObjectIdenticalTo:currentViewController];
    
    [self setNavigationBarButtons];
    
    self.pageControl.currentPage = _currentIndex;
    
}

//// ReactiveCocoa
//
//- (BOOL)isValidUsername:(NSString *)username {
//    return username.length > 3;
//}
//
//
//- (void)usernameTextFieldChanged {
//    self.usernameIsValid = [self isValidUsername:self.pwdResetPageContentVC.usernameTextField.text];
//    [self updateUIState];
//}
//
//// updates the enabled state and style of the text fields based on whether the current username
//// and password combo is valid
//- (void)updateUIState {
//    self.pwdResetPageContentVC.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//    self.navigationItem.rightBarButtonItem.enabled = self.usernameIsValid;
//}

#pragma mark - delegation
- (void)shouldSetSignalOnRightNavItemButton:(RACCommand*)command
{
    self.navigationItem.rightBarButtonItem.rac_command = command;
}

- (void)shouldLoadNextPage{
    [self loadNextPage];
}

- (void)shouldLoadPreviousPage{
    [self loadPreviousPage];
}

@end