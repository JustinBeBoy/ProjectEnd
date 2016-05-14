//
//  Lib.m
//  ShiftN
//
//  Created by thuynp on 4/8/14.
//  Copyright (c) 2014 ominext. All rights reserved.
//

#import "Lib.h"




@implementation Lib
#pragma mark - date time
/** This function convert date to string
 */
+(NSString*)stringFromDate:(NSDate *)date withDateFormater:(NSString *)dateFormater{
    if (!date) {
        return @"";
    }
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:NSLocalizedString(dateFormater, dateFormater)];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];//[NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    [formater setTimeZone:tz];
    formater.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSString *str = [formater stringFromDate:date];
    return str?:@"";
}
/** this function convert string to date
 */
+(NSDate*)dateFromString:(NSString *)string withDateFormater:(NSString *)dateFormater{
    if ([string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    NSString *dateFormat = NSLocalizedString (dateFormater, dateFormater);
    [formater setDateFormat:dateFormat];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];//[NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
    [formater setTimeZone:tz];
    formater.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSDate *date = [formater dateFromString:string];
    return date;
}
/** this function change date formate
 */
+(NSString*)changeFormaterStringDate:(NSString *)string withOldDateFormater:(NSString *)oldDateFormater newFormater:(NSString *)newDateFormater{
    NSDate *date = [self dateFromString:string withDateFormater:oldDateFormater];
    NSString *str = [self stringFromDate:date withDateFormater:newDateFormater];
    return str;
}

+(NSString*)currentDate
{
    return [Lib stringFromDate:[NSDate date] withDateFormater:kStrDateFormat]?:@"";
}

+(NSString*)convertToJapanDate:(NSDate*)_date
{
    if (_date == nil) {
        return @"";
    }
    NSCalendar *calendar = shareCalendar();
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit|NSHourCalendarUnit | NSMinuteCalendarUnit | kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay) fromDate:_date];

    NSInteger second = [components second];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];


    NSString *secondStr = @"";
    NSString *_secondStr = @"";
    if (second < 10) {
        secondStr = [NSString stringWithFormat:@"0%ld秒",(long)second];
        _secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
    }
    else
    {
        secondStr = [NSString stringWithFormat:@"%ld秒",(long)second];
        _secondStr = [NSString stringWithFormat:@"%ld",(long)second];
    }

    NSString *minuteStr = @"";
    NSString *_minuteStr = @"";
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld分",(long)minute];
        _minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
    }
    else
    {
        minuteStr = [NSString stringWithFormat:@"%ld分",(long)minute];
        _minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
    }

    NSString *hourStr = @"";
    NSString *_hourStr = @"";
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld時",(long)hour];
        _hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
    }
    else
    {
        hourStr = [NSString stringWithFormat:@"%ld時",(long)hour];
        _hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
    }

    NSString *dayStr = @"";
    if (day < 10) {
        dayStr = [NSString stringWithFormat:@"0%ld%@",(long)day, NSLocalizedString(@"day", @"day")];
    }
    else
    {
        dayStr = [NSString stringWithFormat:@"%ld%@",(long)day, NSLocalizedString(@"day", @"day")];
    }

    NSString *monthStr = @"";
    if (month < 10) {
        monthStr = [NSString stringWithFormat:@"0%ld%@",(long)month, NSLocalizedString(@"month", @"month")];
    }
    else
    {
        monthStr = [NSString stringWithFormat:@"%ld%@",(long)month, NSLocalizedString(@"month", @"month")];
    }

    NSString *yearStr =[NSString stringWithFormat:@"%ld%@",(long)year, NSLocalizedString(@"year", @"year")];

    NSString *jpDate = @"";

    jpDate = [NSString stringWithFormat:@"%@%@%@",yearStr,monthStr,dayStr];
    
    return jpDate;
}


