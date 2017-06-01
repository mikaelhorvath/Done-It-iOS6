//
//  MIHPrototypViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-27.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHPrototypViewController.h"

@interface MIHPrototypViewController ()

@end

@implementation MIHPrototypViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"WhiteNavbar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]];
    */
    
    
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    
    self.navigationItem.titleView = imageView;
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
