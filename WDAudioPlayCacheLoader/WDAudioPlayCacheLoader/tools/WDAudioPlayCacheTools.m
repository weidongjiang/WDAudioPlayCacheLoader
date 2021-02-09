//
//  WDAudioPlayCacheTools.m
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//

#import "WDAudioPlayCacheTools.h"

@interface WDAudioPlayCacheTools ()

@property (nonatomic, strong) NSFileHandle * writeFileHandle;
@property (nonatomic, strong) NSFileHandle * readFileHandle;

@end


@implementation WDAudioPlayCacheTools

+ (NSString *)tempFilePathFileName:(NSString *)fileName {
    if (!fileName.length) {
        return nil;
    }
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:fileName];
}


+ (NSString *)cacheFolderPath {
    return [[NSHomeDirectory( ) stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"MusicCaches"];
}

+ (NSString *)fileNameWithURL:(NSURL *)url {
    if (!url.absoluteString) {
        return nil;
    }
    return [[url.path componentsSeparatedByString:@"/"] lastObject];
}

+ (NSURL *)customSchemeURL:(NSURL *)url {
    if (!url.absoluteString) {
        return nil;
    }
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    components.scheme = @"streaming";
    return [components URL];
}

+ (NSURL *)originalSchemeURL:(NSURL *)url {
    if (!url.absoluteString) {
        return nil;
    }
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
    components.scheme = @"http";
    return [components URL];
}



+ (BOOL)createTempFile {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [WDAudioPlayCacheTools tempFilePathFileName:fileName];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    return [manager createFileAtPath:path contents:nil attributes:nil];
}

+ (void)writeTempFileData:(NSData *)data {
    NSFileHandle * handle = [NSFileHandle fileHandleForWritingAtPath:[WDAudioPlayCacheTools tempFilePathFileName:fileName]];
    [handle seekToEndOfFile];
    [handle writeData:data];
}

+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length {
    NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:[WDAudioPlayCacheTools tempFilePathFileName:fileName]];
    [handle seekToFileOffset:offset];
    return [handle readDataOfLength:length];
}

+ (void)cacheTempFileWithFileName:(NSString *)name {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * cacheFolderPath = [WDAudioPlayCacheTools cacheFolderPath];
    if (![manager fileExistsAtPath:cacheFolderPath]) {
        [manager createDirectoryAtPath:cacheFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", cacheFolderPath, name];
    
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:[WDAudioPlayCacheTools tempFilePathFileName:fileName] toPath:cacheFilePath error:nil];
    NSLog(@"cache file : %@", success ? @"success" : @"fail");
}

+ (NSString *)cacheFileExistsWithURL:(NSURL *)url {
    NSString * cacheFilePath = [NSString stringWithFormat:@"%@/%@", [WDAudioPlayCacheTools cacheFolderPath], [WDAudioPlayCacheTools fileNameWithURL:url]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFilePath]) {
        return cacheFilePath;
    }
    return nil;
}

+ (BOOL)clearCache {
    NSFileManager * manager = [NSFileManager defaultManager];
    return [manager removeItemAtPath:[WDAudioPlayCacheTools cacheFolderPath] error:nil];
}
@end
