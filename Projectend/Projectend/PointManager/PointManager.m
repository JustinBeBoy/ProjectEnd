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
}else{
    [btnBack setHidden:YES];
    [btnMenu setHidden:NO];
}
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)loadData{
    _arrIDClassAtEachSub = [NSMutableArray array];
    NSArray *arrScore = [Scoreboad queryListScore];
    NSMutableArray *m_arrIDSubject = [NSMutableArray array];
    for (Scoreboad *thisScore in arrScore) {
        [m_arrIDSubject addObject:[NSNumber numberWithInteger:thisScore.idsubject]]; // ghi các idSubject vào mảng m_arrIDSubject
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:m_arrIDSubject]; // loại bỏ các phần tử trùng nhau của mảng m_arrIDSubject
    _arrIDSubject = [orderedSet array];
    
    
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
    AddNewScore *thisAddNewScore = [[AddNewScore alloc] initWithNibName:@"AddNewScore" bundle:nil];
    thisAddNewScore.arrIDSubject = _arrIDSubject;
    [self.navigationController pushViewController:thisAddNewScore animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3; // Demo
    return _arrIDSubject.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_arrIDSubject.count > 0) {
        for (int i=0; i<_arrIDSubject.count; i++) {
            if (section==i) {
                Subject *thisSub = [Subject querySubWithidSubject:[_arrIDSubject[i] integerValue]];
                return [NSString stringWithFormat:@"Điểm môn: %@", thisSub.subject];
            }
        }
    } return @"---";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 4;//Demo
    if (_arrIDSubject.count > 0) {
        for (int i=0; i<_arrIDSubject.count; i++) {
            if (section==i) {
                NSArray *arrScoreE = [Scoreboad queryScoreFromIDSubject:[[_arrIDSubject objectAtIndex:i] integerValue]];
                NSMutableArray *m_arrIDClass = [NSMutableArray array];
                for (Scoreboad *thisScore in arrScoreE) {
                    if (thisScore.idclass>0) {
                        [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]]; // ghi các idClass vào mảng m_arrIDClass
                    }
                }
                NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:m_arrIDClass]; // loại bỏ các phần tử trùng nhau của mảng m_arrIDClass
                NSArray *arrIDClassWithSub = [orderedSet array];
                [_arrIDClassAtEachSub addObject:arrIDClassWithSub]; //lưu arrIDClassWithSub như một phần tử của _arrIDClassAtEachSub
                return arrIDClassWithSub.count;
            }
        }
    } return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassedTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassedTableViewCell"];
    }
    for (int i=0; i<_arrIDSubject.count; i++) {
        if (indexPath.section == i) {
            Subject *thisSub = [Subject querySubWithidSubject:[_arrIDSubject[i] integerValue]];
            NSArray *arrIDClass = [_arrIDClassAtEachSub objectAtIndex:i];
            NSMutableArray *arrClass = [NSMutableArray array];
            for (NSNumber *idClass in arrIDClass) {
                ClassList *thisclass = [ClassList queryClassWithIDClass:[idClass integerValue]];
                [arrClass addObject:thisclass];
            }
            ClassList *thisClass =(ClassList*)[arrClass objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"Điểm môn %@ lớp %@", thisSub.subject, thisClass.name];
        }
    }
    
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
