//
//  AddAndEditViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"
#import "Student.h"

@interface AddAndEditViewController : UIViewController<PickerViewControllerDelegate>
- (IBAction)btSex:(id)sender;
- (IBAction)btDateOfBirth:(id)sender;

@property (strong,nonatomic)Student *student;
@property (nonatomic, assign) BOOL isEditing;
@property (strong, nonatomic) IBOutlet UIButton *olSex;
@property (strong, nonatomic) IBOutlet UIButton *olDateOfBirth;
@property (strong, nonatomic) IBOutlet UITextField *tfName;
@property (strong, nonatomic) IBOutlet UITextField *tfAddress;
@property (strong, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *tfMail;
@property (strong, nonatomic) IBOutlet UILabel *lbWarring;
@property (strong, nonatomic) IBOutlet UITextField *tfUsername;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@end
