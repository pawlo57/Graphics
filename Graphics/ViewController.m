//
//  ViewController.m
//  Graphics
//
//  Created by pawel on 12.04.2013.
//  Copyright (c) 2013 Pawel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        _imageViewXcode1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xcode.png"]];
        _imageViewXcode2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xcode.png"]];
        
        [_imageViewXcode1 setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
        [_imageViewXcode2 setFrame:CGRectMake(220.0f, 350.0f, 100.0f, 100.0f)];
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_imageViewXcode1];
    [self.view addSubview:_imageViewXcode2];
}

- (void)startTopLeftImageViewAnimation {
    [self.imageViewXcode1 setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    
    [self.imageViewXcode1 setAlpha:1.0f];
    
    [UIView beginAnimations:@"imageViewXcode1Animation" context:(__bridge void*)_imageViewXcode1];
    
    [UIView setAnimationDuration:3.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    
    [self.imageViewXcode1 setFrame:CGRectMake(220.0f, 350.0f, 100.0f, 100.0f)];
    [self.imageViewXcode1 setAlpha:1.0f];
    self.imageViewXcode1.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    
    [UIView commitAnimations];
}

- (void)startBottomRightViewAnimationAfterDelay:(CGFloat)paramDelay {
    [self.imageViewXcode2 setFrame:CGRectMake(220.0f, 350.0f, 100.0f, 100.0f)];
    
    [self.imageViewXcode2 setAlpha:1.0f];
    
    [UIView beginAnimations:@"imageViewXcode2Animation" context:(__bridge void*)_imageViewXcode2];
    
    [UIView setAnimationDuration:3.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDelay:paramDelay];
    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    
    [self.imageViewXcode2 setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    [self.imageViewXcode2 setAlpha:0.0f];
    [self.imageViewXcode2 setTransform:CGAffineTransformMakeRotation(90.0f * M_PI/180)];
     //[self.imageViewXcode2 setTransform:CGAffineTransformMakeScale(0.001f, 0.001f)];
    
    [UIView commitAnimations];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startTopLeftImageViewAnimation];
    [self startBottomRightViewAnimationAfterDelay:2.0f];
}

- (void)imageViewDidStop:(NSString *)aniamtionID finished:(NSNumber *)finished context:(void *)context {
    UIImageView *contextImageView = (__bridge UIImageView *)context;
    [contextImageView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
