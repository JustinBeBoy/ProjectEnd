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
@property (strong, nonatomic) IBOutlet DLRadioButton *olbtCheckTeacher;
@property (strong, nonatomic) IBOutlet DLRadioButton *olbtCheckStudent;
@property (strong, nonatomic) IBOutlet UIButton *olbtLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    // Do any additional setup after loading the view from its nib.
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    [self setupUI];
    [self chekboxselected];
}

- (void)setupUI{
//    _olbtCheckTeacher.backgroundColor = [UIColor whiteColor];
    _olbtCheckTeacher.layer.cornerRadius = 8.0;
    [_olbtCheckTeacher.layer setMasksToBounds:YES];
    _olbtCheckStudent.layer.cornerRadius = 8.0;
    [_olbtCheckStudent.layer setMasksToBounds:YES];
    _olbtLogin.layer.cornerRadius = 8.0;
    [_olbtLogin.layer setMasksToBounds:YES];
//    if(_olbtLogin.state == UIControlStateFocused){
//        _olbtLogin.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0 blue:219.0/255.0 alpha:1];
//    };
}

- (void)chekboxselected {
    if ([self.btTeacher isSelected]) {
        _olbtCheckTeacher.backgroundColor = [UIColor whiteColor];
        flagcheckbox = YES;
    }else{
        _olbtCheckTeacher.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0 blue:219.0/255.0 alpha:1];
    }
    if ([self.btStudent isSelected]) {
        _olbtCheckStudent.backgroundColor = [UIColor whiteColor];
        flagcheckbox = NO;
    }else{
        _olbtCheckStudent.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0 blue:219.0/255.0 alpha:1];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    NSLog(@"%i",flagcheckbox);
}

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
            Student *thisStudent = [arrayStudents objectAtIndex:0];
            scorevc.iDStudent = [thisStudent.iId integerValue];
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
- (IBAction)btLoginTD:(id)sender {
    _olbtLogin.backgroundColor = [UIColor whiteColor];
    [_olbtLogin setTitleColor:[UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0 blue:219.0/255.0 alpha:1] forState:UIControlStateNormal];
}
@end