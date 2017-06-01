//
//  MIHFeedBackViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-11-20.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface MIHFeedBackViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
@property (weak, nonatomic) IBOutlet UISwitch *theSwitch;

@end
