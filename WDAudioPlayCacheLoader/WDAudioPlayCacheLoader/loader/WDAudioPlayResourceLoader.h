//
//  WDAudioPlayResourceLoader.h
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class WDAudioPlayResourceLoader;

@protocol WDAudioPlayResourceLoaderDelegate <NSObject>

- (void)loader:(WDAudioPlayResourceLoader *)loader cacheProgress:(CGFloat)progress;
- (void)loader:(WDAudioPlayResourceLoader *)loader failLoadingWithError:(NSError *)error;

@end


@interface WDAudioPlayResourceLoader : NSObject

@property (nonatomic, weak) id<WDAudioPlayResourceLoaderDelegate> delegate;
@property (atomic, assign) BOOL seekRequired; //Seek标识
@property (nonatomic, assign) BOOL cacheFinished;

- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
