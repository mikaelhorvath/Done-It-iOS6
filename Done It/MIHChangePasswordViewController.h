//
//  MIHChangePasswordViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-08-28.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHChangePasswordViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *fieldView;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
- (IBAction)changeBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *passField;

@end
