//
//  MIHFollowingViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-09-26.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHFollowingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *followingArray;
    NSMutableArray *followingArrayImages;
}

@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) PFFile *bildString;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activitySnurra;

@end
