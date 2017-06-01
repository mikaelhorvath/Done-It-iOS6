//
//  MIHInspirationViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-27.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHInspirationViewController.h"
#import <Parse/Parse.h>
#import "SDWebImage/UIImageView+WebCache.h"

@interface MIHInspirationViewController ()

@end

@implementation MIHInspirationViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize imageArray;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imageView setImage:[UIImage imageNamed:@"galleryloading.png"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self retrieveFromParse];
        
    });    
    
    
   [[UINavigationBar appearance]setShadowImage:[UIImage imageNamed:@"whiteNavBar.png"]];
     self.navigationController.navigationBar.clipsToBounds = YES;
   
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    
    self.navigationItem.titleView = imageView;
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
    
    
    //// SEARCH BUTTON
    
    UIImage *buttonImageTwo = [UIImage imageNamed:@"search.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(25, 0, 40, 34);
    buttonTwo.showsTouchWhenHighlighted = YES;
    
    [buttonTwo addTarget:self action:@selector(searchNow) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItemTwo = [[UIBarButtonItem alloc] initWithCustomView:buttonTwo];
    self.navigationItem.rightBarButtonItem = customBarItemTwo;
    
	// Do any additional setup after loading the view.
}

-(void)searchNow{
    [self performSegueWithIdentifier:@"showInspSearch" sender:self];
}

-(void)retrieveFromParse{
    PFQuery *getFeed = [PFQuery queryWithClassName:@"Topgallery"];
    [getFeed orderByDescending:@"createdAt"];
    getFeed.limit = 3;
    getFeed.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getFeed findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            imageFeed = [[NSMutableArray alloc]initWithArray:objects];
            
            for (int i = 0; i < [imageFeed count]; i++) {
                //We'll create an imageView object in every 'page' of our scrollView.
                CGRect frame;
                frame.origin.x = self.scrollView.frame.size.width * i;
                frame.origin.y = 0;
                frame.size = self.scrollView.frame.size;
                frame.size.height = 160;
                
                self.imageView = [[UIImageView alloc] initWithFrame:frame];
                PFObject *theObj = [imageFeed objectAtIndex:i];
                PFFile *imageData = [theObj objectForKey:@"image"];
                UIImage *thisImage = [UIImage imageWithData:imageData.getData];
                //self.imageView.image = thisImage;
                [self.imageView setImageWithURL:imageData.url];
                //imageView.contentMode = UIViewContentModeScaleAspectFit;
                
                [self.scrollView addSubview:self.imageView];
            }
            //Set the content size of our scrollview according to the total width of our imageView objects.
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageFeed count], 160);
            
        }
        
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
