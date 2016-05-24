//
//  ThemSinhVien.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ThemSinhVien.h"
#import "Student.h"
#import "DLRadioButton.h"
#import "UIViewController+PresentViewControllerOverCurrentContext.h"

@interface ThemSinhVien (){
    NSMutableArray *arrStudentChecked;
}

@property (strong, nonatomic) IBOutlet UITableViewCell *tblStudentCell;
- (IBAction)btCheckStudent:(id)sender;
@property (strong, nonatomic) IBOutlet DLRadioButton *olbtCheckStudent;
@end

@implementation ThemSinhVien

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)setupUI{
    [self.navigationController setNavigationBarHidden:YES];
    arrStudentChecked = [[NSMutableArray alloc]init];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)loadData{
    _arrStudentNotAdd = [Student queryStudentWithIDClass:@"0"];
    [_tblAddStudent reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrStudentNotAdd.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.olbtCheckStudent.multipleSelectionEnabled = YES;
    static NSString *cellMainNibID = @"addStudentToClassCell";
    _tblStudentCell = [_tblAddStudent dequeueReusableCellWithIdentifier:cellMainNibID];
    if (_tblStudentCell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"AddStudentCell" owner:self options:nil];
    }
    UILabel *students = (UILabel *)[_tblStudentCell viewWithTag:100];
    
    if ([_arrStudentNotAdd count] > 0)
    {
        Student *currentStudent = [_arrStudentNotAdd objectAtIndex:indexPath.row];
        students.text = currentStudent.name;
    }

    
    return _tblStudentCell;
}
- (IBAction)btCheckStudent:(DLRadioButton *)radioButton {
    self.olbtCheckStudent.multipleSelectionEnabled = YES;
    UITableViewCell *cell = (UITableViewCell *)radioButton.superview.superview;
    NSIndexPath *indexPath = [_tblAddStudent indexPathForCell:cell];
    Student *thisStudent = [_arrStudentNotAdd objectAtIndex:indexPath.row];
    if (radioButton.isSelected) {
        [arrStudentChecked addObject:thisStudent];
        NSLog(@"%ld",indexPath.row);
    }else if(!radioButton.isSelected){
        [arrStudentChecked removeObject:thisStudent];
        NSLog(@" remove object %ld",indexPath.row);
    }
}
- (IBAction)btCancel:(id)sender {
    [self dismissViewControllerOverCurrentContextAnimated:YES completion:nil];
}

- (IBAction)btAdd:(id)sender {
    [self.delegate sendArrMaskStudent:arrStudentChecked];
    [self dismissViewControllerOverCurrentContextAnimated:YES completion:nil];
}
@end
