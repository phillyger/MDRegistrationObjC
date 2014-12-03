//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface PageContentViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;




@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end