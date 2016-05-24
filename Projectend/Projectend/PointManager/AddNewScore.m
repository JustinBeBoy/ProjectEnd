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
    
    NSArray *arrAllClass;
    NSArray *arrAllSubject;
    
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
    arrAllClass = [ClassList queryListClass];
    arrAllSubject = [Subject queryListSubject];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return arrAllSubject.count;
    } else{
        return arrAllClass.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        Subject *thisSubject = [arrAllSubject objectAtIndex:row];
        return [NSString stringWithFormat:@"Môn %@", thisSubject.subject];
    } else{
        ClassList *thisClass = [arrAllClass objectAtIndex:row];
        return [NSString stringWithFormat:@"Lớp %@", thisClass.name];
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (arrAllSubject.count >0 && arrAllClass.count >0) {
        if (isFirst == YES) {
            thatSub = [arrAllSubject objectAtIndex:0];
            thatClass = [arrAllClass objectAtIndex:0];
        }
        if (component == 0) {
            thatSub = [arrAllSubject objectAtIndex:row];
        } else {
            thatClass = [arrAllClass objectAtIndex:row];
        }
        isFirst = NO;
    }
    
}
- (IBAction)pressedBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressedAdd:(id)sender {
    if (arrAllClass.count > 0 && arrAllSubject.count > 0) {
        if (isFirst == YES) {
            thatSub = [arrAllSubject objectAtIndex:0];
            thatClass = [arrAllClass objectAtIndex:0];
        }
        if ([_arrIDSubject indexOfObject:thatSub.iId] != NSNotFound) {
            // get arrClass in this Subject
            NSArray *arrScoreE = [Scoreboad queryScoreFromIDSubject:[thatSub.iId integerValue]];
            NSMutableArray *m_arrIDClass = [NSMutableArray array];
            for (Scoreboad *thisScore in arrScoreE) {
                [m_arrIDClass addObject:[NSNumber numberWithInteger:thisScore.idclass]];
            }
            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:m_arrIDClass];
            NSArray *arrIDClassWithSub = [orderedSet array];
            
            if ([arrIDClassWithSub indexOfObject:thatClass.iId] != NSNotFound) {
                [self showAlertWithTitle:@"Lỗi" andMessage:@"Đã tồn tại bảng điểm môn học của lớp học này"];
            }else{
                NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%ld", [thatClass.iId integerValue]]];
                for (Student *thisStudent in arrStudent) {
                    Scoreboad *thisScore = [Scoreboad new];
                    thisScore.idsubject = [thatSub.iId integerValue];
                    thisScore.idclass = [thatClass.iId integerValue];
                    thisScore.idstudent = [thisStudent.iId integerValue];
                    [thisScore update];
                }
            }
        } else{
            NSArray *arrStudent = [Student queryStudentWithIDClass:[NSString stringWithFormat:@"%ld", [thatClass.iId integerValue]]];
            for (Student *thisStudent in arrStudent) {
                Scoreboad *thisScore = [Scoreboad new];
                thisScore.idsubject = [thatSub.iId integerValue];
                thisScore.idclass = [thatClass.iId integerValue];
                thisScore.idstudent = [thisStudent.iId integerValue];
                [thisScore update];
                
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertActOK = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:alertActOK];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
