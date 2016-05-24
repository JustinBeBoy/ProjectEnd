//
//  AddAndEditSubjectViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/19/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"

@interface AddAndEditSubjectViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *tfSubject;
@property (strong, nonatomic) IBOutlet UITextField *tfDescription;
@property (strong, nonatomic) IBOutlet UITextField *tfCredits;
@property (strong, nonatomic) IBOutlet UILabel *lbWaring;

@property(assign,nonatomic)BOOL isEditing;
@property(strong,nonatomic)Subject *subjectClass;

@end
