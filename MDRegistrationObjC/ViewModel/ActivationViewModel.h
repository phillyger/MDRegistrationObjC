//
//  ActivationViewModel.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/9/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "MDViewModelServices.h"
#import "ActivationViewControllerDelegate.h"


@interface ActivationViewModel : NSObject

- (instancetype)initWithServices:(id<MDViewModelServices>)services;

@property(nonatomic, strong) RACCommand *activateCommand;

// write to this property
@property(nonatomic, strong) NSString *activationToken;

@property (nonatomic,weak) id <ActivationViewControllerDelegate> delegate;

@end
