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
                k_created,  //3
                k_modified, //4
                k_deleted   //5
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
                ksInteger           //5
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
    NSString *queryString = [NSString stringWithFormat:@"%@ = 0", k_deleted];
    NSArray *classDics = [ClassList selectWhere:queryString db:db];
    
    NSMutableArray *listClass = [NSMutableArray array];
    
    for (NSDictionary *dic in classDics) {
        ClassList *class = [[ClassList alloc]initWithDic:dic];
        [listClass addObject:class];
    }
    
    return listClass;
}

+ (NSArray*) queryListClassWhereSubjectId:(NSInteger)subId {
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrClass = nil;
    if (subId != -1) {
        arrClass = [self queryListClassWhereSubjectId:subId DB:db];
    } else {
        arrClass = [self queryListClass:db];
    }
    [db close];
    
    return arrClass;
}

+ (NSArray*) queryListClassWhereSubjectId:(NSInteger)subId DB:(FMDatabase*)db {
    NSString *queryString = [NSString stringWithFormat:@"tb_scoreboads.%@ = 0 AND tb_scoreboads.idsubject <> %ld GROUP BY tb_class_lists.name", k_deleted, subId];
    NSArray *classDics = [ClassList select:@[@"tb_class_lists.id",@"tb_class_lists.name"] from:@"tb_class_lists Inner Join tb_scoreboads ON tb_class_lists.id = tb_scoreboads.idclass" where:queryString db:db];
    
    NSMutableArray *listClass = [NSMutableArray array];
    
    for (NSDictionary *dic in classDics) {
        ClassList *class = [[ClassList alloc]initWithDic:dic];
        [listClass addObject:class];
    }
    
    return listClass;
}


+(ClassList*) queryClassWithIDClass:(NSInteger)iDClass{
    FMDatabase *db = [DB db];
    [db open];
    ClassList *arrClass = [self queryClassWithIDClass:iDClass db:db];
    [db close];
    
    return arrClass;
}
+(ClassList*)queryClassWithIDClass:(NSInteger)iDClass db:(FMDatabase*)db {
    NSString *queryStr = [NSString stringWithFormat:@"%@ = %ld AND %@ = 0", k_id, iDClass, k_deleted];
    ClassList *thisClass = [ClassList selectOneWhere:queryStr db:db];
    return thisClass;
}

@end
