//
//  WDAudioPlayCacheTools.h
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDAudioPlayCacheTools : NSObject


/**
 *  临时文件路径
 */
+ (NSString *)tempFilePathFileName:(NSString *)fileName;

/**
 *  缓存文件夹路径
 */
+ (NSString *)cacheFolderPath;

/**
 *  获取网址中的文件名
 */
+ (NSString *)fileNameWithURL:(NSURL *)url;

////**************************************************************************************************************/

/**
 *  自定义scheme
 */
+ (NSURL *)customSchemeURL:(NSURL *)url;

/**
 *  还原scheme
 */
+ (NSURL *)originalSchemeURL:(NSURL *)url;

////**************************************************************************************************************/


@end

NS_ASSUME_NONNULL_END
