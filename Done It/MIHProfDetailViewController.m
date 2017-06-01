//
//  MIHProfDetailViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-09-24.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHProfDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MIHEditListViewController.h"
#import "MIHDoneItCheckViewController.h"
#import "MIHCommentsViewController.h"
#import "MIHProfDetailCommCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MIHUserDetailViewController.h"
#import "MHFacebookImageViewer.h"

@interface MIHProfDetailViewController ()

@end

@implementation MIHProfDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSNumber *doneIt = [_nvcObject objectForKey:@"DoneIt"];
    if([doneIt isEqual:[NSNumber numberWithBool:YES]]){
        [self.doneItLbl setHidden:YES];
        [self.doneBtnOutlet setHidden:YES];
    }else{
        [self.doneItLbl setText:@"I've done it"];
    }
    
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
    
    [self retrieveFromParseTwo];
    [self.profilePicture setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = self.profilePicture.bounds;
    [snurra setColor:[UIColor blackColor]];
    [self.profilePicture addSubview:snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        PFFile *imageData = _bildString;
        UIImage *theImage = [UIImage imageWithData:imageData.getData];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            [snurra removeFromSuperview];
            [self.profilePicture setImage:theImage];
        });
    });
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _unlikeBtn.hidden = YES;
    _likeBtn.hidden = NO;
    
    [self retrieveLikeRelation];
    //Adding everything to the ScrollView
    
    
    self.currentImageView.hidden = YES;
    [self.myTableView setFrame:CGRectMake(0, 370, self.myTableView.frame.size.width, self.myTableView.frame.size.height)];
    [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 430)];
    
    
    PFObject *object = _nvcObject;
    NSNumber *thisObj = [object objectForKey:@"DoneIt"];
    
    
    
    if(thisObj == [NSNumber numberWithBool:YES]){
        [self retrieveFromParseThree];
        
        // - 60 på height
        [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 483)];
        [self.myTableView setFrame:CGRectMake(0, 420, self.myTableView.frame.size.width, self.myTableView.frame.size.height)];
        
    }else{
        NSLog(@"Denna posten har inte DONEIT");
    }
    

    
    
    _loadingView.layer.cornerRadius = 7;
    _loadingView.layer.masksToBounds = YES;
    
   
    
    ///////////////// UI ELEMENT /////////////////
    
    _profilePicture.layer.cornerRadius = _profilePicture.frame.size.width/2;
    _profilePicture.layer.masksToBounds = YES;
    
    // Hämtar huvudbilden
    [self.mainPicture setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = _mainPicture.frame;
    [_mainPicture addSubview: snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        PFFile* image = [_nvcObject objectForKey:@"image"];
        UIImage* imgProfile = [UIImage imageWithData:image.getData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            
            
            
            [self.mainPicture setImage:imgProfile];
            [snurra removeFromSuperview];
        });
    });
    
    NSString *thisActivity = [_nvcObject objectForKey:@"activity"];
    [self.activityLabel setText:thisActivity];
    NSString *thisDesc = [_nvcObject objectForKey:@"description"];
    [self.descLbl setText:thisDesc];
    
    if(self.activityLabel.text.length > 17){
        [self.activityLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:15.0]];
    }

    /////////////////////////////////////////////
    
    
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
    /*
    PFQuery *countCom = [PFQuery queryWithClassName:@"Comments"];
    [countCom whereKey:@"post" equalTo:_nvcObject];
    countCom.cachePolicy = kPFCachePolicyNetworkElseCache;
    [countCom countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            [self.countComment setText:[NSString stringWithFormat:@"%d", count]];
            
        } else {
            NSLog(@"couldnt count the list");
        }
    }];
    */
     
    NSNumber *likes;
    likes = [_nvcObject objectForKey:@"likes"];
    [self.likeLabel setText:[NSString stringWithFormat:@"%@", likes]];
    NSNumber *countComments = [_nvcObject objectForKey:@"counter"];
    [self.countComment setText:[NSString stringWithFormat:@"%@", countComments]];

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)retrieveFromParseTwo{
    
    
    PFQuery *getTrophy = [PFQuery queryWithClassName:@"Comments"];
    [getTrophy orderByDescending:@"createdAt"];
    [getTrophy whereKey:@"post" equalTo:_nvcObject];
    [getTrophy includeKey:@"user"];
    [getTrophy includeKey:@"post"];
    getTrophy.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTrophy findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            commentFeed = [[NSMutableArray alloc]initWithArray:objects];
        }
        
        [self.myTableView reloadData];
    }];
}

