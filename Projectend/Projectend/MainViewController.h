//
//  MainViewController.h
//  Projectend
//
//  Created by Ominext Mobile on 5/15/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuViewController.h"

@interface MainViewController : UIViewController
@property (nonatomic, strong) SlideMenuViewController *slideMenuViewController;
@property (nonatomic, assign) BOOL showingLeftPanel;
@end
