//
//  MIHFeedDetailViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-07-31.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHFeedDetailViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MIHCommentsViewController.h"
#import "MIHFeedDetailCommentCell.h"
#import "MIHUserDetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MHFacebookImageViewer.h"
#import "MIHShowAllLikesViewController.h"

@interface MIHFeedDetailViewController ()
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image;
@end

@implementation MIHFeedDetailViewController
@synthesize nvcObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    self.myTableView.bounces = NO;
    
    NSNumber *countComments = [nvcObject objectForKey:@"counter"];
    [self.countComment setText:[NSString stringWithFormat:@"%@", countComments]];
    
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
    [self.picView setImage:nil];
    
    //// *** Räknar grejer
    
        

    
    
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = self.picView.bounds;
    [snurra setColor:[UIColor blackColor]];
    [self.picView addSubview:snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        PFFile *imageData = _bildString;
        UIImage *theImage = [UIImage imageWithData:imageData.getData];
        
      
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            [snurra removeFromSuperview];
            [self.picView setImage:theImage];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self retrieveLikeRelation];
    
    
    _imageMainView.backgroundColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.95];
    [self.imageMainView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _unlikeBtn.hidden = YES;
    _likeBtn.hidden = NO;
    
    
    _imageMainViewImage.layer.borderWidth = 1;
    _imageMainViewImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _galleryImgOne.hidden = YES;
    _galleryImgTwo.hidden = YES;
    _galleryImgThree.hidden = YES;
    _galleryImgFour.hidden = YES;
    _galleryImgFive.hidden = YES;
    _imgBtnOne.hidden = YES;
    _imgBtnTwo.hidden = YES;
    _imgBtnThree.hidden = YES;
    _imgBtnFour.hidden = YES;
    self.readMoreBtn.hidden = YES;
    self.currentImageView.hidden = YES;
    [self.myTableView setFrame:CGRectMake(0, 340, self.myTableView.frame.size.width, self.myTableView.frame.size.height)];
    [self.readMoreBtn setFrame:CGRectMake(8, 394, self.readMoreBtn.frame.size.width, self.readMoreBtn.frame.size.height)];
     [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 430)];
    
    
    PFObject *object = nvcObject;
    NSNumber *thisObj = [object objectForKey:@"DoneIt"];
    

    
    if(thisObj == [NSNumber numberWithBool:YES]){
        [self retrieveFromParseThree];
        _galleryImgOne.hidden = NO;
        _galleryImgTwo.hidden = NO;
        _galleryImgThree.hidden = NO;
        _galleryImgFour.hidden = NO;
        _galleryImgFive.hidden = NO;
        _imgBtnOne.hidden = NO;
        _imgBtnTwo.hidden = NO;
        _imgBtnThree.hidden = NO;
        _imgBtnFour.hidden = NO;
        [self.myTableView setFrame:CGRectMake(0, 390, self.myTableView.frame.size.width, self.myTableView.frame.size.height)];
        [self.readMoreBtn setFrame:CGRectMake(8, 444, self.readMoreBtn.frame.size.width, self.readMoreBtn.frame.size.height)];
        
        // - 60 på height
         [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 480)];

        
           }else{
        NSLog(@"Denna posten har inte DONEIT");
    }
    
    
    if([self.countComment.text isEqualToString:@""]){
        [self.countComment setText:@"0"];
    }
    
    _galleryImgOne.layer.cornerRadius = self.galleryImgOne.frame.size.height/2;
    _galleryImgOne.layer.masksToBounds = YES;
    _galleryImgTwo.layer.cornerRadius = self.galleryImgTwo.frame.size.height/2;
    _galleryImgTwo.layer.masksToBounds = YES;
    _galleryImgThree.layer.cornerRadius = self.galleryImgThree.frame.size.height/2;
    _galleryImgThree.layer.masksToBounds = YES;
    _galleryImgFour.layer.cornerRadius = self.galleryImgFour.frame.size.height/2;
    _galleryImgFour.layer.masksToBounds = YES;
    _galleryImgFive.layer.cornerRadius = self.galleryImgFive.frame.size.height/2;
    _galleryImgFive.layer.masksToBounds = YES;

    /*
    PFQuery *countCom = [PFQuery queryWithClassName:@"Comments"];
    [countCom whereKey:@"post" equalTo:nvcObject];
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
    likes = [nvcObject objectForKey:@"likes"];
    [self.likeLabel setText:[NSString stringWithFormat:@"%@", likes]];
    
    
    // Getting the main Picture
    
    [self.mainImageView setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = _mainImageView.frame;
    [_mainImageView addSubview: snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        PFFile* image = [nvcObject objectForKey:@"image"];
        UIImage* imgProfile = [UIImage imageWithData:image.getData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            
            
            
            [self.mainImageView setImage:imgProfile];
            [snurra removeFromSuperview];
        });
    });

    
    
    _sponsorBtn.backgroundColor = [UIColor colorWithRed:41.0/255 green:171.0/255 blue:226.0/255 alpha:1.0];
    
    _sponsorBtn.layer.cornerRadius = _sponsorBtn.frame.size.width/2;
    _sponsorBtn.layer.masksToBounds = YES;
    
    
    
    
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
    
    _picView.layer.cornerRadius = self.picView.frame.size.width/2;
    _picView.layer.masksToBounds = YES;
    
    NSString *thisActivity = [nvcObject objectForKey:@"activity"];
    [self.activityLbl setText:thisActivity];
    
    if(self.activityLbl.text.length > 17){
        [self.activityLbl setFont:[UIFont fontWithName:@"Helvetica-Light" size:15.0]];
    }
    
    NSNumber *hasDone = [nvcObject objectForKey:@"DoneIt"];
    
    NSString *userName = [[nvcObject objectForKey:@"user"] objectForKey:@"username"];
    [self.userCopyLbl setText:[NSString stringWithFormat:@"%@",userName]];
    [self.userAddedLbl setText:[NSString stringWithFormat:@"%@ added to the list!", userName]];
    
    ///Fetstilt
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ added to the list!", userName]];
    NSRange selectedRange = NSMakeRange(0, userName.length); // 4 characters, starting at index 22
    
    [string beginEditing];
    
    [string addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"helvetica-bold" size:13.0]
                   range:selectedRange];
    
    [string endEditing];

    
    [self.userNameBtn setAttributedTitle:string forState:UIControlStateNormal];
   // [self.userNameBtn setTitle:[NSString stringWithFormat:@"%@ added to the list!", userName] forState:UIControlStateNormal];
    
    
    if(hasDone == [NSNumber numberWithBool:YES]){
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ have done it!", userName]];
        NSRange selectedRange = NSMakeRange(0, userName.length); // 4 characters, starting at index 22
        
        [string beginEditing];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"helvetica-bold" size:13.0]
                       range:selectedRange];
        
        [string endEditing];
        
        
        [self.userNameBtn setAttributedTitle:string forState:UIControlStateNormal];
    }
    
    if([self.userAddedLbl.text isEqualToString:@"Sponsor added to the list!"]){
        self.userAddedLbl.text = [nvcObject objectForKey:@"description"];
        _sponsorBtn.hidden = NO;
        _sponsorBtnLbl.hidden = NO;
        self.userAddedLbl.hidden = NO;
        self.userNameBtn.hidden = YES;
    }
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
    [getLike whereKey:@"post" equalTo:nvcObject];
    [getLike findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            
            PFObject* userIClickedOnInTheTableview = nvcObject; //Posten jag gillar..
            for (PFObject *object in objects) {
                PFObject* checkUser = [object objectForKey:@"post"]; //Posten jag gillar
                if([userIClickedOnInTheTableview.objectId isEqualToString:checkUser.objectId]){
                    
                    NSLog(@"YOU DO LIKE THIS POST, SWEET!!!");
                    [self.likeBtn setHidden:YES];
                    [self.unlikeBtn setHidden:NO];
                    
                    self.unlikeBtn.enabled = YES;
                    self.likeBtn.enabled = YES;
                    
                }
            }
            
        }
        
    }];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)retrieveFromParseTwo{
    
    
    PFQuery *getTrophy = [PFQuery queryWithClassName:@"Comments"];
    [getTrophy orderByDescending:@"createdAt"];
    [getTrophy whereKey:@"post" equalTo:nvcObject];
    [getTrophy includeKey:@"user"];
    [getTrophy includeKey:@"post"];
    getTrophy.limit = 1;
    getTrophy.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTrophy findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            commentFeed = [[NSMutableArray alloc]initWithArray:objects];
            //[self.myTableView setFrame:CGRectMake(0, 390, self.myTableView.frame.size.width, [objects count] * 60)];
            
        }
        
        [self.myTableView reloadData];
        if([objects count] == 0){
            self.readMoreBtn.hidden = YES;
            
        }else{
            self.readMoreBtn.hidden = NO;
        }
        
    }];
}

-(void)retrieveFromParseThree{
    
    
    PFQuery *getImgs = [PFQuery queryWithClassName:@"userPostsPictures"];
    [getImgs orderByDescending:@"createdAt"];
    [getImgs whereKey:@"userposts" equalTo:nvcObject];
    getImgs.cachePolicy = kPFCachePolicyNetworkElseCache;
    getImgs.limit = 5;
    
    [getImgs findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            //userPosts = [[NSMutableArray alloc]initWithArray:objects];
            if([objects count] == 0){
                [self.myTableView setFrame:CGRectMake(0, 340, self.myTableView.frame.size.width, self.myTableView.frame.size.height)];
                [self.readMoreBtn setFrame:CGRectMake(8, 394, self.readMoreBtn.frame.size.width, self.readMoreBtn.frame.size.height)];
                [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 430)];
            }
            
            NSMutableArray *imageViews = [[NSMutableArray alloc] init];
            for(NSInteger i=0; i < objects.count; i++)
            {
                self.currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake((17 + (52 * i)), 345, 44, 44)];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showComments"]){
        
       
            MIHCommentsViewController* nvc = (MIHCommentsViewController*)[segue destinationViewController];
        
            nvc.nvcObject = nvcObject;
           
      
    }else if([segue.identifier isEqualToString:@"userDetail"]){
        MIHUserDetailViewController* next = (MIHUserDetailViewController*)[segue destinationViewController];
        
        next.nvcObject = [nvcObject objectForKey:@"user"];
    }else if([segue.identifier isEqualToString:@"showUserDetailComment"]){
     
        MIHUserDetailViewController* nvc = (MIHUserDetailViewController*)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell *)[sender superview].superview;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        PFObject *object = [commentFeed objectAtIndex:indexPath.row];
        
        PFObject *themObj = [object objectForKey:@"user"];
        nvc.nvcObject = themObj;

        
    }else if([segue.identifier isEqualToString:@"showProfileDetail"]){
        MIHUserDetailViewController* nvc = (MIHUserDetailViewController*)[segue destinationViewController];
        nvc.nvcObject = [nvcObject objectForKey:@"user"];
    }else if([segue.identifier isEqualToString:@"showLikes"]){
        
        MIHShowAllLikesViewController *nvc = (MIHShowAllLikesViewController*)[segue destinationViewController];
        
        nvc.nvcObject = nvcObject;
    }else if([segue.identifier isEqualToString:@"readMore"]){
        MIHCommentsViewController* nvc = (MIHCommentsViewController*)[segue destinationViewController];
        
        nvc.nvcObject = nvcObject;
    }
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
    
    MIHFeedDetailCommentCell *cell = (MIHFeedDetailCommentCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

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

- (IBAction)doneBtnClicked:(UIButton *)sender {
    _imageMainView.hidden = YES;
    _imageString = @"imageZero";
    
    [self.imageMainViewImage setImage:[[UIImage alloc]init]];
}
/*
- (IBAction)imgBtnOneClicked:(UIButton *)sender {
    //_imageMainView.hidden = NO;
    //[self.myScrollView setContentOffset:CGPointZero animated:YES];
    _imageString = @"imageOne";
    
    PFObject *thisPostImgOne = [userPosts objectAtIndex:0];
    PFFile *imgOne = [thisPostImgOne objectForKey:@"expPic"];
    UIImage *imageOnez = [UIImage imageWithData:imgOne.getData];
    
    [self displayImage:self.imageView1 withImage:imageOnez];
    
    //[self.imageMainViewImage setImageWithURL:imgOne.url placeholderImage:[UIImage imageNamed:@"placeholderimage.png"]];
    
}

- (IBAction)imgBtnTwoClicked:(UIButton *)sender {
    _imageMainView.hidden = NO;
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    _imageString = @"imageTwo";
    
    PFObject *thisPostImgOne = [userPosts objectAtIndex:1];
    PFFile *imgOne = [thisPostImgOne objectForKey:@"expPic"];
    
    [self.imageMainViewImage setImageWithURL:imgOne.url placeholderImage:[UIImage imageNamed:@"placeholderimage.png"]];
}

- (IBAction)imgBtnThreeClicked:(UIButton *)sender {
    _imageMainView.hidden = NO;
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    _imageString = @"imageThree";
    
    PFObject *thisPostImgOne = [userPosts objectAtIndex:2];
    PFFile *imgOne = [thisPostImgOne objectForKey:@"expPic"];
    
    [self.imageMainViewImage setImageWithURL:imgOne.url placeholderImage:[UIImage imageNamed:@"placeholderimage.png"]];
}

- (IBAction)imgBtnFourClicked:(UIButton *)sender {
    _imageMainView.hidden = NO;
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    _imageString = @"imageFour";
    
    PFObject *thisPostImgOne = [userPosts objectAtIndex:3];
    PFFile *imgOne = [thisPostImgOne objectForKey:@"expPic"];
    
    [self.imageMainViewImage setImageWithURL:imgOne.url placeholderImage:[UIImage imageNamed:@"placeholderimage.png"]];
}


- (IBAction)imgBtnFiveClicked:(UIButton *)sender {
    _imageMainView.hidden = NO;
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    _imageString = @"imageFive";
}
 */
