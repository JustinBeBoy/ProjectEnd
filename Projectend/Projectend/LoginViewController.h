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
#import "Student.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface LoginViewController : UIViewController<SWRevealViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tfUserName;
@property (strong, nonatomic) IBOutlet UITextField *tfPassWord;

@property (strong, nonatomic) IBOutlet DLRadioButton *btStudent;
@property (strong, nonatomic) IBOutlet DLRadioButton *btTeacher;
- (IBAction)btLoginTD:(id)sender;
- (void) moveToHome;


@end
