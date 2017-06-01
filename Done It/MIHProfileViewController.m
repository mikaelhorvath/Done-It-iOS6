//
//  MIHProfileViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-27.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHProfileViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MIHProfileCell.h"
#import "MIHProfileTwoCell.h"
#import "MIHProfDetailViewController.h"
#import "MIHFollowingViewController.h"
#import "MIHDoneItCheckViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface MIHProfileViewController ()

@end

@implementation MIHProfileViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.scrollString = @"list";
    
    //[self.myTableView reloadData];
    PFUser *meTheOne = [PFUser currentUser];
    NSNumber *trophyCount = [meTheOne objectForKey:@"trophyCheck"];
    NSNumber *doneCount = [meTheOne objectForKey:@"doneList"];
    [self.countTrophys setText:[NSString stringWithFormat:@"%@",trophyCount]];
    [self.doneCount setText:[NSString stringWithFormat:@"%@", doneCount]];
    
    //***** Achievement DO FIVE ITEMS ******//
    PFUser *thisNewUser = [PFUser currentUser];
    NSNumber *secondCheck = [thisNewUser objectForKey:@"secondCheck"];
    NSNumber *thirdCheck = [thisNewUser objectForKey:@"thirdCheck"];
    int doneCheck = [[thisNewUser objectForKey:@"doneList"]intValue];
    if(doneCheck == 5){
        
        if(secondCheck == [NSNumber numberWithBool:false]){
            
            
            PFObject *object = [PFObject objectWithClassName:@"Trophys"];
            
            UIImage *image = [UIImage imageNamed:@"image.png"];
            UIGraphicsBeginImageContext(CGSizeMake(250, 250));
            [image drawInRect: CGRectMake(0, 0, 250, 250)];
            UIGraphicsEndImageContext();
            // Upload image
            NSData *imageData = UIImagePNGRepresentation(image);
            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
            
            [object setObject:@"Done It!" forKey:@"activity"];
            [object setObject:@"Do five items!" forKey:@"description"];
            [object setObject:imageFile forKey:@"image"];
            [object setObject:thisNewUser forKey:@"user"];
            [object saveInBackground];
            [thisNewUser setObject:[NSNumber numberWithBool:YES] forKey:@"secondCheck"];
            int trophyCheck = [[thisNewUser objectForKey:@"trophyCheck"]intValue];
            trophyCheck++;
            [thisNewUser setObject:[NSNumber numberWithInt:trophyCheck] forKey:@"trophyCheck"];
            [thisNewUser saveInBackground];
        }
    }
    
  
    if(doneCheck == 20){
        
        if(thirdCheck == [NSNumber numberWithBool:false]){
            
            
            PFObject *object = [PFObject objectWithClassName:@"Trophys"];
            
            UIImage *image = [UIImage imageNamed:@"image.png"];
            UIGraphicsBeginImageContext(CGSizeMake(250, 250));
            [image drawInRect: CGRectMake(0, 0, 250, 250)];
            UIGraphicsEndImageContext();
            // Upload image
            NSData *imageData = UIImagePNGRepresentation(image);
            PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
            
            [object setObject:@"Twenty High!" forKey:@"activity"];
            [object setObject:@"Do twenty items!" forKey:@"description"];
            [object setObject:imageFile forKey:@"image"];
            [object setObject:thisNewUser forKey:@"user"];
            [object saveInBackground];
            [thisNewUser setObject:[NSNumber numberWithBool:YES] forKey:@"thirdCheck"];
            int trophyCheck = [[thisNewUser objectForKey:@"trophyCheck"]intValue];
            trophyCheck++;
            [thisNewUser setObject:[NSNumber numberWithInt:trophyCheck] forKey:@"trophyCheck"];
            [thisNewUser saveInBackground];
        }
    }
    
    //****** ACHIEVEMENT ENDING *******//

    
    
    // Hämta Profilbilden ifrån Parse.com
    [self.picView setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = _picView.frame;
    [_picView addSubview: snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        PFFile* image = [[PFUser currentUser] objectForKey:@"profilePicture"];
        UIImage* imgProfile = [UIImage imageWithData:image.getData];
        
        [self retrieveFromParse];
        [self retrieveFromParseTwo];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            
            
            
            [self.picView setImage:imgProfile];
            [snurra removeFromSuperview];
        });
    });
    
    /////////////////////////////////////

    
    
    /// RÄKNAR VÅR LISTA
    
    PFQuery *countCom = [PFQuery queryWithClassName:@"userPosts"];
    PFUser *theUser = [PFUser currentUser];
    [countCom whereKey:@"user" equalTo:theUser];
    countCom.cachePolicy = kPFCachePolicyNetworkElseCache;
    [countCom countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            [self.countList setText:[NSString stringWithFormat:@"%d", count]];
            
        } else {
            NSLog(@"couldnt count the list");
        }
    }];
    
    PFQuery *countFollowing = [PFQuery queryWithClassName:@"Friends"];
    PFUser *thisUsr = [PFUser currentUser];
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
    PFUser *thisUserr = [PFUser currentUser];
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
    
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        [self retrieveFromParse];
        [self retrieveFromParseTwo];
     
    });
