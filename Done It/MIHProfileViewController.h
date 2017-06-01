//
//  MIHProfileViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-06-27.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>{
    NSMutableArray *userFeed;
    NSMutableArray *trophyFeed;
    NSMutableArray *userFeedImages;
    NSMutableArray *trophyFeedImages;
}

@property (strong, nonatomic) NSString *scrollString;
@property (weak, nonatomic) IBOutlet UILabel *doneCount;
@property (weak, nonatomic) IBOutlet UILabel *followingLbl;
@property (weak, nonatomic) IBOutlet UILabel *followersLbl;
@property (weak, nonatomic) IBOutlet UIButton *leftBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *rightBtnOutlet;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *countList;
@property (weak, nonatomic) IBOutlet UILabel *countTrophys;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
- (IBAction)trophiesClicked:(UIButton *)sender;
- (IBAction)listClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *trophyHideView;
@property (weak, nonatomic) IBOutlet UIView *listHideView;
@property (weak, nonatomic) IBOutlet UITableView *myTableViewTwo;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
- (IBAction)changeProfilePicClicked:(UIButton *)sender;

@end
