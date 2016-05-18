//
//  MainViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/15/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    
}

- (void)setupUI{
    [self.navigationController setNavigationBarHidden:NO];
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu24.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    [revealController.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor colorWithRed:146.0f/255.0f green:204.0f/255.0f blue:55.0f/255.0f alpha:1],NSFontAttributeName: [UIFont systemFontOfSize:20 ]}];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.title = @"Trang Chủ";
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor colorWithRed:146.0f/255.0f green:204.0f/255.0f blue:55.0f/255.0f alpha:1],NSFontAttributeName: [UIFont systemFontOfSize:20 ]}];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Button Manager
- (IBAction)classManager:(id)sender {
    QuanLyLopHocVC *classmanager = [[QuanLyLopHocVC alloc]initWithNibName:@"QuanLyLopHocVC" bundle:nil];
    [self.navigationController pushViewController:classmanager animated:YES];
}

- (IBAction)studentManager:(id)sender {
    StudentManagerViewController *studentmanager = [[StudentManagerViewController alloc]initWithNibName:@"StudentManagerViewController" bundle:nil];
    [self.navigationController pushViewController:studentmanager animated:YES];
}

- (IBAction)subjectManager:(id)sender {
}

- (IBAction)scoreManager:(id)sender {
}
@end
