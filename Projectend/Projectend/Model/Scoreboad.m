//
//  Scoreboad.m
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "Scoreboad.h"

@implementation Scoreboad
+ (NSArray*)getFieldsList {
    static NSArray *arr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arr = @[
                k_id,       //1
                k_created,  //2
                k_modified, //3
                k_deleted,  //4
                k_idsubject, //5
                k_idclass,   //6
                k_idstudent, //7
                k_score     //8
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
                ksInteger,          //4
                ksText   ,          //5
                ksText,          //6
                ksText,             //7
                ksInteger           //8
                ];
    });
    return arr;
}
+(NSArray*)queryIDClassWithSubjectFromScoreTable:(NSString*)IDsubject{
    NSString *queryString = [NSString stringWithFormat:@"%@ = %@ GROUP BY %@", k_idsubject, IDsubject, k_idclass];
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrIDClass = [self selectWhere:queryString db:db];
    [db close];
    return arrIDClass;
}
+(NSArray*) queryScoreInfFromiDClass:(NSInteger)idClass andiDStudent:(NSInteger)idStudent{
    FMDatabase *db = [DB db];
    [db open];
    NSArray *arrCompany = [self queryScoreInfFromiDClass:idClass andiDStudent:idStudent db:db];
    [db close];
    
    return arrCompany;
}
+(NSArray*) queryScoreInfFromiDClass:(NSInteger)idClass andiDStudent:(NSInteger)idStudent db:(FMDatabase*)db{
    NSString *queryStr = [NSString stringWithFormat:@"%@ = %ld AND %@ = %ld", k_idclass, idClass, k_idstudent, idStudent];
    NSArray *arrDic = [Scoreboad selectWhere:queryStr db:db];
    NSMutableArray *arrScore = [NSMutableArray array];
    for (NSDictionary *dic in arrDic) {
        Scoreboad *score = [[Scoreboad alloc]initWithDic:dic];
        [arrScore addObject:score];
    }
    
    return arrScore;
}
+(NSArray*)queryiDSubject{
    FMDatabase *db = [DB db];
    [db open];
//    NSArray *arrSubject = [self queryiDSubjecAndScoreFromiDClass:idClass andiDStudent:idStudent db:db];
    NSArray *arrSubject;
    [db close];
    
    return arrSubject;
}
//+(NSArray*)queryiDSubject:(FMDatabase*)db{
//    NSString *queryStr = [NSString stringWithFormat:@""];
//}
@end
