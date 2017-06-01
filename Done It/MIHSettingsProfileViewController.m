//
//  MIHSettingsProfileViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-07-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHSettingsProfileViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MIHFirstTableCell.h"
#import "MIHSecondTableCell.h"
#import "MIHThirdTableCell.h"

@interface MIHSettingsProfileViewController ()

@end

@implementation MIHSettingsProfileViewController

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
    
    /// Kollar om vi är Facebook användare
    PFUser *user = [PFUser currentUser];
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        _fbArrow.hidden = YES;
        _fbCheckmark.hidden = YES;
        _fbDrawing.hidden = YES;
        [self.fbBtnOutlet setTitle:@"Connect to Facebook" forState:UIControlStateNormal];
    }else{
        _fbArrow.hidden = YES;
        _fbCheckmark.hidden = YES;
        _fbDrawing.hidden = YES;
        [self.fbBtnOutlet setTitle:@"Logout from Facebook" forState:UIControlStateNormal];
        
    }
    
    //*** UI STUFF ***//
   
    _upperView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _upperView.layer.borderWidth = 1;
    
   
    _midView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _midView.layer.borderWidth = 1;
    
    _logoutBtn.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];

    
    [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, 403)];
    
  
    
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.shadowImage = nil;
    
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    
    self.navigationItem.titleView = imageView;
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)takePhotoClicked:(UIButton *)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction)chooseFromGalleryClicked:(UIButton *)sender {
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
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


- (IBAction)logOutClicked:(UIButton *)sender {
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser == nil){
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)contactUsClicked:(UIButton *)sender {
   /*
    MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init]; [mailcontroller setMailComposeDelegate:self]; NSString *email =@"info@doneit.com"; NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil]; [mailcontroller setToRecipients:emailArray]; [mailcontroller setSubject:@"DoneIt App"];[[mailcontroller navigationBar] setTintColor:[UIColor blackColor]];[self presentViewController:mailcontroller animated:YES completion:nil];*/
}

- (IBAction)FBBtnClicked:(UIButton *)sender {
    PFUser *user = [PFUser currentUser];
    NSArray *permissionsArray = @[ @"user_about_me",@"publish_stream",@"publish_actions" ];
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUser:user permissions:permissionsArray block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Woohoo, user logged in with Facebook!");
                [self.fbBtnOutlet setTitle:@"Logout from Facebook" forState:UIControlStateNormal];
            }else if(error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification" message:@"You already have an account that is linked with your Facebook account!" delegate:self cancelButtonTitle:@"Okej" otherButtonTitles:nil];
                [alertView show];
            }
        }];
    }else if([PFFacebookUtils isLinkedWithUser:user]){
        [PFFacebookUtils unlinkUser:user];
        [self.fbBtnOutlet setTitle:@"Connect to Facebook" forState:UIControlStateNormal];
    }

}
/*
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{ [self dismissViewControllerAnimated:YES completion:nil];
    
}
*/
@end
