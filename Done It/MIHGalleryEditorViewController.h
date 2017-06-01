//
//  MIHGalleryEditorViewController.h
//  Done It
//
//  Created by Mikael Horvath on 2014-01-26.
//  Copyright (c) 2014 Mikael Horvath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MIHGalleryEditorViewController : UIViewController{
    NSArray *imageArray;
}

@property (weak, nonatomic) IBOutlet UIView *galleryMainView;
@property (strong, nonatomic) PFObject *nvcObject;
@property (strong, nonatomic) UIImageView *currentImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (strong, nonatomic) NSData *theImage;
@property (strong, nonatomic) NSData *theImageTwo;
@property (strong, nonatomic) NSData *theImageThree;
@property (strong, nonatomic) NSData *theImageFour;
@property (strong, nonatomic) NSData *theImageFive;

@property (strong, nonatomic) NSString *deleteString;

// imageViews and Buttons
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFive;
- (IBAction)imageOne:(UIButton *)sender;
- (IBAction)imageTwo:(UIButton *)sender;
- (IBAction)imageThree:(UIButton *)sender;
- (IBAction)imageFour:(UIButton *)sender;
- (IBAction)imageFive:(UIButton *)sender;

//Image Strings + button string
@property (strong, nonatomic) NSString *buttonString; // För att kolla vilken bild på knapp
@property (strong, nonatomic) NSString *imageOneReady;
@property (strong, nonatomic) NSString *imageTwoReady;
@property (strong, nonatomic) NSString *imageThreeReady;
@property (strong, nonatomic) NSString *imageFourReady;
@property (strong, nonatomic) NSString *imageFiveReady;


- (IBAction)deleteAllObjectsClicked:(UIButton *)sender;
@end
