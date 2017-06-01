//
//  MIHMostPopularViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-10-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHMostPopularViewController.h"
#import <Parse/Parse.h>
#import "MIHMostPopularCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MIHExperienceDetailViewController.h"

@interface MIHMostPopularViewController ()

@end

@implementation MIHMostPopularViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self retrieveFromParse];
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
    
    //[self retrieveFromParse];
    
    _activitySnurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    
    _activitySnurra.frame = CGRectMake(140, 140, 50, 50);
    [self.myTableView addSubview:_activitySnurra];
    [_activitySnurra startAnimating];

    
    _popularView.backgroundColor = [UIColor colorWithRed:231.0/255 green:77.0/255 blue:127.0/255 alpha:1.0];
    
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    self.navigationItem.titleView = imageView;
    
    //////
    UIImage *buttonImage = [UIImage imageNamed:@"backBtn.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(20, 0, 40, 24);
    button.showsTouchWhenHighlighted = YES;
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;

	// Do any additional setup after loading the view.
}

-(void)retrieveFromParse{
    
    
    PFQuery *getTips = [PFQuery queryWithClassName:@"Experiences"];
    [getTips orderByDescending:@"popularity"];
    getTips.limit = 10;
    getTips.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTips findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            popularFeed = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"popularCell";
    MIHMostPopularCell *cell = (MIHMostPopularCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    cell.imageViewz.layer.cornerRadius = cell.imageViewz.frame.size.width/2;
    cell.imageViewz.layer.masksToBounds = YES;
    
    
    PFObject *thisObj = [popularFeed objectAtIndex:indexPath.row];
    cell.mainLbl.text = [thisObj objectForKey:@"name"];
    NSString *category = [thisObj objectForKey:@"type"];
    [cell.categoryLbl setText:[NSString stringWithFormat:@"Category: %@", category]];
    NSNumber *added = [thisObj objectForKey:@"popularity"];
    [cell.addedLbl setText:[NSString stringWithFormat:@"Currently active on %@ lists!", added]];
    
    PFFile *thisFile = [thisObj objectForKey:@"image"];
    [cell.imageViewz setImageWithURL:thisFile.url placeholderImage:[UIImage imageNamed:@"placeholdercircle.png"]];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [popularFeed count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        //for example [activityIndicator stopAnimating];
        [_activitySnurra stopAnimating];
    }
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showPopularDetail"]){
        
        MIHExperienceDetailViewController* nvc = (MIHExperienceDetailViewController*)[segue destinationViewController];
        
        
        PFObject *thisobject = [popularFeed objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
        
        nvc.nvcObject = thisobject;
        nvc.bildString = [thisobject objectForKey:@"image"];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
