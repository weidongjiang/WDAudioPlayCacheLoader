//
//  JWDVideoPlayController.m
//  JWDVideoPlayer
//
//  Created by 伟东 on 2020/6/16.
//  Copyright © 2020 yixiajwd. All rights reserved.
//

#import "JWDVideoPlayController.h"
#import <AVFoundation/AVFoundation.h>
#import "JWDVideoPlayView.h"
#import "AVAsset+JWDAdditions.h"
#import "WDAudioPlayResourceLoader.h"
#import "WDAudioPlayCacheTools.h"

#define STATUS_KEYPATH @"status"
#define REFRESH_INTERVAL 0.5f

static const NSString *PlayerItemStatusContext;

@interface JWDVideoPlayController ()<JWDTransportDelegate,WDAudioPlayResourceLoaderDelegate>

@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) JWDVideoPlayView *playerView;
@property (nonatomic, weak) id<JWDTransport> transport;

@property (strong, nonatomic) id timeObserver;
@property (strong, nonatomic) id itemEndObserver;
@property (assign, nonatomic) float lastPlaybackRate;

@property (nonatomic, strong) WDAudioPlayResourceLoader *resourceLoader;

@end

@implementation JWDVideoPlayController
- (instancetype)initWithUrl:(NSURL *)assetURL {
    self = [super init];
    if (self) {
        [self prepareToPlayUrl:assetURL];
    }
    return self;
}

- (void)prepareToPlayUrl:(NSURL *)assetURL {
    NSArray *keys = @[@"tracks",@"duration",@"commonMetadata",@"availableMediaCharacteristicsWithMediaSelectionOptions"];
    
    self.asset = [AVAsset assetWithURL:assetURL];

    self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset automaticallyLoadedAssetKeys:keys];
    
    
    if ([assetURL.absoluteString hasPrefix:@"http"]) {
        NSString * cacheFilePath = nil;//[self cacheFileExistsWithURL:assetURL];
        if (cacheFilePath) {//本地缓存
            NSLog(@"cacheFilePath---%@",cacheFilePath);
            NSURL * url = [NSURL fileURLWithPath:cacheFilePath];
            self.playerItem = [AVPlayerItem playerItemWithURL:url];
        }else {// 网路加载
            self.resourceLoader = [[WDAudioPlayResourceLoader alloc] init];
            self.resourceLoader.delegate = self;
            NSURL *url = [WDAudioPlayCacheTools customSchemeURL:assetURL];
            AVURLAsset *urlasset = [AVURLAsset URLAssetWithURL:url options:nil];
            [urlasset.resourceLoader setDelegate:self.resourceLoader queue:dispatch_get_main_queue()];
            
            self.playerItem = [AVPlayerItem playerItemWithAsset:urlasset automaticallyLoadedAssetKeys:keys];
        }
    }else {
        self.playerItem = [AVPlayerItem playerItemWithAsset:self.asset automaticallyLoadedAssetKeys:keys];
    }
    
    [self.playerItem addObserver:self
                      forKeyPath:STATUS_KEYPATH
                         options:0
                         context:&PlayerItemStatusContext];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    self.playerView = [[JWDVideoPlayView alloc] initWithPlayer:self.player];
    self.transport = self.playerView.transport;
    self.transport.delegate = self;
    
}

- (NSString *)cacheFileExistsWithURL:(NSURL *)url {
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", [WDAudioPlayCacheTools cacheFolderPath], [WDAudioPlayCacheTools fileNameWithURL:url]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
        return cacheFilePath;
    }
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    if (context == &PlayerItemStatusContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.playerItem removeObserver:self forKeyPath:STATUS_KEYPATH];
            
            if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
                
                [self addPlayerItemTimeObserver];
                [self addItemEndObserverForPlayerItem];
                
                [self.transport setCurrentTime:CMTimeGetSeconds(kCMTimeZero)
                                      duration:CMTimeGetSeconds(self.playerItem.duration)];
                
                [self.transport setTitle:self.asset.title];
                
                [self.player play];
                
                [self loadMediaOptions];
                [self generateThumbnails];
                
            }else {
                NSLog(@"Failed to load video error %@",self.playerItem.error);
            }
        });
    }
}


- (void)loadMediaOptions {
    NSString *mc = AVMediaCharacteristicLegible;
    
    AVMediaSelectionGroup *group = [self.asset mediaSelectionGroupForMediaCharacteristic:mc];
    if (group) {
        NSMutableArray *subtitles = [NSMutableArray array];
        for (AVMediaSelectionOption *option in group.options) {
            [subtitles addObject:option.displayName];
        }
        [self.transport setSubtitles:subtitles];
    }else {
        [self.transport setSubtitles:nil];
    }
    
}

- (void)generateThumbnails {
    
    
}

- (void)addPlayerItemTimeObserver {
    
    CMTime interval = CMTimeMakeWithSeconds(REFRESH_INTERVAL, NSEC_PER_SEC);
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    __weak JWDVideoPlayController *weakSelf = self;
    void (^callBack)(CMTime time) = ^(CMTime time) {
        NSTimeInterval currentTime = CMTimeGetSeconds(time);
        NSInteger duration = CMTimeGetSeconds(weakSelf.playerItem.duration);
        [weakSelf.transport setCurrentTime:currentTime duration:duration];
    };
    
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:interval
                                                                  queue:queue
                                                             usingBlock:callBack];
    
}

- (void)addItemEndObserverForPlayerItem {
    
    __weak JWDVideoPlayController *weakSelf = self;
    void (^callBack)(NSNotification * _Nonnull note) = ^(NSNotification * _Nonnull notification) {
        [weakSelf.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.transport playbackComplete];
        }];
    };
    
    self.itemEndObserver = [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification
                                                                             object:self.playerItem
                                                                              queue:[NSOperationQueue mainQueue]
                                                                         usingBlock:callBack];
    
    
}


#pragma JWDTransportDelegate
- (void)play {
    [self.player play];
}
- (void)pause {
    self.lastPlaybackRate = self.player.rate;
    [self.player pause];
}
- (void)stop {
    [self.player setRate:0.0f];
    [self.transport playbackComplete];
    [self.playerView removeFromSuperview];
    self.playerView = nil;
}

- (void)scrubbingDidStart {
    
}

- (void)scrubbedToTime:(NSTimeInterval)time {
    
}

- (void)scrubbingDidEnd {
    
}

- (void)jumpedToTime:(NSTimeInterval)time {
    [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC)];
}



- (UIView *)view {
    return self.playerView;
}

- (void)dealloc {
    if (self.itemEndObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.itemEndObserver name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
        self.itemEndObserver = nil;
    }
}


#pragma WDAudioPlayResourceLoaderDelegate
- (void)loader:(WDAudioPlayResourceLoader *)loader cacheProgress:(CGFloat)progress {
    NSLog(@"loader cacheProgress----%f",progress);
}
- (void)loader:(WDAudioPlayResourceLoader *)loader failLoadingWithError:(NSError *)error {
    NSLog(@"loader failLoadingWithError---error-%@",error);

}


@end
