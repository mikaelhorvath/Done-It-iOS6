//
//  MIHInspSearchViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-12-16.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHInspSearchViewController.h"
#import "MIHInspirationSearchCell.h"
#import "MIHExperienceDetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface MIHInspSearchViewController ()

@end

@implementation MIHInspSearchViewController

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
    
    //*** Search Uppgifter ***//
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"inspSearch"];
    
    self.searchDisplayController.searchResultsDelegate = self;
    
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.delegate = self;
    //////////

    
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

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)retrieveFromParse{
    PFQuery *getFeed = [PFQuery queryWithClassName:@"Experiences"];
    getFeed.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getFeed findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            parseData = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
    }];
}
// Tableview <<<<

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [searchResults count];
    }
    else
    {
        return 0;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 61;
    }
    else
    {
        return 61;
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"inspSearch";
    
   MIHInspirationSearchCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *object;
    
    if(tableView != self.searchDisplayController.searchResultsTableView){
        object = [parseData objectAtIndex:indexPath.row];
    }else if([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        object = [searchResults objectAtIndex:indexPath.row];
    }
    
    cell.imageViewz.layer.cornerRadius = cell.imageViewz.frame.size.height/2;
    cell.imageViewz.layer.masksToBounds = YES;
    
    NSString *theName = [object objectForKey:@"name"];
    [cell.mainLbl setText:theName];
    
    PFFile *imageFile = [object objectForKey:@"image"];
    [cell.imageViewz setImageWithURL:imageFile.url];
    
    NSString *category = [object objectForKey:@"type"];
    [cell.categoryLbl setText:[NSString stringWithFormat:@"Category: %@", category]];
    
    return cell;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [searchResults removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchString];
    searchResults = [[parseData filteredArrayUsingPredicate:predicate] mutableCopy];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    
    [searchResults removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",self.searchDisplayController.searchBar.text];
    searchResults = [[parseData filteredArrayUsingPredicate:predicate] mutableCopy];
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    //tableView.backgroundColor = self.myTableView.backgroundColor;
    tableView.bounces = NO;
    //tableView.separatorColor = [UIColor lightGrayColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showSearchDetail"]){
        
        MIHExperienceDetailViewController* nvc = (MIHExperienceDetailViewController*)[segue destinationViewController];
        
        PFObject *object = nil;
        
        if(self.searchDisplayController.active){
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            object = [searchResults objectAtIndex:indexPath.row];
            
            nvc.nvcObject = object;
            
        }else{
            NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
            object = [parseData objectAtIndex:indexPath.row];
            
            
            nvc.nvcObject = object;
        }
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
