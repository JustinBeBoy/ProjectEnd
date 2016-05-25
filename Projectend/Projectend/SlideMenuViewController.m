//
//  SlideMenuViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "SlideMenuViewController.h"

@interface SlideMenuViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tbvMenu;
@property (nonatomic, weak) IBOutlet UITableViewCell *cellMenu;

@property (nonatomic,strong) NSMutableArray *arrayOfMenus;

@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self setupMenuArray];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Array Setup
- (void) setupMenuArray{
    NSArray *arrayOfMenu = @[
                         [ManagerList itemWithTitle:@"Quản Lý Lớp học" withImage:[UIImage imageNamed:@"class256t.png"] ],
                         [ManagerList itemWithTitle:@"Quản Lý Sinh Viên" withImage:[UIImage imageNamed:@"student256t.png"] ],
                         [ManagerList itemWithTitle:@"Quản Lý Môn Học" withImage:[UIImage imageNamed:@"subject256t.png"] ],
                         [ManagerList itemWithTitle:@"Quản Lý Bảng Điểm" withImage:[UIImage imageNamed:@"Score.png"] ],
                         [ManagerList itemWithTitle:@"Log Out" withImage:[UIImage imageNamed:@"logout256t.png"] ],
                         ];
    
    self.arrayOfMenus = [NSMutableArray arrayWithArray:arrayOfMenu];
    
    [self.tbvMenu reloadData];
}

#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayOfMenus count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellMainNibID = @"cellMenu";
    
    _cellMenu = [tableView dequeueReusableCellWithIdentifier:cellMainNibID];
    if (_cellMenu == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
    }
    
    UIImageView *mainImage = (UIImageView *)[_cellMenu viewWithTag:1];
    
    UILabel *imageTitle = (UILabel *)[_cellMenu viewWithTag:2];
    
    if ([_arrayOfMenus count] > 0)
    {
        ManagerList *currentRecord = [self.arrayOfMenus objectAtIndex:indexPath.row];
        
        mainImage.image = currentRecord.image;
        imageTitle.text = [NSString stringWithFormat:@"%@", currentRecord.title];
    }
    
    return _cellMenu;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealViewController *revealController = self.revealViewController;
    NSInteger row = indexPath.row;
    UINavigationController *navigationController;
    
    if (row == 0) {
        QuanLyLopHocVC *classmanager = [[QuanLyLopHocVC alloc] initWithNibName:@"QuanLyLopHocVC" bundle:nil];
        navigationController = [[UINavigationController alloc] initWithRootViewController:classmanager];
        [revealController pushFrontViewController:navigationController animated:YES];
    }
    else if (row == 1){
        StudentManagerViewController *studentmanager = [[StudentManagerViewController alloc] initWithNibName:@"StudentManagerViewController" bundle:nil];
        studentmanager.isSlide = YES;
        navigationController = [[UINavigationController alloc] initWithRootViewController:studentmanager];
        [revealController pushFrontViewController:navigationController animated:YES];
    }
    
    else if (row == 2){
        SubjectManagerViewController *subjectmanager = [[SubjectManagerViewController alloc] initWithNibName:@"SubjectManagerViewController" bundle:nil];
        subjectmanager.isSlide = YES;
        navigationController = [[UINavigationController alloc] initWithRootViewController:subjectmanager];
        [revealController pushFrontViewController:navigationController animated:YES];
    }
    else if (row == 4){
        LoginViewController *loginvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        navigationController = [[UINavigationController alloc] initWithRootViewController:loginvc];
        [revealController pushFrontViewController:navigationController animated:YES];
    }
    else if (row == 3){
        PointManager *pointM = [[PointManager alloc] initWithNibName:@"PointManager" bundle:nil];
        navigationController = [[UINavigationController alloc] initWithRootViewController:pointM];
        [revealController pushFrontViewController:navigationController animated:YES];
    }

}

#pragma mark -


- (IBAction)btMenu:(id)sender {
    SWRevealViewController *revealController = self.revealViewController;
    MainViewController *mainviewcontroller = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainviewcontroller];
    [revealController pushFrontViewController:navigationController animated:YES];
}
@end
