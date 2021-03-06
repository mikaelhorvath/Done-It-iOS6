//
//  MIHuserDetFollowingViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-12-28.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface MIHuserDetFollowingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *followingArray;
}

@property (strong, nonatomic) PFObject *nvcObject;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
