//
//  MDViewModelServicesImpl.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/8/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "MDViewModelServicesImpl.h"
#import "MDRegistrationAPIImpl.h"

@interface MDViewModelServicesImpl ()

@property (strong, nonatomic) MDRegistrationAPIImpl *registrationService;

@end

@implementation MDViewModelServicesImpl

-(instancetype)init{
    if (self = [super init]) {
        _registrationService = [MDRegistrationAPIImpl new];
    }
    return self;
    
}

- (id<MDRegistrationAPI>)getMDRegistrationService
{
    return  self.registrationService;
}

@end
