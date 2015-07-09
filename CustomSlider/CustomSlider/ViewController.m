//
//  ViewController.m
//  CustomSlider
//
//  Created by cuong minh on 7/2/15.
//  Copyright (c) 2015 Techmaster. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) UILabel* label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    [self.slider setMinimumValueImage:[UIImage imageNamed:@"MuteSpeaker.png"]];
    [self.slider setMaximumValueImage:[UIImage imageNamed:@"MaxSpeaker.png"]];
    
    //[self.slider setMaximumTrackImage:[UIImage imageNamed: @"maxtrack.png"] forState:UIControlStateNormal];
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 1, 10);
    UIImage* maxTrack = [[UIImage imageNamed: @"maxtrack.png"] resizableImageWithCapInsets:inset];
    
    [self.slider setMaximumTrackImage:maxTrack
                             forState:UIControlStateNormal];
    [self.slider setMinimumTrackImage:[UIImage imageNamed: @"mintrack.png"] forState:UIControlStateNormal]; 
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self.slider setValue: 0.0 animated:true];
    self.label = [UILabel new];
    self.label.backgroundColor = [UIColor whiteColor];
    [self.slider addSubview:self.label];
    [self moveLabel:self.slider.value];
}


- (IBAction)onValueChange:(id)sender {
    [self moveLabel: self.slider.value];

}
- (void) moveLabel: (float)sliderValue {
    CGRect labelPos = [self computeLabelPosition:self.slider.value];
    self.label.text = [NSString stringWithFormat:@"%1.1f", self.slider.value];
    self.label.frame = labelPos;
}

- (CGRect) computeLabelPosition: (float)sliderValue {
    CGRect sliderBound = self.slider.bounds;
    CGRect trackRect = [self.slider trackRectForBounds:sliderBound];
    CGRect thumbRect = [self.slider thumbRectForBounds:sliderBound
                                             trackRect:trackRect value:self.slider.value];
    NSLog(@"x= %3.0f, y=%3.0f, width= %3.0f, height =%3.0f", thumbRect.origin.x, thumbRect.origin.y, thumbRect.size.width, thumbRect.size.height);
    thumbRect.origin = CGPointMake(thumbRect.origin.x, -30);
    return thumbRect;

}

//- (CGPoint) getThumbPosition{
//    CGSize size = [UIScreen mainScreen].bounds.size ;
//    CGFloat screenWidth = size.width;
//    CGFloat screenHeight = size.height;
//    CGFloat ratio = self.slider.value / (self.slider.maximumValue - self.slider.minimumValue);
//    CGFloat currentThumbWidth = (screenWidth * ratio) / (self.slider.maximumValue - self.slider.minimumValue);
//    CGPoint labelPoint = CGPointMake(currentThumbWidth, screenHeight);
//    return labelPoint;
//}


@end
