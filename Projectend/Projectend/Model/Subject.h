//
//  Subject.h
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "BaseModel.h"

@interface Subject : BaseModel
@property(nonatomic,strong)NSString *subject;
@property(nonatomic,assign)NSInteger credits;
@property(nonatomic,strong)NSString *descriptions;
+ (NSArray*) queryListSubject;
+(Subject*) querySubWithidSubject:(NSInteger)idSubject;
+ (NSArray *)querySubject:(NSString *)subject;
@end
