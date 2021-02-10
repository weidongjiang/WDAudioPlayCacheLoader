//
//  NSDate+HTUtilities.h
//  HTIOSFoundationToolKit
//
//  Created by 伟东 on 2020/7/22.
//  Copyright © 2020 伟东. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSDateFormatter 与 NSCalendar 的初始化非常慢（“比文字绘制还慢” by instruments），
// 但它们又不是线程安全的：
// http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Multithreading/ThreadSafetySummary/ThreadSafetySummary.html#//apple_ref/doc/uid/10000057i-CH12-122647-BBCCEGFF
// 以下两个方法按当前线程提供缓存过的 formatter 与 calendar

@interface NSDateFormatter (HTUtilities)
+ (instancetype _Nullable )ht_dateFormateterForCurrentThread;
@end

@interface NSCalendar (HTUtilities)
+ (instancetype _Nullable )ht_calenderForCurrentThread;
@end


NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HTUtilities)

/*!
 *  根据指定的时间格式字符串，生成并返回一个当前日期的NSString对象
 *
 *  @param formatterString 格式化String
 *
 *  @return 格式化NSDate后的string
 */
- (NSString *)ht_stringWithFormatter:(NSString *)formatterString;

/*!
*  根据指定的NSTimeInterval，生成并返回转换成时间格式的NSString对象
*  如  今年： MM-dd HH:mm
*        去年： yyyy-MM-dd HH:mm
*
*  @param t 需要转换的NSTimeInterval
*
*  @return 转换后的NSString
*/
+ (NSString *)ht_convertToDateStringFromTimeInterval:(NSTimeInterval)t;
@end

NS_ASSUME_NONNULL_END
