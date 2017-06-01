//
//  MIHUserDetailCell.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-28.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHUserDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIView *theImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewz;
@property (weak, nonatomic) IBOutlet UIImageView *sampleImage;
@property (weak, nonatomic) IBOutlet UIImageView *doneImage;

@end
