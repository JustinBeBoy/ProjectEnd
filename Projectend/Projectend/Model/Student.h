//
//  Student.h
//  Projectend
//
//  Created by Ominext Mobile on 5/14/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "BaseModel.h"

@interface Student : BaseModel

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *dateofbirth;
@property(strong, nonatomic) NSString *sex;
@property(assign, nonatomic) NSInteger *phone;
@property(strong, nonatomic) NSString *address;
@property(assign, nonatomic) NSInteger *idclass;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *password;


+ (NSArray*) queryStudentWithIDClass:(NSString*)idClass;

@end
