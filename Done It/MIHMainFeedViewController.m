//
//  MIHMainFeedViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-09-19.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHMainFeedViewController.h"
#import "MIHCommentsViewController.h"
#import "MIHFeedDetailViewController.h"
#import <Parse/Parse.h>
#import "SDWebImage/UIImageView+WebCache.h"


@interface MIHMainFeedViewController ()

@end

@implementation MIHMainFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    // Uppdaterar vår tableview varenda gång vi kommer tillbaka!
    //[self.myTableView reloadData];
    [self checkIfTheyLikes];
    
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
    
    UITabBarItem* itTwo = [[self.tabBarController.tabBar items] objectAtIndex:1];
    itTwo.titlePositionAdjustment = UIOffsetMake(0.0, -15.0);
    
    [itTwo setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                         forState:UIControlStateNormal];
    [itTwo setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                         forState:UIControlStateHighlighted];
    
    UITabBarItem* itThree = [[self.tabBarController.tabBar items] objectAtIndex:2];
    itThree.titlePositionAdjustment = UIOffsetMake(0.0, -15.0);
    [itThree setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                           forState:UIControlStateNormal];
    [itThree setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }
                           forState:UIControlStateHighlighted];
}

//// ** Hämtar datan ifrån Parse ** ///
-(void)retrieveFromParse{
    PFQuery *getFeed = [PFQuery queryWithClassName:@"userPosts"];
    [getFeed orderByDescending:@"newUpdate"];
    [getFeed includeKey:@"user"];
    getFeed.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getFeed findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            mainFeed = [[NSMutableArray alloc]initWithArray:objects];
            tableimages = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
    }];

}
-(void)checkIfTheyLikes{
    PFQuery *getLike = [PFQuery queryWithClassName:@"Likes"];
    getLike.cachePolicy = kPFCachePolicyNetworkElseCache;
    [getLike whereKey:@"user" equalTo:[PFUser currentUser]];
    
    [getLike findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            
            allTheLikes = [[NSMutableArray alloc] initWithArray:objects];
            
           }
        [self.myTableView reloadData];
    }];

}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self retrieveFromParse];
    
    _activitySnurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
  
    _activitySnurra.frame = CGRectMake(140, 140, 50, 50);
    [self.myTableView addSubview:_activitySnurra];
    [_activitySnurra startAnimating];
	// Do any additional setup after loading the view.
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
    
    
    //////
    UIImage *buttonImage = [UIImage imageNamed:@"addToList.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(5, 1, 80, 31);
    button.showsTouchWhenHighlighted = YES;
    
    [button addTarget:self action:@selector(addToList) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    //// SEARCH BUTTON
    
    UIImage *buttonImageTwo = [UIImage imageNamed:@"search.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(20, 0, 38, 34);
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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.myTableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self retrieveFromParse];
    [refreshControl endRefreshing];
}

-(void)addToList{
    // kör segue till den valbara addToListSidan
    [self performSegueWithIdentifier:@"showAddToListChoose" sender:self];
}

-(void)searchNow{
    
    [self performSegueWithIdentifier:@"searchNow" sender:self];
    
}


///////////// ******* TABLEVIEW *******

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [mainFeed count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *rowObject = [mainFeed objectAtIndex:indexPath.row];
    NSNumber *haveDone = [rowObject objectForKey:@"DoneIt"];
    
    if(haveDone == [NSNumber numberWithBool:YES]){
        return 347;
    }else{
        return 82;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"feedCell";
    
    MIHFeedCell *cell = (MIHFeedCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];


    cell.likeBtn.hidden = NO;
    cell.unlikeBtn.hidden = YES;
    cell.likeBtn.adjustsImageWhenHighlighted = NO;
    cell.unlikeBtn.adjustsImageWhenHighlighted = NO;

    PFUser* userIClickedOnInTheTableview = [PFUser currentUser];
    PFObject *checkObj = [mainFeed objectAtIndex:indexPath.row];
    
    for (PFObject *object in allTheLikes) {
        PFUser* checkUser = [object objectForKey:@"user"];
        PFObject *likeObj = [object objectForKey:@"post"];
        if([userIClickedOnInTheTableview.objectId isEqualToString:checkUser.objectId] && [checkObj.objectId isEqualToString:likeObj.objectId]){
            NSLog(@"You like this row: %d", indexPath.row+1);
            
            [cell.unlikeBtn setHidden:NO];
            [cell.likeBtn setHidden:YES];
            
        }
            
    }
    
    [cell.commentBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.commentBtn setTag:9002];
    [cell addSubview:cell.likeBtn];
    [cell addSubview:cell.unlikeBtn];
    [cell addSubview:cell.commentBtn];
    cell.pictureBackground.hidden = YES;
    
    [cell.likeBtn setFrame:CGRectMake(47, 320.5, 59, 21)];
    [cell.unlikeBtn setFrame:CGRectMake(47, 320.5, 59, 21)];
    [cell.commentBtn setFrame:CGRectMake(110, 320.5, 73, 21)];
    
    [cell.seperatorLine setFrame:CGRectMake(0, 347, 320, 1)];
    [cell.activityLabel setFrame:CGRectMake(58, 18, cell.activityLabel.frame.size.width, cell.activityLabel.frame.size.height)];
    
    cell.profilePicture.layer.cornerRadius = cell.profilePicture.frame.size.width/2;
    cell.profilePicture.layer.masksToBounds = YES;
    
    CGFloat yourSelectedFontSize = 16.0;
    UIFont *yourNewSameStyleFont = [cell.activityLabel.font fontWithSize:yourSelectedFontSize];
    cell.activityLabel.font = yourNewSameStyleFont;
    
    PFObject *tempObjs = [mainFeed objectAtIndex:indexPath.row];
    cell.activityLabel.text = [tempObjs objectForKey:@"activity"];
    NSString *userName = [[tempObjs objectForKey:@"user"] objectForKey:@"username"];
    
    ///Fetstilt
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ have done it!", userName]];
    NSRange selectedRange = NSMakeRange(0, userName.length); // 4 characters, starting at index 22
    
    [string beginEditing];
    
    [string addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"helvetica-bold" size:13.0]
                   range:selectedRange];
    
    [string endEditing];
    
    [cell.nameLabel setAttributedText:string];
    
    //[cell.nameLabel setText:[NSString stringWithFormat:@"%@ did it!", userName]];
    
    PFFile *imgFileOne = [tempObjs objectForKey:@"image"];
   [cell.feedImage setImageWithURL:imgFileOne.url placeholderImage:[UIImage imageNamed:@"placeholderimage.png"]];
    
    PFFile *profileImg = [[tempObjs objectForKey:@"user"]objectForKey:@"profilePicture"];
    [cell.profilePicture setImageWithURL:profileImg.url placeholderImage:[UIImage imageNamed:@"profileDude.png"]];
    
    
    if([cell.nameLabel.text isEqualToString:@"Sponsor added to the list!"]){
        [cell.nameLabel setText:@"Sponsor"];
    }
    
    //NSNumber *likes;
    self.likeNumber = [[tempObjs objectForKey:@"likes"]intValue];
    [cell.likeLabel setText:[NSString stringWithFormat:@"%d", self.likeNumber]];
    
    NSNumber *commentCount = [tempObjs objectForKey:@"counter"];
    [cell.countCommentLbl setText:[NSString stringWithFormat:@"%@", commentCount]];
    
    if([cell.likeLabel.text isEqualToString:@"-1"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-2"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-3"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-4"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-5"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-6"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-7"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-8"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-9"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-10"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-11"]){
        [cell.likeLabel setText:@"0"];
    }
    if([cell.likeLabel.text isEqualToString:@"-12"]){
        [cell.likeLabel setText:@"0"];
    }
    
    /*
    PFQuery *countCom = [PFQuery queryWithClassName:@"Comments"];
    PFObject *thisCount = [mainFeed objectAtIndex:indexPath.row];
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
    */
 
    //*** HÄR PÅBÖRJAR VI DESIGN BÅDE FÖRE OCH EFTER DONEIT ***//
    
    cell.feedImage.hidden = NO;
    NSNumber *didIdoneIt = [tempObjs objectForKey:@"DoneIt"];
    if(didIdoneIt == [NSNumber numberWithBool:NO]){
        cell.feedImage.hidden = YES;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ added to the list!", userName]];
        NSRange selectedRange = NSMakeRange(0, userName.length); // 4 characters, starting at index 22
        
        [string beginEditing];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"helvetica-bold" size:13.0]
                       range:selectedRange];
        
        [string endEditing];
        
        [cell.nameLabel setAttributedText:string];
        
        //[cell.nameLabel setText:[NSString stringWithFormat:@"%@ added to the list!", userName]];
 
        CGFloat yourSelectedFontSize = 18.0 ;
        UIFont *yourNewSameStyleFont = [cell.activityLabel.font fontWithSize:yourSelectedFontSize];
        cell.activityLabel.font = yourNewSameStyleFont ;
        
        [cell.activityLabel setFrame:CGRectMake(58, 22, cell.activityLabel.frame.size.width, cell.activityLabel.frame.size.height)];
        cell.pictureBackground.hidden = YES;
        
        [cell.likeBtn setFrame:CGRectMake(47, 55, 59, 21)];
        [cell.unlikeBtn setFrame:CGRectMake(47, 55, 59, 21)];
        
        [cell.commentBtn setFrame:CGRectMake(110, 55, 73, 21)];
        [cell.seperatorLine setFrame:CGRectMake(0, 81, 320, 1)];
        
    }
    
    return cell;
        
        
    
    //////////////////////////////////////////////////////////////////////////////
}


