//
//  MIHInspSearchViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-12-16.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHInspSearchViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>{
    NSMutableArray *searchResults;
    NSArray *parseData;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
