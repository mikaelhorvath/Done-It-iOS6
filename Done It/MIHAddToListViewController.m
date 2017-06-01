//
//  MIHAddToListViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-07-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHAddToListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "MHFacebookImageViewer.h"
#import "MIHConfirmationAddToListViewController.h"
#import "MIHDoneItCheckViewController.h"

@interface MIHAddToListViewController ()

@end

@implementation MIHAddToListViewController

CGFloat animatedDistance;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _mainLabel.hidden = YES;
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.001 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _mainLabel.hidden = NO;
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([self.activityField isFirstResponder]){
        [self.descField becomeFirstResponder];
    }else if([self.descField isFirstResponder]){
        [textField resignFirstResponder];
    }
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doneCheck = @"false";
    
    _loadingView.layer.cornerRadius = 7;
    _loadingView.layer.masksToBounds = YES;
    
    [self displayImage:self.pictureField withImage:[UIImage imageNamed:@"defaultevent.png"]];
    
    _pictureField.layer.cornerRadius = _pictureField.frame.size.width/2;
    _pictureField.layer.masksToBounds = YES;
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.shadowImage = nil;
    
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    
    self.navigationItem.titleView = imageView;
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
    
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
    
    
    // Outlets
    
    _addBtnOutlet.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];    
    _activityView.layer.borderWidth = 1;
    _activityView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _descView.layer.borderWidth = 1;
    _descView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _photoView.layer.borderWidth = 1;
    _photoView.layer.borderColor = [UIColor lightGrayColor].CGColor;

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

// MODUL TILL IMAGEVIEWER!!
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}


- (IBAction)addPictureClicked:(UIButton *)sender {
    
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
    
    //[self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 640));
    [image drawInRect: CGRectMake(0, 0, 640, 640)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self displayImage:self.pictureField withImage:smallImage];
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.40f);
    _theImage = imageData;
}

- (IBAction)addToListClicked:(UIButton *)sender {
    
    _loadingView.hidden = NO;
    
    PFUser *thisUser = [PFUser currentUser];
    //////***** TROPHY LÄGG TILL 5 ITEMS *****/////
    int checklist = [[thisUser objectForKey:@"checkList"]intValue];
    checklist++;
    [thisUser setObject:[NSNumber numberWithInt:checklist] forKey:@"checkList"];
    [thisUser saveInBackground];
    
    if(checklist == 5){
        PFObject *object = [PFObject objectWithClassName:@"Trophys"];
        
        UIImage *image = [UIImage imageNamed:@"image.png"];
        UIGraphicsBeginImageContext(CGSizeMake(250, 250));
        [image drawInRect: CGRectMake(0, 0, 250, 250)];
        UIGraphicsEndImageContext();
        // Upload image
        NSData *imageData = UIImagePNGRepresentation(image);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
        [object setObject:@"High Five!" forKey:@"activity"];
        [object setObject:@"Add five items!" forKey:@"description"];
        [object setObject:imageFile forKey:@"image"];
        [object setObject:thisUser forKey:@"user"];
        [object saveInBackground];
        int trophyCheck = [[thisUser objectForKey:@"trophyCheck"]intValue];
        trophyCheck++;
        checklist++;
        [thisUser setObject:[NSNumber numberWithInt:trophyCheck] forKey:@"trophyCheck"];
        [thisUser setObject:[NSNumber numberWithInt:checklist] forKey:@"checkList"];
        [thisUser saveInBackground];
    }
    ////// ****** TROPHY SLUT ****** //////
 
    if(_theImage == nil){
        
        UIImage *image = [UIImage imageNamed:@"defaultevent.png"];
        UIGraphicsBeginImageContext(CGSizeMake(640, 640));
        [image drawInRect: CGRectMake(0, 0, 640, 640)];
        UIGraphicsEndImageContext();
        // Upload image
        NSData *imageData = UIImageJPEGRepresentation(image, 0.80f);
        _imageFile = [PFFile fileWithName:@"Image.png" data:imageData];
        
    }else{
        _imageFile = [PFFile fileWithName:@"Image.png" data:_theImage];
    }
    if([self.doneCheck isEqualToString:@"false"]){
    PFObject *object = [PFObject objectWithClassName:@"userPosts"];
    [object setObject:_activityField.text forKey:@"activity"];
    [object setObject:_descField.text forKey:@"description"];
    [object setObject:[NSDate date] forKey:@"newUpdate"];
    [object setObject:[NSNumber numberWithBool:NO] forKey:@"experience"];
    [object setObject:[NSNumber numberWithBool:NO] forKey:@"DoneIt"];
    [object setObject:[NSNumber numberWithInt:0] forKey:@"likes"];
    [object setObject:[NSNumber numberWithInt:0] forKey:@"counter"];
    [object setObject:_imageFile forKey:@"image"];
    [object setObject:thisUser forKey:@"user"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        _loadingView.hidden = YES;
        //NSLog(@"Posten har nu registrerats på servern!");
        NSLog(@"%@", object);
        NSLog(@"Posten har nu registrerats på servern!");
        [self performSegueWithIdentifier:@"showPostDetail" sender:self];
    }];
    }
    
    if([self.doneCheck isEqualToString:@"true"]){
        PFObject *object = [PFObject objectWithClassName:@"userPosts"];
        [object setObject:_activityField.text forKey:@"activity"];
        [object setObject:_descField.text forKey:@"description"];
        [object setObject:[NSDate date] forKey:@"newUpdate"];
        [object setObject:[NSNumber numberWithBool:NO] forKey:@"experience"];
        [object setObject:[NSNumber numberWithBool:NO] forKey:@"DoneIt"];
        [object setObject:[NSNumber numberWithInt:0] forKey:@"likes"];
        [object setObject:[NSNumber numberWithInt:0] forKey:@"counter"];
        [object setObject:_imageFile forKey:@"image"];
        [object setObject:thisUser forKey:@"user"];
        
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            _loadingView.hidden = YES;
            self.thisObject = object;
            [self performSegueWithIdentifier:@"addGalleryNow" sender:self];
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showPostDetail"]){
        
        MIHConfirmationAddToListViewController* nvc = (MIHConfirmationAddToListViewController*)[segue destinationViewController];
        
        NSString *activity = self.activityField.text;
        NSString *description = self.descField.text;
        nvc.activityString = activity;
        nvc.descString = description;
        nvc.imageFile = self.imageFile;
    }else if([segue.identifier isEqualToString:@"addGalleryNow"]){
        MIHDoneItCheckViewController *nvc = (MIHDoneItCheckViewController*)[segue destinationViewController];
        
        nvc.nvcObject = self.thisObject;
    }
}



- (IBAction)rutaBtnClicked:(UIButton *)sender {
    self.doneCheck = @"true";
    _rutaBtnOutlet.hidden = YES;
    _rutaKryssBtnOutlet.hidden = NO;
}
- (IBAction)rutaKryssBtnClicked:(UIButton *)sender {
    self.doneCheck = @"false";
    _rutaBtnOutlet.hidden = NO;
    _rutaKryssBtnOutlet.hidden = YES;
}
@end
