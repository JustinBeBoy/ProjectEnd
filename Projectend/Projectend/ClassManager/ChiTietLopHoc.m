//
//  ChiTietLopHoc.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ChiTietLopHoc.h"
#import "ThemSinhVien.h"
#import "UIViewController+PresentViewControllerOverCurrentContext.h"

@interface ChiTietLopHoc (){
    IBOutlet UIButton *btnPlus;
    
}

@end

@implementation ChiTietLopHoc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}
-(void)setupUI{
    _edited = NO;
    [self.navigationController setNavigationBarHidden:YES];
    [_btnSave setHidden:YES];
    [btnPlus setHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)loadData{
    _arrMaskStudent = [NSMutableArray array];
    
    _arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@", _thisClass.iId]];
    
    _lblLop.text = [NSString stringWithFormat:@"Lớp %@", _thisClass.name];
    _lblSoSv.text = [NSString stringWithFormat:@"Số sv: %ld", [_arrStudent count]];
    
    [_tableViewStudent reloadData];
    
}
#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrStudent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Student *thisStudent = (Student*)[_arrStudent objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - NS:%@", thisStudent.name, thisStudent.dateofbirth];
    
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
        [_arrMaskStudent addObjectsFromArray:_arrStudent];
        Student *thisStudent = [_arrStudent objectAtIndex:indexPath.row];
        thisStudent.deleted = @(1);
        [thisStudent update];
        [self loadData];
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
    //save data in the database ................
    _edited = NO;
    [_btnExit setHidden:NO];
    [_btnSave setHidden:YES];
    [btnPlus setHidden:YES];
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addPressed:(id)sender {
//    NSArray *subViewArray = [[NSBundle mainBundle] loadNibNamed:@"ThemSinhVien" owner:self options:nil];
//    UIView *subView = [subViewArray objectAtIndex:0];
//    [self.view addSubview:subView];
    ThemSinhVien *themSv = [[ThemSinhVien alloc] initWithNibName:@"ThemSinhVien" bundle:nil];
    [self presentViewControllerOverCurrentContext:themSv animated:YES completion:nil];
}


@end
