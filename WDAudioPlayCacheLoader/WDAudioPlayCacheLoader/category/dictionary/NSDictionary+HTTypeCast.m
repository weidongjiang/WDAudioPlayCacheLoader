//
//  NSDictionary+HTTypeCast.m
//  libcocos2d Mac
//
//  Created by 伟东 on 2020/7/6.
//

#import "NSDictionary+HTTypeCast.h"
#import "NSString+HTTSimpleMatching.h"
#import "HTTTypeCastUtil.h"


/**
 *  返回根据所给key值在当前字典对象上对应的值.
 */
#define OFK [self objectForKey:key]

@implementation NSDictionary (HTTypeCast)


- (BOOL)ht_hasKey:(NSString *)key
{
    return (OFK != nil);
}

#pragma mark - NSObject

- (id)ht_objectForKey:(NSString *)key
{
    return OFK;
}

- (id)ht_unknownObjectForKey:(NSString*)key
{
    return OFK;
}


- (id)ht_objectForKey:(NSString *)key class:(Class)clazz
{
    id obj = OFK;
    if ([obj isKindOfClass:clazz])
    {
        return obj;
    }
    
    return nil;
}

#pragma mark - NSNumber

- (NSNumber *)ht_numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue
{
    return ht_numberOfValue(OFK, defaultValue);
}

- (NSNumber *)ht_numberForKey:(NSString *)key
{
    return [self ht_numberForKey:key defaultValue:nil];
}

#pragma mark - NSString

- (NSString *)ht_stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
{
    return ht_stringOfValue(OFK, defaultValue);
}

- (NSString *)ht_stringForKey:(NSString *)key;
{
    return [self ht_stringForKey:key defaultValue:nil];
}


- (NSString *)ht_validStringForKey:(NSString *)key
{
    NSString *stringValue = [self ht_stringForKey:key];
    if (stringValue.length) {
        return stringValue;
    }
    return nil;
}

#pragma mark - NSArray of NSString

- (NSArray *)ht_stringArrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    return ht_stringArrayOfValue(OFK, defaultValue);
}

- (NSArray *)ht_stringArrayForKey:(NSString *)key;
{
    return [self ht_stringArrayForKey:key defaultValue:nil];
}

#pragma mark - NSDictionary

- (NSDictionary *)ht_dictForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue
{
    return ht_dictOfValue(OFK, defaultValue);
}

- (NSDictionary *)ht_dictForKey:(NSString *)key
{
    return [self ht_dictForKey:key defaultValue:nil];
}

- (NSDictionary *)ht_validDictForKey:(NSString *)key
{
    NSDictionary *dictionary = [self ht_dictForKey:key];
    if (dictionary.count) {
        return dictionary;
    }
    return nil;
}

- (NSDictionary *)ht_dictionaryWithValuesForKeys:(NSArray *)keys
{
    return [self dictionaryWithValuesForKeys:keys];
}

#pragma mark - NSArray

- (NSArray *)ht_arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    return ht_arrayOfValue(OFK, defaultValue);
}

- (NSArray *)ht_arrayForKey:(NSString *)key
{
    return [self ht_arrayForKey:key defaultValue:nil];
}

-(NSArray *)ht_validArrayForKey:(NSString *)key
{
    NSArray *array = [self ht_arrayForKey:key];
    if (array.count) {
        return array;
    }
    return nil;
}

#pragma mark - Float

- (float)ht_floatForKey:(NSString *)key defaultValue:(float)defaultValue;
{
    return ht_floatOfValue(OFK, defaultValue);
}

- (float)ht_floatForKey:(NSString *)key;
{
    return [self ht_floatForKey:key defaultValue:0.0f];
}

#pragma mark - Double

- (double)ht_doubleForKey:(NSString *)key defaultValue:(double)defaultValue;
{
    return ht_doubleOfValue(OFK, defaultValue);
}

- (double)ht_doubleForKey:(NSString *)key;
{
    return [self ht_doubleForKey:key defaultValue:0.0];
}

#pragma mark - CGPoint

- (CGPoint)ht_pointForKey:(NSString *)key defaultValue:(CGPoint)defaultValue
{
    return ht_pointOfValue(OFK, defaultValue);
}