*/

    
    
    _leftBtnOutlet.selected = YES;
    _rightBtnOutlet.selected = NO;
    
    _trophyHideView.hidden = YES;
    _listHideView.hidden = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
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
    //[self retrieveFromParseTwo];
    
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    
    
    self.myTableView.allowsSelectionDuringEditing = YES;
    self.myTableView.scrollEnabled = NO;
    
    //// ** Hidden Cheat Views
    
    _listHideView.backgroundColor = [UIColor clearColor];
    _trophyHideView.backgroundColor = [UIColor clearColor];
    
    //////
    
    _leftBtnOutlet.selected = !_leftBtnOutlet.selected;
    _rightBtnOutlet.selected = NO;
    
    _picView.layer.cornerRadius = self.picView.frame.size.width/2;
    _picView.layer.masksToBounds = YES;
    
    
    [[UINavigationBar appearance]setShadowImage:[UIImage imageNamed:@"whiteNavBar.png"]];
     self.navigationController.navigationBar.clipsToBounds = YES;

    
    
    PFUser *user = [[PFUser currentUser] objectForKey:@"username"];
    
    [self.userNameLbl setText:[NSString stringWithFormat:@"%@", user]];
 
    self.title = [NSString stringWithFormat:@"%@", user];
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"MY LIST", @"comment")];
    //[self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"green.png"]];
;
  
    //// SETTINGS BUTTON
    
    UIImage *buttonImageTwo = [UIImage imageNamed:@"settingsBtn.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(20, 0, 40, 29);
    buttonTwo.showsTouchWhenHighlighted = YES;
    
    [buttonTwo addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItemTwo = [[UIBarButtonItem alloc] initWithCustomView:buttonTwo];
    self.navigationItem.rightBarButtonItem = customBarItemTwo;
    
    
 
    

    
   
	// Do any additional setup after loading the view.
}

-(void)settings{
    [self performSegueWithIdentifier:@"showSettings" sender:self];

}

-(void)retrieveFromParse{
    
    
    PFQuery *getTips = [PFQuery queryWithClassName:@"userPosts"];
    [getTips orderByDescending:@"createdAt"];
    PFUser *anvandare = [PFUser currentUser];
    [getTips whereKey:@"user" equalTo:anvandare];
    [getTips includeKey:@"user"];
    getTips.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTips findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            userFeed = [[NSMutableArray alloc]initWithArray:objects];
            userFeedImages = [[NSMutableArray alloc]initWithArray:objects];
        }
        [self.myTableView reloadData];
        //if([self.scrollString isEqualToString:@"list"]){
        [self.myTableView setFrame:CGRectMake(0, 200, self.myTableView.frame.size.width, [objects count]*101)];
        [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, self.myTableView.frame.size.height + 199)];
        //}
    }];
}

