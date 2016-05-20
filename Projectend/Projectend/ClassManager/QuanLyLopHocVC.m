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

@interface QuanLyLopHocVC (){
    NSArray *arrDSLop;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassedTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassedTableViewCell"];
    }
    
    ClassList *thatclass = (ClassList*)[arrDSLop objectAtIndex:indexPath.row];
    
    NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@",thatclass.iId]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - Số sv:%ld", thatclass.name, [arrStudent count]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassList *thatClass = (ClassList*)[arrDSLop objectAtIndex:indexPath.row];
    
    ChiTietLopHoc *chiTietLopHoc = [[ChiTietLopHoc alloc] initWithNibName:@"ChiTietLopHoc" bundle:nil];
    chiTietLopHoc.thisClass = thatClass;
    
    [self.navigationController pushViewController:chiTietLopHoc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addPressed:(id)sender {
    [self showAlertWithTextField:@"Thêm lớp học" andMessage:@"Mời nhập tên lớp mới:"];
}
-(void)showAlertWithTextField: (NSString*)title andMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * textField) {
        [textField setPlaceholder:@"Tên lớp học"];
    }];
    UIAlertAction *okAct = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSString *string = alert.textFields[0].text;
        [ClassList insertClass:string];
        [self loadData];
        NSLog(@"insert object: %@", string);
    }];
    UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        //do nothing
    }];
    [alert addAction:okAct];
    [alert addAction:cancelAct];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
