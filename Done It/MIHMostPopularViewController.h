//
//  MIHMostPopularViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-10-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHMostPopularViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *popularFeed;
}

@property (weak, nonatomic) IBOutlet UIView *popularView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;
@end