-(void)retrieveFromParseTwo{
    
    
    PFQuery *getTrophy = [PFQuery queryWithClassName:@"Trophys"];
    [getTrophy orderByDescending:@"createdAt"];
    PFUser *anvandare = [PFUser currentUser];
    [getTrophy whereKey:@"user" equalTo:anvandare];
    getTrophy.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTrophy findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            trophyFeed = [[NSMutableArray alloc]initWithArray:objects];
            trophyFeedImages = [[NSMutableArray alloc]initWithArray:objects];
        }
        [self.myTableViewTwo reloadData];
      
    }];
}

/////////// ******* TABLEVIEW ******** /////////////

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _myTableView){
    return [userFeed count];
    }else if(tableView == _myTableViewTwo){
        return [trophyFeed count];
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"DoneIt!";
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/*
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView == self.myTableView){
       return UITableViewCellEditingStyleDelete;
    }else if(tableView == self.myTableViewTwo){
        return UITableViewCellEditingStyleNone;
    }
    return YES;
}


/// DONE IT SWIPE KNAPP
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showConfirmation" sender:self];
    
}
*/

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   
    if(tableView == _myTableView){
        static NSString *CellIdentifier = @"profileCell";
    MIHProfileCell *cell = (MIHProfileCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.doneImage.hidden = YES;
    cell.theImage.layer.cornerRadius = cell.theImage.frame.size.width/2;
    cell.theImage.layer.masksToBounds = YES;
    cell.sampleImage.layer.cornerRadius = cell.sampleImage.frame.size.width/2;
    cell.sampleImage.layer.masksToBounds = YES;
    cell.imageViewz.layer.cornerRadius = cell.imageViewz.frame.size.width/2;
    cell.imageViewz.layer.masksToBounds = YES;
    
        
    PFObject *tempObj = [userFeed objectAtIndex:indexPath.row];
    NSNumber *haveDoneIt = [tempObj objectForKey:@"DoneIt"];
    cell.activityLabel.text = [tempObj objectForKey:@"activity"];
    cell.descLabel.text = [tempObj objectForKey:@"description"];
        
        if(haveDoneIt == [NSNumber numberWithBool:YES]){
            // sätt checkmark på att objektet är klart!
            [cell.doneImage setHidden:NO];
        }
    PFFile *myImg = [tempObj objectForKey:@"image"];
    [cell.imageViewz setImageWithURL:myImg.url placeholderImage:[UIImage imageNamed:@"placeholdercircle.png"]];

    
    
    return cell;
    }else if(tableView == _myTableViewTwo){
         static NSString *CellIdentifier = @"profileCellTwo";
        MIHProfileTwoCell *cell = (MIHProfileTwoCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
      
        cell.imageViewzTwo.layer.cornerRadius = cell.imageViewzTwo.frame.size.width/2;
        cell.imageViewzTwo.layer.masksToBounds = YES;
        
        
        //PFObject *tempObj = [userFeed objectAtIndex:indexPath.row];
        //cell.activityLabel.text = [tempObj objectForKey:@"activity"];
        //cell.descLabel.text = [tempObj objectForKey:@"description"];
        
        PFObject *tempObjs = [trophyFeedImages objectAtIndex:indexPath.row];
         PFFile *myImg = [tempObjs objectForKey:@"image"];
        
        [cell.imageViewzTwo setImageWithURL:myImg.url placeholderImage:[UIImage imageNamed:@"placeholdercircle.png"]];
        cell.activityTwoLabel.text = [tempObjs objectForKey:@"activity"];
        cell.descTwoLabel.text = [tempObjs objectForKey:@"description"];
        
        
        
        
                return cell;
        
    }
    return nil;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"userFeedDetailz"]){
        
        MIHProfDetailViewController* nvc = (MIHProfDetailViewController*)[segue destinationViewController];
        
        
        PFObject *thisobject = [userFeed objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
        
        nvc.nvcObject = thisobject;
        nvc.bildString = [[thisobject objectForKey:@"user"] objectForKey:@"profilePicture"];
        
    }else if([segue.identifier isEqualToString:@"showFollowing"]){
        
        MIHFollowingViewController *nvc = (MIHFollowingViewController*)[segue destinationViewController];
        PFUser *user = [PFUser currentUser];
        nvc.nvcObject = user;
    
    }else if([segue.identifier isEqualToString:@"showConfirmation"]){
        
        MIHDoneItCheckViewController *nvc = (MIHDoneItCheckViewController*)[segue destinationViewController];
    
        PFObject *thisRow = [userFeed objectAtIndex:[self.myTableView indexPathForSelectedRow].row];
        nvc.nvcObject = thisRow;
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trophiesClicked:(UIButton *)sender {
    
    self.scrollString = @"trophy";
    
    [self.myScrollView setContentOffset:CGPointZero animated:YES];
    self.myScrollView.scrollEnabled = NO;
    
    self.myTableViewTwo.hidden = NO;
    self.myTableView.hidden = YES;
    
    _rightBtnOutlet.selected = !_rightBtnOutlet.selected;
    _leftBtnOutlet.selected = NO;
    
    _trophyHideView.hidden = NO;
    _listHideView.hidden = YES;

    
}

- (IBAction)listClicked:(UIButton *)sender {
    
    self.myScrollView.scrollEnabled = YES;
    
    self.scrollString = @"list";
    
    self.myTableViewTwo.hidden = YES;
    self.myTableView.hidden = NO;
    
    _leftBtnOutlet.selected = !_leftBtnOutlet.selected;
    _rightBtnOutlet.selected = NO;
    
    _trophyHideView.hidden = YES;
    _listHideView.hidden = NO;

    
}

-(void)viewWillDisappear:(BOOL)animated{
    _myTableViewTwo.hidden = YES;
    _myTableView.hidden = NO;
    self.myScrollView.scrollEnabled = YES;
}
- (IBAction)changeProfilePicClicked:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Change your picture!"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Take a picture", @"Choose from gallery",nil];
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        
        // image picker needs a delegate,
        [imagePickerController setDelegate:self];
        
        // Place image picker on the screen
        [self presentModalViewController:imagePickerController animated:YES];
        
        
    }else if(buttonIndex == 1){
        
        UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        // image picker needs a delegate so we can respond to its messages
        [imagePickerController setDelegate:self];
        imagePickerController.navigationBar.tintColor = [UIColor blackColor];
        
        // Place image picker on the screen
        [self presentModalViewController:imagePickerController animated:YES];
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize itemSize = CGSizeMake(640,640);
    UIGraphicsBeginImageContext(itemSize);
    
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.40f);
    [self uploadImage:imageData];
    
    /*
     UIGraphicsBeginImageContext(CGSizeMake(640, 640));
     [image drawInRect: CGRectMake(0, 0, 640, 640)];
     UIGraphicsEndImageContext();
     NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
     [self uploadImage:imageData];
     */
    
}


-(void)uploadImage:(NSData*)imageData{
    NSLog(@"Upload image startar");
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    //HUD creation here (see example for code)
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"sparade bild");
            // Hide old HUD, show completed HUD (see example for code)
            
            // Create a PFObject around a PFFile and associate it with the current user
            //PFObject *userPhoto = [PFObject objectWithClassName:@"User"];
            PFUser *user = [PFUser currentUser];
            [user setObject:imageFile forKey:@"profilePicture"];
            
            // Set the access control list to current user for security purposes
            //userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            
            //[userPhoto setObject:user forKey:@"user"];
            
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    // [self refresh:nil];
                    NSLog(@"Sparade användare med bild");
                    PFFile *imageFilez = [user objectForKey:@"profilePicture"];
                    UIImage *profImage = [UIImage imageWithData:imageFilez.getData];
                    [self.picView setImage:profImage];
                }
                else{
                    // Log details of the failure
                    NSLog(@"Sparade  INTE användare med bild");
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }else{
            NSLog(@"kunde inte spara bild");
        }
    }];
}

@end
