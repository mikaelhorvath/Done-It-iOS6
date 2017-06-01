//
//  MIHMyListCell.h
//  Done It
//
//  Created by Mikael Horvath on 2013-11-14.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import "SWTableViewCell.h"
#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface MIHMyListCell : SWTableViewCell

typedef enum {
    kCellStateCenter,
    kCellStateLeft,
    kCellStateRight
} SWCellState;

@protocol SWTableViewCellDelegate <NSObject>

@optional
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index;
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index;
- (void)swippableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state;

@end

@interface SWTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *leftUtilityButtons;
@property (nonatomic, strong) NSArray *rightUtilityButtons;
@property (nonatomic) id <SWTableViewCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons;

- (void)setBackgroundColor:(UIColor *)backgroundColor;
- (void)hideUtilityButtonsAnimated:(BOOL)animated;

@end

@interface NSMutableArray (SWUtilityButtons)

- (void)sw_addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title;
- (void)sw_addUtilityButtonWithColor:(UIColor *)color icon:(UIImage *)icon;

@end

