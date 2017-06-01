//
//  MIHTrendTableViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-12-19.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHTrendTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *trendingTableFeed;
}

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) NSString *listString;
@property (weak, nonatomic) IBOutlet UILabel *headerLbl;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
