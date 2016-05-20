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
    thisClass = [ClassList queryClassWithIDClass:[NSString stringWithFormat:@"%ld", thisStudent.idclass]];
    _lblLop.text = thisClass.name;
    
}
-(void)loadData{
    _arrScore = [Scoreboad queryScoreInfFromiDClass:(int)thisClass.iId andiDStudent:(int)thisStudent.iId];
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
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreTableCell"];
    
    if (!cell) {
        cell = [[ScoreTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScoreTableCell"];
    }
    Scoreboad *thisScore = [_arrScore objectAtIndex:indexPath.row];
    Subject *thisSubject = [Subject querySubWithidSubject:thisScore.idsubject];
    cell.lblSubject.text = thisSubject.subject;
    cell.lblScore.text = thisScore.score;
    
    return cell;
}

- (IBAction)pressedLogOut:(id)sender {
    SWRevealViewController *revealController = self.revealViewController;
    UINavigationController *navigationController;
    LoginViewController *loginvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginvc];
    [revealController pushFrontViewController:navigationController animated:YES];

}

@end