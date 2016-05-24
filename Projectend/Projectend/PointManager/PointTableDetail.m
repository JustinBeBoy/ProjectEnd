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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setupUI{
    Scoreboad *thisScore = [_arrScore objectAtIndex:0];
    Subject *thisSubject = [Subject querySubWithidSubject:thisScore.idsubject];
    ClassList *thisClass = [ClassList queryClassWithIDClass:thisScore.idclass];
    _lblPointDetailTitle.text = [NSString stringWithFormat:@"Điểm %@ lớp %@", thisSubject.subject, thisClass.name];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    lblName.layer.borderWidth = 1.0f;
    lblPoint.layer.borderWidth = 1.0f;
    
    [_tblPointDetail registerNib:[UINib nibWithNibName:@"PointTableDetailCell" bundle:nil] forCellReuseIdentifier:@"PointTableDetailCell"];
    [self.navigationController setNavigationBarHidden:YES];
    alowEdit = NO;
    error = NO;
}
-(void)loadData{
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
    cell.lblHoTen.text = thisStudent.name;
    cell.tfDiem.text = [NSString stringWithFormat:@"%ld",thisScore.score];
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pressedEdit:(id)sender {
    alowEdit = YES;
    [btnEdit setHidden:YES];
    [btnSave setHidden:NO];
    [_tblPointDetail reloadData];
}
- (IBAction)pressedSave:(id)sender {
    if (error==NO) {
        alowEdit = NO;
        [btnSave setHidden:YES];
        [btnEdit setHidden:NO];
        for (Scoreboad *thisScore in _arrScore) {
            if (thisScore.mask.length>0) {
                thisScore.score = [thisScore.mask integerValue];
                thisScore.mask = nil;
                [thisScore update];
            }
        }
        [_tblPointDetail reloadData];
    }
    error = NO;
}
-(void)dismissKeyboard{
    [thatTextField resignFirstResponder];
}
-(void)sentTextField:(UITextField *)textField andIndexPath:(NSIndexPath *)indexPath{
    if ([textField.text integerValue]>10) {
        error = YES;
        [self showAlertWithTitle:@"Lỗi!" andMessage:@"Điểm nhập vào phải nhỏ hơn 10 \n Mời bạn nhập lại"];
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

@end
