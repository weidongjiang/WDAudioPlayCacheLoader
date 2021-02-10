//
//  NSString+HTWrapper.h
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTWrapper)

- (unichar) ht_charAt:(int)index;

- (int) ht_compareTo:(NSString*) anotherString;

- (int) ht_compareToIgnoreCase:(NSString*) str;

- (BOOL) ht_contains:(NSString*) str;

- (BOOL) ht_startsWith:(NSString*)prefix;

- (BOOL) ht_endsWith:(NSString*)suffix;

- (BOOL) ht_equals:(NSString*) anotherString;

- (BOOL) ht_equalsIgnoreCase:(NSString*) anotherString;

- (int) ht_indexOfChar:(unichar)ch;

- (int) ht_indexOfChar:(unichar)ch fromIndex:(int)index;

- (int) ht_indexOfString:(NSString*)str;

- (int) ht_indexOfString:(NSString*)str fromIndex:(int)index;

- (int) ht_lastIndexOfChar:(unichar)ch;

- (int) ht_lastIndexOfChar:(unichar)ch fromIndex:(int)index;

- (int) ht_lastIndexOfString:(NSString*)str;

- (int) ht_lastIndexOfString:(NSString*)str fromIndex:(int)index;

- (NSString *) ht_substringFromIndex:(int)beginIndex toIndex:(int)endIndex;

- (NSString *) ht_toLowerCase;

- (NSString *) ht_toUpperCase;

- (NSString *) ht_trim;

- (NSString *) ht_replaceAll:(NSString*)origin with:(NSString*)replacement;

- (NSArray *) ht_split:(NSString*) separator;

#pragma mark - mine
- (BOOL)ht_isPhoneNumber;
- (BOOL)ht_isPassword;
- (BOOL)ht_isNick;
- (BOOL)ht_isEmail;
- (BOOL)ht_isIdentityNO;
- (NSString *)ht_MD5String;
- (NSInteger)ht_StringCount;

+ (BOOL)ht_isBlankString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
