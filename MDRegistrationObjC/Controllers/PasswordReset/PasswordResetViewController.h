//
//  PasswordResetViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/3/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordResetPageContentViewController.h"

@interface PasswordResetViewController : UIViewController <UIPageViewControllerDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
