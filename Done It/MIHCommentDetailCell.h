//
//  MIHCommentDetailCell.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-04.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHCommentDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deleteBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;

@end
