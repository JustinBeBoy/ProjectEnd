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

@interface PointManager ()

@end

@implementation PointManager

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)loadData{
    NSArray *arrScore = [Scoreboad queryListScore];
    NSMutableArray *m_arrIDSubject = nil;
    for (NSObject *obj in arrScore) {
        Scoreboad *thisScore = (Scoreboad*)obj;
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
- (IBAction)pressedPlus:(id)sender {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrIDSubject.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (_arrIDSubject.count > 0) {
        for (int i=0; i<_arrIDSubject.count; i++) {
            if (section==i) {
                Subject *thisSub = [Subject querySubWithidSubject:(int)_arrIDSubject[i]];
                return [NSString stringWithFormat:@"Điểm môn: %@", thisSub.subject];
            }
        }
    } return @"---";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_arrIDSubject.count > 0) {
        for (int i=0; i<_arrIDSubject.count; i++) {
            if (section==i) {
                NSArray *arrScoreE = [Scoreboad queryScoreFromIDSubject:(int)_arrIDSubject[i]];
                NSMutableArray *m_arrIDClass = nil;
                for (NSObject *obj in arrScoreE) {
                    Scoreboad *thisScore = (Scoreboad*)obj;
                    [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]]; // ghi các idClass vào mảng m_arrIDClass
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
        //
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Điểm môn... lớp...."];
    
    return cell;
}
@end
