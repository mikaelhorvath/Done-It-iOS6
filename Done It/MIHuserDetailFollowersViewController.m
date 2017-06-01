//
//  MIHuserDetailFollowersViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-12-29.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHuserDetailFollowersViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "MIHSearchResultsViewController.h"
#import "MIHUserDetailViewController.h"
#import "MIHFollowersUserDetailCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface MIHuserDetailFollowersViewController ()

@end

@implementation MIHuserDetailFollowersViewController

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
    
    [self retrieveFromParse];
    
    _activitySnurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    
    _activitySnurra.frame = CGRectMake(140, 140, 50, 50);
    [self.myTableView addSubview:_activitySnurra];
    [_activitySnurra startAnimating];
    
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
    
    
    PFQuery *getUsers = [PFQuery queryWithClassName:@"Friends"];
    [getUsers orderByDescending:@"createdAt"];
    PFUser *anvandare = _nvcObject;
    [getUsers whereKey:@"userFriend" equalTo:anvandare];
    [getUsers includeKey:@"user"];
    [getUsers includeKey:@"userFriend"];
    getUsers.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getUsers findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            followersArray = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [followersArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"followersCell";
    
    MIHFollowersUserDetailCell *cell = (MIHFollowersUserDetailCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.picView.layer.cornerRadius = cell.picView.frame.size.width/2;
    cell.picView.layer.masksToBounds = YES;
    
    
    
    PFObject *tempObj = [followersArray objectAtIndex:indexPath.row];
    
    NSString *userNamez = [[tempObj objectForKey:@"user"] objectForKey:@"username"];
    [cell.nameLbl setText:[NSString stringWithFormat:@"%@", userNamez]];
    
    PFFile *myImg = [[tempObj objectForKey:@"user"] objectForKey:@"profilePicture"];
    [cell.picView setImageWithURL:myImg.url placeholderImage:[UIImage imageNamed:@"profileDude.png"]];
    
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        //for example [activityIndicator stopAnimating];
        [_activitySnurra stopAnimating];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showFollowersDetail"]){
        
        MIHUserDetailViewController* nvc = (MIHUserDetailViewController*)[segue destinationViewController];
        PFObject *thisobject = [followersArray objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
        PFObject *themObj = [thisobject objectForKey:@"user"];
        nvc.nvcObject = themObj;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
