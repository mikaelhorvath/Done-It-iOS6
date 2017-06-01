//
//  MIHViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-06-11.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passWordTxt;
@property (weak, nonatomic) IBOutlet UIView *passView;
@property (weak, nonatomic) IBOutlet UIView *userView;
- (IBAction)loginClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *registerBtnOutlet;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *facebookBtn;
- (IBAction)facebookBtnClicked:(UIButton *)sender;

@end
