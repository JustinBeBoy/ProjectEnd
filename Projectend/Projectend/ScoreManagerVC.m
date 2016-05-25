//
//  ScoreManagerVC.m
//  Projectend
//
//  Created by ThucTapiOS on 5/20/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ScoreManagerVC.h"

#define KEY_CHECK_LOGIN  @"Loginded"

@interface ScoreManagerVC (){
    Student *thisStudent;
    ClassList *thisClass;
    
    IBOutlet UILabel *lblSubjectName;
    
    IBOutlet UILabel *lblScore;
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
    
    lblScore.layer.borderWidth = 1.0f;
    lblSubjectName.layer.borderWidth = 1.0f;
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 27;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreTableCell"];
    
    if (!cell) {
        cell = [[ScoreTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScoreTableCell"];
    }
    Scoreboad *thisScore = [_arrScore objectAtIndex:indexPath.row];
    Subject *thisSubject = [Subject querySubWithidSubject:thisScore.idsubject];
    cell.layer.borderWidth =1.0f;
    cell.lblSubject.text = [NSString stringWithFormat:@"  %@", thisSubject.subject];
    cell.lblSubject.layer.borderWidth = 1.0f;
    cell.lblScore.layer.borderWidth = 1.0f;
    cell.lblScore.text = [NSString stringWithFormat:@"%ld",thisScore.score];
    
    return cell;
}

- (IBAction)pressedLogOut:(id)sender {
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setBool:NO forKey:KEY_CHECK_LOGIN];
    LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

@end
