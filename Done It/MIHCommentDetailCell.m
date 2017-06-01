//
//  MIHCommentDetailCell.m
//  Done It
//
//  Created by Mikael Horvath on 2013-08-04.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHCommentDetailCell.h"

@implementation MIHCommentDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteBtnClicked:(UIButton *)sender {
}
@end