- (IBAction)likeBtnClicked:(UIButton *)sender {
    self.unlikeBtn.hidden = NO;
    self.likeBtn.hidden = YES;
    self.unlikeBtn.enabled = NO;
    self.likeBtn.enabled = NO;
    
    PFObject *thisPost = nvcObject;
    
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
    PFObject *newObject = nvcObject;
    [object setObject:newObject forKey:@"post"];
    [object setObject:[PFUser currentUser] forKey:@"user"];
    [object setObject:[NSNumber numberWithBool:YES] forKey:@"checkLike"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        NSLog(@"Du gillar nu denna posten, registreringen har gått bra!");
        //[self retrieveLikeRelation];
        self.unlikeBtn.enabled = YES;
        self.likeBtn.enabled = YES;
    }];

    
}

- (IBAction)unlikeBtnClicked:(UIButton *)sender {
    self.unlikeBtn.hidden = YES;
    self.likeBtn.hidden = NO;
    self.unlikeBtn.enabled = NO;
    self.likeBtn.enabled = NO;
    
    PFObject *thisPost = nvcObject;
    
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
                    
                    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                        if(!error){
                            self.unlikeBtn.enabled = YES;
                            self.likeBtn.enabled = YES;
                        }
                    }];
                    
                }else{
                    // U dont like it
                }
            }}
    }];

    
}
@end
