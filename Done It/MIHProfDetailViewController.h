//
//  MIHProfDetailViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-09-24.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHProfDetailViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSArray *commentFeed;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIButton *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneBtnOutlet;

@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) PFFile *bildString;
- (IBAction)userLblClicked:(UIButton *)sender;
- (IBAction)deleteBtnClicked:(UIButton *)sender;
- (IBAction)doneitBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) UIImageView *currentImageView;

@property (weak, nonatomic) IBOutlet UILabel *doneItLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UIButton *editBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *doneItBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *editBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *countComment;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
- (IBAction)unlikeBtnClicked:(UIButton *)sender;
- (IBAction)likeBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *unlikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end
