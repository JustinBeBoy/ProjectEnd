//
//  SubjectManagerViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/19/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "SubjectManagerViewController.h"

@interface SubjectManagerViewController (){
    NSArray *arrSubject;
}

@end

@implementation SubjectManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//- (void) loadData {
//    arrSubject = [NSArray array];
//    arrSubject = [Subject queryListSubject];
//    [self.tableView reloadData];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark UITableView Datasource/Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return arrCompany.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
//    
//    Company *company = (Company*)[arrCompany objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = company.name;
//    
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Company *company = (Company*)[arrCompany objectAtIndex:indexPath.row];
//    AddEditCompanyViewController *addEditCompanyVC = [[AddEditCompanyViewController alloc]initWithNibName:@"AddEditCompanyViewController" bundle:nil];
//    addEditCompanyVC.isEditing = YES;
//    addEditCompanyVC.company = company;
//    [self.navigationController pushViewController:addEditCompanyVC animated:YES];
//}

@end
