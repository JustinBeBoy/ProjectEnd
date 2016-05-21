//
//  AppDelegate.m
//  Projectend
//
//  Created by Ominext Mobile on 5/13/16.
//  Copyright © 2016 Ominext Mobile. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "Teacher.h"
#define KEY_CHECK_ACOUNT @"DefaultAcount"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [DB checkExistedDB];
    [self CheckUserDefault];
    LoginViewController *rootVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:rootVC];
    [navigationController setNavigationBarHidden:YES];
    
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)CheckUserDefault{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:KEY_CHECK_ACOUNT]) {
        Teacher *teacher = [[Teacher alloc]init];
        Student *student = [[Student alloc]init];
        teacher.username = @"teacheradmin";
        teacher.password = @"admin";
        student.username = @"studentadmin";
        student.password = @"admin";
        student.name = @"Student Admin";
        student.dateofbirth = @"0";
        student.sex = @"none";
        [teacher update];
        [student update];
        [userDefaults setBool:YES forKey:KEY_CHECK_ACOUNT];
    }
}

@end
