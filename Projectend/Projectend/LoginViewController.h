//
//  MainViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLRadioButton/DLRadioButton.h"
#import "Teacher.h"
#import "MainViewController.h"

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *tfUserName;
@property (strong, nonatomic) IBOutlet UITextField *tfPassWord;

@property (strong, nonatomic) IBOutlet DLRadioButton *btStudent;
@property (strong, nonatomic) IBOutlet DLRadioButton *btTeacher;


@end