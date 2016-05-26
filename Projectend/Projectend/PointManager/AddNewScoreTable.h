//
//  AddNewScoreTable.h
//  Projectend
//
//  Created by Admin on 5/25/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@protocol PointTableDetailDelegate <NSObject>

-(void)sendTypePush:(NSString*)type andArrScore:(NSArray*)arr;

@end

@interface AddNewScoreTable : UIViewController <NIDropDownDelegate>{
    NIDropDown *dropDown;
}

@property (strong, nonatomic) IBOutlet UIButton *btnSubjecSelect;
@property (strong, nonatomic) IBOutlet UIButton *btnClassSelect;
@property (strong, nonatomic) id<PointTableDetailDelegate>delegate;

-(void)rel;
@end
