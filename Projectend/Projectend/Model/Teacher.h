//
//  Teacher.h
//  Projectend
//
//  Created by Ominext Mobile on 5/14/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "BaseModel.h"

@interface Teacher : BaseModel
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *sex;
@property(strong,nonatomic) NSString *dateofbirth;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *phone;
@property(strong,nonatomic) NSString *username;
@property(strong,nonatomic) NSString *password;

+ (NSArray*) queryTeacherUsername:(NSString*)username  andPassword:(NSString *)password;

@end
