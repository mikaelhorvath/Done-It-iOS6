//
//  MIHViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHViewController ()

@end

@implementation MIHViewController

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
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        // Push the next view controller without animation
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    } else {
        // show the signup or login screen
    }
    
    /*
    [[UINavigationBar appearance]setShadowImage:[UIImage imageNamed:@"whiteNavBar.png"]];
    self.navigationController.navigationBar.clipsToBounds = YES;
    */
    _userView.layer.borderWidth = 1;
    _userView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _passView.layer.borderWidth = 1;
    _passView.layer.borderColor = [UIColor lightGrayColor].CGColor;
  
    
    _loginBtnOutlet.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];
    _facebookBtn.backgroundColor = [UIColor colorWithRed:0.0/255 green:113.0/255 blue:188.0/255 alpha:1.0];
    _mainView.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];
    
    /*
    _registerBtnOutlet.backgroundColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
     */

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];
    
    if([self.userNameTxt isFirstResponder]){
        [self.passWordTxt becomeFirstResponder];
    }else if([self.passWordTxt isFirstResponder]){
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(UIButton *)sender {
    [PFUser logInWithUsernameInBackground:_userNameTxt.text password:_passWordTxt.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self performSegueWithIdentifier:@"loggedIn" sender:self];
                                            
                                            
                                        } else {
                                            
                                            UIAlertView* loginAlert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Something went wrong, please try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                            [loginAlert show];
                                            
                                        }
                                    }];

}
- (IBAction)facebookBtnClicked:(UIButton *)sender {
    
    NSArray *permissionsArray = @[ @"user_about_me",@"publish_stream",@"publish_actions" ];
    
    
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self performSegueWithIdentifier:@"ChooseFBUsername" sender:self];
            
        } else {
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:@"loggedIn" sender:self];
            
        }
    }];

    
}
@end
