//
//  MIHRegisterViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-06-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHRegisterViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHRegisterViewController ()

@end

@implementation MIHRegisterViewController

CGFloat animatedDistance;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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


- (void)registerNewUser {
    
    // Laddar upp en bild på vår användare
    UIImage *image = [UIImage imageNamed:@"defaultprofilepic.png"];
    UIGraphicsBeginImageContext(CGSizeMake(250, 250));
    [image drawInRect: CGRectMake(0, 0, 250, 250)];
    UIGraphicsEndImageContext();
    // Upload image
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];

    
    
    
    PFUser *user = [PFUser user];
    user.username = _txtUsername.text;
    user.password = _txtPassword.text;
    user.email = _txtEmail.text;
    [user setObject:[NSNumber numberWithBool:YES] forKey:@"firsttrophy"];
    [user setObject:[NSNumber numberWithBool:NO] forKey:@"secondCheck"];
    [user setObject:[NSNumber numberWithInt:NO] forKey:@"thirdCheck"];
    [user setObject:[NSNumber numberWithInt:0] forKey:@"trophyCheck"];
    [user setObject:[NSNumber numberWithBool:YES] forKey:@"inspirationCheck"];
    [user setObject:[NSNumber numberWithInt:0] forKey:@"doneList"];
    [user setObject:[NSNumber numberWithInt:0] forKey:@"checkList"];
    [user setObject:_txtName.text forKey:@"name"];
    [user setObject:imageFile forKey:@"profilePicture"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {            
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertView *errorRegister = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Something went wrong, please try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [errorRegister show];
        }
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _navBarView.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];
   
    _userView.layer.borderWidth = 1;
    _userView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _passwordView.layer.borderWidth = 1;
    _passwordView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _emailView.layer.borderWidth = 1;
    _emailView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _nameView.layer.borderWidth = 1;
    _nameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //*** NAVIGATION TITLE****
    
    UIImage *image = [UIImage imageNamed: @"logoNavBar.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    self.navigationItem.titleView = imageView;
    
	
    _registerBtnOutlet.backgroundColor = [UIColor colorWithRed:122.0/255 green:203.0/255 blue:32.0/255 alpha:1.0];
    
    
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];
    
    if([self.txtUsername isFirstResponder]){
        [self.txtPassword becomeFirstResponder];
    }else if([self.txtPassword isFirstResponder]){
        [self.txtName becomeFirstResponder];
    }else if([self.txtName isFirstResponder]){
        [self.txtEmail becomeFirstResponder];
    }else if([self.txtEmail isFirstResponder]){
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)closeBtnClicked:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerClicked:(UIButton *)sender {
    [self registerNewUser];
}
- (IBAction)backButtonAction:(UIButton *)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
@end
