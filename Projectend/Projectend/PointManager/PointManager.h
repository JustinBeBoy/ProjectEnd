//
//  PointManager.h
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointManager : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblPointWithClass;

@property (strong, nonatomic) NSArray *arrIDSubject;
@property (strong, nonatomic) NSMutableArray *arrIDClassAtEachSub;

@property (assign, nonatomic) BOOL isSlide;

@end