-(void)retrieveFromParseThree{
    
    
    PFQuery *getImgs = [PFQuery queryWithClassName:@"userPostsPictures"];
    [getImgs orderByDescending:@"createdAt"];
    [getImgs whereKey:@"userposts" equalTo:_nvcObject];
    getImgs.cachePolicy = kPFCachePolicyNetworkElseCache;
    getImgs.limit = 5;
    
    [getImgs findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            //userPosts = [[NSMutableArray alloc]initWithArray:objects];
            if([objects count] == 0){
                [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 430)];
                [self.myTableView setFrame:CGRectMake(0, 370, self.myTableView.frame.size.width, self.myTableView.frame.size.height)];
            }
            
            
            NSMutableArray *imageViews = [[NSMutableArray alloc] init];
            for(NSInteger i=0; i < objects.count; i++)
            {
                self.currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake((17 + (52 * i)), 373, 44, 44)];
                PFObject *imgFeed = [objects objectAtIndex:i];
                PFFile *theImage = [imgFeed objectForKey:@"expPic"];
                UIImage *realImage = [UIImage imageWithData:theImage.getData];
                self.currentImageView.layer.cornerRadius = self.currentImageView.frame.size.width/2;
                self.currentImageView.layer.masksToBounds = YES;
                [imageViews addObject:self.currentImageView];
                [self displayImage:self.currentImageView withImage:realImage];
                [self.myScrollView addSubview:self.currentImageView];
            }
            
        }
        
    }];
}

// MODUL TILL IMAGEVIEWER!!
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}


-(void)retrieveLikeRelation{
    PFQuery *getLike = [PFQuery queryWithClassName:@"Likes"];
    
    [getLike whereKey:@"user" equalTo:[PFUser currentUser]];
    [getLike whereKey:@"post" equalTo:_nvcObject];
    [getLike findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            
            PFObject* userIClickedOnInTheTableview = _nvcObject; //Posten jag gillar..
            for (PFObject *object in objects) {
                PFObject* checkUser = [object objectForKey:@"post"]; //Posten jag gillar
                if([userIClickedOnInTheTableview.objectId isEqualToString:checkUser.objectId]){
                    
                    NSLog(@"YOU DO LIKE THIS POST, SWEET!!!");
                    [self.likeBtn setHidden:YES];
                    [self.unlikeBtn setHidden:NO];
                    
                }
            }
            
        }
        
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentFeed count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"feedComm";
    
    MIHProfDetailCommCell *cell = (MIHProfDetailCommCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2;
    cell.profilePic.layer.masksToBounds = YES;
    
    [cell addSubview:cell.profileBtn];
    
    PFObject *tempObj = [commentFeed objectAtIndex:indexPath.row];
    
    NSString *userNamez = [[tempObj objectForKey:@"user"] objectForKey:@"username"];
    NSString *messagez = [tempObj objectForKey:@"message"];
    [cell.messageLbl setText:[NSString stringWithFormat:@"%@: %@", userNamez, messagez]];
    
    
    [cell.profilePic setImage:nil];
    
    
    if([[commentFeed objectAtIndex:indexPath.row] isMemberOfClass:[UIImage class]]){
        
        [cell.profilePic setImage:[commentFeed objectAtIndex:indexPath.row]];
        
    }else{
        
        //*******************************
        
        UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        snurra.frame = cell.profilePic.frame;
        [cell addSubview: snurra];
        [snurra startAnimating];
        
        
        
        
        
        //Backgrundstråd
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //Här gör man det som tar tid, tex ladda ner data.
            //Man får INTE ändra UI:t här
            
            PFObject *tempObjs = [commentFeed objectAtIndex:indexPath.row];
            
            PFFile *myImg = [[tempObjs objectForKey:@"user"] objectForKey:@"profilePicture"];
            UIImage *myImage = [UIImage imageWithData:myImg.getData];
            
            
            //[usersArray replaceObjectAtIndex:indexPath.row withObject:myImage];
            //image = bild;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //Här ändrar man saker i UI
                [snurra removeFromSuperview];
                [cell.profilePic setImage:myImage];
                //[cell setNeedsLayout];
                
                
            });
        });
    }
    
    
    
    
    return cell;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userLblClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteBtnClicked:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[_nvcObject objectForKey:@"activity"] message:@"You are about to delete this post, do you want to continue?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
    
}

