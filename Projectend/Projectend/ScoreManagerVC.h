//
//  ScoreManagerVC.h
//  Projectend
//
//  Created by ThucTapiOS on 5/20/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreBoad.h"
#import "Student.h"
#import "ClassList.h"
#import "ScoreTableCell.h"
#import "Subject.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"

@interface ScoreManagerVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSInteger iDStudent;
@property (strong, nonatomic) IBOutlet UILabel *lblHoTen;
@property (strong, nonatomic) IBOutlet UILabel *lblLop;
@property (strong, nonatomic) NSArray *arrScore;

@property (strong, nonatomic) IBOutlet UITableView *tblScore;


@end
