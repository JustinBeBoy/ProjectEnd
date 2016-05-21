//
//  MainViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "LoginViewController.h"
#import "SlideMenuViewController.h"
#import "ScoreManagerVC.h"

@interface LoginViewController (){
    BOOL flagcheckbox;
    NSArray *arrayTeachers;
    NSArray *arrayStudents;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    // Do any additional setup after loading the view from its nib.
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
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
    self.navigationController.navigationBarHidden = YES;
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
            [self moveToHome];

        }else{
            NSLog(@"nhap lai username and password");
        }
    }
    if (!flagcheckbox) {
        arrayStudents = [NSArray array];
        arrayStudents = [Student queryStudentUsername:self.tfUserName.text andPassword:self.tfPassWord.text];
        if(arrayStudents.count>0){
            ScoreManagerVC *scorevc = [[ScoreManagerVC alloc]initWithNibName:@"ScoreManagerVC" bundle:nil];
            [self.navigationController pushViewController:scorevc animated:YES];
            NSLog(@"dang nhap student thanh cong");
        }else
            NSLog(@"nhap lai username and password");
    }
}
- (void) moveToHome{
//    MainViewController *mainViewController;
    MainViewController *frontViewController  = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    SlideMenuViewController *rearViewController = [[SlideMenuViewController alloc] initWithNibName:@"SlideMenuViewController" bundle:nil];
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    [self.navigationController pushViewController:revealController animated:YES];
}
@end