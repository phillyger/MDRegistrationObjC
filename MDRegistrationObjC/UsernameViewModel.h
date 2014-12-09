//
//  Created by Ole Gammelgaard Poulsen on 05/12/13.
//  Copyright (c) 2012 SHAPE A/S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "PasswordResetViewControllerDelegate.h"
#import "MDViewModelServices.h"

@interface UsernameViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *nextCommand;

// write to this property
@property(nonatomic, strong) NSString *username;

// read from this property
@property(nonatomic, strong) NSString *statusMessage;

@property (nonatomic,weak) id <PasswordResetViewControllerDelegate> delegate;

@end