//
//  MainViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/15/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setupUI];
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu24.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
}

- (void)setupUI{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"Trang Chủ";
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor colorWithRed:146.0f/255.0f green:204.0f/255.0f blue:55.0f/255.0f alpha:1],
                                                            NSFontAttributeName: [UIFont systemFontOfSize:20 ]
                                                            }];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:247/255 green:248/255 blue:246/255 alpha:1]];
    self.navigationItem.leftBarButtonItem = [self leftButtomBar];
}

- (UIBarButtonItem *)leftButtomBar{
    UIImage *image = [UIImage imageNamed:@"menu24.png"];
    CGRect buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    //[button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
