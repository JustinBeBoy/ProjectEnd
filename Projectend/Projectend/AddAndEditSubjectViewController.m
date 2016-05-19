//
//  AddAndEditSubjectViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/19/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AddAndEditSubjectViewController.h"

@interface AddAndEditSubjectViewController (){
    UIBarButtonItem *btsave;
    UIBarButtonItem *btedit;
}

@end

@implementation AddAndEditSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add/Edit Subject";
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)setupUI{
    btsave = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveStudent)];
    btedit = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editSubjet)];
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *backbt = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(btBack)];
    self.navigationItem.leftBarButtonItem = backbt;
    if (self.isEditing) {
        [self tfAnableOrDissable:YES];
        self.navigationItem.rightBarButtonItem = btedit;
    }else{
        self.navigationItem.rightBarButtonItem = btsave;
    }
    
    [self loadDataInView];
}
- (void) loadDataInView {
    if (!self.isEditing) {
        self.subjectClass = [Subject new];
    }
    else {
        self.tfSubject.text = self.subjectClass.subject;
        self.tfDescription.text = self.subjectClass.descriptions;
        self.tfCredits.text = [NSString stringWithFormat:@"%li",self.subjectClass.credits];
    }
}

-(BOOL)checkAllComponent{
    if (self.tfSubject.text.length>0&&self.tfDescription.text.length>0&&self.tfCredits.text.length>0) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark Action
- (void)tfAnableOrDissable:(BOOL)values{
    if (values) {
        self.tfSubject.enabled = NO;
        self.tfDescription.enabled = NO;
        self.tfCredits.enabled = NO;
    }else{
        self.tfSubject.enabled = YES;
        self.tfDescription.enabled = YES;
        self.tfCredits.enabled = YES;
    }
}

- (void)btBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editSubjet{
    [self tfAnableOrDissable:NO];
    [btedit setTitle:@"Save"];
    self.navigationItem.rightBarButtonItem = btsave;
}

- (void)saveStudent{
    if ([self checkAllComponent]) {
        self.subjectClass.subject = self.tfSubject.text;
        self.subjectClass.descriptions = self.tfDescription.text;
        self.subjectClass.credits = [self.tfCredits.text intValue];
        [self.subjectClass update];
        NSLog(@"save Success");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
