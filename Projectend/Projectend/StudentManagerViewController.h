//
//  StudentManagerViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "AddAndEditViewController.h"
#import "SWRevealViewController.h"
#import "ClassList.h"

@interface StudentManagerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbNumber;
@property (strong, nonatomic) IBOutlet UILabel *lbFullName;
@property (strong, nonatomic) IBOutlet UILabel *lbClass;
@property (strong, nonatomic) IBOutlet UILabel *lbSex;
@property (strong, nonatomic) IBOutlet UILabel *lbYear;
@property (strong, nonatomic) IBOutlet UITableView *tableStudent;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellStudent;
@property (assign, nonatomic) BOOL isSlide;

@end
