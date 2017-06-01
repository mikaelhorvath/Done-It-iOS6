//
//  MIHCommentsViewController.m
//  Done It
//
//  Created by Mikael Horvath on 2013-08-04.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHCommentsViewController.h"
#import "MIHCommentDetailCell.h"
#import <Parse/Parse.h>
#import "MIHUserDetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface MIHCommentsViewController ()

@end

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 55.0f

@implementation MIHCommentsViewController

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


-(void)textViewDidBeginEditing:(UITextView *)textView{
    _cancelBtn.hidden = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
       
        if([self.messageField.text isEqualToString:@""]){
            NSLog(@"No text to send!!");
            [textView resignFirstResponder];
        }else if([self.messageField.text isEqualToString:@"Secretcodebymikaelfredfilip2013authorsofthedoneitapp"]){
            UIAlertView *alertCG = [[UIAlertView alloc]initWithTitle:@"Case Group" message:@"Are the owner of this application and its Source Code, Case Group staff is Fred Paendi, Filip Heidfors and Mikael Horvath, this message is not visible until a Case Group staff member activates it with the secret code" delegate:self cancelButtonTitle:@"I Understand!" otherButtonTitles:nil];
            [alertCG show];
            [textView resignFirstResponder];
        }else{
            
            //[thisNewUser setObject:[NSNumber numberWithInt:doneCheck] forKey:@"doneList"];
            //[thisNewUser saveInBackground];
            PFObject *commentObj = _nvcObject;
            int doneCheck = [[commentObj objectForKey:@"counter"]intValue];
            doneCheck++;
            [commentObj setObject:[NSNumber numberWithInt:doneCheck] forKey:@"counter"];
            
            PFUser *thisUser = [PFUser currentUser];
            PFObject *newObj = [PFObject objectWithClassName:@"Comments"];
            [newObj setObject:self.messageField.text forKey:@"message"];
            [newObj setObject:_nvcObject forKey:@"post"];
            [newObj setObject:thisUser forKey:@"user"];
            [newObj saveInBackgroundWithBlock:^(BOOL succeed, NSError *error){
                [self retrieveFromParseTwo];
                [self.myTableView reloadData];
            }];
            self.messageField.text = @"";
            [textView resignFirstResponder];
            _cancelBtn.hidden = YES;
            return NO;
        }
        
    }
    
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    //[self retrieveFromParseTwo];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self retrieveFromParseTwo];
    
    
    _commentView.layer.borderWidth = 1;
    _commentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
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
    
   
    
    UIImage *buttonImageTwo = [UIImage imageNamed:@"refreshButton.png"];
    
    //create the button and assign the image
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonTwo setImage:buttonImageTwo forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    buttonTwo.frame = CGRectMake(20, 0, 36, 31);
    buttonTwo.showsTouchWhenHighlighted = YES;
    
    [buttonTwo addTarget:self action:@selector(refreshNow) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItemTwo = [[UIBarButtonItem alloc] initWithCustomView:buttonTwo];
    self.navigationItem.rightBarButtonItem = customBarItemTwo;

    
	// Do any additional setup after loading the view.
}

-(void)refreshNow{
    [self retrieveFromParseTwo];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)retrieveFromParseTwo{
    
    
    PFQuery *getTrophy = [PFQuery queryWithClassName:@"Comments"];
    [getTrophy orderByAscending:@"createdAt"];
    [getTrophy whereKey:@"post" equalTo:_nvcObject];
    [getTrophy includeKey:@"user"];
    [getTrophy includeKey:@"post"];
    getTrophy.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [getTrophy findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            commentFeed = [[NSMutableArray alloc]initWithArray:objects];
            if([objects count] > 0){
                [self.myTableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
            }
        }
        
        [self.myTableView reloadData];
    }];
}


/// TableView Stuff
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentFeed count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    PFObject *obj = [commentFeed objectAtIndex:[indexPath row]];
    NSString *text = [obj objectForKey:@"message"];
    NSString *textTwo = [[obj objectForKey:@"user"]objectForKey:@"username"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize sizeTwo = [textTwo sizeWithFont:[UIFont fontWithName:@"helvetica-bold" size:13.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height+sizeTwo.height, 44.0f);
    
    return height + 10;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"commentCell";
    
    MIHCommentDetailCell *cell = (MIHCommentDetailCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell addSubview:cell.deleteBtn];
    [cell.deleteBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteBtn setTag:9001];
    [cell addSubview:cell.profileBtn];
    
    
    cell.profilePic.layer.cornerRadius = cell.profilePic.frame.size.width/2;
    cell.profilePic.layer.masksToBounds = YES;
    
    
    
    PFObject *tempObj = [commentFeed objectAtIndex:indexPath.row];
    
    NSString *userNamez = [[tempObj objectForKey:@"user"] objectForKey:@"username"];
  
    PFObject *obj = [commentFeed objectAtIndex:[indexPath row]];
    NSString *text = [obj objectForKey:@"message"];
    NSString *textTwo = [[obj objectForKey:@"user"] objectForKey:@"username"];
    
    cell.messageLbl.numberOfLines = 0;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize sizeTwo = [textTwo sizeWithFont:[UIFont fontWithName:@"helvetica-bold" size:13.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (!cell.messageLbl)
        cell.messageLbl = (UILabel*)[cell viewWithTag:1];
    
    ///Fetstilt
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:\n\%@", userNamez, text]];
    NSRange selectedRange = NSMakeRange(0, userNamez.length); // 4 characters, starting at index 22
    
    [string beginEditing];
    
    [string addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"helvetica-bold" size:13.0]
                   range:selectedRange];
    
    [string endEditing];
 
    [cell.messageLbl setAttributedText:string];
    [cell.messageLbl setFrame:CGRectMake(CELL_CONTENT_MARGIN, 3, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height+sizeTwo.height, 44.0f))];
    
    ///////
    
    NSString *thisUser = [[PFUser currentUser] objectForKey:@"username"];
    if([userNamez isEqualToString:thisUser]){
        cell.deleteBtn.hidden = NO;
    }else{
        cell.deleteBtn.hidden = YES;
    }
    PFFile *profileImg = [[tempObj objectForKey:@"user"]objectForKey:@"profilePicture"];
    [cell.profilePic setImageWithURL:profileImg.url placeholderImage:[UIImage imageNamed:@"profileDude.png"]];
    
    
    
    
    return cell;
    
}

-(void)buttonPressed: (UIButton *)sender{
    //if(sender.tag == 9001){
        
        UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        NSLog(@"you are clicking on row: %@", indexPath);
    
        PFObject *object = [commentFeed objectAtIndex:indexPath.row];
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self retrieveFromParseTwo];
            [self.myTableView reloadData];
        }];
    
    PFObject *commentObj = _nvcObject;
    int doneCheck = [[commentObj objectForKey:@"counter"]intValue];
    doneCheck--;
    [commentObj setObject:[NSNumber numberWithInt:doneCheck] forKey:@"counter"];
  //  }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showUserDetailComment"]){
        
        MIHUserDetailViewController* nvc = (MIHUserDetailViewController*)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell *)[sender superview].superview;
        NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        PFObject *object = [commentFeed objectAtIndex:indexPath.row];

        PFObject *themObj = [object objectForKey:@"user"];
        nvc.nvcObject = themObj;
        
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelBtnClicked:(UIButton *)sender {
    [self.messageField resignFirstResponder];
    self.messageField.text = @"";
    _cancelBtn.hidden = YES;
}
@end
