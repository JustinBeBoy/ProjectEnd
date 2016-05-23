//
//  ThemSinhVien.m
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ThemSinhVien.h"
#import "AddStudentCell.h"
#import "Student.h"

@interface ThemSinhVien () <CheckTouchDelegate>
{
    AddStudentCell *cell;
    NSMutableArray *arrAddingStudent;
}

@end

@implementation ThemSinhVien

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}
-(void)setupUI{
    [self.navigationController setNavigationBarHidden:YES];
    [_tblAddStudent registerNib:[UINib nibWithNibName:@"AddStudentCell" bundle:nil] forCellReuseIdentifier:@"AddStudentCell"];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)loadData{
    _arrStudentNotAdd = [Student queryStudentWithIDClass:@""];//0 hay nil?????????
    [_tblAddStudent reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrStudentNotAdd.count;
//    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = [tableView dequeueReusableCellWithIdentifier:@"AddStudentCell"];
    
    if (cell==nil) {
        cell = [[AddStudentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddStudentCell"];
    }
    Student *thisStudent = (Student*)[_arrStudentNotAdd objectAtIndex:indexPath.row];
    cell.lblAddStudent.text = thisStudent.name;
    
//    cell.lblAddStudent.text = @"tang";
//    [cell.btnCheck setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
//    [cell.btnCheck setBackgroundColor:[UIColor redColor]];
    
    cell.indexPathCell = indexPath;
    cell.delegate = self;
    
    if (thisStudent.isCheck == YES) {
        [cell.btnCheck setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else{
        [cell.btnCheck setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void) btnCheckTouchByIndexPath:(NSIndexPath *)indexpath{
    Student *thisStudent = (Student*)[_arrStudentNotAdd objectAtIndex:indexpath.row];
    if (thisStudent.isCheck == NO) {
        thisStudent.isCheck = YES;
        thisStudent.idclass = (int)_thisClass.iId;
        [arrAddingStudent addObject:thisStudent];
    }else{
        thisStudent.isCheck = NO;
        thisStudent.idclass = 0;
        [arrAddingStudent removeObject:thisStudent];
    }
//    NSLog(@"bam button section: %ld, row: %ld",indexpath.section, indexpath.row);//demo
 
 [self loadData];
}
- (IBAction)clickedAdd:(id)sender {
    for (Student *thisStudent in arrAddingStudent) {
        [thisStudent update];
    }
    // co the van table chi tiet lop hoc chua cap nhat, neu chua can tao delegate de chuyen addAddingStudent sang roi updatedata
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
