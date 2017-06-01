//
//  MIHWaterViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-21.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHWaterViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSArray *waterFeed;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
