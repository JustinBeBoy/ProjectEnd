//
//  AddAndEditViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AddAndEditViewController.h"

@interface AddAndEditViewController (){
    NSString *sexvalue;
    NSString *dateofbirthvalue;
    NSString *dateofbirth;
    NSArray *arrusename;
}

@end

@implementation AddAndEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add/Edit Student";
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI{
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *rightbt = [[UIBarButtonItem alloc]init];
    rightbt.title = @"Save";
    [rightbt setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:146.0f/255.0f green:204.0f/255.0f blue:55.0f/255.0f alpha:1]} forState: UIControlStateNormal];
    [rightbt setAction:@selector(saveStudent)];
    UIBarButtonItem *leftbt = [[UIBarButtonItem alloc]init];
    leftbt.title = @"Save";
    self.navigationItem.rightBarButtonItem = rightbt;
//    self.navigationItem.leftBarButtonItem = leftbt;
}

- (void) loadDataInView {
    if (!self.isEditing) {
        self.student = [Student new];
    }
    else {
        self.tfName.text    = self.student.name;
        self.tfAddress.text     = self.student.address;
        self.tfMail.text = self.student.mail;
        self.tfPhoneNumber.text  = [NSString stringWithFormat:@"%li",self.student.phone];
    }
}



#pragma Check Input
- (BOOL)checkAllComponent{
    NSMutableString *warringcpn = [[NSMutableString alloc]initWithString:@"Warring: "];
    if (self.tfName.text.length>0&&self.tfAddress.text.length>0&&self.tfPhoneNumber.text.length>0&&self.tfMail.text.length>0&&self.tfUsername.text.length>0&&self.tfPassword.text.length>0) {
        if ([self NSStringIsValidEmail:self.tfMail.text]&&self.tfPassword.text.length>=6&&![self checkUsernameExist]) {
            return YES;
        }else{
            if (self.tfPassword.text.length<6) {
                [warringcpn appendString:@"You must to endter password least 6 characters"];
            }
            if(![self NSStringIsValidEmail:self.tfMail.text]){
                [warringcpn appendString:@"Email not Validate"];
            }
            if ([self checkUsernameExist]) {
                [warringcpn appendString:@"Username existed"];
            }
            _lbWarring.text = warringcpn;
            return NO;
        }
    } else {
        if (self.tfName.text.length == 0) {
            [warringcpn appendString:@"input Fullname, "];
        }
        if (self.tfAddress.text.length == 0) {
            [warringcpn appendString:@"input Address, "];
        }
        if (self.tfPhoneNumber.text.length == 0) {
            [warringcpn appendString:@"input Phone Number, "];
        }
        if (self.tfMail.text.length == 0) {
            [warringcpn appendString:@"input Mail, "];
        }
        if (self.tfUsername.text.length == 0) {
            [warringcpn appendString:@"input Username, "];
        }
        if (self.tfPassword.text.length == 0) {
            [warringcpn appendString:@"input Password, "];
        }
        _lbWarring.text = warringcpn;
        return NO;
    }
}
// Validate e-mail address
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL) checkUsernameExist{
    arrusename = [NSArray array];
    arrusename = [Student queryStudentUsername:self.tfUsername.text andPassword:self.tfPassword.text];
    if (arrusename.count>0) {
        return YES;
    } else {
       return NO;
    }
}

#pragma ------
- (void)didSelectItemAtIndex:(NSUInteger)index{
    
}
- (void)getItemSelected:(NSString *)item{
    [self.olSex setTitle:item forState:UIControlStateNormal];
    NSLog(@"%@",item);
}
- (void)didSelectDate:(NSDate *)date formattedString:(NSString *)dateString{
    NSLog(@"%@ ----- %@",date,dateString);
    NSCalendar *calendar = [NSCalendar currentCalendar] ;
    NSDateComponents *component = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    dateofbirth = [NSString stringWithFormat:@"%li/%li/%li",[component day],[component month],[component year]];
    NSLog(@"%@",dateofbirth);
    [self.olDateOfBirth setTitle:dateofbirth forState:UIControlStateNormal];
}

- (IBAction)btSex:(id)sender {
    PickerViewController *pickerViewController = [[PickerViewController alloc] initFromNib];
    pickerViewController.pickerType = CustomPickerType;
    pickerViewController.delegate = self;
    pickerViewController.dataSourceForCustomPickerType = @[@"Male",@"Female"];
    [self presentViewControllerOverCurrentContext:pickerViewController animated:YES completion:nil];
}

- (IBAction)btDateOfBirth:(id)sender {
    PickerViewController *pickerViewController = [[PickerViewController alloc] initFromNib];
    pickerViewController.pickerType = DatePickerType;
    
    pickerViewController.delegate = self;
    [self presentViewControllerOverCurrentContext:pickerViewController animated:YES completion:nil];
}
- (void)saveStudent{
    if ([self checkAllComponent]) {
        self.student.name = self.tfName.text;
        self.student.address = self.tfAddress.text;
        self.student.mail = self.tfMail.text;
        self.student.sex = [[self.olSex titleLabel] text];
        self.student.dateofbirth = [[self.olDateOfBirth titleLabel] text];
        self.student.username = self.tfUsername.text;
        self.student.password = self.tfPassword.text;
        [self.student update];
        NSLog(@"save Success");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
