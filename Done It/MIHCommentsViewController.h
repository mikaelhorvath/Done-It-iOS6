//
//  MIHCommentsViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-04.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHCommentsViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSArray *commentFeed;
}

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
@property (strong, nonatomic) PFObject *nvcObject;
- (IBAction)cancelBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;


@end
