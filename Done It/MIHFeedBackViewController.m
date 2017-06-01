//
//  MIHFeedBackViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-11-20.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHFeedBackViewController.h"

@interface MIHFeedBackViewController ()

@end

@implementation MIHFeedBackViewController

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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {

        
        if(_theSwitch.on){
            PFObject *newObj = [PFObject objectWithClassName:@"Feedback"];
            [newObj setObject:self.messageField.text forKey:@"message"];
            [newObj setObject:@"Anonymous user" forKey:@"user"];
            [newObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if(!error){
                    [textView resignFirstResponder];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank You" message:@"for your feedback, we will have a look as soon as possible!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }else{
            PFUser *thisUser = [PFUser currentUser];
            PFObject *newObj = [PFObject objectWithClassName:@"Feedback"];
            [newObj setObject:self.messageField.text forKey:@"message"];
            [newObj setObject:thisUser.username forKey:@"user"];
            [newObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if(!error){
                    [textView resignFirstResponder];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank You" message:@"for your feedback, we will have a look as soon as possible!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
        
        
        return NO;
        
    }
    
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Visar automatiskt tangentbordet!!
    
    [self.messageField becomeFirstResponder];
    
    
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

	//DESIGN
    
    _nameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _nameView.layer.borderWidth = 1;
    
    _messageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _messageView.layer.borderWidth = 1;
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
