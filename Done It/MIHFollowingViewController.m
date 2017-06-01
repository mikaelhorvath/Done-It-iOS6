//
//  MIHFollowingViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-09-26.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHFollowingViewController.h"
#import "MIHFollowingCell.h"
#import "MIHUserDetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface MIHFollowingViewController ()

@end

@implementation MIHFollowingViewController

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
    
    _activitySnurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    
    _activitySnurra.frame = CGRectMake(140, 140, 50, 50);
    [self.myTableView addSubview:_activitySnurra];
    [_activitySnurra startAnimating];
    
    [self retrieveFromParse];
    
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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.myTableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self retrieveFromParse];
    [refreshControl endRefreshing];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)retrieveFromParse{
    
    
    PFQuery *getUsers = [PFQuery queryWithClassName:@"Friends"];
    [getUsers orderByDescending:@"createdAt"];
    PFUser *anvandare = [PFUser currentUser];
    [getUsers whereKey:@"user" equalTo:anvandare];
    [getUsers includeKey:@"user"];
    [getUsers includeKey:@"userFriend"];
    getUsers.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getUsers findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            followingArray = [[NSMutableArray alloc]initWithArray:objects];
            followingArrayImages = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [followingArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *object = [followingArray objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self retrieveFromParse];
            [self.myTableView reloadData];
        }];
    }
}
    

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"followingCell";
    
    MIHFollowingCell *cell = (MIHFollowingCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2;
    cell.profilePic.layer.masksToBounds = YES;
    
    
    
    PFObject *tempObj = [followingArray objectAtIndex:indexPath.row];
    
    NSString *userNamez = [[tempObj objectForKey:@"userFriend"] objectForKey:@"username"];
    [cell.userNameLbl setText:[NSString stringWithFormat:@"%@", userNamez]];
    
    
    PFFile *myImg = [[tempObj objectForKey:@"userFriend"] objectForKey:@"profilePicture"];
    [cell.profilePic setImageWithURL:myImg.url placeholderImage:[UIImage imageNamed:@"profileDude.png"]];
    
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
    if([segue.identifier isEqualToString:@"showFollowing"]){
        
        MIHUserDetailViewController* next = (MIHUserDetailViewController*)[segue destinationViewController];
        PFObject *thisobject = [followingArray objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
        PFObject *themObj = [thisobject objectForKey:@"userFriend"];
        next.nvcObject = themObj;
        
        }
    }





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
