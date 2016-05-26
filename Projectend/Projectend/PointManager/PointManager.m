//
//  PointManager.m
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "PointManager.h"
#import "Subject.h"
#import "Scoreboad.h"
#import "ClassList.h"
#import "PointTableDetail.h"
#import "AddNewScore.h"
#import "SWRevealViewController.h"
#import "AddNewScoreTable.h"

@interface PointManager (){
    PointTableDetail *thisPointTableDetail;
    
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnMenu;
    
    NSIndexPath *indexPathToDel;
}

@end

@implementation PointManager

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)setupUI{
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
    _tblPointWithClass.tableFooterView = [[UIView alloc] init];
}
-(void)loadData{
    _arrIDClassAtEachSub = [NSMutableArray array];
    NSArray *arrScore = [Scoreboad queryListScore];
    
    NSMutableArray *m_arrIDSubject = [NSMutableArray array];
    for (Scoreboad *thisScore in arrScore) {
        [m_arrIDSubject addObject:[NSNumber numberWithInteger:thisScore.idsubject]];
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:m_arrIDSubject];
    _arrIDSubject = [orderedSet array];
    
    for (int i = 0; i < _arrIDSubject.count; i++) {
        NSArray *arrScoreEachSub = [Scoreboad queryScoreFromIDSubject:[[_arrIDSubject objectAtIndex:i] integerValue]];
        NSMutableArray *m_arrIDClass = [NSMutableArray array];
        for (Scoreboad *thisScore in arrScoreEachSub) {
            if (thisScore.idclass > 0) {
                [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]];
            }
        }
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:m_arrIDClass];
        NSArray *arrIDClassWithSub = [orderedSet array];
        [_arrIDClassAtEachSub addObject:arrIDClassWithSub];
    }
    
    [_tblPointWithClass reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)pressedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pressedMenu:(id)sender {
    SWRevealViewController *revealController = [self revealViewController];
    [revealController revealToggle:sender];
}
- (IBAction)pressedPlus:(id)sender {
    PointTableDetail *detail = [[PointTableDetail alloc] initWithNibName:@"PointTableDetail" bundle:nil];
    detail.typePush = @"add";
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrIDSubject.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Subject *thisSubject = [Subject querySubWithidSubject:[[_arrIDSubject objectAtIndex:section] integerValue]];
    return [NSString stringWithFormat:@"Điểm môn: %@", thisSubject.subject];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arrIDClass = [_arrIDClassAtEachSub objectAtIndex:section];
    return arrIDClass.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassedTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassedTableViewCell"];
    }
    Subject *thisSubject = [Subject querySubWithidSubject:[[_arrIDSubject objectAtIndex:indexPath.section] integerValue]];
    NSArray *arrIDClass = [_arrIDClassAtEachSub objectAtIndex:indexPath.section];
    ClassList *thisClass = [ClassList queryClassWithIDClass:[[arrIDClass objectAtIndex:indexPath.row] integerValue]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Điểm môn %@ lớp %@",thisSubject.subject,thisClass.name];
    cell.layer.borderWidth = 1.0f;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        indexPathToDel = indexPath;
        [self showAlertWithTitle:@"Xoá điểm" andMessage:@"Bạn chắc chắn muốn xoá điểm lớp học này?"];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arrScore = [Scoreboad queryListScoreFromIDSubject:[_arrIDSubject[indexPath.section] integerValue] andIDClass:[[[_arrIDClassAtEachSub objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue]];
    thisPointTableDetail = [[PointTableDetail alloc] initWithNibName:@"PointTableDetail" bundle:nil];
    thisPointTableDetail.arrScore = arrScore;
    
    [self.navigationController pushViewController:thisPointTableDetail animated:YES];
}
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActOk = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSArray *arrScore = [Scoreboad queryListScoreFromIDSubject:[_arrIDSubject[indexPathToDel.section] integerValue] andIDClass:[[[_arrIDClassAtEachSub objectAtIndex:indexPathToDel.section] objectAtIndex:indexPathToDel.row] integerValue]];
        for (Scoreboad *thisScore in arrScore) {
            thisScore.deleted = @(1);
            [thisScore update];
        }
        [self loadData];
    }];
    UIAlertAction *alertActCancel = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:alertActOk];
    [alert addAction:alertActCancel];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
