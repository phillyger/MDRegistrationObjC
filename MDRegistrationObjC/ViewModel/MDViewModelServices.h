//
//  MDRegistrationViewModelService.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDRegistrationAPI.h"

@protocol MDViewModelServices <NSObject>



- (id<MDRegistrationAPI>) getMDRegistrationService;

@end
