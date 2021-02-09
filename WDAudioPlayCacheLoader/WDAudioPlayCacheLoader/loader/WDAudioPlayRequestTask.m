//
//  WDAudioPlayRequestTask.m
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//
#import <UIKit/UIKit.h>
#import "WDAudioPlayRequestTask.h"
#import "WDAudioPlayCacheTools.h"


static const CGFloat WDAudioPlayRequestTaskTimeout = 10.0;


@interface WDAudioPlayRequestTask ()<NSURLConnectionDataDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;// 回话对象
@property (nonatomic, strong) NSURLSessionDataTask *task;// 任务

@end


@implementation WDAudioPlayRequestTask
- (instancetype)init {
    if (self = [super init]) {
        [WDAudioPlayCacheTools tempFilePathFileName:fileName];
    }
    return self;
}


/// 开始请求
- (void)requestStart {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[WDAudioPlayCacheTools originalSchemeURL:self.requestUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:WDAudioPlayRequestTaskTimeout];
    
    if (self.requestOffset > 0) {
        NSString *value = [NSString stringWithFormat:@"bytes=%ld-%ld",self.requestOffset,self.fileLength-1];
        [request addValue:value forHTTPHeaderField:@"Range"];
    }
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session dataTaskWithRequest:request];
    [self.task resume];
}

- (void)setCancel:(BOOL)cancel {
    _cancel = cancel;
    [self.task cancel];
    [self.session invalidateAndCancel];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"WDAudioPlayRequestTask response----%@",response);
    if (self.isCancelled) {
        return;
    }
    completionHandler(NSURLSessionResponseAllow);
    
    NSHTTPURLResponse *_response = (NSHTTPURLResponse *)response;
    NSDictionary *allHeaderFields = [_response allHeaderFields];
//    {
//        "Accept-Ranges" = bytes;
//        "Access-Control-Allow-Origin" = "*";
//        Connection = "keep-alive";
//        "Content-Length" = 4571591;
//        "Content-MD5" = "Rvx8CdxAr3FVf66wI2dVMw==";
//        "Content-Type" = "video/mp4";
//        Date = "Tue, 09 Feb 2021 10:05:15 GMT";
//        Etag = "\"46fc7c09dc40af71557faeb023675533\"";
//        Expires = "Fri, 12 Feb 2021 09:55:52 GMT";
//        "Last-Modified" = "Tue, 28 Apr 2020 04:59:03 GMT";
//        "Ohc-Cache-HIT" = "bj2bgpcache93 [3], czix93 [1]";
//        "Ohc-File-Size" = 4571591;
//        "Ohc-Response-Time" = "1 0 0 0 0 39";
//        Server = "JSP3/2.0.14";
//        "x-bce-content-crc32" = 1570434315;
//        "x-bce-debug-id" = "Huhfp8Zre243zqGeZSLoeTJJ3dUcxbgphwQFlhjGxMlJT8fXAZS0X9WjeDY7phK9OJTX7YJR1on0vNpf8WFMbA==";
//        "x-bce-request-id" = "c6a73e9a-d44f-40ac-b4ea-384bdb4c189a";
//        "x-bce-storage-class" = COLD;
//    }

    NSString * contentRange = [allHeaderFields objectForKey:@"Content-Range"];
    NSString * fileLength = [[contentRange componentsSeparatedByString:@"/"] lastObject];
    NSString *_length = [allHeaderFields objectForKey:@"Content-Length"];
    
    NSString *length = nil;
    if (fileLength > 0) {
        length = fileLength;
    }else if (_length > 0){
        length = _length;
    }
    self.fileLength = length.integerValue > 0 ? length.integerValue : response.expectedContentLength;
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidReceiveResponse)]) {
        [self.delegate requestTaskDidReceiveResponse];
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"WDAudioPlayRequestTask data----%@",data);
    if (self.isCancelled) {
        return;
    }
    [WDAudioPlayCacheTools writeTempFileData:data];

    self.cacheLength += data.length;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidUpdateCache)]) {
        [self.delegate requestTaskDidUpdateCache];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"WDAudioPlayRequestTask error----%@",error);
    if (self.isCancelled) {
        return;
    }
    if (error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidFailWithError:)]) {
            [self.delegate requestTaskDidFailWithError:error];
        }
        return;
    }
    
    if (self.cache) {
        [WDAudioPlayCacheTools cacheTempFileWithFileName:[WDAudioPlayCacheTools fileNameWithURL:self.requestUrl]];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidFinishLoadingWithCache:)]) {
        [self.delegate requestTaskDidFinishLoadingWithCache:self.cache];
    }
    
}

@end
