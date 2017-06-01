//
//  MIHShowAllLikesViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2014-01-21.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHShowAllLikesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSArray *likeFeed;
}

@property (strong, nonatomic) PFObject *nvcObject;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
