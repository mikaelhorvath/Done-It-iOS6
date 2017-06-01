//
//  MIHuserDetailFollowersViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-12-29.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHuserDetailFollowersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSArray *followersArray;
}

@property (strong, nonatomic) PFObject *nvcObject;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
