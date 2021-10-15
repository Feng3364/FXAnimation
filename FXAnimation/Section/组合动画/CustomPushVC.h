//
//  CustomPushVC.h
//  FXAnimation
//
//  Created by Felix on 2021/8/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPush;

@end


@interface CustomPushVC : UIViewController

@property (nonatomic, strong) UIButton *btn;

@end


@interface CustomPopVC : UIViewController

@property (nonatomic, strong) UIButton *btn;

@end

NS_ASSUME_NONNULL_END
