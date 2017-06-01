//
//  MIHSearchResultsViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-11-07.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHSearchResultsViewController.h"
#import "MIHSearchUserDetailCell.h"
#import "MIHSearchUserDetailTwoCell.h"
#import "MIHFeedDetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MIHuserDetFollowingViewController.h"
#import "MIHuserDetailFollowersViewController.h"

@interface MIHSearchResultsViewController ()

@end

@implementation MIHSearchResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self.picView setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = _picView.frame;
    [_picView addSubview: snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        PFFile* image = [_nvcObject objectForKey:@"profilePicture"];
        UIImage* imgProfile = [UIImage imageWithData:image.getData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            
            
            
            [self.picView setImage:imgProfile];
            [snurra removeFromSuperview];
        });
    });
    
    PFUser *meTheOne = _nvcObject;
    NSNumber *trophyCount = [meTheOne objectForKey:@"trophyCheck"];
    NSNumber *doneCount = [meTheOne objectForKey:@"doneList"];
    [self.trophyCountLbl setText:[NSString stringWithFormat:@"%@",trophyCount]];
    [self.doneCount setText:[NSString stringWithFormat:@"%@", doneCount]];
    
    
    /// RÄKNAR VÅR LISTA
    
    PFQuery *countCom = [PFQuery queryWithClassName:@"userPosts"];
    PFUser *theUser = _nvcObject;
    [countCom whereKey:@"user" equalTo:theUser];
    countCom.cachePolicy = kPFCachePolicyNetworkElseCache;
    [countCom countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            [self.listCountLbl setText:[NSString stringWithFormat:@"%d", count]];
            
        } else {
            NSLog(@"couldnt count the list");
        }
    }];
    
    PFQuery *countFollowing = [PFQuery queryWithClassName:@"Friends"];
    PFUser *thisUsr = _nvcObject;
    [countFollowing whereKey:@"user" equalTo:thisUsr];
    countFollowing.cachePolicy = kPFCachePolicyNetworkElseCache;
    [countFollowing countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            [self.followingLbl setText:[NSString stringWithFormat:@"%d", count]];
            
        } else {
            NSLog(@"couldnt count the list");
        }
    }];
    
    PFQuery *countFollowers = [PFQuery queryWithClassName:@"Friends"];
    PFUser *thisUserr = _nvcObject;
    [countFollowers whereKey:@"userFriend" equalTo:thisUserr];
    countFollowers.cachePolicy = kPFCachePolicyNetworkElseCache;
    [countFollowers countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            [self.followersLbl setText:[NSString stringWithFormat:@"%d", count]];
            
        } else {
            NSLog(@"couldnt count the list");
        }
    }];
    

    

}

-(void)viewWillAppear:(BOOL)animated{
    
    _leftBtnOutlet.selected = YES;
    _rightBtnOutlet.selected = NO;
    
    _trophyView.hidden = YES;
    _listView.hidden = NO;
    
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
    
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    self.myTableView.scrollEnabled = NO;
    
    [self retrieveUserRelation];
    [self retrieveFromParse];
    [self retrieveFromParseTwo];
    
    _picView.layer.cornerRadius = _picView.frame.size.width/2;
    _picView.layer.masksToBounds = YES;
    
    /// Användarnamnet till titeln
    NSString *userLabel = [_nvcObject objectForKey:@"username"];
    
    self.title = [NSString stringWithFormat:@"%@", userLabel];
    
    _listView.backgroundColor = [UIColor clearColor];
    _trophyView.backgroundColor = [UIColor clearColor];
    
    //////
    
    _leftBtnOutlet.selected = !_leftBtnOutlet.selected;
    _rightBtnOutlet.selected = NO;
    
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

-(void)retrieveUserRelation{
    PFQuery *getFriend = [PFQuery queryWithClassName:@"Friends"];
    //[getFriend includeKey:@"user"];
    //[getFriend includeKey:@"userFriend"];
    //getFriend.cachePolicy = kPFCachePolicyNetworkElseCache;
    [getFriend whereKey:@"user" equalTo:[PFUser currentUser]];
    [getFriend whereKey:@"userFriend" equalTo:_nvcObject];
    [getFriend findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            friendCheck = [[NSMutableArray alloc] initWithArray:objects];
            
            PFUser* userIClickedOnInTheTableview =_nvcObject; //Användare jag gillar..
            for (PFObject *object in objects) {
                PFUser* checkUser = [object objectForKey:@"userFriend"]; //Användaren jag gillar
                NSLog(@"%@", friendCheck);
                if([userIClickedOnInTheTableview.objectId isEqualToString:checkUser.objectId]){
                    
                    [_followLabel setText:@"ALREADY FOLLOWING"];
                    _followBtn.hidden = YES;
                    _greyAddBtn.hidden = NO;
                    
                }else if(![friendCheck count]){
                    
                    [_followLabel setText:@"FOLLOW USER YOLO"];
                    _followBtn.hidden = YES;
                    _greyAddBtn.hidden = YES;
                    
                }
            }
            
        }
        
    }];
}