- (IBAction)doneitBtnClicked:(UIButton *)sender {
    //[self performSegueWithIdentifier:@"iDidIt" sender:self];
    

    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        
        _loadingView.hidden = NO;
        PFObject *object = self.nvcObject;
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
            _loadingView.hidden = YES;
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"editPost"]){
        
        MIHEditListViewController* nvc = (MIHEditListViewController*)[segue destinationViewController];
        
        nvc.nvcObject = _nvcObject;
        nvc.bildString = [_nvcObject objectForKey:@"image"];
        nvc.theImage = [_nvcObject objectForKey:@"image"];
        
        
    }else if([segue.identifier isEqualToString:@"iDidIt"]){
        MIHDoneItCheckViewController *nvc = (MIHDoneItCheckViewController*)[segue destinationViewController];
        
        nvc.nvcObject = _nvcObject;
        PFFile *thisFile = [_nvcObject objectForKey:@"image"];
        nvc.theImage = thisFile.getData;
        
    }else if([segue.identifier isEqualToString:@"showComments"]){
        
        
        MIHCommentsViewController* nvc = (MIHCommentsViewController*)[segue destinationViewController];
        
        nvc.nvcObject = _nvcObject;

        
    }else if([segue.identifier isEqualToString:@"showCommentDetail"]){
        MIHUserDetailViewController* nvc = (MIHUserDetailViewController*)[segue destinationViewController];
        nvc.nvcObject = [_nvcObject objectForKey:@"user"];
    }
}






- (IBAction)unlikeBtnClicked:(UIButton *)sender {
    self.unlikeBtn.hidden = YES;
    self.likeBtn.hidden = NO;
    
    PFObject *thisPost = _nvcObject;
    
    int index = [[thisPost objectForKey:@"likes"]intValue];
    index--;
    [thisPost setObject:[NSNumber numberWithInt:index] forKey:@"likes"];
    
    [thisPost saveInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        if(succeed){
            
            NSNumber *likes;
            likes = [thisPost objectForKey:@"likes"];
            [self.likeLabel setText:[NSString stringWithFormat:@"%@", likes]];
            [self.likeLabel setNeedsLayout];
            //[self retrieveLikeRelation];
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
                    
                    [object deleteInBackground];
                    
                }else{
                    // U dont like it
                }
            }}
    }];
    

}

- (IBAction)likeBtnClicked:(UIButton *)sender {
    self.unlikeBtn.hidden = NO;
    self.likeBtn.hidden = YES;
    
    PFObject *thisPost = _nvcObject;
    
    int index = [[thisPost objectForKey:@"likes"]intValue];
    index++;
    [thisPost setObject:[NSNumber numberWithInt:index] forKey:@"likes"];
    
    //[thisPost saveInBackground];
    
    [thisPost saveInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        if(succeed){
            NSLog(@"Uppdaterad!!!!");
            NSNumber *likes;
            likes = [thisPost objectForKey:@"likes"];
            [self.likeLabel setText:[NSString stringWithFormat:@"%@", likes]];
            [self.likeLabel setNeedsLayout];
        }
    }];
    
    ///// Lägger till vår likade post i likeklassen för kika vidare på det när vi hämtar ut allt därifrån.
    
    PFObject *object = [PFObject objectWithClassName:@"Likes"];
    PFObject *newObject = _nvcObject;
    [object setObject:newObject forKey:@"post"];
    [object setObject:[PFUser currentUser] forKey:@"user"];
    [object setObject:[NSNumber numberWithBool:YES] forKey:@"checkLike"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        NSLog(@"Du gillar nu denna posten, registreringen har gått bra!");
        //[self retrieveLikeRelation];
    }];
}
@end
