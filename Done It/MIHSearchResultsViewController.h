//
//  MIHSearchResultsViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-11-07.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHSearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *friendCheck;
    NSArray *userFeed;
    NSArray *trophyFeed;
}
@property (strong, nonatomic) PFObject *nvcObject;
@property (weak, nonatomic) IBOutlet UIButton *rightBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *leftBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *trophyView;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *trophyCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *listCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *doneCount;
@property (weak, nonatomic) IBOutlet UILabel *followersLbl;
@property (weak, nonatomic) IBOutlet UILabel *followingLbl;
@property (weak, nonatomic) IBOutlet UIButton *greyAddBtn;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
- (IBAction)trophysBtnClicked:(UIButton *)sender;
- (IBAction)listBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableViewTwo;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)followBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end