-(void)buttonPressed: (UIButton *)sender{
    if(sender.tag == 9002){
        UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
        NSLog(@"cell row %i", [self.myTableView indexPathForCell:cell].row);
        
    }
}



///// SKICKA DATA TILL NÄSTKOMMANDE FÖNSTER

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"feedDetail"]){
        
        MIHFeedDetailViewController* nvc = (MIHFeedDetailViewController*)[segue destinationViewController];
        
       
        PFObject *thisobject = [mainFeed objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
          
            nvc.nvcObject = thisobject;
            nvc.bildString = [[thisobject objectForKey:@"user"] objectForKey:@"profilePicture"];
    
    }else if([segue.identifier isEqualToString:@"showComments"]){
        MIHCommentsViewController* nvc = (MIHCommentsViewController*)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell *)[sender superview].superview;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        PFObject *object = [mainFeed objectAtIndex:indexPath.row];
        nvc.nvcObject = object;
        
    }
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading
        //for example [activityIndicator stopAnimating];
        [_activitySnurra stopAnimating];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)likeBtnPressed:(UIButton *)sender {
    
    MIHFeedCell *cell = (MIHFeedCell *)[sender superview].superview;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    PFObject *thisPost = [mainFeed objectAtIndex:indexPath.row];
    cell.likeBtn.hidden = YES;
    cell.unlikeBtn.hidden = NO;
    cell.unlikeBtn.enabled = NO;

    
    self.likeNumber = [[thisPost objectForKey:@"likes"]intValue];
    self.likeNumber++;
    [thisPost setObject:[NSNumber numberWithInt:self.likeNumber] forKey:@"likes"];
    
    //[thisPost saveInBackground];
    
    [thisPost saveInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        if(succeed){
            NSLog(@"Uppdaterad!!!!");
            //[cell.likeLabel setNeedsDisplay];
            //[self checkIfTheyLikes];
        }
    }];
    
    ///// Lägger till vår likade post i likeklassen för kika vidare på det när vi hämtar ut allt därifrån.
    
    PFObject *object = [PFObject objectWithClassName:@"Likes"];
    PFObject *newObject = [mainFeed objectAtIndex:indexPath.row];
    [object setObject:newObject forKey:@"post"];
    [object setObject:[PFUser currentUser] forKey:@"user"];
    [object setObject:[NSNumber numberWithBool:YES] forKey:@"checkLike"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if(!error){
        [self checkIfTheyLikes];
        //cell.likeBtn.enabled = YES;
        cell.unlikeBtn.enabled = YES;
        }
    }];
    

    
    

    
}

