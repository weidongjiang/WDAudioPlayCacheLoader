//
//  NSArray+HTUtilities.m
//  cocos2d_libs
//
//  Created by 伟东 on 2020/7/21.
//

#import "NSArray+HTUtilities.h"
#import "NSFileManager+HTUtilities.h"
#import <time.h>
#import <stdarg.h>

#pragma mark StringExtensions

@implementation NSArray (HTStringExtensions)

- (NSArray *) ht_arrayBySortingStrings
{
    NSMutableArray *sort = [NSMutableArray arrayWithArray:self];
    for (id eachitem in self)
        if (![eachitem isKindOfClass:[NSString class]])    [sort removeObject:eachitem];
    return [sort sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSString *) yxtStringValue
{
    return [self componentsJoinedByString:@" "];
}

@end

#pragma mark UtilityExtensions

@implementation NSArray (HTUtilityExtensions)

- (NSArray *) ht_uniqueMembers
{
    NSMutableArray *copy = [self mutableCopy];// autorelease];
    for (id object in self)
    {
        [copy removeObjectIdenticalTo:object];
        [copy addObject:object];
    }
    return copy;
}

- (NSArray *) ht_unionWithArray: (NSArray *) anArray
{
    if (!anArray) return self;
    return [[self arrayByAddingObjectsFromArray:anArray] ht_uniqueMembers];
}

- (NSArray *)ht_intersectionWithArray:(NSArray *)anArray {
    NSMutableArray *copy = [self mutableCopy];// autorelease];
    for (id object in self)
        if (![anArray containsObject:object])
            [copy removeObjectIdenticalTo:object];
    return [copy ht_uniqueMembers];
}

- (NSArray *)ht_intersectionWithSet:(NSSet *)anSet
{
    NSMutableArray *copy = [self mutableCopy];// autorelease];
    for (id object in self)
        if (![anSet containsObject:object])
            [copy removeObjectIdenticalTo:object];
    return [copy ht_uniqueMembers];
}

// http://en.wikipedia.org/wiki/Complement_(set_theory)
- (NSArray *)ht_complementWithArray:(NSArray *)anArray
{
    NSMutableArray *copy = [self mutableCopy];// autorelease];
    for (id object in self)
        if ([anArray containsObject:object])
            [copy removeObjectIdenticalTo:object];
    return [copy ht_uniqueMembers];
}

- (NSArray *)ht_complementWithSet:(NSSet *)anSet
{
    NSMutableArray *copy = [self mutableCopy];// autorelease];
    for (id object in self)
        if ([anSet containsObject:object])
            [copy removeObjectIdenticalTo:object];
    return [copy ht_uniqueMembers];
}

@end

#pragma mark Mutable UtilityExtensions
@implementation NSMutableArray (YXTUtilityExtensions)
- (void)ht_addSafeObject:(id)obj
{
    if (obj)
    {
        [self addObject:obj];
    }
}

- (void)ht_insertSafeObject:(id)obj atIndex:(NSUInteger)index
{
    if (obj && index<= self.count)
    {
        [self insertObject:obj atIndex:index];
    }
}

+ (NSMutableArray*) ht_arrayWithSet:(NSSet*)set
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[set count]];
    [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [array addObject:obj];
    }];
    return array;
}

- (void)ht_addObjectIfAbsent:(id)object
{
    if (object == nil || [self containsObject:object])
    {
        return;
    }
    
    [self addObject:object];
}

- (NSMutableArray *) ht_reverse
{
    for (int i=0; i<(floor([self count]/2.0)); i++)
        [self exchangeObjectAtIndex:i withObjectAtIndex:([self count]-(i+1))];
    return self;
}

// Make sure to run srandom([[NSDate date] timeIntervalSince1970]); or similar somewhere in your program
- (NSMutableArray *) ht_scramble
{
    for (int i=0; i<([self count]-2); i++)
        [self exchangeObjectAtIndex:i withObjectAtIndex:(i+(random()%([self count]-i)))];
    return self;
}

- (NSMutableArray *) ht_removeFirstObject
{
    [self ht_removeObjectAtIndex:0];
    return self;
}

- (void)ht_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)ht_removeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

@end


#pragma mark StackAndQueueExtensions

@implementation NSMutableArray (YXTStackAndQueueExtensions)

- (id) ht_popObject
{
    if ([self count] == 0) return nil;
    
    id lastObject = [self lastObject];// retain] autorelease];
    [self removeLastObject];
    return lastObject;
}

- (NSMutableArray *) ht_pushObject:(id)object
{
    if (object) {
        [self addObject:object];
    }
    return self;
}

- (NSMutableArray *) ht_pushObjects:(id)object,...
{
    if (!object) return self;
    id obj = object;
    va_list objects;
    va_start(objects, object);
    do
    {
        [self addObject:obj];
        obj = va_arg(objects, id);
    } while (obj);
    va_end(objects);
    return self;
}

- (id) ht_pullObject
{
    if ([self count] == 0) return nil;
    
    id firstObject = [self objectAtIndex:0];// retain] autorelease];
    [self removeObjectAtIndex:0];
    return firstObject;
}

- (NSMutableArray *)ht_push:(id)object
{
    return [self ht_pushObject:object];
}

- (id) ht_pop
{
    return [self ht_popObject];
}

- (id) ht_pull
{
    return [self ht_pullObject];
}

- (void)ht_enqueueObjects:(NSArray *)objects
{
    for (id object in [objects reverseObjectEnumerator]) {
        [self insertObject:object atIndex:0];
    }
}

@end


@implementation NSArray (HTPSLib)

- (id)ht_objectUsingPredicate:(NSPredicate *)predicate {
    NSArray *filteredArray = [self filteredArrayUsingPredicate:predicate];
    if (filteredArray) {
        return [filteredArray firstObject];
    }
    return nil;
}

- (BOOL)ht_isEmpty
{
    return [self count] == 0 ? YES : NO;
}

@end

@implementation NSArray (HTExtendedArray)

- (BOOL)ht_saveToDocumentsPathFile:(NSString *)path
{
    if (path)
    {
        return [self writeToFile:ht_DocumentFileWithName(path) atomically:NO];
    }
    return NO;
}

+ (NSArray *)ht_loadArrayFromDocumentsPath:(NSString *)path
{
    if (path)
    {
        return [NSArray arrayWithContentsOfFile:ht_DocumentFileWithName(path)];
    }
    return nil;
}

@end
