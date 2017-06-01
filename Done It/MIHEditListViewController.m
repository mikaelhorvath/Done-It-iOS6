//
//  MIHEditListViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-09-25.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHEditListViewController.h"
#import "MHFacebookImageViewer.h"
#import "MIHGalleryEditorViewController.h"
#import "MIHShareOnFBViewController.h"

@interface MIHEditListViewController ()

@end

@implementation MIHEditListViewController

CGFloat animatedDistance;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
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

-(void)viewWillAppear:(BOOL)animated{
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


-(void)viewDidAppear:(BOOL)animated{
    [self.mainImage setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = self.mainImage.bounds;
    [snurra setColor:[UIColor blackColor]];
    [self.mainImage addSubview:snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        PFFile *imageData = _bildString;
        UIImage *theImage = [UIImage imageWithData:imageData.getData];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            [snurra removeFromSuperview];
            [self.mainImage setImage:theImage];
        });
    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber *doneIt = [_nvcObject objectForKey:@"DoneIt"];
    if([doneIt isEqual:[NSNumber numberWithBool:YES]]){
        [self.rutaKryssOutlet setHidden:NO];
        [self.rutaOutlet setHidden:YES];
        [self.galleryBtnOutlet setHidden:NO];
        
        [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width,420)];
        [self.fbSharebtn setFrame:CGRectMake(self.fbSharebtn.frame.origin.x, 350, self.fbSharebtn.frame.size.width, self.fbSharebtn.frame.size.height)];
        
    }else{
        //
        [self.galleryBtnOutlet setHidden:YES];
        
        [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width,400)];
        [self.fbSharebtn setFrame:CGRectMake(self.fbSharebtn.frame.origin.x, 333, self.fbSharebtn.frame.size.width, self.fbSharebtn.frame.size.height)];
        
    }
    
    self.imageCheck = @"false";
    self.imageFBCheck = @"false";
    
    _activityField.text = [_nvcObject objectForKey:@"activity"];
    _descField.text = [_nvcObject objectForKey:@"description"];
    
    UIImage *imageOne = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    
    self.navigationItem.titleView = imageView;
    
    UIImage *image = [UIImage imageNamed: @"tabBarGrey.png"];
    
    [self.tabBarController.tabBar setBackgroundImage:image];
    
    PFFile *thisFile = self.bildString;
    UIImage *previewImage = [UIImage imageWithData:thisFile.getData];
    [self displayImage:self.imagePreview withImage:previewImage];
    
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
    
    //Höger knappen
    UIImage *buttonImageTwo = [UIImage imageNamed:@"doneG.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(20, 0, 42, 31);
    
    [buttonTwo addTarget:self action:@selector(doneIt) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItemTwo = [[UIBarButtonItem alloc] initWithCustomView:buttonTwo];
    self.navigationItem.rightBarButtonItem = customBarItemTwo;

    
    
    // Outlets
    
    _addBtn.backgroundColor = [UIColor colorWithRed:41.0/255 green:171.0/255 blue:226.0/255 alpha:1.0];
    
    _loadingView.layer.cornerRadius = 7;
    _loadingView.layer.masksToBounds = YES;
    
    _activityView.layer.borderWidth = 1;
    _activityView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _descView.layer.borderWidth = 1;
    _descView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _imagePreview.layer.borderWidth = 0.5;
    _imagePreview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _imagePreview.layer.cornerRadius = _imagePreview.frame.size.height/2;
    _imagePreview.layer.masksToBounds = YES;
    
	// Do any additional setup after loading the view.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}

-(void)doneIt{
    
    PFUser *thisUser = [PFUser currentUser];
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:_theImage];
    
    if([self.imageCheck isEqualToString:@"false"]){
        
        PFObject *object = _nvcObject;
        [object setObject:_activityField.text forKey:@"activity"];
        [object setObject:_descField.text forKey:@"description"];
        [object setObject:[NSDate date] forKey:@"newUpdate"];
        [object setObject:thisUser forKey:@"user"];
        
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            NSLog(@"Posten har nu registrerats på servern!");
        }];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    if([self.imageCheck isEqualToString:@"true"]){
        
        PFObject *object = _nvcObject;
        [object setObject:_activityField.text forKey:@"activity"];
        [object setObject:_descField.text forKey:@"description"];
        [object setObject:[NSDate date] forKey:@"newUpdate"];
        [object setObject:imageFile forKey:@"image"];
        [object setObject:thisUser forKey:@"user"];
        
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            NSLog(@"Posten har nu registrerats på servern!");
        }];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPicClicked:(UIButton *)sender {
    
    UIImagePickerController *imagePickerController= [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    imagePickerController.navigationBar.tintColor = [UIColor blackColor];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePickerController setDelegate:self];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    
    self.imageCheck = @"true";
    self.imageFBCheck = @"true";
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //[self.imageLayer setImage:image];    // "myImageView" name of any UImageView.
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 640));
    [image drawInRect: CGRectMake(0, 0, 640, 640)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.mainImage setImage:smallImage];
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.08f);
    [self displayImage:self.imagePreview withImage:smallImage];
    _theImage = imageData;
}

