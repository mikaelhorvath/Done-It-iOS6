//
//  MIHEditListViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-09-25.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHEditListViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
- (IBAction)addPicClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *activityField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
- (IBAction)addToListClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (strong, nonatomic) NSData *theImage;

@property (strong,nonatomic) NSString *imageCheck;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *galleryBtnOutlet;
@property (strong, nonatomic) NSString *imageFBCheck;

@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) PFFile *bildString;
- (IBAction)deleteBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *rutaKryssOutlet;
@property (weak, nonatomic) IBOutlet UIButton *rutaOutlet;
- (IBAction)rutaBtnClicked:(UIButton *)sender;
- (IBAction)rutaKryssBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIButton *fbSharebtn;
- (IBAction)fbShareBtnClicked:(UIButton *)sender;

@end
