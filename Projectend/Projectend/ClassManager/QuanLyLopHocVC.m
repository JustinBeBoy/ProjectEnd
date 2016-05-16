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

@interface QuanLyLopHocVC (){
    NSArray *arrDSLop;
}

@end

@implementation QuanLyLopHocVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    ClassList *thatclass = (ClassList*)[arrDSLop objectAtIndex:indexPath.row];
    
    NSArray *arrStudent = [Student queryStudentWithIDClass:thatclass.idStr];
    
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
    // Dispose of any resources that can be recreated.
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addPressed:(id)sender {
}

@end
