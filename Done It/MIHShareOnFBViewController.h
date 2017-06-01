//
//  MIHShareOnFBViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2014-01-10.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHShareOnFBViewController : UIViewController <UITextViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSData *nvcData;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *dialogView;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtnOutlet;
@property (weak, nonatomic) IBOutlet UITextView *messageView;
- (IBAction)publishNowClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) PFFile *fbFile;
@property (strong, nonatomic) NSString *fbString;

@end
