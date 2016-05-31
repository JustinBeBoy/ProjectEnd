//
//  PointTableDetail.m
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "PointTableDetail.h"
#import "Student.h"
#import "Scoreboad.h"
#import "Subject.h"
#import "ClassList.h"
#import "SWRevealViewController.h"
#import "AddNewScoreTable.h"
#import "UIViewController+PresentViewControllerOverCurrentContext.h"

@interface PointTableDetail () <PointTableDetailCellProtocol>
{
    PointTableDetailCell *cell;
    
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnEdit;
    IBOutlet UILabel *lblPoint;
    IBOutlet UILabel *lblName;
    
    UITextField *thatTextField;
    
    BOOL alowEdit;
    BOOL error;
}

@end

@implementation PointTableDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setupUI{
    if ([_typePush  isEqualToString: @"add"]) {
        AddNewScoreTable *new = [[AddNewScoreTable alloc] initWithNibName:@"AddNewScoreTable" bundle:nil];
        new.delegate = self;
        [self presentViewControllerOverCurrentContext:new animated:YES completion:nil];
    }
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    lblName.layer.borderWidth = 1.0f;
    lblPoint.layer.borderWidth = 1.0f;
    
    [_tblPointDetail registerNib:[UINib nibWithNibName:@"PointTableDetailCell" bundle:nil] forCellReuseIdentifier:@"PointTableDetailCell"];
    [self.navigationController setNavigationBarHidden:YES];
    
    _tblPointDetail.tableFooterView = [[UIView alloc] init];
    
    alowEdit = NO;
    error = NO;
}
-(void)loadData{
    if ([_typePush isEqualToString:@"addmore"]) {
        alowEdit = YES;
        [btnEdit setHidden:YES];
        [btnSave setHidden:NO];
    }
    
    Scoreboad *thisScore = [_arrScore objectAtIndex:0];
    Subject *thisSubject = [Subject querySubWithidSubject:thisScore.idsubject];
    ClassList *thisClass = [ClassList queryClassWithIDClass:thisScore.idclass];
    NSMutableArray *arrIDStudent = [NSMutableArray array];
    for (Scoreboad *thisScoreN in _arrScore) {
        [arrIDStudent addObject:[NSNumber numberWithInteger:thisScoreN.idstudent]];
    }
    
    NSMutableArray *arrScoreAdd = [NSMutableArray arrayWithArray:_arrScore];
    NSArray *arrStu = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@", thisClass.iId]];
    
    if (arrStu.count > _arrScore.count && ![_typePush  isEqualToString: @"addmore"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thêm sinh viên" message:@"Lớp này có các sinh viên mới chưa có điểm \n Bạn có nhập thêm điểm của những sinh viên này?" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *actOK = [UIAlertAction actionWithTitle:@"Thêm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            for (Student *thisStudent in arrStu) {
                if ([arrIDStudent indexOfObject:thisStudent.iId]==NSNotFound) {
                    Scoreboad *thisScoreAdd = [[Scoreboad alloc] init];
                    thisScoreAdd.idsubject = [thisSubject.iId integerValue];
                    thisScoreAdd.idclass = [thisClass.iId integerValue];
                    thisScoreAdd.idstudent = [thisStudent.iId integerValue];
                    thisScoreAdd.mask = @"notScore";
                    [thisScoreAdd update];
                    [arrScoreAdd addObject:thisScoreAdd];
                }
            }
            alowEdit = YES;
            [btnEdit setHidden:YES];
            [btnSave setHidden:NO];
            _arrScore = arrScoreAdd;
            [_tblPointDetail reloadData];
        }];
        UIAlertAction *actCancel = [UIAlertAction actionWithTitle:@"Huỷ" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:actOK];
        [alert addAction:actCancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    _lblPointDetailTitle.text = [NSString stringWithFormat:@"Điểm %@ lớp %@", thisSubject.subject, thisClass.name];
    
    [_tblPointDetail reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 4;
    return _arrScore.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cell = [tableView dequeueReusableCellWithIdentifier:@"PointTableDetailCell"];
    if (cell==nil) {
        cell = [[PointTableDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PointTableDetailCell"];
    }
    Scoreboad *thisScore = [_arrScore objectAtIndex:indexPath.row];
    Student *thisStudent = [Student queryStudentWithidStudent:thisScore.idstudent];
    cell.lblHoTen.layer.borderWidth = 1.0f;
    cell.tfDiem.layer.borderWidth = 1.0f;
    cell.lblHoTen.text = [NSString stringWithFormat:@"  %@",thisStudent.name];
    if ([_typePush isEqualToString:@"addmore"] || [thisScore.mask isEqualToString:@"notScore"]) {
        cell.tfDiem.text = @"";
    } else {
        cell.tfDiem.text = [NSString stringWithFormat:@"%ld",thisScore.score];
    }
    cell.indexPathCell = indexPath;
    cell.delegate = self;
    if (alowEdit==YES) {
        cell.tfDiem.enabled = YES;
    } else{
        cell.tfDiem.enabled = NO;
    }
    return cell;
}

- (IBAction)pressedBack:(id)sender {
    if (alowEdit == YES ) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Lưu điểm" message:@"Bạn chưa lưu điểm \n Bạn có muốn lưu không?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actOk = [UIAlertAction actionWithTitle:@"Lưu" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self saveData];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *actCancel = [UIAlertAction actionWithTitle:@"Không" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            if ([_typePush isEqualToString:@"addmore"]) {
                [self clearData];
            }
            [self loadData];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:actOk];
        [alert addAction:actCancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)pressedEdit:(id)sender {
    alowEdit = YES;
    [btnEdit setHidden:YES];
    [btnSave setHidden:NO];
    
    [_tblPointDetail reloadData];
}
- (IBAction)pressedSave:(id)sender {
    _typePush = nil;
    [self saveData];
}

-(void)clearData{
    for (Scoreboad *thisScore in _arrScore) {
        thisScore.deleted = @(1);
        [thisScore update];
    }
}

-(void)saveData{
    if (error==NO) {
        alowEdit = NO;
        [btnSave setHidden:YES];
        [btnEdit setHidden:NO];
        BOOL err = NO;
        for (Scoreboad *thisScore in _arrScore) {
            if (thisScore.mask.length>0 && ![thisScore.mask isEqualToString:@"notScore"]) {
                thisScore.score = [thisScore.mask integerValue];
                thisScore.mask = nil;
                [thisScore update];
            }else if ([thisScore.mask isEqualToString:@"notScore"]){
                err = YES;
            }
        }
        if (err == YES) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"nhập đủ điểm các sinh viên" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            alowEdit = YES;
            [btnSave setHidden:NO];
            [btnEdit setHidden:YES];
            return;
        }
        [self loadData];
    }
    error = NO;
}

-(void)sentTextField:(UITextField *)textField andIndexPath:(NSIndexPath *)indexPath{
    if ([textField.text integerValue]>10 || textField.text.length<1) {
        error = YES;
        [self showAlertWithTitle:@"Lỗi!" andMessage:@"Mời bạn nhập lại điểm"];
    }else{
        error = NO;
        thatTextField = textField;
        Scoreboad *thisScore = [_arrScore objectAtIndex:indexPath.row];
        thisScore.mask = thatTextField.text;
        [thisScore update];
    }
}
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActOk = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:alertActOk];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)sendTypePush:(NSString*)type andArrScore:(NSArray *)arr{
    _typePush = type;
    _arrScore = arr;
    [self loadData];
}
@end
