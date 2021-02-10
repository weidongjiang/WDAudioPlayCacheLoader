//
//  HTLTypeCastUtil.m
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/6.
//

#import "HTLTypeCastUtil.h"
#import "NSString+HTTSimpleMatching.h"
#import "NSObject+HTTAssociatedObject.h"

id htl_nonnullValue(id value)
{
    if (nil == value) return nil;
    
    if ([value isKindOfClass:NSDictionary.class])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [(NSDictionary *)value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj != [NSNull null]) {
                
                obj = htl_nonnullValue(obj);
                if (nil != obj)
                {
                    [dict setObject:obj forKey:key];
                }
                
            }
        }];
        
        return dict;
    }
    else if ([value isKindOfClass:NSArray.class])
    {
        NSMutableArray *array = [NSMutableArray array];
        [(NSArray *)value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (obj != [NSNull null]) {
                
                obj = htl_nonnullValue(obj);
                if (nil != obj)
                {
                    [array addObject:obj];
                }
                
            }
        }];
        return array;
    }
    else if (value != [NSNull null])
    {
        return value;
    }
    
    return nil;
}

NSString *htl_stringOfValue(id value, NSString *defaultValue)
{
    if (![value isKindOfClass:[NSString class]])
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            return [value stringValue];
        }
        return defaultValue;
    }
    return value;
}

NSArray *htl_stringArrayOfValue(id value, NSArray *defaultValue)
{
    if (![value isKindOfClass:[NSArray class]])
        return defaultValue;
    
    for (id item in value) {
        if (![item isKindOfClass:[NSString class]])
            return defaultValue;
    }
    return value;
}

NSDictionary *htl_dictOfValue(id value, NSDictionary *defaultValue)
{
    if ([value isKindOfClass:[NSDictionary class]])
        return value;
    
    return defaultValue;
}

NSArray *htl_arrayOfValue(id value ,NSArray *defaultValue)
{
    if ([value isKindOfClass:[NSArray class]])
        return value;
    
    return defaultValue;
}

float htl_floatOfValue(id value, float defaultValue)
{
    if ([value respondsToSelector:@selector(floatValue)])
        return [value floatValue];
    
    return defaultValue;
}

double htl_doubleOfValue(id value, double defaultValue)
{
    if ([value respondsToSelector:@selector(doubleValue)])
        return [value doubleValue];
    
    return defaultValue;
}

BOOL htl_boolOfValue(id value, BOOL defaultValue)
{
    if ([value respondsToSelector:@selector(boolValue)])
        return [value boolValue];
    
    return defaultValue;
}

int htl_intOfValue(id value, int defaultValue)
{
    if ([value respondsToSelector:@selector(intValue)])
        return [value intValue];
    
    return defaultValue;
}

unsigned int htl_unsignedIntOfValue(id value, unsigned int defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedIntValue)])
        return [value unsignedIntValue];
    
    return defaultValue;
}

long long int htl_longLongOfValue(id value, long long int defaultValue)
{
    if ([value respondsToSelector:@selector(longLongValue)])
        return [value longLongValue];
    
    return defaultValue;
}

unsigned long long int htl_unsignedLongLongOfValue(id value, unsigned long long int defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedLongLongValue)])
        return [value unsignedLongLongValue];
    
    return defaultValue;
}

NSInteger htl_integerOfValue(id value, NSInteger defaultValue)
{
    if ([value respondsToSelector:@selector(integerValue)])
        return [value integerValue];
    
    return defaultValue;
}

NSUInteger htl_unsignedIntegerOfValue(id value, NSUInteger defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedIntegerValue)])
        return [value unsignedIntegerValue];
    
    return defaultValue;
}

UIImage *htl_imageOfValue(id value, UIImage *defaultValue)
{
    if ([value isKindOfClass:[UIImage class]])
        return value;
    
    return defaultValue;
}

UIColor *htl_colorOfValue(id value, UIColor *defaultValue)
{
    if ([value isKindOfClass:[UIColor class]])
        return value;
    
    return defaultValue;
}

time_t htl_timeOfValue(id value, time_t defaultValue)
{
    NSString *stringTime = htl_stringOfValue(value, nil);
    
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime)
    {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
        {
            // 为了兼顾 userDefaults 可能传值不正确的情况
            if (strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created) == NULL)
            {
                return defaultValue;
            }
        }
        
        return mktime(&created);
    }
    
    return defaultValue;
}

NSDate *htl_dateOfValue(id value)
{
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [NSDate dateWithTimeIntervalSince1970:[value intValue]];
    }
    else if ([value isKindOfClass:[NSString class]] && [value length] > 0)
    {
        return [NSDate dateWithTimeIntervalSince1970:htl_timeOfValue(value, [[NSDate date] timeIntervalSince1970])];
    }
    
    return nil;
}


NSData *htl_dataOfValue(id value, NSData *defaultValue)
{
    if ([value isKindOfClass:[NSData class]])
    {
        return value;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return [value dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    return defaultValue;
}

NSURL *htl_urlOfValue(id value, NSURL *defaultValue)
{
    if ([value isKindOfClass:[NSURL class]])
    {
        return value;
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return [NSURL fileURLWithPath:value];
    }
    else if ([value isKindOfClass:[NSData class]])
    {
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:value];
        if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            
            return url;
        }
    }
    
    return defaultValue;
}
