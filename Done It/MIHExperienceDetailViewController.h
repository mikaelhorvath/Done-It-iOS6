//
//  MIHExperienceDetailViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-12-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHExperienceDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) PFFile *bildString;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (IBAction)addToListClicked:(UIButton *)sender;

@end
