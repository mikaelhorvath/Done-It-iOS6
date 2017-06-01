//
//  MIHTrendingListsViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-10-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHTrendingListsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSArray *trendingFeed;
}
@property (weak, nonatomic) IBOutlet UIView *trendingView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *mainPicView;
@property (weak, nonatomic) IBOutlet UILabel *listNameLbl;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