- (CGPoint)ht_pointForKey:(NSString *)key;
{
    return [self ht_pointForKey:key defaultValue:HTZeroPoint];
}

#pragma mark - CGSize

- (CGSize)ht_sizeForKey:(NSString *)key defaultValue:(CGSize)defaultValue;
{
    return ht_sizeOfValue(OFK, defaultValue);
}

- (CGSize)ht_sizeForKey:(NSString *)key;
{
    return [self ht_sizeForKey:key defaultValue:HTZeroSize];
}

#pragma mark - CGRect

- (CGRect)ht_rectForKey:(NSString *)key defaultValue:(CGRect)defaultValue;
{
    return ht_rectOfValue(OFK, defaultValue);
}

- (CGRect)ht_rectForKey:(NSString *)key;
{
    return [self ht_rectForKey:key defaultValue:HTZeroRect];
}

#pragma mark - BOOL

- (BOOL)ht_boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
{
    return ht_boolOfValue(OFK, defaultValue);
}

- (BOOL)ht_boolForKey:(NSString *)key;
{
    return [self ht_boolForKey:key defaultValue:NO];
}

#pragma mark - Int

- (int)ht_intForKey:(NSString *)key defaultValue:(int)defaultValue;
{
    return ht_intOfValue(OFK, defaultValue);
}

- (int)ht_intForKey:(NSString *)key;
{
    return [self ht_intForKey:key defaultValue:0];
}

#pragma mark - Unsigned Int

- (unsigned int)ht_unsignedIntForKey:(NSString *)key defaultValue:(unsigned int)defaultValue;
{
    return ht_unsignedIntOfValue(OFK, defaultValue);
}

- (unsigned int)ht_unsignedIntForKey:(NSString *)key;
{
    return [self ht_unsignedIntForKey:key defaultValue:0];
}

#pragma mark - Long Long

- (long long int)ht_longLongForKey:(NSString *)key defaultValue:(long long int)defaultValue
{
    return ht_longLongOfValue(OFK, defaultValue);
}

- (long long int)ht_longLongForKey:(NSString *)key;
{
    return [self ht_longLongForKey:key defaultValue:0LL];
}

#pragma mark - Unsigned Long Long

- (unsigned long long int)ht_unsignedLongLongForKey:(NSString *)key defaultValue:(unsigned long long int)defaultValue;
{
    return ht_unsignedLongLongOfValue(OFK, defaultValue);
}

- (unsigned long long int)ht_unsignedLongLongForKey:(NSString *)key;
{
    return [self ht_unsignedLongLongForKey:key defaultValue:0ULL];
}

#pragma mark - NSInteger

- (NSInteger)ht_integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
{
    return ht_integerOfValue(OFK, defaultValue);
}

- (NSInteger)ht_integerForKey:(NSString *)key;
{
    return [self ht_integerForKey:key defaultValue:0];
}

#pragma mark - Unsigned Integer

- (NSUInteger)ht_unsignedIntegerForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
    return ht_unsignedIntegerOfValue(OFK, defaultValue);
}

- (NSUInteger)ht_unsignedIntegerForKey:(NSString *)key
{
    return [self ht_unsignedIntegerForKey:key defaultValue:0];
}

#pragma mark - UIImage

- (UIImage *)ht_imageForKey:(NSString *)key defaultValue:(UIImage *)defaultValue
{
    return ht_imageOfValue(OFK, defaultValue);
}

- (UIImage *)ht_imageForKey:(NSString *)key
{
    return [self ht_imageForKey:key defaultValue:nil];
}

#pragma mark - UIColor

- (UIColor *)ht_colorForKey:(NSString *)key defaultValue:(UIColor *)defaultValue
{
    return ht_colorOfValue(OFK, defaultValue);
}

- (UIColor *)ht_colorForKey:(NSString *)key
{
    return [self ht_colorForKey:key defaultValue:[UIColor whiteColor]];
}

#pragma mark - Time

- (time_t)ht_timeForKey:(NSString *)key defaultValue:(time_t)defaultValue
{
    return ht_timeOfValue(OFK, defaultValue);
}