+ (BOOL)isJapaneseHolidayByDate:(NSDate *)date {
    // read data from plist file
    static NSDictionary*    _sholidayDictionary = nil;
    static dispatch_once_t onceToken;
    static const NSInteger K_MONTH = 1000;
    dispatch_once(&onceToken, ^{
        NSString* fullPath = [[NSBundle mainBundle] pathForResource:kJapaneseHolidayFile ofType:@"plist"];
        NSDictionary *holidayDictionary = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        if (holidayDictionary) {
            // get holiday list
            NSArray* holidays = [holidayDictionary objectForKey:@"Holidays"];
            NSCalendar* calendar = shareCalendar();
            NSMutableDictionary *listObj = [NSMutableDictionary dictionaryWithCapacity:holidays.count];
            // check if the date is in holiday list
            for (id object in holidays) {
                if (object && [object isKindOfClass:[NSDictionary class]]) {
                    NSDate* hDate = [object objectForKey:@"Date"];

                    if (hDate && [hDate isKindOfClass:[NSDate class]]) {
                        NSDateComponents* comp1 = [calendar components:NSDayCalendarUnit| NSMonthCalendarUnit fromDate:hDate];
                        NSInteger key = comp1.day + comp1.month * K_MONTH;
                        [listObj setObject:@(1) forKey:[NSNumber numberWithInteger:key]];
                    }
                }
            }
            _sholidayDictionary = listObj;
        }
        
    });
    if (_sholidayDictionary) {
        NSCalendar* calendar = shareCalendar();
        NSDateComponents* comp2 = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
        NSInteger key = comp2.day + comp2.month * K_MONTH;
        [[_sholidayDictionary objectForKey:[NSNumber numberWithInteger:key]] boolValue];
    }

    
    return NO;
}

+ (BOOL)isJapaneseHolidayByString:(NSString *)date {
    return [self isJapaneseHolidayByDate:[self dateFromString:date withDateFormater:kStrDateFormat]];
}

+ (UIColor*)colorFromHexString:(NSString *)color alpha:(CGFloat)alpha {
    if (!color) {
        NSLog(@"Color is nil %@", color);
        return nil;
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:color];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

    return UIColorFromRGBA(rgbValue, alpha);
}

+ (UIColor*)colorFromHexString:(NSString *)color {
    return [self colorFromHexString:color alpha:1.0];
}

+ (NSDate *)nextDayFromDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *component = [[NSDateComponents alloc]init];
    component.day = 1;
    return [calendar dateByAddingComponents:component toDate:date options:0];
}

+ (NSInteger)dayOfMonth:(NSInteger)month year:(NSInteger)year
{
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:
        {
            if ((year%4==0 && year%100!=0) || year%400==0) {
                return 29;
            }
            return 28;
        }
            
        default:
            break;
    }
    NSLog(@"Invalid month %ld", (long)month);
    return 0;
}

+(void)showDialog:(UIView*)dialogView inView:(UIView*)aView{
    UIView *loadingView = [[UIView alloc] init];
	loadingView.frame = CGRectMake(0, 0, aView.bounds.size.width, aView.bounds.size.height);
	loadingView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
	loadingView.tag = 1011;
    CGRect frame = dialogView.frame;
    frame.origin.x = (aView.frame.size.width - frame.size.width)/2;
    frame.origin.y = (aView.frame.size.height - frame.size.height)/2;
    dialogView.frame = frame;
    [loadingView addSubview:dialogView];
    [aView addSubview:loadingView];
}

+(void)removeDialog:(UIView*)superView {
    for (UIView *aView in superView.subviews) {
		if ((aView.tag == 1011)  && [aView isKindOfClass:[UIView class]]) {
			[aView removeFromSuperview];
		}
	}
}

+ (void)showViewController:(UIViewController*)dialogViewController inViewController:(UIViewController*)aViewController{
    UIViewController *loadingViewController = [[UIViewController alloc]init];
    loadingViewController.view.frame = CGRectMake(0, 0, aViewController.view.bounds.size.width, aViewController.view.bounds.size.height);
    loadingViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    loadingViewController.view.tag = 1000;
    CGRect frame = dialogViewController.view.frame;
    frame.origin.x = (aViewController.view.frame.size.width - frame.size.width)/2;
    frame.origin.y = (aViewController.view.frame.size.height - frame.size.height)/2;
    dialogViewController.view.frame = frame;
    [loadingViewController addChildViewController:dialogViewController];
    [loadingViewController.view addSubview:dialogViewController.view];
    [aViewController addChildViewController:loadingViewController];
    [aViewController.view addSubview:loadingViewController.view];
}

