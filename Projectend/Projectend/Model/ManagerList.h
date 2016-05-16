//
//  ManagerList.h
//  Projectend
//
//  Created by Ominext Mobile on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ManagerList : NSObject
+ (id)itemWithTitle:(NSString *)title withImage:(UIImage *)image ;
- (id)initWithTitle:(NSString *)title withImage:(UIImage *)image ;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIImage  *image;

@end
