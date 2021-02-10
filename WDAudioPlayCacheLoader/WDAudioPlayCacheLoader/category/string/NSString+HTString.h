//
//  NSString+HTString.h
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/21.
//



#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (HTString)

/**
 *  字符串字数
 *  中文为 1 位，英文为 0.5 个
 *
 *  @return 字符串字数
 */
- (NSInteger)ht_stringCount;
- (NSString *)ht_interceptionByGBK:(int)length;

- (BOOL)ht_isValidNickname;

- (BOOL)ht_isValiddDesc;

- (BOOL)ht_isPhoneNumber;

- (BOOL)ht_isEmail;

- (BOOL)ht_isPassword;

- (BOOL)ht_isMobileNumber;

- (id)ht_JSONValue;

- (NSString *)ht_getChineseCaptialChar;

- (NSString *)ht_MD5String;

- (NSString *)ht_second2String;

- (NSString *)ht_urlEncode;
- (NSString *)ht_urlEncodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)ht_urlDecode;
- (NSString *)ht_urlDecodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)absoluteString;

- (NSDictionary*)ht_parseQuery;
- (NSString *)ht_firstPYString;

+ (BOOL)ht_stringContainsEmoji:(NSString *)string;

//emoji按照一个character计算
- (NSUInteger)ht_realLength;
//获取指定长度字体的压缩字符串，性能不保证，不建议在高频计算中使用
- (NSString*)ht_limitStringWithFont:(UIFont*)font length:(CGFloat)length;

- (NSInteger)ht_calculateSubStringCount:(NSString*)str;


/**
 返回label可显示的合适字符串
 【解决表情字符只截一段问题】

 @param labelSize label的宽高
 @param font 字体
 @return 新得字符串
 */
- (NSString *)ht_clipFitStringForLabel:(CGSize)labelSize font:(UIFont *)font;

/**
 返回字符串对应字体下单行宽度

 @param font 字体大小
 @return 宽度
 */
- (CGFloat)ht_singleLineWidthWithFont:(UIFont*)font;
@end
