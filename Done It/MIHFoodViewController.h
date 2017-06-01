//
//  MIHFoodViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-21.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHFoodViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSArray *foodFeed;
}

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
