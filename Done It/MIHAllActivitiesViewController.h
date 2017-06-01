//
//  MIHAllActivitiesViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-02.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHAllActivitiesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *listArray;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *allView;


@end
