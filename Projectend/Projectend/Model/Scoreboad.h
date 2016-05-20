//
//  Scoreboad.h
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "BaseModel.h"

@interface Scoreboad : BaseModel
@property (nonatomic,assign) NSInteger idsubject;
@property (nonatomic,assign) NSInteger idclass;
@property (nonatomic,assign) NSInteger idstudent;
@property (nonatomic,strong) NSString *score;

+(NSArray*)queryIDClassWithSubjectFromScoreTable:(NSString*)IDsubject;
+(NSArray*) queryScoreInfFromiDClass:(NSInteger)idClass andiDStudent:(NSInteger)idStudent;
@end
