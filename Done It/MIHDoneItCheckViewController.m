//
//  MIHDoneItCheckViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-11-14.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHDoneItCheckViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MIHAppDelegate.h"
#import "MHFacebookImageViewer.h"
#import "MIHShareOnFBViewController.h"

@interface MIHDoneItCheckViewController ()

@end

@implementation MIHDoneItCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    [self.statusBarView setBackgroundColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    [self.headerView setBackgroundColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    //0.93 är tidigare värdet.
    
    self.buttonString = @"buttonZero";
    
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
    
    
    _fbDialogView.layer.borderColor = [UIColor blackColor].CGColor;
    _fbDialogView.layer.borderWidth = 1.0;
    
    NSLog(@"%@", _nvcObject);
    // initierar vår knapp string
    
    self.buttonString = @"buttonZero";
    
    self.imageOneReady = @"false";
    self.imageTwoReady = @"false";
    self.imageThreeReady = @"false";
    self.imageFourReady = @"false";
    self.imageFiveReady = @"false";
    
    _textViewArea.layer.borderWidth = 1;
    _textViewArea.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIImage *imageOne = [UIImage imageNamed: @"doneItNavBarLogo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    self.navigationItem.titleView = imageView;
    
    //[[UINavigationBar appearance] setBarTintColor:[UIColor greenColor]];
    
    
    // Grafik till bilderna på knapparna!!!!
    self.imageViewOne.layer.cornerRadius = self.imageViewOne.frame.size.width/2;
    self.imageViewOne.layer.masksToBounds = YES;
    self.imageViewTwo.layer.cornerRadius = self.imageViewTwo.frame.size.width/2;
    self.imageViewTwo.layer.masksToBounds = YES;
    self.imageViewThree.layer.cornerRadius = self.imageViewThree.frame.size.width/2;
    self.imageViewThree.layer.masksToBounds = YES;
    self.imageViewFour.layer.cornerRadius = self.imageViewFour.frame.size.width/2;
    self.imageViewFour.layer.masksToBounds = YES;
    self.imageViewFive.layer.cornerRadius = self.imageViewFive.frame.size.width/2;
    self.imageViewFive.layer.masksToBounds = YES;

    //////
    UIImage *buttonImage = [UIImage imageNamed:@"backButtonWhite.png"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(5, 0, 40, 24);
    button.showsTouchWhenHighlighted = NO;
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
	// Do any additional setup after loading the view.
    
    // Höger knappen
    // doneWithWhiteBack.png
    UIImage *buttonImageTwo = [UIImage imageNamed:@"doneWhiteTransparent.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(20, 0, 40, 31);
    
    [buttonTwo addTarget:self action:@selector(doneIt) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItemTwo = [[UIBarButtonItem alloc] initWithCustomView:buttonTwo];
    self.navigationItem.rightBarButtonItem = customBarItemTwo;

    NSNumber *didCheck = [_nvcObject objectForKey:@"DoneIt"];
    if(didCheck == [NSNumber numberWithBool:YES]){
        [self.CongratLbl setText:@"You have"];
        [self.youveLbl setText:@"already done it!"];
        self.navigationItem.rightBarButtonItem = nil;
        _didItView.hidden = NO;
    }
    

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        
        if([self.textMsg.text isEqualToString:@""]){
           
            [textView resignFirstResponder];
            _textViewArea.hidden = YES;
        }else{
           
            self.textMsg.text = @"";
            [textView resignFirstResponder];
            _textViewArea.hidden = YES;

            return NO;
        }
    }
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doneIt{
    
    PFUser *thisNewUser = [PFUser currentUser];
    PFObject *tempObj = self.nvcObject;
    NSNumber *doneCheck = [tempObj objectForKey:@"DoneIt"];
    
    
    if(doneCheck == [NSNumber numberWithBool:NO]){
        [self RegisterDuplicatePost];
        
        [tempObj setObject:[NSNumber numberWithBool:YES] forKey:@"DoneIt"];
        [tempObj setObject:[NSDate date] forKey:@"newUpdate"];
        [tempObj saveInBackground];
        
        
        int doneCheck = [[thisNewUser objectForKey:@"doneList"]intValue];
        doneCheck++;
        [thisNewUser setObject:[NSNumber numberWithInt:doneCheck] forKey:@"doneList"];
        [thisNewUser saveInBackground];
    }else{
        // Ska aldrig få komma åt denna egentligen.
        NSLog(@"It's a bug and nothing happened!");
    }
    
  
    
    // ALLT ÄR KLART, VI LÄMNAR SIDAN
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

// Foto delegatet där vi lyssnar på färdiga bilder, kollar även vilken knapp vi klickar på!
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if([self.buttonString isEqualToString:@"buttonOne"]){
     
    self.buttonString = @"buttonZero";
    self.imageOneReady = @"true";
    [self dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //[self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 640));
    [image drawInRect: CGRectMake(0, 0, 640, 640)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.imageViewOne setImage:smallImage];
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.40f);
    _theImage = imageData;
        
        UIGraphicsBeginImageContext(CGSizeMake(1024, 1024));
        [image drawInRect: CGRectMake(0, 0, 1024, 1024)];
        UIImage *smallImagetwo = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // Upload image
        NSData *imageDatatwo = UIImagePNGRepresentation(smallImagetwo);
        _thefbimage = imageDatatwo;
        
    }else if([self.buttonString isEqualToString:@"buttonTwo"]){
        
        self.buttonString = @"buttonZero";
        self.imageTwoReady = @"true";
        [self dismissModalViewControllerAnimated:YES];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //[self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
        
        UIGraphicsBeginImageContext(CGSizeMake(640, 640));
        [image drawInRect: CGRectMake(0, 0, 640, 640)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.imageViewTwo setImage:smallImage];
        // Upload image
        //NSData *imageData = UIImagePNGRepresentation(smallImage);
        NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.40f);
        _theImageTwo = imageData;

    }else if([self.buttonString isEqualToString:@"buttonThree"]){
        
        self.buttonString = @"buttonZero";
        self.imageThreeReady = @"true";
        [self dismissModalViewControllerAnimated:YES];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
       // [self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
        
        UIGraphicsBeginImageContext(CGSizeMake(640, 640));
        [image drawInRect: CGRectMake(0, 0, 640, 640)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.imageViewThree setImage:smallImage];
        // Upload image
        //NSData *imageData = UIImagePNGRepresentation(smallImage);
        NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.40f);
        _theImageThree = imageData;
        
    }else if([self.buttonString isEqualToString:@"buttonFour"]){
        self.buttonString = @"buttonZero";
        self.imageFourReady = @"true";
        [self dismissModalViewControllerAnimated:YES];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // [self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
        
        UIGraphicsBeginImageContext(CGSizeMake(640, 640));
        [image drawInRect: CGRectMake(0, 0, 640, 640)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.imageViewFour setImage:smallImage];
        // Upload image
       // NSData *imageData = UIImagePNGRepresentation(smallImage);
        NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.40f);
        _theImageFour = imageData;
    }else if([self.buttonString isEqualToString:@"buttonFive"]){
        self.buttonString = @"buttonZero";
        self.imageFiveReady = @"true";
        [self dismissModalViewControllerAnimated:YES];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // [self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
        
        UIGraphicsBeginImageContext(CGSizeMake(640, 640));
        [image drawInRect: CGRectMake(0, 0, 640, 640)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.imageViewFive setImage:smallImage];
        // Upload image
        //NSData *imageData = UIImagePNGRepresentation(smallImage);
        NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.40f);
        _theImageFive = imageData;
    }
}



-(void)RegisterDuplicatePost{
    // Redigerar ursprungsposten med ny bild!
    
    
    PFFile *imageFile = [PFFile fileWithName:@"image.jpg" data:_theImage];
    PFFile *imageFileTwo = [PFFile fileWithName:@"image.jpg" data:_theImageTwo];
    PFFile *imageFileThree = [PFFile fileWithName:@"image.jpg" data:_theImageThree];
    PFFile *imageFileFour = [PFFile fileWithName:@"image.jpg" data:_theImageFour];
    PFFile *imageFileFive = [PFFile fileWithName:@"image.jpg" data:_theImageFive];
    
    if([self.imageOneReady isEqualToString:@"true"]){
    PFObject *object = _nvcObject;
    [object setObject:imageFile forKey:@"image"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        NSLog(@"Originalposten har uppdaterats med ny bild!");
    }];
    
    PFObject *secondObj = [PFObject objectWithClassName:@"userPostsPictures"];
    [secondObj setObject:imageFile forKey:@"expPic"];
    [secondObj setObject:_nvcObject forKey:@"userposts"];
    [secondObj saveInBackgroundWithBlock:^(BOOL succedeed, NSError *error){
        NSLog(@"Första bilden har laddats upp!");
    }];
    }
    if([self.imageTwoReady isEqualToString:@"true"]){
    PFObject *thirdObj = [PFObject objectWithClassName:@"userPostsPictures"];
    [thirdObj setObject:imageFileTwo forKey:@"expPic"];
    [thirdObj setObject:_nvcObject forKey:@"userposts"];
    [thirdObj saveInBackgroundWithBlock:^(BOOL succedeed, NSError *error){
        NSLog(@"Andra bilden har laddats upp!");
    }];
    }
    
    if([self.imageThreeReady isEqualToString:@"true"]){
    PFObject *fourthObj = [PFObject objectWithClassName:@"userPostsPictures"];
    [fourthObj setObject:imageFileThree forKey:@"expPic"];
    [fourthObj setObject:_nvcObject forKey:@"userposts"];
    [fourthObj saveInBackgroundWithBlock:^(BOOL succedeed, NSError *error){
        NSLog(@"Tredje bilden har laddats upp!");
    }];
    }
    if([self.imageFourReady isEqualToString:@"true"]){
    PFObject *fifthObj = [PFObject objectWithClassName:@"userPostsPictures"];
    [fifthObj setObject:imageFileFour forKey:@"expPic"];
    [fifthObj setObject:_nvcObject forKey:@"userposts"];
    [fifthObj saveInBackgroundWithBlock:^(BOOL succedeed, NSError *error){
        NSLog(@"Fjärde bilden har laddats upp!");
    }];
    }
    
    if([self.imageFiveReady isEqualToString:@"true"]){
    PFObject *sixthObj = [PFObject objectWithClassName:@"userPostsPictures"];
    [sixthObj setObject:imageFileFive forKey:@"expPic"];
    [sixthObj setObject:_nvcObject forKey:@"userposts"];
    [sixthObj saveInBackgroundWithBlock:^(BOOL succedeed, NSError *error){
        NSLog(@"Femte bilden har laddats upp!");
    }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    if([self.buttonString isEqualToString:@"buttonOne"]){
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    }else if([self.buttonString isEqualToString:@"buttonTwo"]){
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    }else if([self.buttonString isEqualToString:@"buttonThree"]){
         [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    }else if([self.buttonString isEqualToString:@"buttonFour"]){
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    }else if([self.buttonString isEqualToString:@"buttonFive"]){
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];
    }else if([self.buttonString isEqualToString:@"buttonZero"]){
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
}

- (IBAction)pictureOne:(UIButton *)sender {
    self.buttonString = @"buttonOne";
    NSLog(@"%@",self.buttonString);
    
    // Hämtar Kamerarullen
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
    
}

- (IBAction)pictureTwo:(UIButton *)sender {
    self.buttonString = @"buttonTwo";
    NSLog(@"%@",self.buttonString);
    
    // Hämtar Kamerarullen
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction)pictureThree:(UIButton *)sender {
    self.buttonString = @"buttonThree";
    NSLog(@"%@",self.buttonString);
    
    // Hämtar Kamerarullen
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction)pictureFour:(UIButton *)sender {
    self.buttonString = @"buttonFour";
    NSLog(@"%@",self.buttonString);
    
    // Hämtar Kamerarullen
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}

- (IBAction)pictureFive:(UIButton *)sender {
    self.buttonString = @"buttonFive";
    NSLog(@"%@",self.buttonString);
    
    // Hämtar Kamerarullen
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];   
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}

- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}


- (IBAction)fbShareBtnClicked:(UIButton *)sender {
    PFUser *user = [PFUser currentUser];
    NSString *userName = [user objectForKey:@"username"];
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",userName] message:@"is not connected to Facebook. To be able to share this post, you must connect to facebook! Go to MY LIST / Settings" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
    }else{
        
        if([self.imageOneReady isEqualToString:@"true"]){
            
            [self performSegueWithIdentifier:@"shareOnFacebook" sender:self];
            
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You have not selected the first image!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        
    }

    
    
    
    
}

// MODUL TILL IMAGEVIEWER!!
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}

- (IBAction)closeBtnClicked:(UIButton *)sender {
    _fbDialogView.hidden = YES;
    _closeBtnOutlet.hidden = YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"shareOnFacebook"]){
        
        MIHShareOnFBViewController *nvc = (MIHShareOnFBViewController*)[segue destinationViewController];
        
        nvc.nvcData = _thefbimage;
        nvc.fbString = @"false";
        
    }
}




@end
