//
//  QuanLyLopHocVC.h
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChiTietLopHoc.h"

@interface QuanLyLopHocVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) BOOL isSlide;

@end
