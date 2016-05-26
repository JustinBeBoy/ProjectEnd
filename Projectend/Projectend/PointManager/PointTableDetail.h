//
//  PointTableDetail.h
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointTableDetailCell.h"
#import "AddNewScoreTable.h"

@interface PointTableDetail : UIViewController <UITableViewDataSource, UITableViewDelegate, PointTableDetailDelegate>

@property (strong, nonatomic) NSString *typePush;
@property (strong, nonatomic) IBOutlet UILabel *lblPointDetailTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblPointDetail;
@property (strong, nonatomic) NSArray *arrScore;

@end
