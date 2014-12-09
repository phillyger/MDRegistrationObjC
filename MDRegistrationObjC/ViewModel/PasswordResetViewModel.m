//
//  PasswordResetViewModel.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "PasswordResetViewModel.h"
#import <ReactiveCocoa.h>
#import "EXTScope.h"
#import "MDViewModelServicesImpl.h"

@interface PasswordResetViewModel ()

@property (weak, nonatomic) id<MDViewModelServices> services;
@property (nonatomic) UIAlertView *alertView;
@end

@implementation PasswordResetViewModel

- (instancetype)initWithServices:(id<MDViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        
    }
    return self;
}

//- (RACSignal *)submitResetPassword:(NSDictionary*)userInfo {
//    
//    @weakify(self);
//    
//    
//    return [[[self.services getMDRegistrationService] resetPassword:userInfo]
//            doNext:^(RACTuple *JSONAndHeaders) {
//                @strongify(self);
//                
//                NSArray *tupleList =[JSONAndHeaders allObjects];
//                NSLog(@"%@", tupleList.lastObject);
//                NSDictionary *responseDict = tupleList.lastObject;
//                
//                NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];
//                
//                if ([outcomeCode intValue] == 200000) {
//                    
//                    NSLog(@"good to go");
//                    self.alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset" message:@"The password has successfully been reset." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    
//                    [self.alertView show];
//                    [self.delegate shouldDismissController];
//    
//                } else {
//                    NSLog(@"stop");
//                    self.alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset Failed!" message:@"Unable to reset password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                    
//                    [self.alertView show];
//                    
//                }
//            }];
//    
//}

- (RACSignal *)submitResetPassword:(NSDictionary*)userInfo {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //        @weakify(self);
        
        [[[[self.services getMDRegistrationService] resetPassword:userInfo]
          map:^id(RACTuple *tuple) {
              return tuple.second;
          }]
         subscribeNext:^(NSDictionary *dict) {
             [subscriber sendNext:dict];
             [subscriber sendCompleted];
         }
         error:^(NSError *error) {
             NSLog(@"error:%@", error);
             [subscriber sendError:error];
         }
         ];
        // 6. When we are done, remvoe the reference to this request
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

-(void)subscribeToResetPassword:(NSDictionary*)userInfo
{
    [[self submitResetPassword:userInfo] subscribeNext:^(NSDictionary *responseDict) {
        NSLog(@"hello");
        NSLog(@"%@", responseDict);

        NSString *outcomeCode = [responseDict valueForKeyPath:@"outcome.code"];

        if ([outcomeCode intValue] == 200000) {

            NSLog(@"good to go");
            self.alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset" message:@"The password has successfully been reset." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [self.alertView show];
            [self.delegate shouldDismissController];

        } else {
            NSLog(@"stop");
            self.alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset Failed!" message:@"Unable to reset password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [self.alertView show];
            
        }

        
    } error:^(NSError *error) {
        NSLog(@"stop");
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset Failed!" message:@"Unable to reset password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [self.alertView show];
    } completed:^{
        // do nothing
    }];
    
}



@end
