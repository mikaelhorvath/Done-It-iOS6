//
//  MIHSearchResultsCell.h
//  Done It
//
//  Created by Mikael Horvath on 2013-11-14.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHSearchResultsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLbl;
@property (weak, nonatomic) IBOutlet UILabel *doneListLbl;
@property (weak, nonatomic) IBOutlet UILabel *trophyLbl;
@property (weak, nonatomic) IBOutlet UIImageView *feedImage;

@end
