//
//  ManagerList.m
//  Projectend
//
//  Created by Ominext Mobile on 5/16/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "ManagerList.h"

@implementation ManagerList
+ (id)itemWithTitle:(NSString *)title withImage:(UIImage *)image{
    return [[self alloc] initWithTitle:(NSString *)title withImage:(UIImage *)image];
}

- (id)initWithTitle:(NSString *)title withImage:(UIImage *)image {
    if ((self = [super init]))
    {
        _title = title;
        _image = image;
    }
    
    return self;
}
@end