- (time_t)ht_timeForKey:(NSString *)key
{
    time_t defaultValue = [[NSDate date] timeIntervalSince1970];
    return [self ht_timeForKey:key defaultValue:defaultValue];
}

#pragma mark - NSDate

- (NSDate *)ht_dateForKey:(NSString *)key
{
    return ht_dateOfValue(OFK);
}

#pragma mark - NSURL
- (NSURL *)ht_urlForKey:(NSString *)key defaultValue:(NSURL *)defaultValue
{
    return ht_urlOfValue(OFK, defaultValue);
}

- (NSURL *)ht_urlForKey:(NSString *)key
{
    return [self ht_urlForKey:key defaultValue:nil];
}

#pragma mark - Enumerate

- (void)ht_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsUsingBlock:block];
}

- (void)ht_enumerateKeysAndUnknownObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsUsingBlock:block];
}

- (void)ht_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(key, castedObj, stop);
        }
    }];
}

- (void)ht_enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block classes:(id)object, ...
{
    if (!object) return;
    NSMutableArray* classesArray = [NSMutableArray array];
    id paraObj = object;
    va_list objects;
    va_start(objects, object);
    do
    {
        [classesArray addObject:paraObj];
        paraObj = va_arg(objects, id);
    } while (paraObj);
    va_end(objects);
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        BOOL allowBlock = NO;
        for (int i = 0; i < classesArray.count; i++)
        {
            if ([obj isKindOfClass:[classesArray objectAtIndex:i]])
            {
                allowBlock = YES;
                break;
            }
        }
        if (allowBlock)
        {
            block(key, obj, stop);
        }
    }];
}

- (void)ht_enumerateKeysAndArrayObjectsUsingBlock:(void (^)(id key, NSArray *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsUsingBlock:block withCastFunction:ht_arrayOfValue];
}

- (void)ht_enumerateKeysAndDictObjectsUsingBlock:(void (^)(id key, NSDictionary *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsUsingBlock:block withCastFunction:ht_dictOfValue];
}

- (void)ht_enumerateKeysAndStringObjectsUsingBlock:(void (^)(id key, NSString *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsUsingBlock:block withCastFunction:ht_stringOfValue];
}

- (void)ht_enumerateKeysAndNumberObjectsUsingBlock:(void (^)(id key, NSNumber *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsUsingBlock:block withCastFunction:ht_numberOfValue];
}

#pragma mark - Enumerate with Options

- (void)ht_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
    [self enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
}

- (void)ht_enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateKeysAndObjectsWithOptions:opts usingBlock:^(id key, id obj, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(key, castedObj, stop);
        }
    }];
}

- (void)ht_enumerateKeysAndArrayObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSArray *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:ht_arrayOfValue];
}

- (void)ht_enumerateKeysAndDictObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSDictionary *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:ht_dictOfValue];
}

- (void)ht_enumerateKeysAndStringObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSString *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:ht_stringOfValue];
}

- (void)ht_enumerateKeysAndNumberObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, NSNumber *obj, BOOL *stop))block
{
    [self ht_enumerateKeysAndObjectsWithOptions:opts usingBlock:block withCastFunction:ht_numberOfValue];
}

- (NSString *)ht_toJSONStringWithSortedKeyAsc
{
    __block NSString *jsonString = nil;
    NSError *error = nil;
    NSData *httpData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];
    jsonString = [[NSString alloc] initWithData:httpData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end

@implementation NSMutableDictionary (HTTypeCast)

- (void)ht_addEntriesFromDictionary:(NSDictionary *)dictionary classes:(id)object, ...
{
    if (!dictionary.count || !object) return;
    
    NSMutableArray* classesArray = [NSMutableArray array];
    id paraObj = object;
    va_list objects;
    va_start(objects, object);
    do
    {
        [classesArray addObject:paraObj];
        paraObj = va_arg(objects, id);
    } while (paraObj);
    va_end(objects);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [dictionary ht_enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *dictionaryStop) {
        [classesArray enumerateObjectsUsingBlock:^(id clazz, NSUInteger idx, BOOL *classStop) {
            if ([obj isKindOfClass:clazz]) {
                [self setObject:obj forKey:key];
                *classStop = YES;
            }
        }];
    }];
#pragma clang diagnostic pop
}

@end
