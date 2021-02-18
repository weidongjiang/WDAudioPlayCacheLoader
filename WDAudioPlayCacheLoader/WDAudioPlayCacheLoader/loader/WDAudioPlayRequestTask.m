//
//  WDAudioPlayRequestTask.m
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//
#import <UIKit/UIKit.h>
#import "WDAudioPlayRequestTask.h"
#import "WDAudioPlayCacheTools.h"
#import "HTCategoryTools.h"

static NSString *K_videoCachePathKey = @"videoCache";

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
    if (self.isCancelled) {
        return;
    }
//    NSLog(@"WDAudioPlayRequestTask data----%@",data);

    NSString *path = [self getFullPathWithFile:dataTask.response.URL];

    [self writeTempFileData:data path:[self tempFilePath]];

    
    self.cacheLength += data.length;
    
    NSLog(@"WDAudioPlayRequestTask data cacheLength ----%ld",(long)self.cacheLength);

    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidUpdateCache)]) {
        [self.delegate requestTaskDidUpdateCache];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (self.isCancelled) {
        return;
    }
    if (error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidFailWithError:)]) {
            [self.delegate requestTaskDidFailWithError:error];
        }
        NSLog(@"WDAudioPlayRequestTask error----%@",error);
        return;
    }
    
    if (self.cache) {
        [self cacheTempFileWithFileName:[WDAudioPlayCacheTools fileNameWithURL:self.requestUrl] path:[self tempFilePath]];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestTaskDidFinishLoadingWithCache:)]) {
        [self.delegate requestTaskDidFinishLoadingWithCache:self.cache];
    }
    
}


- (NSString *)tempFilePath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"MusicTemp.mp4"];
}

- (void)writeTempFileData:(NSData *)data path:(NSString *)path {
    
//    NSFileManager *manager = [NSFileManager defaultManager];
//    if(![manager fileExistsAtPath:path]){
//       //参数1：文件路径
//       //参数2：初始化的内容
//       //参数3：附加信息,一般置为nil
//       [manager createFileAtPath:path contents:data attributes:nil];
//    }else {
//        manager isWritableFileAtPath
//    }
    
    NSFileHandle * handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle writeData:data];
    unsigned long long ret = [handle seekToEndOfFile];//返回文件大小
    NSLog(@"writeTempFileData------%ll",ret);
}


- (void)cacheTempFileWithFileName:(NSString *)name path:(NSString *)path {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * cacheFolderPath = [self cacheFolderPath];
    if ([manager fileExistsAtPath:cacheFolderPath]) {
        [manager createDirectoryAtPath:cacheFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", cacheFolderPath, name];
 
    [self copyFileFromPath:path toPath:cacheFilePath];
    
}


- (void)copyFileFromPath:(NSString *)path1 toPath:(NSString *)path2
{
    NSFileHandle * fh1 = [NSFileHandle fileHandleForReadingAtPath:path1];//读到内存
    [[NSFileManager defaultManager] createFileAtPath:path2 contents:nil attributes:nil];//写之前必须有该文件
    NSFileHandle * fh2 = [NSFileHandle fileHandleForWritingAtPath:path2];//写到文件
    NSData * _data = nil;
    unsigned long long ret = [fh1 seekToEndOfFile];//返回文件大小
   if (ret < 1024 * 1024 * 5) {//小于5M的文件一次读写
       [fh1 seekToFileOffset:0];
        _data = [fh1 readDataToEndOfFile];
       [fh2 writeData:_data];
    }else{
        NSUInteger n = ret / (1024 * 1024 * 5);
        if (ret % (1024 * 1024 * 5) != 0) {
            n++;
        }
        NSUInteger offset = 0;
        NSUInteger size = 1024 * 1024 * 5;
        for (NSUInteger i = 0; i < n - 1; i++) {
            //大于5M的文件多次读写
            [fh1 seekToFileOffset:offset];
            @autoreleasepool {
                /*该自动释放池必须要有否则内存一会就爆了
                 原因在于readDataOfLength方法返回了一个自动释放的对象,它只能在遇到自动释放池的时候才释放.如果不手动写这个自动释放池,会导致_data指向的对象不能及时释放,最终导致内存爆了.
                 */
                _data = [fh1 readDataOfLength:size];
                [fh2 seekToEndOfFile];
                [fh2 writeData:_data];
                NSLog(@"%lu/%lu", i + 1, n - 1);
            }
            offset += size;
        }
        //最后一次剩余的字节
        [fh1 seekToFileOffset:offset];
        _data = [fh1 readDataToEndOfFile];
        [fh2 seekToEndOfFile];
        [fh2 writeData:_data];
    }
    [fh1 closeFile];
    [fh2 closeFile];
}






- (NSString *)cacheFolderPath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"MusicCaches"];
}





- (NSString *)getFullPathWithFile:(NSURL *)fileName {
     
    //先获取 沙盒中的Library/Caches/路径
    NSString *videoAssetURL_path = [fileName.path ht_replaceAll:@"/" with:@"_"];
    NSString *myCacheDirectory = [self videoCacheFilePath];
    //拼接路径
    return [myCacheDirectory stringByAppendingPathComponent:videoAssetURL_path];
}

- (NSString *)videoCacheFilePath {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:K_videoCachePathKey];
    //检测MyCaches 文件夹是否存在
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        //不存在 那么创建
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return myCacheDirectory;
}


@end
