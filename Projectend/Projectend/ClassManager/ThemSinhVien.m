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

@interface ThemSinhVien () <CheckTouchDelegate>

@end

@implementation ThemSinhVien

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)setupUI{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AddStudentCell *cell = [[AddStudentCell alloc] init];
    cell.delegate = self;
    [self loadData];
}
-(void)loadData{
    _arrStudentNotAdd = [Student queryListStudent];
    [_tblAddStudent reloadData];
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
//    return _arrStudentNotAdd.count;
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddStudentCell"];
    
    if (cell==nil) {
        cell = [[AddStudentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddStudentCell"];
    }
//    Student *thisStudent = (Student*)[_arrStudentNotAdd objectAtIndex:indexPath.row];
//    cell.lblAddStudent.text = thisStudent.name;
    cell.lblAddStudent.text = @"tang";
    [cell.btnCheck setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    cell.indexPathCell = indexPath;
    
//    if (thisStudent.isCheck == YES) {
//        [cell.btnCheck setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
//    }else{
//        [cell.btnCheck setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void) btnCheckTouchByIndexPath:(NSIndexPath *)indexpath{
    Student *thisStudent = (Student*)[_arrStudentNotAdd objectAtIndex:indexpath.row];
    if (thisStudent.isCheck == NO) {
        thisStudent.isCheck = YES;
    }else{
        thisStudent.isCheck = NO;
    }
 
 [self.tblAddStudent reloadData];
}
- (IBAction)clickedAdd:(id)sender {
}
@end
