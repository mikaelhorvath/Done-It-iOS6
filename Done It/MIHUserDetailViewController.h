//
//  MIHUserDetailViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-28.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MIHUserDetailCell.h"

@interface MIHUserDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSArray *userFeed;
    NSArray *trophyFeed;
    NSArray *friendCheck;
}
@property (weak, nonatomic) IBOutlet UIButton *greyAddBtn;
@property (weak, nonatomic) IBOutlet UILabel *followersLbl;
@property (weak, nonatomic) IBOutlet UILabel *followingLbl;

@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
- (IBAction)followUserClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *doneCount;
@property (strong, nonatomic) PFObject *nvcObject;
@property (weak, nonatomic) IBOutlet UILabel *usernameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *listCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *trophyCountLbl;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITableView *myTableViewTwo;

@property (weak, nonatomic) IBOutlet UIView *trophyHideView;
@property (weak, nonatomic) IBOutlet UIView *listHideView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *leftBtnOutlet;
- (IBAction)trophiesClicked:(UIButton *)sender;
- (IBAction)listClicked:(UIButton *)sender;



@end
