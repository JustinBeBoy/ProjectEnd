//
//  AddNewScore.m
//  Projectend
//
//  Created by Admin on 5/22/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AddNewScore.h"
#import "Subject.h"
#import "ClassList.h"
#import "Scoreboad.h"
#import "Student.h"

@interface AddNewScore (){
    IBOutlet UIPickerView *pickAddNewScore;
    
    Subject *thatSub;
    ClassList *thatClass;
    
    NSMutableArray *arrIDAllClass;
    NSMutableArray *arrIDAllSubject;
    
    BOOL isFirst;
}

@end

@implementation AddNewScore

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI{
    isFirst = YES;
    //set arrIDAllClass
    NSArray *arrAllClass = [ClassList queryListClass];
    for (ClassList *thisClass in arrAllClass) {
        [arrIDAllClass addObject:thisClass.iId];
    }
    
    //set arrIDAllSubject
    NSArray *arrAllSubject = [Subject queryListSubject];
    for (Subject *thisSubject in arrAllSubject) {
        [arrIDAllSubject addObject:thisSubject.iId];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return arrIDAllSubject.count;
    } else{
        return arrIDAllClass.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        Subject *thisSubject = [Subject querySubWithidSubject:(int)[arrIDAllSubject objectAtIndex:row]];
        return [NSString stringWithFormat:@"Môn %@", thisSubject.subject];
    } else{
        ClassList *thisClass = [ClassList queryClassWithIDClass:(int)[arrIDAllClass objectAtIndex:row]];
        return [NSString stringWithFormat:@"Lớp %@", thisClass.name];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (isFirst == YES) {
        thatSub = [Subject querySubWithidSubject:(int)[arrIDAllSubject objectAtIndex:0]];
        thatClass = [ClassList queryClassWithIDClass:(int)[arrIDAllClass objectAtIndex:0]];
    }
    if (component == 0) {
        thatSub = [Subject querySubWithidSubject:(int)[arrIDAllSubject objectAtIndex:row]];
    } else {
        thatClass = [ClassList queryClassWithIDClass:(int)[arrIDAllClass objectAtIndex:row]];
    }
    isFirst = NO;
}

- (IBAction)pressedAdd:(id)sender {
    if ([_arrIDSubject indexOfObject:thatSub.iId] != NSNotFound) {
        // get arrClass in this Subject
        NSArray *arrScoreE = [Scoreboad queryScoreFromIDSubject:(int)thatSub.iId];
        NSMutableArray *m_arrIDClass = nil;
        for (Scoreboad *thisScore in arrScoreE) {
            [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]];
        }
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:m_arrIDClass];
        NSArray *arrIDClassWithSub = [orderedSet array];
        
        if ([arrIDClassWithSub indexOfObject:thatClass.iId] != NSNotFound) {
            [self showAlertWithTitle:@"Lỗi" andMessage:@"Đã tồn tại bảng điểm môn học của lớp học này"];
        }
    }
    NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%@", thatClass.iId]];
    for (Student *thisStudent in arrStudent) {
        Scoreboad *thisScore = [Scoreboad new];
        thisScore.idsubject = (int)thatSub.iId;
        thisScore.idclass = (int)thatClass.iId;
        thisScore.idstudent = (int)thisStudent.iId;
        [thisScore update];
    }
    [self showAlertWithTitle:@"Thêm điểm" andMessage:@"Đã thêm thành công. Bạn có thể chọn lớp để sửa điểm"];
}
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:alertActOK];
    [self presentViewController:alert animated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
