//
//  Lib.h
//  ShiftN
//
//  Created by thuynp on 4/8/14.
//  Copyright (c) 2014 ominext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Global.h"

#define tabbarHeight 50
#define UIColorFromRGBA(rgbValue,alphaValue)  [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

/** Get UIColor from RGB value 
    example: UIColorFromRGB(0XFF0000);
 */
#define UIColorFromRGB(rgbValue)    UIColorFromRGBA(rgbValue,1.0)


/** Get localized string
    example: NSLocalizedString("today", "today");
 */
#define NSLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

__unused static NSString *OMLang(NSString *key)
{
    return NSLocalizedString(key
                             , key);
}

@interface Lib : NSObject

#pragma mark - date-time
/** format string from date
 */
+(NSString*)stringFromDate:(NSDate *)date withDateFormater:(NSString *)dateFormater;
+(NSDate*)dateFromString:(NSString *)string withDateFormater:(NSString *)dateFormater;
/** this function change date formate
 */
+(NSString*)changeFormaterStringDate:(NSString *)string withOldDateFormater:(NSString *)oldDateFormater newFormater:(NSString *)newDateFormater;


/** This function get current date by string
 */
+(NSString*)currentDate;

/** Convert to japanese date
 */
+(NSString*)convertToJapanDate:(NSDate*)_date;

+ (BOOL)isJapaneseHolidayByString:(NSString*)date;
+ (BOOL)isJapaneseHolidayByDate:(NSDate *)date;

/** get UIColor from hex string
    string must start by #
    example: [Lib colorFromHexString:@"#FF0000" alpha:1.0];
 */
+ (UIColor*)colorFromHexString:(NSString*)color alpha:(CGFloat)alpha;

+ (UIColor*)colorFromHexString:(NSString *)color;

+ (NSDate*)nextDayFromDate:(NSDate*)date;
+ (NSInteger)dayOfMonth:(NSInteger)month year:(NSInteger)year;

+ (void)showDialog:(UIView*)dialogView inView:(UIView*)aView;
+ (void)removeDialog:(UIView*)superView;

+ (void)showViewController:(UIViewController*)dialogViewController inViewController:(UIViewController*)aViewController;
+ (void)removeDialogViewController:(UIViewController*)superViewController;

+ (NSString*)convertTodayFromString:(NSString*)dateString;

+(NSString*)convertDayFromIntToString:(int)dayOfWeek;

+ (NSString*)dateStringFromYear:(int)year Month:(int)month Day:(int)day;

+(int)getDayOfMonth:(int)m year:(int)y;

+ (NSString*)convertFullTime:(NSString*)dateFull;

+(NSString*)subStringFromString:(NSString*)string;

+(NSDate*)convertDateFromYear:(int)year month:(int)month;

+(int)currentDayFromNSDate:(NSDate*)date;

+(int)currentMonthFromNSDate:(NSDate*)date;

+(int)currentYearFromNSDate:(NSDate*)date;
@end
