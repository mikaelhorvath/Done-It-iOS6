//
//  MIHRegisterViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-06-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHRegisterViewController : UIViewController <UITextFieldDelegate>

- (IBAction)closeBtnClicked:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)registerClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerBtnOutlet;
- (IBAction)backButtonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@end
