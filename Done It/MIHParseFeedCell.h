//
//  MIHParseFeedCell.h
//  Done It
//
//  Created by Mikael Horvath on 2013-09-17.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <Parse/Parse.h>

@interface MIHParseFeedCell : PFTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *countCommentLbl;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *feedImage;

@property (weak, nonatomic) IBOutlet UIImageView *sampleImage;

@end
