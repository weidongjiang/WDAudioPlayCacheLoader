//
//  NSDictionary+BlocksKit.m
//  BlocksKit
//

#import "NSDictionary+YXBlocksKit.h"

@implementation NSDictionary (YXBlocksKit)

- (void)yx_each:(void (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		block(key, obj);
	}];
}

- (void)yx_apply:(void (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	[self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
		block(key, obj);
	}];
}

- (id)yx_match:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	return self[[[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
		if (block(key, obj)) {
			*stop = YES;
			return YES;
		}

		return NO;
	}] anyObject]];
}

- (NSDictionary *)yx_select:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	NSArray *keys = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
		return block(key, obj);
	}] allObjects];

	NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
	return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSDictionary *)yx_reject:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);
	return [self yx_select:^BOOL(id key, id obj) {
		return !block(key, obj);
	}];
}

- (NSDictionary *)yx_map:(id (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];

	[self yx_each:^(id key, id obj) {
		id value = block(key, obj) ?: [NSNull null];
		result[key] = value;
	}];

	return result;
}

- (BOOL)yx_any:(BOOL (^)(id key, id obj))block
{
	return [self yx_match:block] != nil;
}

- (BOOL)yx_none:(BOOL (^)(id key, id obj))block
{
	return [self yx_match:block] == nil;
}

- (BOOL)yx_all:(BOOL (^)(id key, id obj))block
{
	NSParameterAssert(block != nil);

	__block BOOL result = YES;

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		if (!block(key, obj)) {
			result = NO;
			*stop = YES;
		}
	}];

	return result;
}

@end
