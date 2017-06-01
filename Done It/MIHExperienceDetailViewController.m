//
//  MIHExperienceDetailViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-12-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHExperienceDetailViewController.h"

@interface MIHExperienceDetailViewController ()

@end

@implementation MIHExperienceDetailViewController

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
    
    self.descLabel.numberOfLines = 0;
    NSString *descString = [_nvcObject objectForKey:@"info"];
    [self.descLabel setText:[NSString stringWithFormat:@"%@", descString]];
    [self.descLabel sizeToFit];
    
    [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.frame.size.width, self.picView.frame.size.height+self.titleLabel.frame.size.height+self.descLabel.frame.size.height+50)];
    
    NSLog(@"%@",_nvcObject);
    
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
    
    [self.picView setImage:nil];
    
    UIActivityIndicatorView* snurra = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    snurra.frame = _picView.frame;
    [_picView addSubview: snurra];
    [snurra startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Här gör man det som tar tid, tex ladda ner data.
        //Man får INTE ändra UI:t här
        
        PFFile* image = [_nvcObject objectForKey:@"image"];
        UIImage* imgProfile = [UIImage imageWithData:image.getData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Här ändrar man saker i UI
            
            
            
            [self.picView setImage:imgProfile];
            [snurra removeFromSuperview];
        });
    });
    
    _titleLabel.text = [_nvcObject objectForKey:@"name"];
    _descLabel.text = [_nvcObject objectForKey:@"info"];

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToListClicked:(UIButton *)sender {
    
    PFFile *imageFile = [_nvcObject objectForKey:@"image"];
    PFUser *thisUser = [PFUser currentUser];
    
    PFObject *object = [PFObject objectWithClassName:@"userPosts"];
    [object setObject:[_nvcObject objectForKey:@"name"] forKey:@"activity"];
    [object setObject:[_nvcObject objectForKey:@"description"] forKey:@"description"];
    [object setObject:[NSDate date] forKey:@"newUpdate"];
    [object setObject:[NSNumber numberWithBool:YES] forKey:@"experience"];
    [object setObject:[NSNumber numberWithBool:NO] forKey:@"DoneIt"];
    [object setObject:[NSNumber numberWithInt:0] forKey:@"likes"];
    [object setObject:[NSNumber numberWithInt:0] forKey:@"counter"];
    [object setObject:imageFile forKey:@"image"];
    [object setObject:thisUser forKey:@"user"];
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
       
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[_nvcObject objectForKey:@"name"] message:@"has been added to your list!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }];
    
    NSNumber *inspCheck = [thisUser objectForKey:@"inspirationCheck"];
    
    if(inspCheck == [NSNumber numberWithBool:YES]){
        //ladda upp trophy här samt sätt inspCheck till False!
        PFObject *object = [PFObject objectWithClassName:@"Trophys"];
        
        UIImage *image = [UIImage imageNamed:@"image.png"];
        UIGraphicsBeginImageContext(CGSizeMake(250, 250));
        [image drawInRect: CGRectMake(0, 0, 250, 250)];
        UIGraphicsEndImageContext();
        // Upload image
        NSData *imageData = UIImagePNGRepresentation(image);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
        [object setObject:@"I'm Inspired!" forKey:@"activity"];
        [object setObject:@"Add one inspiration!" forKey:@"description"];
        [object setObject:imageFile forKey:@"image"];
        [object setObject:thisUser forKey:@"user"];
        [object saveInBackground];
        [thisUser setObject:[NSNumber numberWithBool:NO] forKey:@"inspirationCheck"];
        int trophyCheck = [[thisUser objectForKey:@"trophyCheck"]intValue];
        trophyCheck++;
        [thisUser setObject:[NSNumber numberWithInt:trophyCheck] forKey:@"trophyCheck"];
        [thisUser saveInBackground];
    }
    
    PFObject *experienceObj = _nvcObject;
    int popularIncr = [[experienceObj objectForKey:@"popularity"]intValue];
    popularIncr++;
    [experienceObj setObject:[NSNumber numberWithInt:popularIncr] forKey:@"popularity"];
    [experienceObj saveInBackground];

}
@end
