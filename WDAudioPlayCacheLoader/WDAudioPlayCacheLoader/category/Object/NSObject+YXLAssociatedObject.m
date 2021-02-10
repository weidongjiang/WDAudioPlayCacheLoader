//
//  NSObject+YXLAssociatedObject.m
//  YXLiveVideoApp
//
//  Created by zhangyun on 16/8/10.
//  Copyright © 2016年 YIXIA. All rights reserved.
//

#import "NSObject+YXLAssociatedObject.h"
#import <objc/runtime.h>

#pragma mark - Weak support

@interface _YXLWeakAssociatedObject : NSObject

@property (nonatomic, weak) id value;

@end

@implementation _YXLWeakAssociatedObject

@end

@implementation NSObject (YXLAssociatedObject)

#pragma mark - Instance Methods

- (void)yxl_associateValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yxl_atomicallyAssociateValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void)yxl_associateCopyOfValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)yxl_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

- (void)yxl_weaklyAssociateValue:(__autoreleasing id)value withKey:(const void *)key
{
    _YXLWeakAssociatedObject *assoc = objc_getAssociatedObject(self, key);
    if (!assoc) {
        assoc = [_YXLWeakAssociatedObject new];
        [self yxl_associateValue:assoc withKey:key];
    }
    assoc.value = value;
}

- (id)yxl_associatedValueForKey:(const void *)key
{
    id value = objc_getAssociatedObject(self, key);
    if (value && [value isKindOfClass:[_YXLWeakAssociatedObject class]]) {
        return [(_YXLWeakAssociatedObject *)value value];
    }
    return value;
}

- (void)yxl_removeAllAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}

#pragma mark - Class Methods

+ (void)yxl_associateValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)yxl_atomicallyAssociateValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

+ (void)yxl_associateCopyOfValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)yxl_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

+ (void)yxl_weaklyAssociateValue:(__autoreleasing id)value withKey:(const void *)key
{
    _YXLWeakAssociatedObject *assoc = objc_getAssociatedObject(self, key);
    if (!assoc) {
        assoc = [_YXLWeakAssociatedObject new];
        [self yxl_associateValue:assoc withKey:key];
    }
    assoc.value = value;
}

+ (id)yxl_associatedValueForKey:(const void *)key
{
    id value = objc_getAssociatedObject(self, key);
    if (value && [value isKindOfClass:[_YXLWeakAssociatedObject class]]) {
        return [(_YXLWeakAssociatedObject *)value value];
    }
    return value;
}

+ (void)yxl_removeAllAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}
@end