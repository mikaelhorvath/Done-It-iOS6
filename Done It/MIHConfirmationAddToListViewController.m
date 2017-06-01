//
//  MIHConfirmationAddToListViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2014-01-15.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import "MIHConfirmationAddToListViewController.h"

@interface MIHConfirmationAddToListViewController ()

@end

@implementation MIHConfirmationAddToListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    if(tabBar.selectedItem == [self.tabBarController.tabBar.items objectAtIndex:0]){
        [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"red.png"]];
        
        UITabBarItem* it = [[self.tabBarController.tabBar items] objectAtIndex:0];
        it.titlePositionAdjustment = UIOffsetMake(0.0, -15.0);
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                           forState:UIControlStateNormal];
        
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                           forState:UIControlStateHighlighted];
        
    }else if(tabBar.selectedItem == [self.tabBarController.tabBar.items objectAtIndex:1]){
        [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"orange.png"]];
        
        UITabBarItem* it = [[self.tabBarController.tabBar items] objectAtIndex:1];
        it.titlePositionAdjustment = UIOffsetMake(0.0, -15.0);
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                           forState:UIControlStateNormal];
        
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                           forState:UIControlStateHighlighted];
        
    }else if(tabBar.selectedItem == [self.tabBarController.tabBar.items objectAtIndex:2]){
        [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"green.png"]];
        
        UITabBarItem* it = [[self.tabBarController.tabBar items] objectAtIndex:2];
        it.titlePositionAdjustment = UIOffsetMake(0.0, -15.0);
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                           forState:UIControlStateNormal];
        
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                           forState:UIControlStateHighlighted];
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.profilePic setImage:nil];

    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = self.profilePic.bounds;
    [snurra setColor:[UIColor blackColor]];
    [self.profilePic addSubview:snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PFUser *currentUser = [PFUser currentUser];
        PFFile *imageData = [currentUser objectForKey:@"profilePicture"];
        UIImage *theImage = [UIImage imageWithData:imageData.getData];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            [snurra removeFromSuperview];
            [self.profilePic setImage:theImage];
        });
    });
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2;
    self.profilePic.layer.masksToBounds = YES;
    
    //Setting the textstrings
    [self.activityLabel setText:self.activityString];
    [self.descLabel setText:self.descString];
    
    
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    self.navigationItem.titleView = imageView;
    
    //////
    UIImage *buttonImage = [UIImage imageNamed:@"doneG.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(20, 0, 42, 24);
    button.showsTouchWhenHighlighted = YES;
    
    [button addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = customBarItem;
	// Do any additional setup after loading the view.

    
    [self.mainPicture setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = _mainPicture.frame;
    [_mainPicture addSubview: snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        PFFile* image = self.imageFile;
        UIImage* imgProfile = [UIImage imageWithData:image.getData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            
            
            
            [self.mainPicture setImage:imgProfile];
            [snurra removeFromSuperview];
        });
    });
    

}

-(void)done{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
