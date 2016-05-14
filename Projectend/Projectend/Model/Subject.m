//
//  Subject.m
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "Subject.h"

@implementation Subject
+ (NSArray*)getFieldsList {
    static NSArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[
                k_id,           //1
                k_subject,      //2
                k_credits,      //3
                k_deleted,      //4
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
                ksInteger,          //3
                ksInteger           //4
                ];
    });
    return arr;
}

+ (NSArray*) queryListSubject {
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrSubject = [self queryListSubject:db];
    [db close];
    
    return arrSubject;
}

+ (NSArray*) queryListSubject:(FMDatabase*)db {
    NSString *queryString = [NSString stringWithFormat:@"%@ = 0",k_deleted];
    NSArray *subjectDics = [Subject selectWhere:queryString db:db];
    
    NSMutableArray *listSubject = [NSMutableArray array];
    
    for (NSDictionary *dic in subjectDics) {
        Subject *subject = [[Subject alloc]initWithDic:dic];
        [listSubject addObject:subject];
    }
    
    return listSubject;
}

@end
