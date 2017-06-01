//
//  MIHInspirationViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2013-06-27.
//  Copyright (c) 2013 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHInspirationViewController : UIViewController <UIScrollViewDelegate, UIPageViewControllerDelegate>{
    NSArray *imageFeed;
}

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageArray;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) UIImageView *imageView;

@end
