//
//  StoryboardUtils.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/14/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "StoryboardUtils.h"
#import <UIKit/UIKit.h>

static NSString *kMainStoryboardiPad = @"Main";
static UIStoryboard *main;

@implementation StoryboardUtils

+(void)load
{
    main = [UIStoryboard storyboardWithName:kMainStoryboardiPad bundle:nil];
    
}

+ (void)openMainStoryboardWithPresentingController:(UIViewController*)presentingController {
    
    UIViewController *initialDashboardController = [main instantiateInitialViewController];
    initialDashboardController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [presentingController presentViewController:initialDashboardController animated:YES completion:nil];
}
@end
