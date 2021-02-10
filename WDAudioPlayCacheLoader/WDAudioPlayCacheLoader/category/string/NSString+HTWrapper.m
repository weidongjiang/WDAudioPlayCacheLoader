//
//  NSString+HTWrapper.m
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/21.
//

#import "NSString+HTWrapper.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (HTWrapper)

#define JavaNotFound -1

- (unichar) ht_charAt:(int)index {
    return [self characterAtIndex:index];
}

- (int) ht_compareTo:(NSString*) anotherString {
    return [self compare:anotherString];
}

/** Java-like method. Compares two strings lexicographically, ignoring case differences. */
- (int) ht_compareToIgnoreCase:(NSString*) str {
    return [self compare:str options:NSCaseInsensitiveSearch];
}

/** Java-like method. Returns true if and only if this string contains the specified sequence of char values. */
- (BOOL) ht_contains:(NSString*) str {
    NSRange range = [self rangeOfString:str];
    return (range.location != NSNotFound);
}

- (BOOL) ht_startsWith:(NSString*)prefix {
    return [self hasPrefix:prefix];
}

- (BOOL) ht_endsWith:(NSString*)suffix {
    return [self hasSuffix:suffix];
}

- (BOOL) ht_equals:(NSString*) anotherString {
    return [self isEqualToString:anotherString];
}

- (BOOL) ht_equalsIgnoreCase:(NSString*) anotherString {
    return [[self ht_toLowerCase] ht_equals:[anotherString ht_toLowerCase]];
}

- (int) ht_indexOfChar:(unichar)ch{
    return [self ht_indexOfChar:ch fromIndex:0];
}

- (int) ht_indexOfChar:(unichar)ch fromIndex:(int)index{
    int len = (int)self.length;
    for (int i = index; i < len; ++i) {
        if (ch == [self ht_charAt:i]) {
            return i;
        }
    }
    return JavaNotFound;
}

- (int) ht_indexOfString:(NSString*)str {
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return (int)range.location;
}

- (int) ht_indexOfString:(NSString*)str fromIndex:(int)index {
    NSRange fromRange = NSMakeRange(index, self.length - index);
    NSRange range = [self rangeOfString:str options:NSLiteralSearch range:fromRange];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return (int)range.location;
}

- (int) ht_lastIndexOfChar:(unichar)ch {
    int len = (int)self.length;
    for (int i = len-1; i >=0; --i) {
        if ([self ht_charAt:i] == ch) {
            return i;
        }
    }
    return JavaNotFound;
}

- (int) ht_lastIndexOfChar:(unichar)ch fromIndex:(int)index {
    int len = (int)self.length;
    if (index >= len) {
        index = len - 1;
    }
    for (int i = index; i >= 0; --i) {
        if ([self ht_charAt:i] == ch) {
            return index;
        }
    }
    return JavaNotFound;
}

- (int) ht_lastIndexOfString:(NSString*)str {
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return (int)range.location;
}

- (int) ht_lastIndexOfString:(NSString*)str fromIndex:(int)index {
    NSRange fromRange = NSMakeRange(0, index);
    NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:fromRange];
    if (range.location == NSNotFound) {
        return JavaNotFound;
    }
    return (int)range.location;
}

- (NSString *) ht_substringFromIndex:(int)beginIndex toIndex:(int)endIndex {
    if (endIndex <= beginIndex) {
        return @"";
    }
    NSRange range = NSMakeRange(beginIndex, endIndex - beginIndex);
    return [self substringWithRange:range];
}

- (NSString *) ht_toLowerCase {
    return [self lowercaseString];
}

- (NSString *) ht_toUpperCase {
    return [self uppercaseString];
}

- (NSString *) ht_trim {
    if (self == nil || (NSNull*)self == [NSNull null]) {
        return @"";
    }
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) ht_replaceAll:(NSString*)origin with:(NSString*)replacement {
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}

- (NSArray *) ht_split:(NSString*) separator {
    return [self componentsSeparatedByString:separator];
}

#pragma mark - mine
- (BOOL)ht_isPhoneNumber
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^((\\+86)|(86))?(1)\\d{10}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:self
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, self.length)];
    
    
    if(numberofMatch > 0)
    {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)ht_isPassword
{
    NSString *passwordRegex = @"^[\\S]{6,20}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    if(![passwordTest evaluateWithObject:self]){
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)ht_isNick
{
    NSInteger count = [self lengthOfBytesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    if (count<4 || count>32) {
        return NO;
    }
    NSString *passwordRegex = @"^([\u4e00-\u9fa5]|[a-zA-Z0-9_]|-)+$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    if(![passwordTest evaluateWithObject:self]){
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)ht_isEmail
{
    NSString *emailRegex = @"^([a-zA-Z0-9_\\.\\-\\+])+@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if(![emailTest evaluateWithObject:self]){
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)ht_isIdentityNO
{
    if (self.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

- (NSString *)ht_MD5String
{
    const char *src = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, (CC_LONG)strlen(src), result);
    
    NSString *ret = [[NSString alloc] initWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3],
                     result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    
    return [ret lowercaseString];
}

- (NSInteger)ht_StringCount
{
    return (int)([self lengthOfBytesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]/2.0f);
}

+ (BOOL)ht_isBlankString:(NSString *)string
{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if (    [string isEqual:nil]
        ||  [string isEqual:Nil]){
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [string length]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
    
}


@end
