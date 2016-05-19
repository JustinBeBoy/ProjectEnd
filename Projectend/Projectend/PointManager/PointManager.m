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
    _arrSubjectList = [Subject queryListSubject];
    for (NSString *obj in _arrSubjectList) {
        NSArray *arrClassWithSub;
        //creat arrClassWithSub from Database .......................
        [_arrClassAtEachSub addObject:arrClassWithSub];
        [_tblPointWithClass reloadData];
    }
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
    return _arrSubjectList.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_arrSubjectList.count > 0) {
        for (int i=0; i<_arrSubjectList.count; i++) {
            if (section==i) {
                Subject *thisSub = (Subject*)[_arrSubjectList objectAtIndex:i];
//                return thisSub.name;..............................
                return @"thisSub.name";
            }
        }
    } return @"";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_arrSubjectList.count > 0) {
        for (int i=0; i<_arrSubjectList.count; i++) {
            if (section==i) {
                return [[_arrClassAtEachSub objectAtIndex:i] count];
            }
        }
    } return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassedTableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClassedTableViewCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Điểm môn... lớp...."];
    
    return cell;
}
@end
