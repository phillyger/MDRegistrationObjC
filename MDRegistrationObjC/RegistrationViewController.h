//
//  ViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationPageContentViewController.h"
#import "RegistrationPageContentTableViewController.h"
#import "LTHPasscodeViewController.h"
#import "LoginViewControllerDelegate.h"
#import "RegistrationViewControllerDelegate.h"
#import "MDReactiveView.h"

@interface RegistrationViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIAlertViewDelegate, LTHPasscodeViewControllerDelegate, RegistrationViewControllerDelegate, MDReactiveView>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (nonatomic,weak) id <LoginViewControllerDelegate> delegate;

@end
