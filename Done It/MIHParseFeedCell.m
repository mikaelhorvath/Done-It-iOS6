//
//  MIHParseFeedCell.m
//  Done It
//
//  Created by Mikael Horvath on 2013-09-17.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "MIHParseFeedCell.h"

@implementation MIHParseFeedCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
/*
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
       
        _feedImage = [[PFImageView alloc]init];
       
        [self.contentView addSubview:_feedImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX ,0, 60, 60);
    _feedImage.frame = frame;
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
