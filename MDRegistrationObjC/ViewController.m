//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ViewController.h"

static NSInteger maxPages = 3;

@interface ViewController ()

@property (assign)int currentIndex;

- (void)loadNextPage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
//    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
//    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(loadNextPage)];
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    
    
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    self.pageControl = [UIPageControl appearance];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNextPage
{
    NSLog(@"Run next page...");
}

- (IBAction)startWalkthrough:(UIButton *)sender
{
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ((maxPages == 0) || (index >= maxPages)) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = nil;
    
    // add a switch to determine the page controller to show.
    
    switch (index) {
        case 0:
            pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationContent1ViewController"];
            pageContentViewController.pageIndex = index;
            break;
        case 1:
            pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationContent2ViewController"];
            pageContentViewController.pageIndex = index;
            break;
        case 2:
            pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationContent3ViewController"];
            pageContentViewController.pageIndex = index;
            break;
        default:
            break;
    }
    
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == maxPages) {
        return nil;
    }
    

    
    return [self viewControllerAtIndex:index];
//    return regViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
//    return [self.pageTitles count];
    return maxPages;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
