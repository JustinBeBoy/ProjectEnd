//
//  ScoreManagerVC.m
//  Projectend
//
//  Created by ThucTapiOS on 5/20/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ScoreManagerVC.h"

@interface ScoreManagerVC (){
    Student *thisStudent;
    ClassList *thisClass;
}

@end

@implementation ScoreManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void) setupUI{
    [self.navigationController setNavigationBarHidden:YES];
    thisStudent = [Student queryStudentWithidStudent:_iDStudent];
    _lblHoTen.text = thisStudent.name;
    thisClass = [ClassList queryClassWithIDClass:thisStudent.idclass];
    _lblLop.text = thisClass.name;
    
    [_tblScore registerNib:[UINib nibWithNibName:@"ScoreTableCell" bundle:nil] forCellReuseIdentifier:@"ScoreTableCell"];
    
}
-(void)loadData{
    _arrScore = [Scoreboad queryScoreFromiDClass:[thisClass.iId integerValue] andiDStudent:[thisStudent.iId integerValue]];
    [_tblScore reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrScore.count;
//    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreTableCell"];
    
    if (!cell) {
        cell = [[ScoreTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScoreTableCell"];
    }
    Scoreboad *thisScore = [_arrScore objectAtIndex:indexPath.row];
    Subject *thisSubject = [Subject querySubWithidSubject:thisScore.idsubject];
    cell.lblSubject.text = thisSubject.subject;
//    cell.lblSubject.text = @"Môn học";
//    cell.lblScore.text = @"123";
    cell.lblScore.text = [NSString stringWithFormat:@"%ld",thisScore.score];
    
    return cell;
}
- (IBAction)pressedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressedLogOut:(id)sender {
    LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

@end