/// Hämtar användarens Feed inlägg
-(void)retrieveFromParse{
    
    
    PFQuery *getTips = [PFQuery queryWithClassName:@"userPosts"];
    [getTips orderByDescending:@"createdAt"];
    PFUser *anvandare = _nvcObject;
    [getTips whereKey:@"user" equalTo:anvandare];
    [getTips includeKey:@"user"];
    getTips.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTips findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            userFeed = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
        [self.myTableView setFrame:CGRectMake(0, 200, self.myTableView.frame.size.width, [objects count]*101)];
        [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, self.myTableView.frame.size.height + 199)];
    }];
}

// Hämtar användarens Trophies
-(void)retrieveFromParseTwo{
    
    
    PFQuery *getTrophy = [PFQuery queryWithClassName:@"Trophys"];
    [getTrophy orderByDescending:@"createdAt"];
    PFUser *anvandare = _nvcObject;
    [getTrophy whereKey:@"user" equalTo:anvandare];
    getTrophy.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTrophy findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            trophyFeed = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableViewTwo reloadData];
    }];
}

/////////// ******* TABLEVIEW ******** /////////////

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _myTableView){
        return [userFeed count];
    }else if (tableView == _myTableViewTwo){
        return [trophyFeed count];
    }
    return YES;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _myTableView){
        static NSString *CellIdentifier = @"userDetailCell";
        
        MIHSearchUserDetailCell *cell = (MIHSearchUserDetailCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        

        cell.imageViewz.layer.cornerRadius = cell.imageViewz.frame.size.width/2;
        cell.imageViewz.layer.masksToBounds = YES;
        
        
        PFObject *tempObj = [userFeed objectAtIndex:indexPath.row];
        cell.activityLabel.text = [tempObj objectForKey:@"activity"];
        cell.descLabel.text = [tempObj objectForKey:@"description"];
        NSNumber *haveDoneIt = [tempObj objectForKey:@"DoneIt"];
        
        if(haveDoneIt == [NSNumber numberWithBool:YES]){
            [cell.doneImage setImage:[UIImage imageNamed:@"doneItIcon.png"]];
        }else{
            //NULL
        }
        PFFile *myImg = [tempObj objectForKey:@"image"];
        [cell.imageViewz setImageWithURL:myImg.url];
        
        
        
        
        return cell;
    }else if(tableView == _myTableViewTwo){
        
        static NSString *CellIdentifier = @"userDetailTwoCell";
        
        MIHSearchUserDetailTwoCell *cell = (MIHSearchUserDetailTwoCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.imageViewzTwo.layer.cornerRadius = cell.imageViewzTwo.frame.size.width/2;
        cell.imageViewzTwo.layer.masksToBounds = YES;
        
        
        PFObject *tempObj = [trophyFeed objectAtIndex:indexPath.row];
        cell.activityLabelTwo.text = [tempObj objectForKey:@"activity"];
        cell.descLabelTwo.text = [tempObj objectForKey:@"description"];
        PFFile *myImg = [tempObj objectForKey:@"image"];
        
        [cell.imageViewzTwo setImageWithURL:myImg.url];
        
             return cell;
        
        
    }
    return nil;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showTheUserDetail"]){
        
        MIHFeedDetailViewController* nvc = (MIHFeedDetailViewController*)[segue destinationViewController];
        
        
        PFObject *thisobject = [userFeed objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
        
        nvc.nvcObject = thisobject;
        nvc.bildString = [[thisobject objectForKey:@"user"] objectForKey:@"profilePicture"];
        
    }else if([segue.identifier isEqualToString:@"showFollowing"]){
       
        MIHuserDetFollowingViewController *nvc = (MIHuserDetFollowingViewController*)[segue destinationViewController];
        
        PFObject *thisObj = _nvcObject;
        nvc.nvcObject = thisObj;
        
    }else if([segue.identifier isEqualToString:@"showFollowers"]){
        MIHuserDetailFollowersViewController *nvc = (MIHuserDetailFollowersViewController*)[segue destinationViewController];
        
        PFObject *thisObjekt = _nvcObject;
        nvc.nvcObject = thisObjekt;
    }
}



-(void)viewWillDisappear:(BOOL)animated{
    _myTableViewTwo.hidden = YES;
    _myTableView.hidden = NO;
    
    self.myScrollView.scrollEnabled = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trophysBtnClicked:(UIButton *)sender {
    
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    self.myScrollView.scrollEnabled = NO;
    _myTableViewTwo.hidden = NO;
    _myTableView.hidden = YES;
    
    _rightBtnOutlet.selected = !_rightBtnOutlet.selected;
    _leftBtnOutlet.selected = NO;
    
    _trophyView.hidden = NO;
    _listView.hidden = YES;
    
}

- (IBAction)listBtnClicked:(UIButton *)sender {
    
    self.myScrollView.scrollEnabled = YES;
    
    _myTableViewTwo.hidden = YES;
    _myTableView.hidden = NO;
    
    _leftBtnOutlet.selected = !_leftBtnOutlet.selected;
    _rightBtnOutlet.selected = NO;
    
    _trophyView.hidden = YES;
    _listView.hidden = NO;

    
}
- (IBAction)followBtnClicked:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"You are now following this user" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    
    PFUser *thisUser = [PFUser currentUser];
    PFObject *friendlist = [PFObject objectWithClassName:@"Friends"];
    [friendlist setObject:_nvcObject forKey:@"userFriend"];
    [friendlist setObject:thisUser forKey:@"user"];
    [friendlist saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if(!error){
            [self retrieveUserRelation];
        }
    }];

    
}
@end
