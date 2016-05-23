//
//  AddStudentCell.m
//  Projectend
//
//  Created by ThucTapiOS on 5/17/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AddStudentCell.h"

@implementation AddStudentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickCheck:(id)sender {
    [self.delegate btnCheckTouchByIndexPath:_indexPathCell];
    NSLog(@"click button");
}
@end
