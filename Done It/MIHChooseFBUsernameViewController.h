//
//  MIHChooseFBUsernameViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2014-01-23.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHChooseFBUsernameViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *fieldView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
- (IBAction)chooseUserNameClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
- (IBAction)backBtnClicked:(UIButton *)sender;

@end
