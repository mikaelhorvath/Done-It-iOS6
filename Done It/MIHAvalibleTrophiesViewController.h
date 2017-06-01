//
//  MIHAvalibleTrophiesViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-10-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHAvalibleTrophiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *trophyFeed;
}

@property (weak, nonatomic) IBOutlet UIView *trophyView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
