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
                k_descriptions, //4
                k_deleted,      //5
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
                ksText,             //4
                ksInteger           //5
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
+(Subject*) querySubWithidSubject:(NSInteger)idSubject{
    FMDatabase *db = [DB db];
    [db open];
    Subject *thisSubject = [self querySubWithidSubject:idSubject db:db];
    [db close];
    
    return thisSubject;
}
+(Subject*) querySubWithidSubject:(NSInteger)idSubject db:(FMDatabase*)db {
    NSString *queryString = [NSString stringWithFormat:@"%@ = %ld AND %@ = 0",k_id, idSubject, k_deleted];
    Subject *thisSubject = [Subject selectOneWhere:queryString db:db];
    
    return thisSubject;
}
+ (NSArray *)querySubject:(NSString *)subject{
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrSubject = [self querySubject:subject db:db];
    [db close];
    
    return arrSubject;
}
+ (NSArray *)querySubject:(NSString *)subject db:(FMDatabase *)db{
    NSString *queryString = [NSString stringWithFormat:@"%@=0 AND %@=\"%@\"",k_deleted,k_subject,subject];
    
    NSArray *arrDic = [Subject selectWhere:queryString db:db];
    NSMutableArray *arrSubject = [NSMutableArray array];
    
    for (NSDictionary *dic in arrDic) {
        Subject *subject = [[Subject alloc]initWithDic:dic];
        [arrSubject addObject:subject];
    }
    
    return arrSubject;
}

@end
