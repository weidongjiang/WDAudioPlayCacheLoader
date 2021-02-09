//
//  WDAudioPlayResourceLoader.m
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/9.
//

#import "WDAudioPlayResourceLoader.h"
#import "WDAudioPlayRequestTask.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "WDAudioPlayCacheTools.h"

static const NSString *WDAudioPlayResourceLoaderType = @"video/mp4";


@interface WDAudioPlayResourceLoader ()<AVAssetResourceLoaderDelegate,WDAudioPlayRequestTaskDelegate>

@property (nonatomic, strong) NSMutableArray *requestList;
@property (nonatomic, strong) WDAudioPlayRequestTask *requestTask;

@end



@implementation WDAudioPlayResourceLoader

- (instancetype)init {
    if (self = [super init]) {
        self.requestList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)stopLoading {
    self.requestTask.cancel = YES;
}


- (void)newTaskWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest cache:(BOOL)cache {
    NSInteger fileLength = 0;
    if (self.requestTask) {
        fileLength = self.requestTask.fileLength;
        self.requestTask.cancel = YES;
    }
    
    self.requestTask = [[WDAudioPlayRequestTask alloc] init];
    self.requestTask.requestUrl = loadingRequest.request.URL;
    self.requestTask.requestOffset = loadingRequest.dataRequest.requestedOffset;
    self.requestTask.cache = cache;
    self.requestTask.delegate = self;
    if (fileLength > 0) {
        self.requestTask.fileLength = fileLength;
    }
    
    [self.requestTask requestStart];
    self.seekRequired = NO;
}


- (void)addLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    [self.requestList addObject:loadingRequest];
    
    @synchronized (self) {
        if (self.requestTask) {
            BOOL isCache_requestedOffset_1 = loadingRequest.dataRequest.requestedOffset >= self.requestTask.requestOffset;
            BOOL isCache_requestedOffset_2 = loadingRequest.dataRequest.requestedOffset <= self.requestTask.requestOffset + self.requestTask.cacheLength;
            if (isCache_requestedOffset_1 && isCache_requestedOffset_2) {//数据已缓存
                [self processRequestList];
            }else {
                if (self.seekRequired) {
                    [self newTaskWithLoadingRequest:loadingRequest cache:NO];
                }
            }
        }else {
            [self newTaskWithLoadingRequest:loadingRequest cache:YES];
        }
    }
    
}

- (void)removeLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    [self.requestList removeObject:loadingRequest];
}

- (void)processRequestList {
    NSMutableArray * finishRequestList = [NSMutableArray array];
    for (AVAssetResourceLoadingRequest * loadingRequest in self.requestList) {
        if ([self finishLoadingWithLoadingRequest:loadingRequest]) {
            [finishRequestList addObject:loadingRequest];
        }
    }
    [self.requestList removeObjectsInArray:finishRequestList];
}

- (BOOL)finishLoadingWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge  CFStringRef)(WDAudioPlayResourceLoaderType), NULL);
    loadingRequest.contentInformationRequest.contentType = CFBridgingRelease(contentType);
    loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
    loadingRequest.contentInformationRequest.contentLength = self.requestTask.fileLength;
    
    
    NSInteger cacheLength = self.requestTask.cacheLength;
    NSInteger requestOffset = loadingRequest.dataRequest.requestedOffset;
    if (loadingRequest.dataRequest.currentOffset) {
        requestOffset = loadingRequest.dataRequest.currentOffset;
    }
    
    NSInteger canReadLength = cacheLength - (requestOffset - self.requestTask.requestOffset);
    NSInteger respondLength = MIN(canReadLength, loadingRequest.dataRequest.requestedLength);
    
    [loadingRequest.dataRequest respondWithData:[WDAudioPlayCacheTools readTempFileDataWithOffset:requestOffset - self.requestTask.requestOffset length:respondLength]];
    
    //如果完全响应了所需要的数据，则完成
    NSUInteger nowendOffset = requestOffset + canReadLength;
    NSUInteger reqEndOffset = loadingRequest.dataRequest.requestedOffset + loadingRequest.dataRequest.requestedLength;
    if (nowendOffset >= reqEndOffset) {
        [loadingRequest finishLoading];
        return YES;
    }
    return NO;
}

#pragma - AVAssetResourceLoaderDelegate
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest API_AVAILABLE(macos(10.9), ios(6.0), tvos(9.0)) API_UNAVAILABLE(watchos) {
    NSLog(@"WDAudioPlayResourceLoader shouldWaitForLoadingOfRequestedResource----%@",loadingRequest);

    [self addLoadingRequest:loadingRequest];
    
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest API_AVAILABLE(macos(10.9), ios(7.0), tvos(9.0)) API_UNAVAILABLE(watchos) {
    
    NSLog(@"WDAudioPlayResourceLoader didCancelLoadingRequest----%@",loadingRequest);
    [self removeLoadingRequest:loadingRequest];
}


- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForRenewalOfRequestedResource:(AVAssetResourceRenewalRequest *)renewalRequest API_AVAILABLE(macos(10.10), ios(8.0), tvos(9.0)) API_UNAVAILABLE(watchos) {
    
    NSLog(@"WDAudioPlayResourceLoader shouldWaitForRenewalOfRequestedResource----%@",renewalRequest);

    return YES;
}



- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForResponseToAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge API_AVAILABLE(macos(10.10), ios(8.0), tvos(9.0)) API_UNAVAILABLE(watchos) {
    
    NSLog(@"WDAudioPlayResourceLoader shouldWaitForResponseToAuthenticationChallenge----%@",authenticationChallenge);

    
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)authenticationChallenge API_AVAILABLE(macos(10.10), ios(8.0), tvos(9.0)) API_UNAVAILABLE(watchos) {
    NSLog(@"WDAudioPlayResourceLoader didCancelAuthenticationChallenge----%@",authenticationChallenge);

}


#pragma - WDAudioPlayRequestTaskDelegate
- (void)requestTaskDidUpdateCache {
    [self processRequestList];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loader:cacheProgress:)]) {
        CGFloat cacheProgress = (CGFloat)self.requestTask.cacheLength / (self.requestTask.fileLength - self.requestTask.requestOffset);
        [self.delegate loader:self cacheProgress:cacheProgress];
    }
}
- (void)requestTaskDidReceiveResponse {
    
}
- (void)requestTaskDidFinishLoadingWithCache:(BOOL)cache {
    self.cacheFinished = cache;
}
- (void)requestTaskDidFailWithError:(NSError *)error {
    
}


@end
