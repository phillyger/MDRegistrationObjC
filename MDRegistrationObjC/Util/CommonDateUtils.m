//
//  CommonDateUtils.m
//  MDRegistrationObjC
//
//  Created by GER OSULLIVAN on 12/14/14.
//  Copyright (c) 2014 brilliantage. All rights reserved.
//

#import "CommonDateUtils.h"

@implementation CommonDateUtils

+ (BOOL)isYearLeapYear:(NSDate *) aDate {
    NSInteger year = [self yearFromDate:aDate];
    return (( year%100 != 0) && (year%4 == 0)) || year%400 == 0;
}

+ (NSInteger)yearFromDate:(NSDate *)aDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy";
    NSInteger year = [[dateFormatter stringFromDate:aDate] integerValue];
    return year;
}

+ (NSRange)daysInMonth:(NSDate *)aDate {
    NSDate *today = [NSDate date]; //Get a date object for today's date
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:today];
    
    
    return days;
}

@end
