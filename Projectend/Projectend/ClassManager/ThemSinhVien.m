//
//  ThemSinhVien.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ThemSinhVien.h"
#import "AddStudentCell.h"
#import "Student.h"

@interface ThemSinhVien ()

@end

@implementation ThemSinhVien

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrStudentNotAdd.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIButton *button;
    AddStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddStudent"];
    
    if (!cell) {
        cell = [[AddStudentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddStudent"];
    }
    Student *thisStudent = (Student*)[_arrStudentNotAdd objectAtIndex:indexPath.row];
    cell.lblAddStudent.text = thisStudent.name;
    button.tag = indexPath.row;
    //if kiem tra bien student.isCheck == YES
        // thi hien thi img check len
    //else
        // thi hien thi img uncheck
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//AddStudentCell Delegate
//btnCheckTouchByIndex:index
/*{
 Student *thisStudent = (Student*)[_arrStudentNotAdd objectAtIndex:index.row];
 thisStudent.isCheck = ?;
 
 [self.tblAddStudent reloadData];
}*/
@end
