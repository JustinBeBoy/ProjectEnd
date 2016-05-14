//
//  Global.h
//  MedisafeRD
//
//  Created by Exlinct on 2/21/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kJapaneseHolidayFile    @"JapaneseHolidaysCalendar"
#define NUMBER_DAY_IN_WEEK 7

#define IMAGE_ITEM_STATE_NORMAL     [UIImage imageNamed:@""]
#define IMAGE_ITEM_STATE_FINISHED   [UIImage imageNamed:@"icon_taked"]
#define IMAGE_ITEM_STATE_IGNORED    [UIImage imageNamed:@"icon_miss_take"];
#define IMAGE_ITEM_STATE_SKIPPED    [UIImage imageNamed:@"icon_skip_medication"];
#define IMAGE_BUTTON_SKIP           [UIImage imageNamed:@"btn_skip"]
#define IMAGE_BUTTON_SKIP_RESET     [UIImage imageNamed:@"btn_reset_2"]
#define IMAGE_BUTTON_FINISH         [UIImage imageNamed:@"btn_finish"]
#define IMAGE_BUTTON_FINISH_RESET   [UIImage imageNamed:@"btn_reset_1"]
#define IMAGE_BUTTON_TAKE_NOW       [UIImage imageNamed:@"btn_Takenow"]
#define IMAGE_BUTTON_TAKE_NOW_RESET [UIImage imageNamed:@"btn_reset_1"]
#define IMAGE_ICON_CALENDAR_WHITE   [UIImage imageNamed:@"icon_calendar_white"]
#define IMAGE_ICON_PILL_WHITE       [UIImage imageNamed:@"icon_pill_white"]
#define IMAGE_ICON_NOTIFICATION     [UIImage imageNamed:@"icon_notification"]

#define MAX_REMINDER_TIME_NUMBER 5

#define MAX_NOTIFICATION_MEDICATION 2

#define NUMBER_DAY_IN_WEEK 7

static NSString *kStrDateFormat = @"yyyy-MM-dd HH:mm:ss";
static NSString *kStrDateOnlyFormat = @"yyyy-MM-dd";
static NSString *kStrDateFormatDislay = @"yyyy/MM/dd";
static NSString *kStrDateFormatJapaneseYearMonth = @"yyyyyearMMmonth";
static NSString *kStrIsDisplayBadge = @"isDisplayBadge";
static NSString *kStrTimeBadge = @"timeBadge";

static NSString *kNSDateHelperFormatDayMonthYearWithTime     = @"dd-MM-yyyy HH:mm:ss";
static NSString *kNSDateHelperFormatDDMMYY                   = @"dd-MM-yyyy";
static NSString *kNSDateHelperTimeFormat                     = @"HH:mm:ss";

static NSString *kStrAlertBody = @"alert body";
static NSString *kStrNotificationType = @"notification type";
static NSString *kStrItemId = @"item id";

__unused static NSDateFormatter *shareDateOnlyFormat()
{
    static dispatch_once_t onceToken;
    static NSDateFormatter *formater = nil;
    dispatch_once(&onceToken, ^{
        formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:kStrDateOnlyFormat];
    });
    return formater;
}
__unused static NSCalendar *shareCalendar()
{
    static NSCalendar *calendar = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [NSCalendar currentCalendar];
    });
    return calendar;
}

typedef NS_ENUM(NSUInteger,CTMedicationState) {
    CTMedicationStateAvailable,
    CTMedicationStateActive,
    CTMedicationStateSkip,
    CTMedicationStateMiss
};

typedef NS_ENUM(NSUInteger,CTAppointState) {
    CTAppointStateAvailable,
    CTAppointStateActive,
    CTAppointStateSkip,
    CTAppointStateMiss
};

typedef NS_ENUM(NSUInteger,CTMedicationType) {
    CTMedication,
    CTSingleIntake
};

typedef NS_ENUM(NSUInteger,CTScheduleType) {
    CTScheduleTypeEvery,
    CTScheduleTypeSpecificDay
};

typedef NS_ENUM(NSUInteger,CTNotificationType) {
    CTNotificationTypeAppointment,
    CTNotificationTypeSingleIntake,
    CTNotificationTypeMedication,
    CTNotificationTypeInventory
};



@interface Global : NSObject

@end
