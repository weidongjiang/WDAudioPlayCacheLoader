//
//  NSArray+HTTypeCast.m
//  libcocos2d Mac
//
//  Created by 伟东 on 2020/7/6.
//

#import "NSArray+HTTypeCast.h"
#import "HTTTypeCastUtil.h"


#define OAI [self ht_safeObjectAtIndex:index]

@implementation NSArray (HTTypeCast)

- (id)ht_safeObjectAtIndex:(NSUInteger)index
{
    return (index >= self.count) ? nil : [self objectAtIndex:index];
}

#pragma mark - NSObject

- (id)ht_objectAtIndex:(NSUInteger)index
{
    return OAI;
}

- (id)ht_unknownObjectAtIndex:(NSUInteger)index
{
    return OAI;
}

#pragma mark - NSNumber

- (NSNumber *)ht_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue
{
    return ht_numberOfValue(OAI, defaultValue);
}

- (NSNumber *)ht_numberAtIndex:(NSUInteger)index
{
    return [self ht_numberAtIndex:index defaultValue:nil];
}

#pragma mark - NSString

- (NSString *)ht_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;
{
    return ht_stringOfValue(OAI, defaultValue);
}

- (NSString *)ht_stringAtIndex:(NSUInteger)index;
{
    return [self ht_stringAtIndex:index defaultValue:nil];
}

- (NSString *)ht_validStringAtIndex:(NSUInteger)index
{
    NSString *string = [self ht_stringAtIndex:index];
    if (string.length) {
        return string;
    }
    return nil;
}

#pragma mark - NSArray of NSString

- (NSArray *)ht_stringArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return ht_stringArrayOfValue(OAI, defaultValue);
}

- (NSArray *)ht_stringArrayAtIndex:(NSUInteger)index;
{
    return [self ht_stringArrayAtIndex:index defaultValue:nil];
}

#pragma mark - NSDictionary

- (NSDictionary *)ht_dictAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue
{
    return ht_dictOfValue(OAI, defaultValue);
}

- (NSDictionary *)ht_dictAtIndex:(NSUInteger)index
{
    return [self ht_dictAtIndex:index defaultValue:nil];
}

-(NSDictionary *)ht_validDictAtIndex:(NSUInteger)index
{
    NSDictionary *dictionary = [self ht_dictAtIndex:index];
    if (dictionary.count) {
        return dictionary;
    }
    return nil;
}

#pragma mark - NSArray

- (NSArray *)ht_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return ht_arrayOfValue(OAI, defaultValue);
}

- (NSArray *)ht_arrayAtIndex:(NSUInteger)index
{
    return [self ht_arrayAtIndex:index defaultValue:nil];
}

- (NSArray *)ht_validArrayAtIndex:(NSUInteger)index
{
    NSArray *array = [self ht_arrayAtIndex:index];
    if (array.count) {
        return array;
    }
    return nil;
}

#pragma mark - Float

- (float)ht_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue;
{
    return ht_floatOfValue(OAI, defaultValue);
}

- (float)ht_floatAtIndex:(NSUInteger)index;
{
    return [self ht_floatAtIndex:index defaultValue:0.0f];
}

#pragma mark - Double

- (double)ht_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue;
{
    return ht_doubleOfValue(OAI, defaultValue);
}

- (double)ht_doubleAtIndex:(NSUInteger)index;
{
    return [self ht_doubleAtIndex:index defaultValue:0.0];
}

#pragma mark - CGPoint

- (CGPoint)ht_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue
{
    return ht_pointOfValue(OAI, defaultValue);
}

- (CGPoint)ht_pointAtIndex:(NSUInteger)index;
{
    return [self ht_pointAtIndex:index defaultValue:HTZeroPoint];
}

#pragma mark - CGSize

- (CGSize)ht_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue;
{
    return ht_sizeOfValue(OAI, defaultValue);
}

- (CGSize)ht_sizeAtIndex:(NSUInteger)index;
{
    return [self ht_sizeAtIndex:index defaultValue:HTZeroSize];
}

#pragma mark - CGRect

- (CGRect)ht_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue;
{
    return ht_rectOfValue(OAI, defaultValue);
}

- (CGRect)ht_rectAtIndex:(NSUInteger)index;
{
    return [self ht_rectAtIndex:index defaultValue:HTZeroRect];
}

#pragma mark - BOOL

- (BOOL)ht_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;
{
    return ht_boolOfValue(OAI, defaultValue);
}

- (BOOL)ht_boolAtIndex:(NSUInteger)index;
{
    return [self ht_boolAtIndex:index defaultValue:NO];
}

#pragma mark - Int

- (int)ht_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue;
{
    return ht_intOfValue(OAI, defaultValue);
}

- (int)ht_intAtIndex:(NSUInteger)index;
{
    return [self ht_intAtIndex:index defaultValue:0];
}

#pragma mark - Unsigned Int

- (unsigned int)ht_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue;
{
    return ht_unsignedIntOfValue(OAI, defaultValue);
}

- (unsigned int)ht_unsignedIntAtIndex:(NSUInteger)index;
{
    return [self ht_unsignedIntAtIndex:index defaultValue:0];
}

#pragma mark - Long Long

- (long long int)ht_longLongAtIndex:(NSUInteger)index defaultValue:(long long int)defaultValue
{
    return ht_longLongOfValue(OAI, defaultValue);
}

