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
    NSArray *arrayClassStudent;
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
    UIBarButtonItem *rightbt = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"plus16w.png"] style:UIBarButtonItemStylePlain target:self action:@selector(plusStudent)];
    self.navigationItem.rightBarButtonItem = rightbt;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"Quản Lý Sinh Viên";
    
    _lbNumber.layer.borderWidth = 1.0f;
    _lbNumber.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    _lbFullName.layer.borderWidth = 1.0f;
    _lbFullName.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    _lbClass.layer.borderWidth = 1.0f;
    _lbClass.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    _lbSex.layer.borderWidth = 1.0f;
    _lbSex.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    _lbYear.layer.borderWidth = 1.0f;
    _lbYear.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
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
        SWRevealViewController *reveal = self.revealViewController;
        reveal.panGestureRecognizer.enabled = NO;
        UIBarButtonItem *backbt = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(btback)];
        [backbt setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:15 ]} forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = backbt;
    }
}
- (void)reloadData{
    arrayStudent = [Student queryListStudent];
    arrayClassStudent = [ClassList queryListClass];
    [self.tableStudent reloadData];
    
}

#pragma mark Button Action
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
    return 50;
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
    number.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    fullname.layer.borderWidth = 1.0f;
    fullname.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    class.layer.borderWidth = 1.0f;
    class.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    sex.layer.borderWidth = 1.0f;
    sex.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    
    year.layer.borderWidth = 1.0f;
    year.layer.borderColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1].CGColor;
    

    if ([arrayStudent count] > 0)
    {
        ClassList *currentClass;
        Student *currentRecord = [arrayStudent objectAtIndex:indexPath.row];
        number.text = [NSString stringWithFormat:@"%li",(long)indexPath.row+1];
        fullname.text = [NSString stringWithFormat:@"%@",currentRecord.name];
        for (int i = 0; i < [arrayClassStudent count]; i++) {
            currentClass = [arrayClassStudent objectAtIndex:i];
            if (currentRecord.idclass == [currentClass.iId integerValue]) {
                class.text = [NSString stringWithFormat:@"%@",currentClass.name];
            }
        }
        sex.text = currentRecord.sex;
        year.text = currentRecord.dateofbirth;
        
    }

    return _cellStudent;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Student *student = (Student*)[arrayStudent objectAtIndex:indexPath.row];
    AddAndEditViewController *addeditviewcontroller = [[AddAndEditViewController alloc]initWithNibName:@"AddAndEditViewController" bundle:nil];
    addeditviewcontroller.student = student;
    addeditviewcontroller.isEditing = YES;
    [self.navigationController pushViewController:addeditviewcontroller animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete){
        Student *student = (Student*)[arrayStudent objectAtIndex:indexPath.row];
        student.deleted = @(1);
        [student update];
        [self reloadData];
        NSLog(@"dfafafasfasfafd");
    }
}

@end
