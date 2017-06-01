//
//  MIHAppDelegate.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHAppDelegate.h"

@implementation MIHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //247 147 30
 
    
    [Parse setApplicationId:@"ICaXGleoDvEqarOJ0t9ZLiC9okVjHI0u8aZAqDFo"
                  clientKey:@"PLSAHfUgYlP89VUztYZLTSHfsxEP6Wr6YAcQjldm"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFFacebookUtils initializeFacebook];
   
    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc]init]];
    
  // [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"WhiteNavBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
    
   
    
    
    //[[UITabBar appearance] setTitlePositionAdjustment:UIOffsetMake(0, -10)];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
