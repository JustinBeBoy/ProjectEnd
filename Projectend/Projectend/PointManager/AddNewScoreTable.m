//
//  AddNewScoreTable.m
//  Projectend
//
//  Created by Admin on 5/25/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AddNewScoreTable.h"
#import "Scoreboad.h"
#import "Subject.h"
#import "ClassList.h"
#import "Student.h"
#import "SWRevealViewController.h"
#import "UIViewController+PresentViewControllerOverCurrentContext.h"

@interface AddNewScoreTable (){
    NSArray *arrSubject;
    NSArray *arrClass;
    
    NSMutableArray *arrIDClass;
    NSMutableArray *arrIDSubject;
    
    NSInteger subjectId;
    NSInteger classId;
    
    IBOutlet UILabel *lblError;
}

@end

@implementation AddNewScoreTable

- (void)viewDidLoad {
    [super viewDidLoad];
    subjectId = -1;
    classId = -1;
    
    [self setupUI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
-(void)setupUI{
    _btnSubjecSelect.layer.borderWidth = 1;
    _btnSubjecSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnSubjecSelect.layer.cornerRadius = 5;
    
    _btnClassSelect.layer.borderWidth = 1;
    _btnClassSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    _btnClassSelect.layer.cornerRadius = 5;
}
-(void)loadData{
    arrIDClass = [NSMutableArray array];
    arrIDSubject = [NSMutableArray array];
    arrClass =[ClassList queryListClass];
    arrSubject = [Subject queryListSubject];
    for (ClassList *thisClass in arrClass) {
        [arrIDClass addObject:thisClass.iId];
    }
    for (Subject *thisSub in arrSubject) {
        [arrIDSubject addObject:thisSub.iId];
    }
}
-(NSArray*)getArrSubjectFromIDSubject:(NSArray*)arrIdSub{
    NSMutableArray *arrSub = [NSMutableArray array];
    for (NSNumber *thisIDSubject in arrIdSub) {
        Subject *thisSubject = [Subject querySubWithidSubject:[thisIDSubject integerValue]];
        [arrSub addObject:thisSubject];
    }
    return arrSub;
}
-(NSArray*)getArrClassFromIDClass:(NSArray*)arrIdClass{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSNumber *thisIDClass in arrIdClass) {
        ClassList *thisClass = [ClassList queryClassWithIDClass:[thisIDClass integerValue]];
        [arr addObject:thisClass];
    }
    return arr;
}
-(void)rel{
    dropDown = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)pressedSubject:(id)sender {
    lblError.text=nil;
    NSMutableArray *arrSubjectName = [NSMutableArray array];
    for (Subject *thisSubject in arrSubject) {
        [arrSubjectName addObject:thisSubject.subject];
    }
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arrSubjectName :nil :@"down"];
        dropDown.tag = 10;//mon hoc
        dropDown.delegate = self;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (IBAction)pressedClass:(id)sender {
    lblError.text = nil;
    NSMutableArray *arrClassName = [NSMutableArray array];
    for (ClassList *thisClass in arrClass) {
        [arrClassName addObject:thisClass.name];
    }
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arrClassName :nil :@"down"];
        dropDown.tag = 20;//lop hoc
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

#pragma mark - niDropDelegate

- (void) niDropDownDelegateMethodWithIndex: (NIDropDown *) sender Index:(NSInteger)index {
    if (sender.tag == 10) {
        NSLog(@"---------------->ma mon %ld", [((Subject*)arrSubject[index]).iId integerValue]);
        subjectId = [((Subject*)arrSubject[index]).iId integerValue];
        NSArray *arrScore = [Scoreboad queryScoreFromIDSubject:subjectId];
        NSMutableArray *m_arrIDClass = [NSMutableArray array];
        for (Scoreboad *thisScore in arrScore) {
            [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]];
        }
        NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:m_arrIDClass];
        NSArray *arrIDClassExist = [orderSet array];
        NSMutableArray *arrIDClassNotExist = [NSMutableArray array];
        for (NSNumber *thisID in arrIDClass) {
            if ([arrIDClassExist indexOfObject:thisID]==NSNotFound) {
                [arrIDClassNotExist addObject:thisID];
            }
        }
        arrClass = [self getArrClassFromIDClass:arrIDClassNotExist];
        
    } else if(sender.tag == 20){
        NSLog(@"---------------->ma lop %ld", [((ClassList*)arrClass[index]).iId integerValue]);
        classId = [((ClassList*)arrClass[index]).iId integerValue];
        NSArray *arrScore = [Scoreboad queryScoreFromIDClass:classId];
        NSMutableArray *m_arrIDSub = [NSMutableArray array];
        for (Scoreboad *thisScore in arrScore) {
            [m_arrIDSub addObject:[NSNumber numberWithInteger:thisScore.idsubject]];
        }
        NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:m_arrIDSub];
        NSArray *arrIDSubExist = [orderSet array];
        NSMutableArray *arrIDSubNotExist = [NSMutableArray array];
        for (NSNumber *thisID in arrIDSubject) {
            if ([arrIDSubExist indexOfObject:thisID]==NSNotFound) {
                [arrIDSubNotExist addObject:thisID];
            }
        }
        arrSubject = [self getArrSubjectFromIDSubject:arrIDSubNotExist];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}
- (IBAction)pressedBack:(id)sender {
    [self dismissViewControllerOverCurrentContextAnimated:YES completion:nil];
}
- (IBAction)pressedAdd:(id)sender {
    if (subjectId != -1 && classId != -1) {
        NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%ld", classId]];
        NSMutableArray *arr = [NSMutableArray array];
        if (arrStudent.count>0) {
            for (Student *thisStudent in arrStudent) {
                Scoreboad *thisScore = [Scoreboad new];
                thisScore.idsubject = subjectId;
                thisScore.idclass = classId;
                thisScore.idstudent = [thisStudent.iId integerValue];
                [thisScore update];
                [arr addObject:thisScore];
                [self.delegate sendTypePush:@"addmore" andArrScore:arr];
            }
            
            [self dismissViewControllerOverCurrentContextAnimated:YES completion:nil];
        }else{
            lblError.text = @"Lớp này chưa có sinh viên";
        }
    }
    
}
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message andTime:(float)time{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
