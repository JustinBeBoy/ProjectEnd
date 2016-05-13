//
//  Teacher.m
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
+ (NSArray*)getFieldsList {
    static NSArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[
                k_id,           //1
                k_name,         //2
                k_dateofbirth,  //3
                k_sex,          //4
                k_phone,        //5
                k_address,      //6
                k_username,     //7
                k_password,     //8
                k_deleted       //9
                ];
    });
    
    return arr;
}

+ (NSArray*)getFieldOption {
    static NSArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[
                ksIntPrimaryInc,    //1
                ksText,             //2
                ksText,             //3
                ksText,             //4
                ksInteger,          //5
                ksText,             //6
                ksText,             //7
                ksText,             //8
                ksInteger           //9
                ];
    });
    return arr;
}

+ (NSArray*) queryListTeacher {
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrCompany = [self queryListTeacher:db];
    [db close];
    
    return arrCompany;
}

+ (NSArray*) queryListTeacher:(FMDatabase*)db {
    NSString *queryString = [NSString stringWithFormat:@"%@ = 0",k_deleted];
    NSArray *companyDics = [Teacher selectWhere:queryString db:db];
    
    NSMutableArray *listCompany = [NSMutableArray array];
    
    for (NSDictionary *dic in companyDics) {
        Teacher *teacher = [[Teacher alloc]initWithDic:dic];
        [listCompany addObject:teacher];
    }
    return listCompany;
}

@end
