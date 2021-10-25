//
//  LoginVC.h
//  FXAnimation
//
//  Created by Felix on 2021/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : UIViewController

@end


@interface AnimationButton : UIButton

@property (nonatomic, assign) CGFloat radius;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
