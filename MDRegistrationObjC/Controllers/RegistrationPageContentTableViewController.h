//
//  PageContentTableViewController.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/2/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationPageContentTableViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *question1Label;
@property (weak, nonatomic) IBOutlet UILabel *question2Label;
@property (weak, nonatomic) IBOutlet UILabel *question3Label;


@property (weak, nonatomic) IBOutlet UITextField *answer1TextField;

@property (weak, nonatomic) IBOutlet UITextField *answer2TextField;
@property (weak, nonatomic) IBOutlet UITextField *answer3TextField;

@end
