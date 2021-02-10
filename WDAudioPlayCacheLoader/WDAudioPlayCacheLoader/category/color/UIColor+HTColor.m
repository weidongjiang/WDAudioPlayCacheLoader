//
//  UIColor+HTColor.m
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/21.
//

#import "UIColor+HTColor.h"

@implementation UIColor (HTColor)

+ (UIColor *)ht_colorWithHex:(NSString *)hex {
    return [self ht_colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)ht_colorWithHex:(NSString *)hex alpha:(CGFloat)alpha {
    NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:cleanString];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

+ (UIColor *)ht_rgbColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [self ht_rgbColor:r g:g b:b a:1.0f];
}

+ (UIColor *)ht_rgbColor:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    r = MAX(0.0f, MIN(255.0f, r));
    g = MAX(0.0f, MIN(255.0f, g));
    b = MAX(0.0f, MIN(255.0f, b));
    a = MAX(0.0f, MIN(1.0f, a));
    
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a];
}

+ (UIColor *)ht_color:(CGFloat)same {
    return [self ht_color:same alpha:1.0f];
}

+ (UIColor *)ht_color:(CGFloat)same alpha:(CGFloat)alpha {
    same = MAX(0.0f, MIN(255.0f, same));
    alpha = MAX(0.0f, MIN(1.0f, alpha));
    return [self ht_rgbColor:same g:same b:same a:alpha];
}

+ (UIColor *)ht_randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
