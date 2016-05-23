//
//  ClassList.h
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface ClassList : BaseModel

@property(strong,nonatomic) NSString *name;

+ (NSArray*) queryListClass;
+(void) insertClass:(NSString*)classname;
+(ClassList*) queryClassWithIDClass:(NSInteger)iDClass;
@end
