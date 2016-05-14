//
//  DB.h
//  MedisafeRD
//
//  Created by Exlinct on 1/27/16.
//  Copyright © 2016 Ominext. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DB : NSObject

+ (NSString*)dbPath;
+ (void)checkExistedDB;
+ (FMDatabase*)db;
+ (void)deleteDB;

@end
