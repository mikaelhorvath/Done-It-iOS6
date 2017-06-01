//
//  MIHShareOnFBViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2014-01-10.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import "MIHShareOnFBViewController.h"
#import "MHFacebookImageViewer.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

@interface MIHShareOnFBViewController ()

@end

@implementation MIHShareOnFBViewController

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
    
    _navBarView.backgroundColor = [UIColor colorWithRed:59.0/255 green:89.0/255 blue:152.0/255 alpha:1.0];
    _dialogView.layer.cornerRadius = 7;
    _dialogView.layer.masksToBounds = YES;
    _dialogView.layer.borderColor = [UIColor blackColor].CGColor;
    _dialogView.layer.borderWidth = 0.5;
    _mainImageView.layer.borderColor = [UIColor blackColor].CGColor;
    _mainImageView.layer.borderWidth = 0.5;
    _mainImageView.layer.cornerRadius = _mainImageView.frame.size.width/2;
    _mainImageView.layer.masksToBounds = YES;
    _loadingView.layer.cornerRadius = 7;
    _loadingView.layer.masksToBounds = YES;
    
    _sendBtnOutlet.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];

    if([self.fbString isEqualToString:@"false"]){
    UIImage *fbImage = [UIImage imageWithData:self.nvcData];
    [self displayImage:self.mainImageView withImage:fbImage];
    }else if([self.fbString isEqualToString:@"true"]){
        UIImage *theImg = [UIImage imageWithData:_fbFile.getData];
        [self displayImage:self.mainImageView withImage:theImg];
    }
    
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

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        
        if([self.messageView.text isEqualToString:@""]){
            
            [textView resignFirstResponder];
  
        }else{
            
            [textView resignFirstResponder];
  
            
            return NO;
        }
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

// MODUL TILL IMAGEVIEWER!!
- (void) displayImage:(UIImageView*)imageView withImage:(UIImage*)image  {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)publishNowClicked:(UIButton *)sender {
    _loadingView.hidden = NO;
    UIImage *thisImage;
    
    if([self.fbString isEqualToString:@"false"]){
        thisImage = [UIImage imageWithData:self.nvcData];
    }else if([self.fbString isEqualToString:@"true"]){
        thisImage = [UIImage imageWithData:_fbFile.getData];
    }
    
    NSString *textMsg = self.messageView.text;
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   thisImage,@"picture",[NSString stringWithFormat:@"%@", textMsg],@"name",@"http://www.doneit.com",@"link",
                                   nil];
    
    
    [FBRequestConnection startWithGraphPath:@"me/photos" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        NSString *alertText;
        if (!error) {
            _loadingView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"Your post has successfully been posted to Facebook" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        } else {
            alertText = [NSString stringWithFormat:
                         @"SuccessFully Posted: "];
        };
        
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
