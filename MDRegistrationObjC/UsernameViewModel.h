//
//  Created by Ole Gammelgaard Poulsen on 05/12/13.
//  Copyright (c) 2012 SHAPE A/S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "PasswordResetViewControllerDelegate.h"


@interface UsernameViewModel : NSObject

@property(nonatomic, strong) RACCommand *usernameCommand;

// write to this property
@property(nonatomic, strong) NSString *username;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@property (nonatomic,weak) id <PasswordResetViewControllerDelegate> delegate;

@end