- (IBAction)deleteBtnClicked:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[_nvcObject objectForKey:@"activity"] message:@"You are about to delete this post, do you want to continue?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        
        NSNumber *checkExp = [_nvcObject objectForKey:@"experience"];
        
        if(checkExp == [NSNumber numberWithBool:YES]){
            
            PFQuery *getLike = [PFQuery queryWithClassName:@"Experiences"];
            [getLike whereKey:@"name" containsString:[_nvcObject objectForKey:@"activity"]];
            [getLike findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                if(!error){
                    
                    PFObject *thisObj = [objects objectAtIndex:0];
                    int decreaseNow = [[thisObj objectForKey:@"popularity"]intValue];
                    decreaseNow--;
                    [thisObj setObject:[NSNumber numberWithInt:decreaseNow] forKey:@"popularity"];
                    [thisObj saveInBackground];
                    
                }
                
            }];
            
        }
        
        _loadingView.hidden = NO;
        PFObject *object = self.nvcObject;
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            _loadingView.hidden = YES;
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"editGallery"]){
        
        MIHGalleryEditorViewController* nvc = (MIHGalleryEditorViewController*)[segue destinationViewController];
        
        nvc.nvcObject = _nvcObject;
       
        
    }else if([segue.identifier isEqualToString:@"shareOnFacebook"]){
        MIHShareOnFBViewController *nvc = (MIHShareOnFBViewController*)[segue destinationViewController];
        if([self.imageFBCheck isEqualToString:@"false"]){
            nvc.fbString = @"true";
            nvc.fbFile = self.bildString;
        }else if([self.imageFBCheck isEqualToString:@"true"]){
            nvc.fbString = @"false";
            nvc.nvcData = _theImage;
        }
        
    }
}

/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 if([segue.identifier isEqualToString:@"shareOnFacebook"]){
 
 MIHShareOnFBViewController *nvc = (MIHShareOnFBViewController*)[segue destinationViewController];
 
 nvc.nvcData = _thefbimage;
 
 }
 }

 */


- (IBAction)rutaBtnClicked:(UIButton *)sender {
    _rutaOutlet.hidden = YES;
    _rutaKryssOutlet.hidden = NO;
    
    PFObject *thisObj = self.nvcObject;
    [thisObj setObject:[NSNumber numberWithBool:YES] forKey:@"DoneIt"];
    [thisObj saveInBackground];
    
    PFUser *thisNewUser = [PFUser currentUser];
    int doneCheck = [[thisNewUser objectForKey:@"doneList"]intValue];
    doneCheck++;
    [thisNewUser setObject:[NSNumber numberWithInt:doneCheck] forKey:@"doneList"];
    [thisNewUser saveInBackground];
}

- (IBAction)rutaKryssBtnClicked:(UIButton *)sender {
    _rutaOutlet.hidden = NO;
    _rutaKryssOutlet.hidden = YES;
    PFObject *thisObj = self.nvcObject;
    [thisObj setObject:[NSNumber numberWithBool:NO] forKey:@"DoneIt"];
    [thisObj saveInBackground];
    
    PFUser *thisNewUser = [PFUser currentUser];
    int doneCheck = [[thisNewUser objectForKey:@"doneList"]intValue];
    doneCheck--;
    [thisNewUser setObject:[NSNumber numberWithInt:doneCheck] forKey:@"doneList"];
    [thisNewUser saveInBackground];
}
- (IBAction)fbShareBtnClicked:(UIButton *)sender {
    
    // Passing this object to Facebook share page!
    
    PFUser *user = [PFUser currentUser];
    NSString *userName = [user objectForKey:@"username"];
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@",userName] message:@"is not connected to Facebook. To be able to share this post, you must connect to facebook! Go to MY LIST / Settings" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
    }else{
        
        
            
            [self performSegueWithIdentifier:@"shareOnFacebook" sender:self];
            
    
        
    }

    
}
@end