+ (void)removeDialogViewController:(UIViewController*)superViewController{
    for (UIViewController *aViewController in superViewController.childViewControllers) {
        if (aViewController.view.tag == 1000 && [aViewController isKindOfClass:[UIViewController class]]) {
            [aViewController removeFromParentViewController];
            [aViewController.view removeFromSuperview];
        }
    }
}

+ (NSString *)convertTodayFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:kStrDateOnlyFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"c"];
    NSString *dayOfWeek = [dateFormatter stringFromDate:date];
    if ([dayOfWeek intValue] == 1) {
        return @"日";
    }
    else if ([dayOfWeek intValue] == 2){
        return @"月";
    }
    else if ([dayOfWeek intValue] == 3){
        return @"火";
    }
    else if ([dayOfWeek intValue] == 4){
        return @"水";
    }
    else if ([dayOfWeek intValue] == 5){
        return @"木";
    }
    else if ([dayOfWeek intValue] == 6){
        return @"金";
    }
    else if ([dayOfWeek intValue] == 7){
        return @"土";
    }
    return @"";
}

+(NSString*)convertDayFromIntToString:(int)dayOfWeek{
    switch (dayOfWeek) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"月";
            break;
        case 3:
            return @"火";
            break;
        case 4:
            return @"水";
            break;
        case 5:
            return @"木";
            break;
        case 6:
            return @"金";
            break;
        case 7:
            return @"土";
            break;
        default:
            return @"";
            break;
    }
}

+(NSString *)dateStringFromYear:(int)year Month:(int)month Day:(int)day{
    NSString *strMonth = [[NSString alloc]init];
    NSString *strDay = [[NSString alloc]init];
    NSString *stryear = [NSString stringWithFormat:@"%i",year];
    if (month < 10) {
        strMonth = [NSString stringWithFormat:@"0%i",month];
    }
    else{
        strMonth = [NSString stringWithFormat:@"%i",month];
    }
    
    if (day < 10) {
        strDay = [NSString stringWithFormat:@"0%i",day];
    }
    else{
        strDay = [NSString stringWithFormat:@"%i",day];
    }
    
    return [NSString stringWithFormat:@"%@-%@-%@",stryear,strMonth,strDay];
}

+(int)getDayOfMonth:(int)m year:(int)y
{
    switch (m) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
            break;
        case 2:
            if ((y%4 == 0) && (y%100 != 0))
                return 29;
            return 28;
            break;
        default:
            break;
    }
    return 0;
}

+ (NSString*)convertFullTime:(NSString*)dateFull{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateFull];
    NSDateComponents *component = [shareCalendar() components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    int hour = (int)[component hour];
    int min = (int)[component minute];
    if (hour < 10 && min < 10) {
       return [NSString stringWithFormat:@"0%i:0%i",hour,min];
    }
    else if (hour < 10 && min >=10){
        return [NSString stringWithFormat:@"0%i:%i",hour,min];
    }
    else if (hour >= 10 && min < 10){
        return [NSString stringWithFormat:@"%i:0%i",hour,min];
    }
    
    return [NSString stringWithFormat:@"%i:%i",hour,min];
}

+(NSString *)subStringFromString:(NSString *)string{
    if (string.length <=7 || string.length <=0) {
        return string;
    }
    return [string substringWithRange:NSMakeRange(0, 7)];
}

+(NSDate *)convertDateFromYear:(int)year month:(int)month{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:kStrDateOnlyFormat];
    NSString *str = [[NSString alloc]init];
    if (month < 10) {
        str = [NSString stringWithFormat:@"%i-0%i-01",year,month];
    }
    else{
        str = [NSString stringWithFormat:@"%i-%i-01",year,month];
    }
    return [dateFormatter dateFromString:str];
}

+ (int)currentDayFromNSDate:(NSDate *)date{
    NSDateComponents *component = [shareCalendar() components:NSCalendarUnitDay fromDate:date];
    return (int)[component day];
}

+ (int)currentMonthFromNSDate:(NSDate *)date{
    NSDateComponents *component = [shareCalendar() components:NSCalendarUnitMonth fromDate:date];
    return (int)[component month];
}

+ (int)currentYearFromNSDate:(NSDate *)date{
    NSDateComponents *component = [shareCalendar() components:NSCalendarUnitYear fromDate:date];
    return (int)[component year];
    
}
@end
