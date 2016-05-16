//
//  ChiTietLopHoc.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ChiTietLopHoc.h"

@interface ChiTietLopHoc (){
    BOOL isEditOrSave;
    IBOutlet UIButton *btnPlus;
}

@end

@implementation ChiTietLopHoc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    isEditOrSave = NO;
    [super viewDidAppear:animated];
    [self reloadData];
}
-(void)reloadData{
    _arrStudent = [Student queryStudentWithIDClass:_thisClass.idStr];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];}
- (IBAction)saveOrEditPressed:(id)sender {
    if (isEditOrSave) {
        isEditOrSave = NO;
    } else isEditOrSave = YES;
    if (isEditOrSave) {
        [btnPlus setEnabled:YES];
    } else [btnPlus setEnabled:NO];
}
- (IBAction)addPressed:(id)sender {
}


@end
