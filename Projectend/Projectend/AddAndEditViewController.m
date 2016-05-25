//
//  AddAndEditViewController.m
//  Projectend
//
//  Created by Ominext Mobile on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AddAndEditViewController.h"
#import "SWRevealViewController.h"

@interface AddAndEditViewController (){
    NSString *sexvalue;
    NSString *dateofbirthvalue;
    NSString *dateofbirth;
    NSArray *arrusename;
    UIBarButtonItem *btsave;
    UIBarButtonItem *btedit;
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
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:20 ]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:2.0f/255.0f green:136.0f/255.0f blue:209.0f/255.0f alpha:1];
    btsave = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveStudent)];
    [btsave setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:15 ]} forState:UIControlStateNormal];
    btedit = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editStudent)];
    [btedit setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont systemFontOfSize:15 ]} forState:UIControlStateNormal];
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *backbt = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(btBack)];
    self.navigationItem.leftBarButtonItem = backbt;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    _olSex.layer.cornerRadius = 8.0;
    [_olSex.layer setMasksToBounds:YES];
    _olDateOfBirth.layer.cornerRadius = 8.0;
    [_olDateOfBirth.layer setMasksToBounds:YES];
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
        self.student = [Student new];
    }
    else {
        self.tfName.text = self.student.name;
        self.tfAddress.text = self.student.address;
        self.tfMail.text = self.student.mail;
        self.tfPhoneNumber.text  = [NSString stringWithFormat:@"%li",self.student.phone];
        self.tfPassword.text = self.student.password;
        self.tfUsername.text = self.student.username;
        [self.olSex setTitle:self.student.sex forState:UIControlStateNormal];
        [self.olDateOfBirth setTitle:self.student.dateofbirth forState:UIControlStateNormal];
    }
}


#pragma mark Check Input
- (BOOL)checkAllComponent{
    NSMutableString *warringcpn = [[NSMutableString alloc]initWithString:@"Warring: "];
    if (self.tfName.text.length>0&&self.tfAddress.text.length>0&&self.tfPhoneNumber.text.length>0&&self.tfMail.text.length>0&&self.tfUsername.text.length>0&&self.tfPassword.text.length>0) {
        if ([self NSStringIsValidEmail:self.tfMail.text]&&self.tfPassword.text.length>=6&&![self checkUsernameExist]&&[self validatePhone:self.tfPhoneNumber.text warring:warringcpn]) {
            return YES;
        }else{
            if (self.tfPassword.text.length<6) {
                [warringcpn appendString:@"You must to endter password least 6 characters "];
            }
            if(![self NSStringIsValidEmail:self.tfMail.text]){
                [warringcpn appendString:@"Email not Validate "];
            }
            if ([self checkUsernameExist]) {
                [warringcpn appendString:@"Username existed "];
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
    if (self.isEditing) {
        return NO;
    }
    arrusename = [NSArray array];
    arrusename = [Student queryStudentUsername:self.tfUsername.text];
    if (arrusename.count>0) {
        return YES;
    } else {
       return NO;
    }
}

- (BOOL)validatePhone:(NSString *)phoneNumber warring:(NSMutableString*)waring
{
    NSInteger tflength = self.tfPhoneNumber.text.length;
    if(tflength >8 && tflength < 12){
//    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//    
//    return [phoneTest evaluateWithObject:phoneNumber];
    
    NSString *phoneRegex = @"^[0-9]{8,11}$";
//    NSString *phoneRegex = @"^(\\+\\d{1,3})?\\(?\\d{3}\\)?[.-]\\d{3}[.-]\\d{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        if ([test evaluateWithObject:phoneNumber]) {
            return YES;
        }else{
            [waring appendString:@"Phone not Validate"];
            return NO;
        }
        return [test evaluateWithObject:phoneNumber];
    }else{
        [waring appendString:@"phone must have 9 to 11 number "];
        return NO;
    }
}

#pragma ------

#pragma mark UITableView Datasource/Delegate
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
#pragma -------

#pragma mark Action

- (IBAction)btSex:(id)sender {
    PickerViewController *pickerViewController = [[PickerViewController alloc] initFromNib];
    pickerViewController.pickerType = CustomPickerType;
    pickerViewController.delegate = self;
    pickerViewController.dataSourceForCustomPickerType = @[@"Nam",@"Nữ"];
    [self presentViewControllerOverCurrentContext:pickerViewController animated:YES completion:nil];
}

- (IBAction)btDateOfBirth:(id)sender {
    PickerViewController *pickerViewController = [[PickerViewController alloc] initFromNib];
    pickerViewController.pickerType = DatePickerType;
    
    pickerViewController.delegate = self;
    [self presentViewControllerOverCurrentContext:pickerViewController animated:YES completion:nil];
}

- (void)btBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editStudent{
    [self tfAnableOrDissable:NO];
    [btedit setTitle:@"Save"];
    self.navigationItem.rightBarButtonItem = btsave;
    NSLog(@"editstudemt");
}

-(void)tfAnableOrDissable:(BOOL)values{
    if (values) {
        self.tfUsername.enabled = NO;
        self.tfPhoneNumber.enabled = NO;
        self.tfAddress.enabled = NO;
        self.tfMail.enabled = NO;
        self.tfName.enabled = NO;
        self.tfPassword.enabled = NO;
        self.olSex.enabled = NO;
        self.olDateOfBirth.enabled = NO;
    }else{
        self.tfPhoneNumber.enabled = YES;
        self.tfAddress.enabled = YES;
        self.tfMail.enabled = YES;
        self.tfName.enabled = YES;
        self.tfPassword.enabled = YES;
        self.olSex.enabled = YES;
        self.olDateOfBirth.enabled = YES;
    }
}

- (void)saveStudent{
    if ([self checkAllComponent]) {
        self.student.name = self.tfName.text;
        self.student.address = self.tfAddress.text;
        self.student.mail = self.tfMail.text;
        self.student.sex = [[self.olSex titleLabel] text];
        self.student.phone = [self.tfPhoneNumber.text integerValue];
        self.student.dateofbirth = [[self.olDateOfBirth titleLabel] text];
        self.student.username = self.tfUsername.text;
        self.student.password = self.tfPassword.text;
        [self.student update];
        NSLog(@"save Success");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
