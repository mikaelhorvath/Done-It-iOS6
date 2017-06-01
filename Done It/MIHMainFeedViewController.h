//
//  MIHMainFeedViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-09-19.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MIHFeedCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MIHMainFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *mainFeed;
    NSMutableArray *tableimages;
    NSMutableArray *allTheLikes;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (nonatomic, assign) int likeNumber;
- (IBAction)likeBtnPressed:(UIButton *)sender;
- (IBAction)unlikeBtnPressed:(UIButton *)sender;


@end
