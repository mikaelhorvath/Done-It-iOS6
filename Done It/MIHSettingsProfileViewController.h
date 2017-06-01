//
//  MIHSettingsProfileViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-07-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MIHSettingsProfileViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIView *upperView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)takePhotoClicked:(UIButton *)sender;
- (IBAction)chooseFromGalleryClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
- (IBAction)logOutClicked:(UIButton *)sender;
- (IBAction)contactUsClicked:(UIButton *)sender;
- (IBAction)FBBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *fbArrow;
@property (weak, nonatomic) IBOutlet UIImageView *fbCheckmark;
@property (weak, nonatomic) IBOutlet UIView *fbDrawing;
@property (weak, nonatomic) IBOutlet UIButton *fbBtnOutlet;

@end
