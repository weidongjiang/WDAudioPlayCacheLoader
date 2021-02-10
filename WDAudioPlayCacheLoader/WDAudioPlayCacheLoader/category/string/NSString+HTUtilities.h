//
//  NSString+HTUtilities.h
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/21.
//

#import <Foundation/Foundation.h>


/*!
 *  将字符串哈希的相关工具方法。
 */
@interface NSString (HTCrypto)
/*!
 *  生成并返回当前字符串的MD5哈希字符串
 *
 *
 *  @return MD5 后的字符串
 */
- (NSString *)ht_stringWithMD5;

/*!
 *  生成并返回当前字符串的MD5摘要字符串
 *
 *  @return 生成的MD5摘要字符串
 */
- (NSString *)ht_stringWithMD5HexDigest;

/*!
 *  生成并返回指定NSData转化成MD5哈希字符串
 *
 *  @param data 要转换成MD5字符串的NSData
 *
 *  @return 转换成MD5的字符串
 */
+ (NSString *)ht_md5StringWithData:(NSData *)data;



@end

/*!
 *  字符串常用工具方法。
 */
@interface NSString (HTNSStringUtils)


/**
 * Determines if the string contains only whitespace.
 */
- (BOOL)ht_isWhitespace;


/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)ht_isEmptyOrWhitespace;

- (BOOL)ht_isEmptyWhitespaceOrNewLines;

/*!
 *  生成并返回指定最大长度后的字符串；如果要转换的字符串的长度超过指定长度，生成字符串后三位以“...”显示
 *  如， “abcdef” maxLen = 4 -> "a..."
 *
 *  @param maxLen 最大长度
 *
 *  @return 复合最大长度的字符串
 */
- (NSString *)ht_stringWithMaxLength:(NSUInteger)maxLen;



/*!
 *  生成并返回将当前字符串指定范围替换后的字符串
 *
 *  @param aRange  替换范围
 *  @param aString 替换字符串
 *
 *  @return 替换后的字符串
 */
- (NSString *)ht_stringByReplacingRange:(NSRange)aRange with:(NSString *)aString;

/*!
 *  生成并返回去掉当前字符串中的空格和换行符后的字符串
 *
 *  @return 转换后的字符串
 */
- (NSString *)ht_trimmedString;



/*!
 *  返回第一个字符串对象
 *
 *  @param string 输入字符串
 *
 *  @return 第一个字符串对象
 */
+ (NSString *)ht_firstNonNsNullStringWithString:(NSString*)string, ...;



@end

/*!
 *  添加删除转义字符的工具方法。
 */
@interface NSString (HTIndempotentPercentEscapes)

/*!
 *  返回一个将当前字符串中的转义字符decode的字符串
 *
 *  @return decode后的字符串
 */
- (NSString*) ht_stringByAddingPercentEscapesOnce;

/*!
 *  返回一个将当前字符串encode的字符串
 *
 *  @return encode后的字符串
 */
- (NSString*) ht_stringByReplacingPercentEscapesOnce;
@end

/*!
 *  取得UUID
 */
@interface NSString (HTCreateUUID)
/*!
 *  生成并返回一个UUID字符串
 *
 *  @return UUID字符串
 */
+ (NSString*) ht_stringWithUUID;

+ (NSString *)ht_stringWithNewUUID;
@end


/*!
 *  判断当前字符串与指定子串的相关操作的工具方法。
 */
@interface NSString  (HTRangeAvoidance)
/*!
 *  判断当前字符串是否包含对应子串
 *
 *  @param substring 要判断的子串
 *
 *  @return YES，包含；NO，不包含
 */
- (BOOL)ht_hasSubstring:(NSString *)substring;

/*!
 *  生成一个指定子字符串出现后的字符串，
 *  如"donganyuan" substring "an" 返回 "yuan"
 *
 *  @param substring 要判断的子串
 *
 *  @return 返回的子字符串
 */
- (NSString *)ht_substringAfterSubstring:(NSString *)substring;

/*!
 *  不考虑大小写，判断两个字符串是否相同
 *
 *  @param otherString 要比较的字符串
 *
 *  @return YES，相同；NO，不相同；
 */
- (BOOL)ht_isEqualToStringIgnoringCase:(NSString *)otherString;
@end