- (IBAction)unlikeBtnPressed:(UIButton *)sender {
        MIHFeedCell *cell = (MIHFeedCell *)[sender superview].superview;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        PFObject *thisPost = [mainFeed objectAtIndex:indexPath.row];
        cell.likeBtn.hidden = NO;
        cell.unlikeBtn.hidden = YES;
    
        int index = [[thisPost objectForKey:@"likes"]intValue];
        index--;
        [thisPost setObject:[NSNumber numberWithInt:index] forKey:@"likes"];
   
    [thisPost saveInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        if(succeed){
            
            [cell.likeLabel setNeedsDisplay];
            //[self checkIfTheyLikes];
            //cell.unlikeBtn.hidden = YES;
        
        }
    }];
    
    // Raderar vår LIKE post i den specifika like klassen, vi hämtar den kollar om VI (currentUser) och posten på den raden stämmer överrens med posten i databasen, isåfall letar vi upp den raden och raderar den!
    
    PFQuery *getLike = [PFQuery queryWithClassName:@"Likes"];
    [getLike includeKey:@"post"];
    [getLike includeKey:@"user"];
    getLike.cachePolicy = kPFCachePolicyNetworkElseCache;
    [getLike findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            PFUser* userIClickedOnInTheTableview = [PFUser currentUser];
            PFObject *checkObj = thisPost;
            for (PFObject *object in objects) {
                PFUser* checkUser = [object objectForKey:@"user"];
                PFObject *likeObj = [object objectForKey:@"post"];
                if([userIClickedOnInTheTableview.objectId isEqualToString:checkUser.objectId] && [checkObj.objectId isEqualToString:likeObj.objectId]){
                   
                    [object deleteInBackgroundWithBlock:^(BOOL succeed, NSError *error){
                        if(!error){
                            [self checkIfTheyLikes];
                        }
                        
                    }];
                    
                    
                    
                }else{
                    // U dont like it
                }
                //[self checkIfTheyLikes];
            }}
    }];



}
@end
