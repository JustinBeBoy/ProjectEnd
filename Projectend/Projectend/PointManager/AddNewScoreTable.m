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
    
    NSArray *arrIDSubject;
    NSArray *arrIDClass;
    
    Subject *subObj;
    ClassList *classObj;
    
    NSInteger subjectId;
    NSInteger classId;
}

@end

@implementation AddNewScoreTable

- (void)viewDidLoad {
    [super viewDidLoad];
    subjectId = -1;
    classId = -1;
    subObj = nil;
    classObj = nil;
    
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
    NSArray *arrAllScore = [Scoreboad queryListScore];
    NSMutableArray *m_arrIDSubject = [NSMutableArray array];
    NSMutableArray *m_arrIDClass = [NSMutableArray array];
    for (Scoreboad *thisScore in arrAllScore) {
        [m_arrIDSubject addObject:[NSNumber numberWithInteger:thisScore.idsubject]];
        [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]];
    }
    
    NSOrderedSet *orderedSetSub = [NSOrderedSet orderedSetWithArray:m_arrIDSubject];
    NSOrderedSet *orderSetClass = [NSOrderedSet orderedSetWithArray:m_arrIDClass];
    arrIDSubject = [orderedSetSub array];
    arrIDClass = [orderSetClass array];
    
    arrSubject = [Subject queryListSubjectWhereClassId:classId];
    arrClass = [ClassList queryListClassWhereSubjectId:subjectId];
//    arrSubject = [self getArrSubjectFromIDSubject:arrIDSubject];
//    arrClass = [self getArrClassFromIDClass:arrIDClass];
}
-(NSArray*)getArrSubjectFromIDSubject:(NSArray*)arrIdSub{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSNumber *thisIDSubject in arrIdSub) {
        Subject *thisSubject = [Subject querySubWithidSubject:[thisIDSubject integerValue]];
        [arr addObject:thisSubject];
    }
    return arr;
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
        subObj = (Subject*)arrSubject[index];
        arrClass = [ClassList queryListClassWhereSubjectId:subjectId];
    } else if(sender.tag == 20){
        NSLog(@"---------------->ma lop %ld", [((ClassList*)arrClass[index]).iId integerValue]);
        classId = [((ClassList*)arrClass[index]).iId integerValue];
        classObj = (ClassList*)arrClass[index];
        arrSubject = [Subject queryListSubjectWhereClassId:classId];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    NSLog(@"%@", _btnSubjecSelect.titleLabel.text);
    NSLog(@"%@", _btnClassSelect.titleLabel.text);
}
- (IBAction)pressedBack:(id)sender {
    [self dismissViewControllerOverCurrentContextAnimated:YES completion:nil];
}
- (IBAction)pressedAdd:(id)sender {
    NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%ld", classId]];
    if (arrStudent.count>0) {
        for (Student *thisStudent in arrStudent) {
            Scoreboad *thisScore = [Scoreboad new];
            thisScore.idsubject = subjectId;
            thisScore.idclass = classId;
            thisScore.idstudent = [thisStudent.iId integerValue];
            [thisScore update];
            [self.delegate sendTypePush:@"addmore"];
        }
    }else{
    }
    [self dismissViewControllerOverCurrentContextAnimated:YES completion:nil];
}

@end
