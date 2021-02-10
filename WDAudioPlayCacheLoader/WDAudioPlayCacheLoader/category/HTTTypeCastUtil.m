//
//  HTTTypeCastUtil.m
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/6.
//

#import "HTTTypeCastUtil.h"
#import "NSString+HTTSimpleMatching.h"
#import "NSObject+HTTAssociatedObject.h"

id ht_nonnullValue(id value)
{
    if (nil == value) return nil;
    
    if ([value isKindOfClass:NSDictionary.class])
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [(NSDictionary *)value enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj != [NSNull null]) {
                
                obj = ht_nonnullValue(obj);
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
                
                obj = ht_nonnullValue(obj);
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

NSNumber *ht_numberOfValue(id value, NSNumber *defaultValue)
{
    NSNumber *returnValue = defaultValue;
    if (![value isKindOfClass:[NSNumber class]])
    {
        if ([value isKindOfClass:NSString.class])
        {
            NSThread *thread = [NSThread currentThread];
            NSNumberFormatter *formatter = [thread ht_objectWithAssociatedKey:@"TypeCastUtil.NumberFormatter"];
            if (!formatter)
            {
                formatter = [[NSNumberFormatter alloc] init] ;//autorelease];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                [thread ht_setObject:formatter forAssociatedKey:@"TypeCastUtil.NumberFormatter" retained:YES];
            }
            
            returnValue = [formatter numberFromString:(NSString *)value];
        }
    }
    else
    {
        returnValue = value;
    }
    
    return returnValue;
}

NSString *ht_stringOfValue(id value, NSString *defaultValue)
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

NSArray *ht_stringArrayOfValue(id value, NSArray *defaultValue)
{
    if (![value isKindOfClass:[NSArray class]])
        return defaultValue;
    
    for (id item in value) {
        if (![item isKindOfClass:[NSString class]])
            return defaultValue;
    }
    return value;
}

NSDictionary *ht_dictOfValue(id value, NSDictionary *defaultValue)
{
    if ([value isKindOfClass:[NSDictionary class]])
        return value;
    
    return defaultValue;
}

NSArray *ht_arrayOfValue(id value ,NSArray *defaultValue)
{
    if ([value isKindOfClass:[NSArray class]])
        return value;
    
    return defaultValue;
}

float ht_floatOfValue(id value, float defaultValue)
{
    if ([value respondsToSelector:@selector(floatValue)])
        return [value floatValue];
    
    return defaultValue;
}

double ht_doubleOfValue(id value, double defaultValue)
{
    if ([value respondsToSelector:@selector(doubleValue)])
        return [value doubleValue];
    
    return defaultValue;
}

CGPoint ht_pointOfValue(id value, CGPoint defaultValue)
{
    if ([value isKindOfClass:[NSString class]] && ![NSString ht_isEmptyString:value])
        return HTPointFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGPointValue];
    
    return defaultValue;
}

CGSize ht_sizeOfValue(id value, CGSize defaultValue)
{
    if ([value isKindOfClass:[NSString class]] && ![NSString ht_isEmptyString:value])
        return HTSizeFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGSizeValue];
    
    return defaultValue;
}

CGRect ht_rectOfValue(id value, CGRect defaultValue)
{
    if ([value isKindOfClass:[NSString class]] && ![NSString ht_isEmptyString:value])
        return HTRectFromString(value);
    else if ([value isKindOfClass:[NSValue class]])
        return [value CGRectValue];
    
    return defaultValue;
}

BOOL ht_boolOfValue(id value, BOOL defaultValue)
{
    if ([value respondsToSelector:@selector(boolValue)])
        return [value boolValue];
    
    return defaultValue;
}

int ht_intOfValue(id value, int defaultValue)
{
    if ([value respondsToSelector:@selector(intValue)])
        return [value intValue];
    
    return defaultValue;
}

unsigned int ht_unsignedIntOfValue(id value, unsigned int defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedIntValue)])
        return [value unsignedIntValue];
    
    return defaultValue;
}

long long int ht_longLongOfValue(id value, long long int defaultValue)
{
    if ([value respondsToSelector:@selector(longLongValue)])
        return [value longLongValue];
    
    return defaultValue;
}

unsigned long long int ht_unsignedLongLongOfValue(id value, unsigned long long int defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedLongLongValue)])
        return [value unsignedLongLongValue];
    
    return defaultValue;
}

NSInteger ht_integerOfValue(id value, NSInteger defaultValue)
{
    if ([value respondsToSelector:@selector(integerValue)])
        return [value integerValue];
    
    return defaultValue;
}

NSUInteger ht_unsignedIntegerOfValue(id value, NSUInteger defaultValue)
{
    if ([value respondsToSelector:@selector(unsignedIntegerValue)])
        return [value unsignedIntegerValue];
    
    return defaultValue;
}

UIImage *ht_imageOfValue(id value, UIImage *defaultValue)
{
    if ([value isKindOfClass:[UIImage class]])
        return value;
    
    return defaultValue;
}

UIColor *ht_colorOfValue(id value, UIColor *defaultValue)
{
    if ([value isKindOfClass:[UIColor class]])
        return value;
    
    return defaultValue;
}

time_t ht_timeOfValue(id value, time_t defaultValue)
{
    NSString *stringTime = ht_stringOfValue(value, nil);
    
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime)
    {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
        {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    
    return defaultValue;
}

NSDate *ht_dateOfValue(id value)
{
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [NSDate dateWithTimeIntervalSince1970:[value intValue]];
    }
    else if ([value isKindOfClass:[NSString class]] && [value length] > 0)
    {
        return [NSDate dateWithTimeIntervalSince1970:ht_timeOfValue(value, [[NSDate date] timeIntervalSince1970])];
    }
    
    return nil;
}

NSURL *ht_urlOfValue(id value, NSURL *defaultValue)
{
    if ([value isKindOfClass:[NSURL class]])
        return value;
    
    return defaultValue;
}
