//
//  MIHFeedViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-27.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHFeedViewController.h"
#import "MIHFeedCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MIHFeedDetailViewController.h"
#import "MIHCommentsViewController.h"
#import "MIHParseFeedCell.h"

@interface MIHFeedViewController ()

@end

@implementation MIHFeedViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithClassName:@"Wine"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"userPosts";
        
        self.textKey = @"activity";
        
        self.imageKey = @"image";
        
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *thisNewUser = [PFUser currentUser];
   
    
    if([thisNewUser objectForKey:@"firsttrophy"] == [NSNumber numberWithBool:YES]){
        PFObject *object = [PFObject objectWithClassName:@"Trophys"];
        
        UIImage *image = [UIImage imageNamed:@"image.png"];
        UIGraphicsBeginImageContext(CGSizeMake(250, 250));
        [image drawInRect: CGRectMake(0, 0, 250, 250)];
        UIGraphicsEndImageContext();
        // Upload image
        NSData *imageData = UIImagePNGRepresentation(image);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
        [object setObject:@"You're On!" forKey:@"activity"];
        [object setObject:@"Signed up for DoneIt" forKey:@"description"];
        [object setObject:imageFile forKey:@"image"];
        [object setObject:thisNewUser forKey:@"user"];
        [object saveInBackground];
        [thisNewUser setObject:[NSNumber numberWithBool:NO] forKey:@"firsttrophy"];
        int trophyCheck = [[thisNewUser objectForKey:@"trophyCheck"]intValue];
        trophyCheck++;
        [thisNewUser setObject:[NSNumber numberWithInt:trophyCheck] forKey:@"trophyCheck"];
        [thisNewUser saveInBackground];
    }else{
      // Händer ingenting! ..
    }
    
    
    //// SEARCH BUTTON
    
    UIImage *buttonImageTwo = [UIImage imageNamed:@"search.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(20, 0, 40, 31);
    buttonTwo.showsTouchWhenHighlighted = YES;
    
    [buttonTwo addTarget:self action:@selector(searchNow) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItemTwo = [[UIBarButtonItem alloc] initWithCustomView:buttonTwo];
    self.navigationItem.rightBarButtonItem = customBarItemTwo;

    
   
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    
    self.navigationItem.titleView = imageView;
    
    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    //[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
     self.navigationController.navigationBar.clipsToBounds = YES;
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
    
	// Do any additional setup after loading the view.
}

-(void)searchNow{
    
    [self performSegueWithIdentifier:@"searchNow" sender:self];
    
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query includeKey:@"user"];
  
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
        
        
        
    }
    [query orderByDescending:@"createdAt"];
    
    return query;
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadObjects];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    
    if(tabBar.selectedItem == [self.tabBarController.tabBar.items objectAtIndex:0]){
        [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"red.png"]];
        
        UITabBarItem* it = [[self.tabBarController.tabBar items] objectAtIndex:0];
        it.titlePositionAdjustment = UIOffsetMake(0.0, -18.0);
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor], UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Light" size:12.0f] }
                                           forState:UIControlStateNormal];
        
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                           forState:UIControlStateHighlighted];
        
    }else if(tabBar.selectedItem == [self.tabBarController.tabBar.items objectAtIndex:1]){
        [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"orange.png"]];
        
        UITabBarItem* it = [[self.tabBarController.tabBar items] objectAtIndex:0];
        it.titlePositionAdjustment = UIOffsetMake(0.0, -18.0);
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor], UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Light" size:12.0f] }
                                           forState:UIControlStateNormal];
        
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                           forState:UIControlStateHighlighted];
        
    }else if(tabBar.selectedItem == [self.tabBarController.tabBar.items objectAtIndex:2]){
        [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"green.png"]];
        
        UITabBarItem* it = [[self.tabBarController.tabBar items] objectAtIndex:0];
        it.titlePositionAdjustment = UIOffsetMake(0.0, -18.0);
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor], UITextAttributeFont: [UIFont fontWithName:@"Helvetica-Light" size:12.0f] }
                                           forState:UIControlStateNormal];
        
        [tabBar.selectedItem setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                                           forState:UIControlStateHighlighted];
        
    }

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    
    static NSString *CellIdentifier = @"feedCell";
    MIHParseFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MIHParseFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell addSubview:cell.commentBtn];
    
    cell.activityLabel.text = [object objectForKey:@"activity"];
    
    NSString *userName = [[object objectForKey:@"user"] objectForKey:@"username"];
    [cell.nameLabel setText:[NSString stringWithFormat:@"%@ added to the list!", userName]];
    
    if([cell.nameLabel.text isEqualToString:@"Sponsor added to the list!"]){
        [cell.nameLabel setText:@"Sponsor"];
    }
    
    
    PFQuery *countCom = [PFQuery queryWithClassName:@"Comments"];
    PFObject *thisCount = [self.objects objectAtIndex:indexPath.row];
    [countCom whereKey:@"post" equalTo:thisCount];
    countCom.cachePolicy = kPFCachePolicyNetworkElseCache;
    [countCom countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            [cell.countCommentLbl setText:[NSString stringWithFormat:@"%d", count]];
            
        } else {
            // The request failed
        }
    }];
    

    cell.feedImage.layer.cornerRadius = cell.feedImage.frame.size.width/2;
    cell.feedImage.layer.masksToBounds = YES;
   /*
    PFFile *thumbnail = [object objectForKey:self.imageKey];
    [thumbnail getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            // Now that the data is fetched, update the cell's image property with thumbnail
            cell.feedImage.image = [UIImage imageWithData:data];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    */
    
    
     
    [cell.feedImage setImage:nil];
    
    
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = cell.feedImage.frame;
    [cell addSubview: snurra];
    [snurra startAnimating];
    
    
    
    
    
    //Backgrundstråd
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        PFFile *myImg = [object objectForKey:@"image"];
        UIImage *bild = [UIImage imageWithData:myImg.getData];
        
        
        
        
        //[userFeed replaceObjectAtIndex:indexPath.row withObject:bild];
        //image = bild;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            [snurra removeFromSuperview];
            [cell.feedImage setImage:bild];
            [cell setNeedsDisplay];
            
        });
    });


    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"feedDetail"]){
        
        MIHFeedDetailViewController* nvc = (MIHFeedDetailViewController*)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        [object fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error){
        
            nvc.nvcObject = object;
            nvc.bildString = [[object objectForKey:@"user"] objectForKey:@"profilePicture"];
          }];
    }else if([segue.identifier isEqualToString:@"showComments"]){
        MIHCommentsViewController* nvc = (MIHCommentsViewController*)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell *)[sender superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        nvc.nvcObject = object;

    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
