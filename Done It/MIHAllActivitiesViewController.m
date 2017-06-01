//
//  MIHAllActivitiesViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-08-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHAllActivitiesViewController.h"
#import "MIHAllActivitiesCell.h"

@interface MIHAllActivitiesViewController ()

@end

@implementation MIHAllActivitiesViewController

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
    
    _allView.backgroundColor = [UIColor colorWithRed:139.0/255 green:197.0/255 blue:63.0/255 alpha:1.0];
    
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

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"extremeCat" sender:self];
    }else if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"foodCat" sender:self];
    }else if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"motorCat" sender:self];
    }else if(indexPath.row == 3){
        [self performSegueWithIdentifier:@"waterCat" sender:self];
    }else if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"airCat" sender:self];
    }else if(indexPath.row == 5){
        [self performSegueWithIdentifier:@"natureCat" sender:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    if(indexPath.row == 0){
        static NSString *CellIdentifier = @"myObject";
        
        MIHAllActivitiesCell *cell = (MIHAllActivitiesCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.categoryLbl.text = @"Extreme";
        
        UIImage* bild = [UIImage imageNamed:@"inspButtonOne.png"];
        cell.picView.image = bild;
        
        
        //[cell setNeedsDisplay];
        return cell;
        
    }else if(indexPath.row == 1){
        static NSString *CellIdentifier = @"myObject";
        
        MIHAllActivitiesCell *cell = (MIHAllActivitiesCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.categoryLbl.text = @"Food";
        
        UIImage* bild = [UIImage imageNamed:@"inspButtonTwo.png"];
        cell.picView.image = bild;
        
        
        //[cell setNeedsDisplay];
        return cell;

    }else if(indexPath.row == 2){
        static NSString *CellIdentifier = @"myObject";
        
        MIHAllActivitiesCell *cell = (MIHAllActivitiesCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.categoryLbl.text = @"Motor";
        
        UIImage* bild = [UIImage imageNamed:@"inspButtonThree.png"];
        cell.picView.image = bild;
        
        
        //[cell setNeedsDisplay];
        return cell;

    }else if(indexPath.row == 3){
        static NSString *CellIdentifier = @"myObject";
        
        MIHAllActivitiesCell *cell = (MIHAllActivitiesCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.categoryLbl.text = @"Water";
        
        UIImage* bild = [UIImage imageNamed:@"inspButtonFour.png"];
        cell.picView.image = bild;
        
        
        //[cell setNeedsDisplay];
        return cell;

    }else if(indexPath.row == 4){
        static NSString *CellIdentifier = @"myObject";
        
        MIHAllActivitiesCell *cell = (MIHAllActivitiesCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.categoryLbl.text = @"Air";
        
        UIImage* bild = [UIImage imageNamed:@"inspButtonFive.png"];
        cell.picView.image = bild;
        
        
        //[cell setNeedsDisplay];
        return cell;

    }else if(indexPath.row == 5){
        static NSString *CellIdentifier = @"myObject";
        
        MIHAllActivitiesCell *cell = (MIHAllActivitiesCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.categoryLbl.text = @"Nature";
        
        UIImage* bild = [UIImage imageNamed:@"inspButtonSix.png"];
        cell.picView.image = bild;
        
        
        //[cell setNeedsDisplay];
        return cell;

    }
   
}


@end
