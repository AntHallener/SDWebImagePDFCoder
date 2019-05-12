//
//  SDViewController.m
//  SDWebImagePDFCoder
//
//  Created by lizhuoli1126@126.com on 10/28/2018.
//  Copyright (c) 2018 lizhuoli1126@126.com. All rights reserved.
//

#import "SDViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImagePDFCoder/SDWebImagePDFCoder.h>

@interface SDViewController ()

@end

@implementation SDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    SDImagePDFCoder *PDFCoder = [SDImagePDFCoder sharedCoder];
    [[SDImageCodersManager sharedManager] addCoder:PDFCoder];
    NSURL *pdfURL = [NSURL URLWithString:@"https://raw.githubusercontent.com/icons8/flat-color-icons/master/pdf/about.pdf"];
    NSURL *pdfURL2 = [NSURL URLWithString:@"https://raw.githubusercontent.com/icons8/flat-color-icons/master/pdf/webcam.pdf"];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height / 2)];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = YES;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenSize.height / 2, screenSize.width, screenSize.height / 2)];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.clipsToBounds = YES;
    
    [self.view addSubview:imageView1];
    [self.view addSubview:imageView2];
    
    [imageView1 sd_setImageWithURL:pdfURL placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            NSLog(@"PDF load success");
            NSData *pdfData = [image sd_imageDataAsFormat:SDImageFormatPDF];
            NSAssert(pdfData.length > 0, @"PDF Data export failed");
        }
    }];
    [imageView2 sd_setImageWithURL:pdfURL2 placeholderImage:nil options:SDWebImageRetryFailed context:@{SDWebImageContextPDFImageSize : @(imageView2.bounds.size)} progress:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            NSLog(@"PDF load animation success");
            [UIView animateWithDuration:2 animations:^{
                imageView2.bounds = CGRectMake(0, 0, 2 * screenSize.width, screenSize.height);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:2 animations:^{
                    imageView2.bounds = CGRectMake(0, 0, screenSize.width, screenSize.height / 2);
                }];
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
