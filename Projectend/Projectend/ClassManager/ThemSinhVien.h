//
//  ThemSinhVien.h
//  Projectend
//
//  Created by ThucTapiOS on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassList.h"


@protocol ThemSinhVienDeletge <NSObject>

-(void)sendArrMaskStudent:(NSArray*)arrMask;

@end

@interface ThemSinhVien : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tblAddStudent;
@property (strong, nonatomic) NSArray *arrStudentNotAdd;
@property (strong, nonatomic) ClassList *thisClass;

@property (strong, nonatomic) id<ThemSinhVienDeletge>delegate;

- (IBAction)btCancel:(id)sender;
- (IBAction)btAdd:(id)sender;


@end
