//
//  CustomTabBar.m
//  FXAnimation
//
//  Created by Felix on 2021/10/11.
//

#import "CustomTabBar.h"

#define ItemWH      65
#define TabBarItemHeight    49.0f
#define ScreenWidth UIScreen.mainScreen.bounds.size.width

@implementation CustomTabBar

- (instancetype)init{
    if (self = [super init]){
        [self initView];
    }
    return self;
}

- (void)initView {
    _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerBtn.adjustsImageWhenHighlighted = NO;
    [self addSubview:_centerBtn];
    self.backgroundColor = UIColor.yellowColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _centerBtn.frame = CGRectMake((ScreenWidth - ItemWH) / 2.0, (TabBarItemHeight - ItemWH) / 2.0, ItemWH, ItemWH);
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden) {
        return [super hitTest:point withEvent:event];
    } else {
        //转换坐标
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            //返回按钮
            return _centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}

@end
