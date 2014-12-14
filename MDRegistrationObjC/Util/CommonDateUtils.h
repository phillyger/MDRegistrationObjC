//
//  CommonDateUtils.h
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/14/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDateUtils : NSObject

+ (BOOL)isYearLeapYear:(NSDate *) aDate;
+ (NSRange)daysInMonth:(NSDate *)aDate;

@end
