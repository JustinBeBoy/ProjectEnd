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
@property (nonatomic,assign) NSInteger score;
@property (nonatomic,strong) NSString *mask;

+(NSArray*) queryScoreFromiDClass:(NSInteger)idClass andiDStudent:(NSInteger)idStudent;
+(NSArray*) queryListScore;
+(NSArray*) queryScoreFromIDSubject:(NSInteger)iDSubject;
+(NSArray*) queryScoreFromIDClass:(NSInteger)iDClass;
+(NSArray*) queryScoreFromIDStudent:(NSInteger)idStudent;
+(NSArray*) queryListScoreFromIDSubject:(NSInteger)iDSubject andIDClass:(NSInteger)iDClass;
@end
