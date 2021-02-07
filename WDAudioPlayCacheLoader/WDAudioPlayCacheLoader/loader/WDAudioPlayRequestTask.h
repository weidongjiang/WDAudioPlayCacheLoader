//
//  WDAudioPlayRequestTask.h
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WDAudioPlayRequestTaskDelegate <NSObject>

@required
- (void)requestTaskDidUpdateCache; //更新缓冲进度代理方法

@optional
- (void)requestTaskDidReceiveResponse;
- (void)requestTaskDidFinishLoadingWithCache:(BOOL)cache;
- (void)requestTaskDidFailWithError:(NSError *)error;

@end


@interface WDAudioPlayRequestTask : NSObject

@property (nonatomic, weak) id<WDAudioPlayRequestTaskDelegate> delegate;
@property (nonatomic, strong) NSURL *requestUrl;// 请求网址
@property (nonatomic, assign) NSInteger requestOffset;// 请求起始位置
@property (nonatomic, assign) NSInteger fileLength;// 文件长度
@property (nonatomic, assign) NSInteger cacheLength;// 缓冲长度
@property (nonatomic, assign) BOOL isCache;// 是否缓存文件
@property (nonatomic, assign) BOOL isCancel;// 是否取消请求

/// 开始请求
- (void)requestStart;

@end

NS_ASSUME_NONNULL_END
