//
//  MIHExtremeCatViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-14.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHExtremeCatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>{
    NSArray *extremeFeed;
}

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
