//
//  SlideMenuViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "SlideMenuViewController.h"

@interface SlideMenuViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tbvMenu;
@property (nonatomic, weak) IBOutlet UITableViewCell *cellMenu;

@property (nonatomic,strong) NSMutableArray *arrayOfMenus;

@end

@implementation SlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Array Setup
- (void) setupMenuArray{
    NSArray *arrayOfMenu = @[
                         [ManagerList itemWithTitle:@"Quản Lý Lớp học" withImage:[UIImage imageNamed:@"class24.png"] ],
                         [ManagerList itemWithTitle:@"Quản Lý Sinh Viên" withImage:[UIImage imageNamed:@"student24.png"] ],
                         [ManagerList itemWithTitle:@"Quản Lý Môn Học" withImage:[UIImage imageNamed:@"subject24.png"] ],
                         [ManagerList itemWithTitle:@"Quản Lý Bảng Điểm" withImage:[UIImage imageNamed:@"scoreboard24.png"] ],
                         [ManagerList itemWithTitle:@"Log Out" withImage:[UIImage imageNamed:@"logout24.png"] ],
                         ];
    
    self.arrayOfMenus = [NSMutableArray arrayWithArray:arrayOfMenu];
    
    [self.tbvMenu reloadData];
}

#pragma mark -

#pragma mark -
#pragma mark UITableView Datasource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayOfMenus count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellMainNibID = @"cellMain";
    
    _cellMenu = [tableView dequeueReusableCellWithIdentifier:cellMainNibID];
    if (_cellMenu == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"MainCellRight" owner:self options:nil];
    }
    
    UIImageView *mainImage = (UIImageView *)[_cellMenu viewWithTag:1];
    
    UILabel *imageTitle = (UILabel *)[_cellMenu viewWithTag:2];
    
    if ([_arrayOfMenus count] > 0)
    {
        ManagerList *currentRecord = [self.arrayOfMenus objectAtIndex:indexPath.row];
        
        mainImage.image = currentRecord.image;
        imageTitle.text = [NSString stringWithFormat:@"%@", currentRecord.title];
    }
    
    return _cellMenu;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ManagerList *currentRecord = [self.arrayOfMenus objectAtIndex:indexPath.row];
//    
//    // Return Data to delegate: either way is fine, although passing back the object may be more efficient
//    // [_delegate imageSelected:currentRecord.image withTitle:currentRecord.title withCreator:currentRecord.creator];
//    // [_delegate animalSelected:currentRecord];
//    
//    [_delegate animalSelected:currentRecord];
//}

#pragma mark -
#pragma mark Default System Code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
