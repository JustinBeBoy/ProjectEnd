//
//  MainViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/15/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "PointManager.h"

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
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuwhile24.png"] style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Trang Chủ";
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:20 ]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:2.0f/255.0f green:136.0f/255.0f blue:209.0f/255.0f alpha:1];
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

#pragma mark Button Manager
- (IBAction)classManager:(id)sender {
    QuanLyLopHocVC *classmanager = [[QuanLyLopHocVC alloc]initWithNibName:@"QuanLyLopHocVC" bundle:nil];
    [self.navigationController pushViewController:classmanager animated:YES];
}

- (IBAction)studentManager:(id)sender {
    StudentManagerViewController *studentmanager = [[StudentManagerViewController alloc]initWithNibName:@"StudentManagerViewController" bundle:nil];
    studentmanager.isSlide = NO;
    [self.navigationController pushViewController:studentmanager animated:YES];
}

- (IBAction)subjectManager:(id)sender {
    SubjectManagerViewController *subjectmanager = [[SubjectManagerViewController alloc]initWithNibName:@"SubjectManagerViewController" bundle:nil];
    subjectmanager.isSlide = NO;
    [self.navigationController pushViewController:subjectmanager animated:YES];
}

- (IBAction)scoreManager:(id)sender {
    PointManager *pointmvc = [[PointManager alloc]initWithNibName:@"PointManager" bundle:nil];
    [self.navigationController pushViewController:pointmvc animated:YES];
}
@end
