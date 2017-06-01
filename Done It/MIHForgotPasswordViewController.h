//
//  MIHForgotPasswordViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2014-01-15.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHForgotPasswordViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtnOutlet;
- (IBAction)sendBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *fieldView;
- (IBAction)backBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIView *doneView;
@property (strong, nonatomic) NSTimer *timer;
- (IBAction)doneClicked:(UIButton *)sender;

@end
