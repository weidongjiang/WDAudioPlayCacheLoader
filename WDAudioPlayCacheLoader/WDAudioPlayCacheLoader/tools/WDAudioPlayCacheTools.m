//
//  WDAudioPlayCacheTools.m
//  WDAudioPlayCacheLoader
//
//  Created by 伟东 on 2021/2/7.
//

#import "WDAudioPlayCacheTools.h"

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


@end
