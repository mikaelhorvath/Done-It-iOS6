//
//  MIHDoneItCheckViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-11-14.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHDoneItCheckViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *statusBarView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) NSData *thefbimage;
@property (strong, nonatomic) NSData *theImage;
@property (strong, nonatomic) NSData *theImageTwo;
@property (strong, nonatomic) NSData *theImageThree;
@property (strong, nonatomic) NSData *theImageFour;
@property (strong, nonatomic) NSData *theImageFive;
@property (strong, nonatomic) NSData *originalPicture;
@property (strong, nonatomic) NSString *buttonString;

@property (strong, nonatomic) NSMutableDictionary *postParams;

// ImageSträngar för initiera uploads!
@property (strong, nonatomic) NSString *imageOneReady;
@property (strong, nonatomic) NSString *imageTwoReady;
@property (strong, nonatomic) NSString *imageThreeReady;
@property (strong, nonatomic) NSString *imageFourReady;
@property (strong, nonatomic) NSString *imageFiveReady;


// Knapparna
- (IBAction)pictureOne:(UIButton *)sender;
- (IBAction)pictureTwo:(UIButton *)sender;
- (IBAction)pictureThree:(UIButton *)sender;
- (IBAction)pictureFour:(UIButton *)sender;
- (IBAction)pictureFive:(UIButton *)sender;

//imageViewz
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFive;

// Labels
@property (weak, nonatomic) IBOutlet UILabel *CongratLbl;
@property (weak, nonatomic) IBOutlet UILabel *youveLbl;
@property (weak, nonatomic) IBOutlet UIView *didItView;
@property (weak, nonatomic) IBOutlet UIButton *fbShareBtnOutlet;
- (IBAction)fbShareBtnClicked:(UIButton *)sender;
- (IBAction)closeBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *fbDialogView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtnOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *fbImageView;
@property (weak, nonatomic) IBOutlet UIView *textViewArea;
@property (weak, nonatomic) IBOutlet UITextView *textMsg;



@end
