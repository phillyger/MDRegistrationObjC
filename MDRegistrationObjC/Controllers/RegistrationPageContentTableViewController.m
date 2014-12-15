//
//  PageContentTableViewController.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/2/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "RegistrationPageContentTableViewController.h"
#import "ActionSheetStringPicker.h"
#import "RegistrationSecurityQuestionsViewModel.h"
#import "MDViewModelServicesImpl.h"

@interface RegistrationPageContentTableViewController ()

@property (nonatomic, strong) NSArray *selectionQuestions;
@property (nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, strong) RegistrationSecurityQuestionsViewModel *viewModelSecQuestions; // screen #3
@property (strong, nonatomic) MDViewModelServicesImpl *viewModelServices;

- (void)selectAQuestionWithCellTagId:(NSInteger)cellTagId sender:(UITableViewCell*)sender;

@end

@implementation RegistrationPageContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Assign delegate
    [self.answer1TextField setDelegate:self];
    [self.answer2TextField setDelegate:self];
    [self.answer3TextField setDelegate:self];
    
    // Disable answer field.
    self.answer1TextField.enabled = NO;
    self.answer2TextField.enabled = NO;
    self.answer3TextField.enabled = NO;

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

//    self.questions = @[@"What city where you born in?",
//                       @"What was your first pet’s name?",
//                       @"What is the make of your first car?",
//                       @"What is the middle name of your oldest child?",
//                       @"What school did you attend in 6th grade?",
//                       @"In what town was your first job?"];

    self.viewModelSecQuestions = [[RegistrationSecurityQuestionsViewModel alloc]
                                  initWithServices:self.viewModelServices];
    
    [self bindViewModel:self.viewModelSecQuestions];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
//    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewModel Delegation
- (void)bindViewModel:(id)viewModel
{

    RAC(self, selectionQuestions) = [self fetchAvailableSecurityQuestionsList];
}

- (RACSignal *)fetchAvailableSecurityQuestionsList{

    //TODO: Replace hardcoded Sec Questions with an asyn call.
    RACSignal *arrayReducedSignal = [RACSignal combineLatest:@[ RACObserve(self.question1Label, text), RACObserve(self.question2Label, text), RACObserve(self.question3Label, text) ]
                                                  reduce:^NSArray*(NSString *q1, NSString *q2, NSString *q3) {
                                                      
                                                      NSMutableArray *tmpArray = [@[@"What city where you born in?",
                                                                                    @"What was your first pet’s name?",
                                                                                    @"What is the make of your first car?",
                                                                                    @"What is the middle name of your oldest child?",
                                                                                    @"What school did you attend in 6th grade?",
                                                                                    @"In what town was your first job?"] mutableCopy];
                                                      
                                                      if ([tmpArray containsObject:q1]) {
                                                          [tmpArray removeObject:q1];
                                                      }
                                                      if ([tmpArray containsObject:q2]) {
                                                          [tmpArray removeObject:q2];
                                                      }
                                                      if ([tmpArray containsObject:q3]) {
                                                          [tmpArray removeObject:q3];
                                                      }
                                                      
                                                      return [tmpArray copy];
                                                  }];

    return arrayReducedSignal;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger cellTagId = [cell tag];
    NSLog(@"cell tag: %d", (int)[cell tag]);
//    UILabel * sender = cell.textLabel;
    
    
    if ((int)[indexPath row] == 0) {
//        NSLog(@"Select cell : %d", (int)[indexPath row]);
        [self selectAQuestionWithCellTagId:cellTagId sender:cell];
    }
                                             
}

#pragma mark - Implementation
- (void)selectAQuestionWithCellTagId:(NSInteger)cellTagId sender:(UITableViewCell*)sender{

//    NSLog(@"cell tag in func: %d", (int)cellTagId);
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Question" rows:self.selectionQuestions initialSelection:self.selectedIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        switch (cellTagId) {
            case 1:
                self.question1Label.text = (self.selectionQuestions)[(NSUInteger) selectedIndex];
                self.answer1TextField.enabled = YES;
                break;
            case 2:
                self.question2Label.text = (self.selectionQuestions)[(NSUInteger) selectedIndex];
                self.answer2TextField.enabled = YES;
                break;
            case 3:
                self.question3Label.text = (self.selectionQuestions)[(NSUInteger) selectedIndex];
                self.answer3TextField.enabled = YES;
                break;
            default:
                break;
        }
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
        NSLog(@"Cancel Picker");
    } origin:sender];

    
}

#pragma mark - Keyboard
//- (void)registerForKeyboardNotifications {
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//    
//}
//
//- (void)deregisterFromKeyboardNotifications {
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardDidHideNotification
//                                                  object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillHideNotification
//                                                  object:nil];
//    
//}
//
//- (void)keyboardWasShown:(NSNotification *)notification {
//    
//
//    
//}
//
//- (void)keyboardWillBeHidden:(NSNotification *)notification {
//    
//    
//}

//- (void)questionWasSelected:(NSNumber *)selectedIndex element:(id)element {
//    self.selectedIndex = [selectedIndex intValue];
//    
//    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
//    self.question1Label.text = (self.questions)[(NSUInteger) self.selectedIndex];
//}
//
//
//- (void)actionPickerCancelled:(id)sender {
//    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
