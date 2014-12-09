//
//  PasswordResetViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/3/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordResetPageContentViewController.h"
#import "PasswordResetViewControllerDelegate.h"
#import "PasswordResetPageViewController.h"

@interface PasswordResetViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate,UIAlertViewDelegate, PasswordResetViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) PasswordResetPageViewController *pageViewController;



@end
