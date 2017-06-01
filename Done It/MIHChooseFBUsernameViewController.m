//
//  MIHChooseFBUsernameViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2014-01-23.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import "MIHChooseFBUsernameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface MIHChooseFBUsernameViewController ()

@end

@implementation MIHChooseFBUsernameViewController

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
    _fieldView.layer.borderWidth = 1;
    _fieldView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    _chooseBtn.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];
    _navBarView.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseUserNameClicked:(UIButton *)sender {
    
    // Laddar upp en bild på vår användare
    UIImage *image = [UIImage imageNamed:@"defaultprofilepic.png"];
    UIGraphicsBeginImageContext(CGSizeMake(250, 250));
    [image drawInRect: CGRectMake(0, 0, 250, 250)];
    UIGraphicsEndImageContext();
    // Upload image
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    
    
    PFUser* user = [PFUser currentUser];
    if(![self.usernameField.text isEqualToString:@""]){
        [user setUsername:self.usernameField.text];
        [user setObject:[NSNumber numberWithBool:YES] forKey:@"firsttrophy"];
        [user setObject:[NSNumber numberWithBool:NO] forKey:@"secondCheck"];
        [user setObject:[NSNumber numberWithInt:NO] forKey:@"thirdCheck"];
        [user setObject:[NSNumber numberWithInt:0] forKey:@"trophyCheck"];
        [user setObject:[NSNumber numberWithBool:YES] forKey:@"inspirationCheck"];
        [user setObject:[NSNumber numberWithInt:0] forKey:@"doneList"];
        [user setObject:[NSNumber numberWithInt:0] forKey:@"checkList"];
        [user setObject:imageFile forKey:@"profilePicture"];

        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //Detta händer när den är sparad eller det har gått fel.
            if (succeeded && !error) {
                //Gå vidare
                [self performSegueWithIdentifier:@"loggedIn" sender:self];
                
            }else{
                
                UIAlertView *alerttwo = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The chosen username is already taken, please try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alerttwo show];
            }
        }];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You must choose a username!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    

    
}
- (IBAction)backBtnClicked:(UIButton *)sender {
    
    PFUser *currentUser = [PFUser currentUser];
    [PFFacebookUtils unlinkUser:currentUser];
    
    [PFUser logOut];
       if(currentUser == nil){
           NSLog(@"Logged Out!");
       }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
