//
//  AddStudentCell.h
//  Projectend
//
//  Created by ThucTapiOS on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckTouchDelegate <NSObject>

-(void)btnCheckTouchByIndexPath: (NSIndexPath*)indexpath;

@end

@interface AddStudentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblAddStudent;
@property (strong, nonatomic) IBOutlet UIButton *btnCheck;
@property (strong, nonatomic) NSIndexPath *indexPathCell;
@property (strong, nonatomic) id<CheckTouchDelegate>delegate;
- (IBAction)clickCheck:(id)sender;

@end
