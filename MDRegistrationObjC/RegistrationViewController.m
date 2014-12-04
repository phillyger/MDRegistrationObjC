//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RegistrationViewController.h"



@interface RegistrationViewController ()

@property (assign)NSInteger maxPages;
@property (assign)NSInteger currentIndex;
@property (assign)NSInteger beforeTransitionIndex;
@property (assign)NSInteger afterTransitionIndex;


- (BOOL)loadNextPage;
- (BOOL)loadPreviousPage;

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
    
    _currentIndex++;
    
    self.pageControl.currentPage = _currentIndex;
    
    [self setNavigationBarButtons];
    
    [self moveToIndex:_currentIndex];
    
    return YES;
}

- (BOOL)loadPreviousPage
{
    _currentIndex--;
    
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
    
 
    NSLog(@"Close registration...");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exit Registration" message:@"Are you sure you want to cancel setting up account access?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",buttonIndex);
    if (buttonIndex == 0)
    {
        NSLog(@"You have clicked Yes");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"You have clicked No");
        
    }
}


- (RegistrationPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSLog(@"Running viewControllerAtIndex..." );
    
    if ((_maxPages == 0) || (index >= _maxPages)) {
        return nil;
    }
    
//    self.pageControl.currentPage = index;
//    [self.pageControl updateCurrentPageDisplay];
    
    
        [self.pageViewController setViewControllers:@[self.contentViewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _currentIndex = index;
    NSLog(@"currentIndex: %d", (int)_currentIndex);
    return self.contentViewControllers[index];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
 
    NSLog(@"Running viewControllerBeforeViewController..." );

    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    
    _beforeTransitionIndex = index - 1;
    
    
//    NSLog(@"BeforeViewController::_beforeTransitionIndex: %d", (int)_beforeTransitionIndex);
    
    return self.contentViewControllers[_beforeTransitionIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

     NSLog(@"Running viewControllerAfterViewController..." );
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    
    if (index >= self.contentViewControllers.count - 1) {
        return nil;
    }
    
//    _currentIndex = index + 1;
    _afterTransitionIndex = index + 1;
    
//    NSLog(@"AfterViewController::_afterTransitionIndex: %d", (int)_afterTransitionIndex);
    
    return self.contentViewControllers[_afterTransitionIndex];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    NSLog(@"Running presentationCountForPageViewController..." );
    return self.contentViewControllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    NSLog(@"Running presentationIndexForPageViewController..." );
    return _currentIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSLog(@"Running willTransitionToViewControllers..." );
    _beforeTransitionIndex = _currentIndex;
    
    NSLog(@"will: %d", (int)_currentIndex);
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
     NSLog(@"Running didFinishAnimating..." );
    // Find index of current page
    RegistrationPageContentViewController *currentViewController = (RegistrationPageContentViewController *)[self.pageViewController.viewControllers lastObject];
    _currentIndex = [self.contentViewControllers indexOfObjectIdenticalTo:currentViewController];
    _afterTransitionIndex = _currentIndex;
    

    
    [self setNavigationBarButtons];
//    if (_beforeTransitionIndex > _afterTransitionIndex) {
//        [self loadPreviousPage];
//    } else {
//        [self loadNextPage];
//    }
    
    self.pageControl.currentPage = _afterTransitionIndex;
    NSLog(@"PageControl::pageCurrent:: after: %d", (int)_afterTransitionIndex);
    
    
}


@end
