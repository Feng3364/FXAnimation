//
//  MusicVC.h
//  FXAnimation
//
//  Created by Felix on 2021/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicVC : UIViewController

@end


@interface MusicAlbumView : UIView

@property (nonatomic, strong) UIImageView *album;

/// 开始动画
/// @param rate 动画时间系数
- (void)startAnimation:(CGFloat)rate;

/// 重置视图
- (void)resetView;

@end

NS_ASSUME_NONNULL_END
