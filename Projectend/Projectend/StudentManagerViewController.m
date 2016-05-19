//
//  StudentManagerViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "StudentManagerViewController.h"

@interface StudentManagerViewController ()<UITableViewDelegate>
{
    NSArray *arrayStudent;
}

@end

@implementation StudentManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadData];
}

- (void) setupUI{
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *rightbt = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"plus16.png"] style:UIBarButtonItemStylePlain target:self action:@selector(plusStudent)];
    self.navigationItem.rightBarButtonItem = rightbt;
    self.navigationItem.title = @"Quản Lý Sinh Viên";
    
    _lbNumber.layer.borderWidth = 1.0f;
    _lbFullName.layer.borderWidth = 1.0f;
    _lbClass.layer.borderWidth = 1.0f;
    _lbSex.layer.borderWidth = 1.0f;
    _lbYear.layer.borderWidth = 1.0f;
    SWRevealViewController *revealController = [self revealViewController];
    if (self.isSlide) {
        SWRevealViewController *revealControllers = [self revealViewController];
        [revealControllers panGestureRecognizer];
        [revealControllers tapGestureRecognizer];
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu24.png"]
                                                                             style:UIBarButtonItemStylePlain target:revealControllers action:@selector(revealToggle:)];
        [revealController.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor colorWithRed:146.0f/255.0f green:204.0f/255.0f blue:55.0f/255.0f alpha:1],NSFontAttributeName: [UIFont systemFontOfSize:20 ]}];
        self.navigationItem.leftBarButtonItem = revealButtonItem;
    }else{
        UIBarButtonItem *backbt = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(btback)];
        self.navigationItem.leftBarButtonItem = backbt;
    }
}
- (void)reloadData{
    arrayStudent = [Student queryListStudent];
    [self.tableStudent reloadData];
    
}

- (void)btback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)plusStudent{
    AddAndEditViewController *addandedit = [[AddAndEditViewController alloc]initWithNibName:@"AddAndEditViewController" bundle:nil];
    addandedit.isEditing = NO;
    [self.navigationController pushViewController:addandedit animated:YES];
}

#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayStudent count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellMainNibID = @"cellStudent";
    
    _cellStudent = [tableView dequeueReusableCellWithIdentifier:cellMainNibID];
    if (_cellStudent == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"StudentViewCell" owner:self options:nil];
    }
    
    UILabel *number = (UILabel *)[_cellStudent viewWithTag:1];
    UILabel *fullname = (UILabel *)[_cellStudent viewWithTag:2];
    UILabel *class = (UILabel *)[_cellStudent viewWithTag:3];
    UILabel *sex = (UILabel *)[_cellStudent viewWithTag:4];
    UILabel *year = (UILabel *)[_cellStudent viewWithTag:5];
    
    number.layer.borderWidth = 1.0f;
    fullname.layer.borderWidth = 1.0f;
    class.layer.borderWidth = 1.0f;
    sex.layer.borderWidth = 1.0f;
    year.layer.borderWidth = 1.0f;

    if ([arrayStudent count] > 0)
    {
        Student *currentRecord = [arrayStudent objectAtIndex:indexPath.row];
        number.text = [NSString stringWithFormat:@"%li",(long)indexPath.row+1];
        fullname.text = [NSString stringWithFormat:@"%@",currentRecord.name];
        class.text = [NSString stringWithFormat:@"%ld", (long)currentRecord.idclass];
        sex.text = currentRecord.sex;
        year.text = currentRecord.dateofbirth;
        
    }

    return _cellStudent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Student *student = (Student*)[arrayStudent objectAtIndex:indexPath.row];
    AddAndEditViewController *addeditviewcontroller = [[AddAndEditViewController alloc]initWithNibName:@"AddAndEditViewController" bundle:nil];
    addeditviewcontroller.isEditing = YES;
    addeditviewcontroller.student = student;
    [self.navigationController pushViewController:addeditviewcontroller animated:YES];
}

@end
