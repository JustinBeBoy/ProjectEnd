//
//  SubjectManagerViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/19/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "AddAndEditSubjectViewController.h"
#import "SWRevealViewController.h"

@interface SubjectManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isSlide;
@end
