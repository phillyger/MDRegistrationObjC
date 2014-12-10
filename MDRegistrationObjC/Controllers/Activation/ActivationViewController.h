//
//  Activation.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivationViewControllerDelegate.h"
#import "MDReactiveView.h"

@interface ActivationViewController : UIViewController <ActivationViewControllerDelegate, MDReactiveView>

@property (weak, nonatomic) IBOutlet UITextField *activationTokenTextField;
@property (weak, nonatomic) IBOutlet UIButton *activationButton;

@end
