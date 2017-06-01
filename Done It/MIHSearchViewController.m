//
//  MIHSearchViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-08-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHSearchViewController.h"
#import "MIHFeedDetailViewController.h"
#import "MIHSearchResultsViewController.h"

@interface MIHSearchViewController ()

@end

@implementation MIHSearchViewController

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
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"theCell"];
    
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

-(void)retrieveFromParse{
    PFQuery *getFeed = [PFUser query];
    getFeed.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getFeed findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            parseData = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
    }];
    
}


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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"theCell";
    
    MIHSearchResultsCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *object;

    if(tableView != self.searchDisplayController.searchResultsTableView){
        object = [parseData objectAtIndex:indexPath.row];
    }else if([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        object = [searchResults objectAtIndex:indexPath.row];
    }
    
    cell.mainLbl.text = [object objectForKey:@"username"];
    
    NSNumber *doneList = [object objectForKey:@"doneList"];
    NSNumber *trophyCheck = [object objectForKey:@"trophyCheck"];
    
    [cell.doneListLbl setText:[NSString stringWithFormat:@"%@", doneList]];
    [cell.trophyLbl setText:[NSString stringWithFormat:@"%@", trophyCheck]];
    
    cell.feedImage.layer.cornerRadius = cell.feedImage.frame.size.width/2;
    cell.feedImage.layer.masksToBounds = YES;
    
    [cell.feedImage setImage:nil];
    
    
    
    
    
    if([[searchResults objectAtIndex:indexPath.row] isMemberOfClass:[UIImage class]]){
        
        [cell.feedImage setImage:[searchResults objectAtIndex:indexPath.row]];
        
    }else{
        
        //*******************************
        
        UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        snurra.frame = cell.feedImage.frame;
        [cell addSubview: snurra];
        [snurra startAnimating];
        
        
        
        
        
        //Backgrundstråd
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
           // PFObject *tempObjs = [tableimages objectAtIndex:indexPath.row];
            
            PFFile *myImg = [object objectForKey:@"profilePicture"];
            UIImage *bild = [UIImage imageWithData:myImg.getData];
            
            
            
            
            //[searchResults replaceObjectAtIndex:indexPath.row withObject:bild];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Här ändrar man saker i UI
                [snurra removeFromSuperview];
                [cell.feedImage setImage:bild];
                
            });
        });
        
        
    }
    

    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
if([segue.identifier isEqualToString:@"searchResult"]){
    
    MIHSearchResultsViewController* nvc = (MIHSearchResultsViewController*)[segue destinationViewController];
    
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


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [searchResults removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.username contains[c] %@",searchString];
    searchResults = [[parseData filteredArrayUsingPredicate:predicate] mutableCopy];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    
    [searchResults removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.username contains[c] %@",self.searchDisplayController.searchBar.text];
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


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