- (long long int)ht_longLongAtIndex:(NSUInteger)index
{
    return [self ht_longLongAtIndex:index defaultValue:0LL];
}

#pragma mark - Unsigned Long Long

- (unsigned long long int)ht_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long int)defaultValue;
{
    return ht_unsignedLongLongOfValue(OAI, defaultValue);
}

- (unsigned long long int)ht_unsignedLongLongAtIndex:(NSUInteger)index;
{
    return [self ht_unsignedLongLongAtIndex:index defaultValue:0ULL];
}

#pragma mark - NSInteger

- (NSInteger)ht_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue;
{
    return ht_integerOfValue(OAI, defaultValue);
}

- (NSInteger)ht_integerAtIndex:(NSUInteger)index;
{
    return [self ht_integerAtIndex:index defaultValue:0];
}

#pragma mark - Unsigned Integer

- (NSUInteger)ht_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue
{
    return ht_unsignedIntegerOfValue(OAI, defaultValue);
}

- (NSUInteger)ht_unsignedIntegerAtIndex:(NSUInteger)index
{
    return [self ht_unsignedIntegerAtIndex:index defaultValue:0];
}

#pragma mark - UIImage

- (UIImage *)ht_imageAtIndex:(NSUInteger)index defaultValue:(UIImage *)defaultValue
{
    return ht_imageOfValue(OAI, defaultValue);
}

- (UIImage *)ht_imageAtIndex:(NSUInteger)index
{
    return [self ht_imageAtIndex:index defaultValue:nil];
}

#pragma mark - UIColor

- (UIColor *)ht_colorAtIndex:(NSUInteger)index defaultValue:(UIColor *)defaultValue
{
    return ht_colorOfValue(OAI, defaultValue);
}

- (UIColor *)ht_colorAtIndex:(NSUInteger)index
{
    return [self ht_colorAtIndex:index defaultValue:[UIColor whiteColor]];
}

#pragma mark - Time

- (time_t)ht_timeAtIndex:(NSUInteger)index defaultValue:(time_t)defaultValue
{
    return ht_timeOfValue(OAI, defaultValue);
}

- (time_t)ht_timeAtIndex:(NSUInteger)index
{
    time_t defaultValue = [[NSDate date] timeIntervalSince1970];
    return [self ht_timeAtIndex:index defaultValue:defaultValue];
}

#pragma mark - NSDate

- (NSDate *)ht_dateAtIndex:(NSUInteger)index
{
    return ht_dateOfValue(OAI);
}

#pragma mark - NSURL
- (NSURL *)ht_urlAtIndex:(NSUInteger)index defaultValue:(NSURL *)defaultValue
{
    return ht_urlOfValue(OAI, defaultValue);
}

- (NSURL *)ht_urlForKey:(NSUInteger)index
{
    return [self ht_urlAtIndex:index defaultValue:nil];
}

#pragma mark - Enumerate

- (void)ht_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self enumerateObjectsUsingBlock:block];
}

- (void)ht_enumerateUnknownObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self enumerateObjectsUsingBlock:block];
}

- (void)ht_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(castedObj, idx, stop);
        }
    }];
}

- (void)ht_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block classes:(id)object, ...
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
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
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
            block(obj, idx, stop);
        }
    }];
}

- (void)ht_enumerateArrayObjectsUsingBlock:(void (^)(NSArray *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsUsingBlock:block withCastFunction:ht_arrayOfValue];
}

- (void)ht_enumerateDictObjectsUsingBlock:(void (^)(NSDictionary *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsUsingBlock:block withCastFunction:ht_dictOfValue];
}

- (void)ht_enumerateStringObjectsUsingBlock:(void (^)(NSString *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsUsingBlock:block withCastFunction:ht_stringOfValue];
}

- (void)ht_enumerateNumberObjectsUsingBlock:(void (^)(NSNumber *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsUsingBlock:block withCastFunction:ht_numberOfValue];
}

#pragma mark - Enumerate with Options

- (void)ht_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [self enumerateObjectsWithOptions:opts usingBlock:block];
}

- (void)ht_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block withCastFunction:(id (*)(id, id))castFunction
{
    [self enumerateObjectsWithOptions:opts usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id castedObj = castFunction(obj, nil);
        if (castedObj)
        {
            block(castedObj, idx, stop);
        }
    }];
}

- (void)ht_enumerateArrayObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSArray *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:ht_arrayOfValue];
}

- (void)ht_enumerateDictObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSDictionary *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:ht_dictOfValue];
}

- (void)ht_enumerateStringObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSString *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:ht_stringOfValue];
}

- (void)ht_enumerateNumberObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(NSNumber *obj, NSUInteger idx, BOOL *stop))block
{
    [self ht_enumerateObjectsWithOptions:opts usingBlock:block withCastFunction:ht_numberOfValue];
}

- (NSArray *)ht_typeCastedObjectsWithCastFunction:(id (*)(id, id))castFunction
{
    NSMutableArray * result = [NSMutableArray array];
    [self ht_enumerateObjectsWithOptions:0 usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj) {
            [result addObject:obj];
        }
    } withCastFunction:castFunction];
    return result;
}

- (NSArray *)ht_stringObjects
{
    return [self ht_typeCastedObjectsWithCastFunction:ht_stringOfValue];
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
