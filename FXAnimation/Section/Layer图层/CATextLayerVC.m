//
//  CATextLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/10/12.
//

/*
 思路:
 1.CATextLayer替代UILabel
 */

#import "CATextLayerVC.h"

@interface CATextLayerVC ()

@end

@implementation CATextLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 200);
    textLayer.foregroundColor = UIColor.redColor.CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
    textLayer.contentsScale = UIScreen.mainScreen.scale;//适配retain屏
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"hello";
    textLayer.string = text;
    [self.view.layer addSublayer:textLayer];
}

@end
