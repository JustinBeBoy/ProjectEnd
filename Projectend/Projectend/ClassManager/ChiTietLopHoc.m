//
//  ChiTietLopHoc.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ChiTietLopHoc.h"
#import "ThemSinhVien.h"

@interface ChiTietLopHoc (){
    IBOutlet UIButton *btnPlus;
}

@end

@implementation ChiTietLopHoc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _edited = NO;
    [self setupUI];
}
-(void)setupUI{
    [self.navigationController setNavigationBarHidden:YES];
    [_btnSave setHidden:YES];
    [btnPlus setHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadData];
}
-(void)reloadData{
    _arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@", _thisClass.iId]];
    
    _lblLop.text = [NSString stringWithFormat:@"%@", _thisClass.name];
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    ThemSinhVien *themSv = [[ThemSinhVien alloc] initWithNibName:@"ThemSinhVien" bundle:nil];
    [self presentViewController:themSv animated:YES completion:nil];
}


@end
