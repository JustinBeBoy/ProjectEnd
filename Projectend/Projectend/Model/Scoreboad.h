//
//  Scoreboad.h
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "BaseModel.h"

@interface Scoreboad : BaseModel
@property (nonatomic,strong) NSString *idsubject;
@property (nonatomic,strong) NSString *idclass;
@property (nonatomic,strong) NSString *idstudent;
@property (nonatomic,strong) NSString *score;

+(NSArray*)queryIDClassWithSubjectFromScoreTable:(NSString*)IDsubject;
@end
