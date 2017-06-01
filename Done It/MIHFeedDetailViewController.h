//
//  MIHFeedDetailViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-07-31.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHFeedDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *commentFeed;
    NSArray *userPosts;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *userAddedLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityLbl;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *sponsorBtn;
@property (weak, nonatomic) IBOutlet UILabel *sponsorBtnLbl;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCopyLbl;


@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) PFFile *bildString;
@property (strong, nonatomic) UIImageView *currentImageView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UILabel *countComment;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *userNameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImgTwo;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImgThree;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImgFour;
@property (weak, nonatomic) IBOutlet UIImageView *galleryImgFive;

@property (weak, nonatomic) IBOutlet UIView *imageMainView;
- (IBAction)doneBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageMainViewImage;

- (IBAction)imgBtnOneClicked:(UIButton *)sender;
- (IBAction)imgBtnTwoClicked:(UIButton *)sender;
- (IBAction)imgBtnThreeClicked:(UIButton *)sender;
- (IBAction)imgBtnFourClicked:(UIButton *)sender;
- (IBAction)imgBtnFiveClicked:(UIButton *)sender;
@property (strong, nonatomic) NSString *imageString;
- (IBAction)likeBtnClicked:(UIButton *)sender;
- (IBAction)unlikeBtnClicked:(UIButton *)sender;


// KNAPPARNA

@property (weak, nonatomic) IBOutlet UIButton *imgBtnOne;
@property (weak, nonatomic) IBOutlet UIButton *imgBtnTwo;
@property (weak, nonatomic) IBOutlet UIButton *imgBtnThree;
@property (weak, nonatomic) IBOutlet UIButton *imgBtnFour;
@property (weak, nonatomic) IBOutlet UIButton *unlikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *readMoreBtn;


@end
