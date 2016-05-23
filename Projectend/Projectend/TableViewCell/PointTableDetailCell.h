//
//  PointTableDetailCell.h
//  Projectend
//
//  Created by ThucTapiOS on 5/18/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PointTableDetailCellProtocol <NSObject>

-(void)sentTextField:(UITextField*)textField andIndexPath:(NSIndexPath*)indexPath;

@end


@interface PointTableDetailCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblHoTen;
@property (strong, nonatomic) IBOutlet UITextField *tfDiem;
@property (strong, nonatomic) NSIndexPath *indexPathCell;
@property (strong, nonatomic) id<PointTableDetailCellProtocol>delegate;

@end
