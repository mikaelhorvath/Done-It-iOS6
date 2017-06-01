//
//  MIHGalleryEditorViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2014-01-26.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import "MIHGalleryEditorViewController.h"
#import "MHFacebookImageViewer.h"
#import <QuartzCore/QuartzCore.h>

@interface MIHGalleryEditorViewController ()

@end

@implementation MIHGalleryEditorViewController

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
    [self.galleryMainView setBackgroundColor:[UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0]];

    
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
    
    [self retrieveFromParseThree];
    
    self.buttonString = @"buttonZero";
    self.imageOneReady = @"false";
    self.imageTwoReady = @"false";
    self.imageThreeReady = @"false";
    self.imageFourReady = @"false";
    self.imageFiveReady = @"false";
    
    // Design på imageViews
    _imageViewOne.layer.cornerRadius = _imageViewOne.frame.size.width/2;
    _imageViewOne.layer.masksToBounds = YES;
    _imageViewTwo.layer.cornerRadius = _imageViewTwo.frame.size.width/2;
    _imageViewTwo.layer.masksToBounds = YES;
    _imageViewThree.layer.cornerRadius = _imageViewThree.frame.size.width/2;
    _imageViewThree.layer.masksToBounds = YES;
    _imageViewFour.layer.cornerRadius = _imageViewFour.frame.size.width/2;
    _imageViewFour.layer.masksToBounds = YES;
    _imageViewFive.layer.cornerRadius = _imageViewFive.frame.size.width/2;
    _imageViewFive.layer.masksToBounds = YES;
    
    UIImage *imageOne = [UIImage imageNamed: @"doneItNavBarLogo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: imageOne];
    self.navigationItem.titleView = imageView;
    
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
    
	// Do any additional setup after loading the view.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doneIt{
    
    [PFObject deleteAllInBackground:imageArray block:^(BOOL succeeded, NSError *error){
       // Allt gick bra, bilderna är tömda, vi påbörjar uppladdning av nya bilder!
        if(!error){
        [self RegisterDuplicatePost];
        [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
 
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



-(void)retrieveFromParseThree{
    
    
    PFQuery *getImgs = [PFQuery queryWithClassName:@"userPostsPictures"];
    [getImgs orderByDescending:@"createdAt"];
    [getImgs whereKey:@"userposts" equalTo:_nvcObject];
    getImgs.cachePolicy = kPFCachePolicyNetworkElseCache;
    getImgs.limit = 5;
    
    [getImgs findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            
            if([objects count] > 0){
                self.currentLabel.hidden = NO;
            }
            
            imageArray = [[NSMutableArray alloc]initWithArray:objects];
            
            NSMutableArray *imageViews = [[NSMutableArray alloc] init];
            for(NSInteger i=0; i < objects.count; i++)
            {
                self.currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake((30 + (52 * i)), 365, 44, 44)];
                PFObject *imgFeed = [objects objectAtIndex:i];
                PFFile *theImage = [imgFeed objectForKey:@"expPic"];
                UIImage *realImage = [UIImage imageWithData:theImage.getData];
                self.currentImageView.layer.cornerRadius = self.currentImageView.frame.size.width/2;
                self.currentImageView.layer.masksToBounds = YES;
                [imageViews addObject:self.currentImageView];
                [self displayImage:self.currentImageView withImage:realImage];
                [self.view addSubview:self.currentImageView];
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


-(void)viewWillDisappear:(BOOL)animated{

 //[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//**** FOTO DELEGAT ****//

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


//***** VÅRA KNAPPAR *****//
- (IBAction)imageOne:(UIButton *)sender {
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

- (IBAction)imageTwo:(UIButton *)sender {
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

- (IBAction)imageThree:(UIButton *)sender {
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

- (IBAction)imageFour:(UIButton *)sender {
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

- (IBAction)imageFive:(UIButton *)sender {
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
- (IBAction)deleteAllObjectsClicked:(UIButton *)sender {
    [PFObject deleteAllInBackground:imageArray block:^(BOOL succeeded, NSError *error){
        if(!error){
            [self retrieveFromParseThree];
            NSLog(@"deleted!!!");
        }
    }];
}
@end
