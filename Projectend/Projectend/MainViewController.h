//
//  MainViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/15/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentManagerViewController.h"
#import "SubjectManagerViewController.h"
#import "QuanLyLopHocVC.h"

@interface MainViewController : UIViewController
- (IBAction)classManager:(id)sender;
- (IBAction)studentManager:(id)sender;
- (IBAction)subjectManager:(id)sender;
- (IBAction)scoreManager:(id)sender;
@property (nonatomic, assign) BOOL showingLeftPanel;
@end
