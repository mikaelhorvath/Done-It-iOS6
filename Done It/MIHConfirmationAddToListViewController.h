//
//  MIHConfirmationAddToListViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2014-01-15.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHConfirmationAddToListViewController : UIViewController
@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) NSString *activityString;
@property (strong, nonatomic) NSString *descString;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicture;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;



@end
