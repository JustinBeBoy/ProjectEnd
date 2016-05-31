//
//  QuanLyLopHocVC.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "QuanLyLopHocVC.h"
#import "ClassList.h"
#import "Student.h"
#import "ClassedTableViewCell.h"
#import "Scoreboad.h"
#import "SWRevealViewController.h"

@interface QuanLyLopHocVC (){
    NSArray *arrDSLop;
    
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnMenu;
    
}

@end

@implementation QuanLyLopHocVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];

}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

- (void) setupUI{
    [_tableView registerNib:[UINib nibWithNibName:@"ClassedTableViewCell" bundle:nil] forCellReuseIdentifier:@"ClassedTableViewCell"];
    _tableView.tableFooterView = [[UIView alloc]init];
    if (_isSlide == NO) {
        [btnBack setHidden:NO];
        [btnMenu setHidden:YES];
        SWRevealViewController *reveal = self.revealViewController;
        reveal.panGestureRecognizer.enabled = NO;
    }else{
        [btnBack setHidden:YES];
        [btnMenu setHidden:NO];
        SWRevealViewController *reveal = self.revealViewController;
        reveal.panGestureRecognizer.enabled = YES;
    }
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) loadData {
    arrDSLop = [NSArray array];
    arrDSLop = [ClassList queryListClass];
    [_tableView reloadData];
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDSLop.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassedTableViewCell"];
    
    if (cell == nil) {
        cell = [[ClassedTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassedTableViewCell"];
    }
    
    ClassList *thatclass = (ClassList*)[arrDSLop objectAtIndex:indexPath.row];
    
    NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@",thatclass.iId]];
    cell.layer.borderWidth = 1.0f;
    cell.lblName.text = [NSString stringWithFormat:@"  Lớp %@", thatclass.name];
    cell.lblDetail.text = [NSString stringWithFormat:@"Số sinh viên: %ld",arrStudent.count];
//    cell.textLabel.text = [NSString stringWithFormat:@"Lớp %@ \t - \t Số sinh viên: %ld", thatclass.name, [arrStudent count]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassList *thatClass = (ClassList*)[arrDSLop objectAtIndex:indexPath.row];
    
    ChiTietLopHoc *chiTietLopHoc = [[ChiTietLopHoc alloc] initWithNibName:@"ChiTietLopHoc" bundle:nil];
    chiTietLopHoc.thisClass = thatClass;
    
    [self.navigationController pushViewController:chiTietLopHoc animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Xoá lớp" message:@"Bạn có chắc chắn muốn xoá lớp học này?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertActOk = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            ClassList *thisClass = [arrDSLop objectAtIndex:indexPath.row];
            
            NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%ld", [thisClass.iId integerValue]]];
            for (Student *thisStudent in arrStudent) {
                thisStudent.idclass = 0;
                [thisStudent update];
            }
            
            NSArray *arrScore = [Scoreboad queryScoreFromIDClass:[thisClass.iId integerValue]];
            for (Scoreboad *thisScore in arrScore) {
                thisScore.idclass = 0;
                [thisScore update];
            }
            
            thisClass.deleted = @(1);
            [thisClass update];
            [self loadData];
        }];
        UIAlertAction *alertActCancel = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:alertActOk];
        [alert addAction:alertActCancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)menuPressed:(id)sender {
    SWRevealViewController *revealController = [self revealViewController];
    [revealController revealToggle:sender];
}
- (IBAction)addPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thêm lớp học" message:@"Mời nhập tên lớp mới" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
        [textField setPlaceholder:@"Tên lớp học"];
    }];
    UIAlertAction *okAct = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString *name = alert.textFields[0].text;
        BOOL exist = NO;
        for (ClassList *thisClass in arrDSLop) {
            if (name == thisClass.name) {
                exist = YES;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Lỗi" message:@"Lớp học đã tồn tại" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }
        }
        if (exist == NO) {
            ClassList *thisClass = [[ClassList alloc] init];
            thisClass.name = name;
            [thisClass update];
            [self loadData];
        }

    }];
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAct];
    [alert addAction:cancelAct];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
