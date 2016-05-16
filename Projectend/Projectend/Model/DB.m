//
//  DB.m
//  MedisafeRD
//
//  Created by Exlinct on 1/27/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import "DB.h"
#import "Student.h"
#import "Subject.h"
#import "Scoreboad.h"
#import "Teacher.h"

@implementation DB

+ (NSString*)dbPath {
    NSString *prefix = @"db";
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"db/%@.sqlite", prefix]];
    return path;
}

+ (void)deleteDB {
    NSString *dbPath = [self dbPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:dbPath error:NULL];
    }
}

+ (void)checkExistedDB {
    NSString *dbPath = [self dbPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        NSLog(@"DbPath existed %@", dbPath);
        return;
    }
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[dbPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSArray *modelList = @[
                           [Teacher class],
                           [Student class],
                           [Subject class],
//                           [Scoreboad class]
                           ];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    [db open];
    
    int numError = 0;
    for (id modelClass in modelList) {
        BOOL isSuccess = [modelClass createTable:db];
        if (!isSuccess) {
            NSLog(@"Error create %@", [modelClass tableName]);
            numError +=1;
        }else{
            NSLog(@"Create table %@ success", [modelClass tableName]);
        }
    }
    NSLog(@"Num error create table = %d", numError);
    [db close];
}

+ (FMDatabase*)db {
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    return db;
}
@end
