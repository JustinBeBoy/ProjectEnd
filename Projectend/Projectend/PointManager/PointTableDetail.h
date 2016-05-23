//
//  PointTableDetail.h
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointTableDetailCell.h"

@interface PointTableDetail : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblPointDetailTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblPointDetail;
@property (strong, nonatomic) NSArray *arrScore;

@end
