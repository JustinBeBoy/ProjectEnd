//
//  ClassList.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ClassList.h"

@implementation ClassList

+ (NSArray*)getFieldsList {
    static NSArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[
                k_id,       //1
                k_name,     //2
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
                ksText   ,          //2
                ];
    });
    return arr;
}

+ (NSArray*) queryListClass {
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrClass = [self queryListClass:db];
    [db close];
    
    return arrClass;
}

+ (NSArray*) queryListClass:(FMDatabase*)db {
    NSString *queryString = @"";
    NSArray *classDics = [ClassList selectWhere:queryString db:db];
    
    NSMutableArray *listClass = [NSMutableArray array];
    
    for (NSDictionary *dic in classDics) {
        ClassList *class = [[ClassList alloc]initWithDic:dic];
        [listClass addObject:class];
    }
    
    return listClass;
}

@end
