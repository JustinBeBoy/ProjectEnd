//
//  PointTableDetail.m
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "PointTableDetail.h"
#import "Student.h"

@interface PointTableDetail (){
    
    IBOutlet UILabel *lblPoint;
    IBOutlet UILabel *lblName;
}

@end

@implementation PointTableDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI{
    lblName.layer.borderWidth = 1.0f;
    lblPoint.layer.borderWidth = 1.0f;
    [_tblPointDetail registerNib:[UINib nibWithNibName:@"PointTableDetailCell" bundle:nil] forCellReuseIdentifier:@"PointTableDetailCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _arrStudent.count;
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PointTableDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointTableDetailCell"];
    if (cell==nil) {
        cell = [[PointTableDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PointTableDetailCell"];
    }
    Student *thisStudent = [_arrStudent objectAtIndex:indexPath.row];
//    cell.lblHoTen.text = thisStudent.name;
    cell.lblHoTen.text = @"Tang";
    NSString *score = @"8";
    //find score with (idstudent, idclass, idsubject)..........................
    cell.lblDiem.text = score;
    return cell;
}

- (IBAction)pressedBack:(id)sender {
}
- (IBAction)pressedPlus:(id)sender {
}

@end
