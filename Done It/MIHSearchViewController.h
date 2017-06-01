//
//  MIHSearchViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "MIHSearchResultsCell.h"

@interface MIHSearchViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>{
    NSMutableArray *searchResults;
    NSArray *parseData;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end
