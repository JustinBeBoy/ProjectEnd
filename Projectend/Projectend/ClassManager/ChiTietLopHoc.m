//
//  ChiTietLopHoc.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ChiTietLopHoc.h"
#import "UIViewController+PresentViewControllerOverCurrentContext.h"

@interface ChiTietLopHoc (){
    IBOutlet UIButton *btnPlus;
    
    IBOutlet UIView *vTitle;
}

@end

@implementation ChiTietLopHoc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}
-(void)setupUI{
    [self.navigationController setNavigationBarHidden:YES];
    [_btnSave setHidden:YES];
    [btnPlus setHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)loadData{
    _edited = NO;
    vTitle.layer.borderWidth = 1.0f;
    
    _arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@", _thisClass.iId]];
    _arrMaskStudent = [NSMutableArray array];
    [_arrMaskStudent addObjectsFromArray:_arrStudent];
    _lblLop.text = [NSString stringWithFormat:@"Lớp: %@", _thisClass.name];
    _lblSoSv.text = [NSString stringWithFormat:@"Số sinh viên: %ld", [_arrMaskStudent count]];
    
    [_tableViewStudent reloadData];
    
}
#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrMaskStudent.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Student *thisStudent = (Student*)[_arrMaskStudent objectAtIndex:indexPath.row];
    cell.layer.borderWidth = 1.0f;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ \t - \t Ngày sinh: %@", thisStudent.name, thisStudent.dateofbirth];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_edited == YES) {
        return YES;
    }else{
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Student *thisStudent = [_arrMaskStudent objectAtIndex:indexPath.row];
        [_arrMaskStudent removeObject:thisStudent];
        _lblSoSv.text = [NSString stringWithFormat:@"Số sinh viên: %ld", [_arrMaskStudent count]];
        [_tableViewStudent reloadData];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)editPressed:(id)sender {
    _edited = YES;
    [btnPlus setHidden:NO];
    [_btnExit setHidden:YES];
    [_btnSave setHidden:NO];
}

- (IBAction)savePressed:(id)sender {
    _edited = NO;
    for (Student *thisStudent in _arrStudent) {
        if ([_arrMaskStudent indexOfObject:thisStudent] == NSNotFound) {
            NSArray *arrScore = [Scoreboad queryScoreFromIDStudent:[thisStudent.iId integerValue]];
            for (Scoreboad *thisScore in arrScore) {
                thisScore.idclass = 0;
                [thisScore update];
            }
            thisStudent.idclass = 0;
            [thisStudent update];
        }
    }
    for (Student *thisStudent in _arrMaskStudent) {
        if ([_arrStudent indexOfObject:thisStudent] == NSNotFound) {
            NSArray *arrScore = [Scoreboad queryScoreFromIDStudent:[thisStudent.iId integerValue]];
            for (Scoreboad *thisScore in arrScore) {
                thisScore.idclass = [_thisClass.iId integerValue];
                [thisScore update];
            }
            thisStudent.idclass = [_thisClass.iId integerValue];
            [thisStudent update];
        }
    }
    [_btnExit setHidden:NO];
    [_btnSave setHidden:YES];
    [btnPlus setHidden:YES];
    [self showAlertWithTitle:@"Lưu thay đổi" andMessage:@"Lưu thành công!"];
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addPressed:(id)sender {
    ThemSinhVien *themSv = [[ThemSinhVien alloc] initWithNibName:@"ThemSinhVien" bundle:nil];
    themSv.thisClass = _thisClass;
    themSv.delegate = self;
    [self presentViewControllerOverCurrentContext:themSv animated:YES completion:nil];
}
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActOk = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:alertActOk];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)sendArrMaskStudent:(NSArray *)arrMask{
    [_arrMaskStudent addObjectsFromArray:arrMask];
    [_tableViewStudent reloadData];
}
@end
