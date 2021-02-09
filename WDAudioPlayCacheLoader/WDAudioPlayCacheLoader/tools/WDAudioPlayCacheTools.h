//
//  WDAudioPlayCacheTools.h
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//

#import <Foundation/Foundation.h>


static NSString * _Nullable fileName = @"MusicTemp.mp4";

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

/**
 *  创建临时文件
 */
+ (BOOL)createTempFile;

/**
 *  往临时文件写入数据
 */
+ (void)writeTempFileData:(NSData *)data;

/**
 *  读取临时文件数据
 */
+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length;

/**
 *  保存临时文件到缓存文件夹
 */
+ (void)cacheTempFileWithFileName:(NSString *)name;

/**
 *  是否存在缓存文件 存在：返回文件路径 不存在：返回nil
 */
+ (NSString *)cacheFileExistsWithURL:(NSURL *)url;

/**
 *  清空缓存文件
 */
+ (BOOL)clearCache;

@end

NS_ASSUME_NONNULL_END
