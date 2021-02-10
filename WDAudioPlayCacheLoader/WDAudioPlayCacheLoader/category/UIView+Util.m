//
//  UIView+Util.m
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/6.
//

#import "UIView+Util.h"

@implementation UIView (Util)

+ (CGFloat)heightWith6Height:(CGFloat)h{
    if (SHEIGHT == 667 || SHEIGHT == 736 || SHEIGHT == 812 || SHEIGHT == 896) { // 6,6p,x,max
        return h;
    }else{
        return h * (SHEIGHT / 667);
    }
}

+ (CGFloat)widthWith6Width:(CGFloat)w{
    if (SWIDTH == 375 || SWIDTH == 414) {
        return w;
    }else{
        return  w * (SHEIGHT / 667);
    }
}

+ (CGFloat)autoWidth:(CGFloat)w{
    if (SWIDTH > SHEIGHT) { // 横屏
        if (SHEIGHT >= 375) {
            return (w/375)*SHEIGHT;
        }else{
            return  w * (SWIDTH / 667);
        }
    }else{
        if (SWIDTH >= 375) {
            return (w/375)*SWIDTH;
        }else{
            return  w * (SHEIGHT / 667);
        }
    }
}
+ (CGFloat)caculateFrameValueWith6Size:(CGFloat)value{
    if (SWIDTH == 375) {
        return value;
    }
    else{
        return value * (SWIDTH / 375);
    }
}
+ (CGFloat)autoAllNewWidth:(CGFloat)w{
    
    return SWIDTH * w /375;
}
+ (CGFloat)autoAllNewHeight:(CGFloat)h{
    
    return SHEIGHT *h /667;
}
//为了iPad
+ (CGFloat)autoAllWideAndHighContrast:(CGFloat)w{
    return YXAllNewLW(w) > YXAllNewLH(w) ? YXAllNewLH(w):YXAllNewLW(w);
}
//
//- (void)addBlurEffectWithColor:(UIColor *)color alpha:(CGFloat)alpha{
//    if (YXSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//        [self insertSubview:effectView atIndex:0];
//        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self);
//        }];
//    }else{
//        UITabBar *toolbar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.5, self.frame.size.height*0.5)];
//        toolbar.barStyle = UIBarStyleDefault;
//        if (color) {
//            [toolbar setBarTintColor:color];
//        }
//        [self insertSubview:toolbar atIndex:0];
//        toolbar.alpha = alpha;
//        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self);
//        }];
//    }
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//    [self layoutIfNeeded];
//}
//
//- (void)addDefaultBlurEffect{
//    [self addBlurEffectWithColor:nil alpha:1];
//}
//
//- (void)addYXLBlurEffectWithColor:(UIColor *)color blurRadius:(CGFloat)radius alpha:(CGFloat)alpha{
//    if (YXSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
//        YXLVisualEffectView *effectV = [[YXLVisualEffectView alloc] init];
//        [self insertSubview:effectV atIndex:0];
//        [effectV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self);
//        }];
//        [effectV effectWithColor:color blurRadius:radius alpha:alpha];
//    }else {
//        [self addDefaultBlurEffect];
//    }
//}
//
//
//
//- (void)addBlackBlurEffect{
//
//    if (YXSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//
//        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//        [self insertSubview:effectView atIndex:0];
//        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self);
//        }];
//    } else {
//        UITabBar *toolbar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.5, self.frame.size.height*0.5)];
//        toolbar.barStyle = UIBarStyleBlack;
//        [self insertSubview:toolbar atIndex:0];
//        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.right.bottom.equalTo(self);
//        }];
//    }
//
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//    [self layoutIfNeeded];
//
//}
//
///**
// 自定义导航栏效果
// */
//-(void)addCustomNavView{
//    UIImage *image = [UIImage coreBlurImage:[UIImage yxt_imageWithColor:[UIColor yxt_rgbColor:255 g:255 b:255 a:1]] withBlurNumber:10];
//    UIImageView *topViewImage = [[UIImageView alloc]init];
//    topViewImage.frame = CGRectMake(0, 0, SWIDTH, 64);
//    topViewImage.image = image;
//    [self insertSubview:topViewImage atIndex:0];
//
//    UIView *bottomLine = [[UIView alloc]init];
//    bottomLine.backgroundColor = [UIColor yxt_colorWithHex:@"#666666"];
//    bottomLine.frame = CGRectMake(0, 63.5, SWIDTH, 0.5);
//    [self addSubview:bottomLine];
//
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//    [self layoutIfNeeded];
//}

@end
