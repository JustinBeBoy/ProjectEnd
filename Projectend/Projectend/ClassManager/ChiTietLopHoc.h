//
//  ChiTietLopHoc.h
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassList.h"
#import "Student.h"

@interface ChiTietLopHoc : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) BOOL edited;
@property (strong, nonatomic) IBOutlet UILabel *lblLop;
@property (strong, nonatomic) IBOutlet UILabel *lblSoSv;
@property (strong, nonatomic) IBOutlet UIButton *btnExit;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (strong, nonatomic) NSMutableArray *arrMaskStudent;

@property (nonatomic, strong) ClassList *thisClass;
@property (nonatomic, strong) NSArray *arrStudent;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStudent;

@end
