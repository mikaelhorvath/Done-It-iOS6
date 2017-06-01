//
//  MIHAddToListViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-07-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHAddToListViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextField *activityField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) NSData *theImage;
- (IBAction)addToListClicked:(UIButton *)sender;
- (IBAction)addPictureClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *pictureField;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *rutaBtnOutlet;
@property (strong, nonatomic) NSString *doneCheck;
- (IBAction)rutaBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *rutaKryssBtnOutlet;
- (IBAction)rutaKryssBtnClicked:(UIButton *)sender;
@property (strong, nonatomic) PFObject *thisObject;

@end
