//
//  ViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIAlertViewDelegate>



- (IBAction)startWalkthrough:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) UIPageViewController *pageViewController;
//@property (strong, nonatomic) NSArray *pageTitles;
//@property (strong, nonatomic) NSArray *pageImages;

@end