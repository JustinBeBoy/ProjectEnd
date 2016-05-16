//
//  MainViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    BOOL flagcheckbox;
    NSArray *arrayTeachers;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self chekboxselected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)chekboxselected {
    if ([self.btTeacher isSelected]) {
        flagcheckbox = YES;
    }
    if ([self.btStudent isSelected]) {
        flagcheckbox = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%i",flagcheckbox);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cboxTeacher:(id)sender {
    [self chekboxselected];
    NSLog(@"%i",flagcheckbox);
}

- (IBAction)cboxStudent:(id)sender {
    [self chekboxselected];
    NSLog(@"%i",flagcheckbox);
}

- (IBAction)btnLogIn:(id)sender {
    if (flagcheckbox) {
        arrayTeachers = [NSArray array];
        arrayTeachers = [Teacher queryTeacherUsername:self.tfUserName.text andPassword:self.tfPassWord.text];
        if (arrayTeachers.count>0) {
            MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            [self.navigationController pushViewController:mainViewController animated:YES];
        }else{
            NSLog(@"nhap lai username and password");
        }
    }
}
@end