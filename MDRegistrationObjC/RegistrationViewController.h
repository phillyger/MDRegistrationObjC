//
//  ViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationPageContentViewController.h"

@interface RegistrationViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) UIPageViewController *pageViewController;


@end
