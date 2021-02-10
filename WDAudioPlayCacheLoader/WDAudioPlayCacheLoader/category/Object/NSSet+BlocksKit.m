//
//  NSSet+BlocksKit.m
//  BlocksKit
//

#import "NSSet+BlocksKit.h"

@implementation NSSet (BlocksKit)

- (void)yx_each:(void (^)(id obj))block
{
	NSParameterAssert(block != nil);

	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		block(obj);
	}];
}

- (void)yx_apply:(void (^)(id obj))block
{
	NSParameterAssert(block != nil);

	[self enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, BOOL *stop) {
		block(obj);
	}];
}

- (id)yx_match:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);

	return [[self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
		if (block(obj)) {
			*stop = YES;
			return YES;
		}

		return NO;
	}] anyObject];
}

- (NSSet *)yx_select:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);

	return [self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
		return block(obj);
	}];
}

- (NSSet *)yx_reject:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);

	return [self objectsPassingTest:^BOOL(id obj, BOOL *stop) {
		return !block(obj);
	}];
}

- (NSSet *)yx_map:(id (^)(id obj))block
{
	NSParameterAssert(block != nil);

	NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];

	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		id value = block(obj) ?:[NSNull null];
		[result addObject:value];
	}];

	return result;
}

- (id)yx_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block
{
	NSParameterAssert(block != nil);

	__block id result = initial;

	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		result = block(result, obj);
	}];

	return result;
}

- (BOOL)yx_any:(BOOL (^)(id obj))block
{
	return [self yx_match:block] != nil;
}

- (BOOL)yx_none:(BOOL (^)(id obj))block
{
	return [self yx_match:block] == nil;
}

- (BOOL)yx_all:(BOOL (^)(id obj))block
{
	NSParameterAssert(block != nil);

	__block BOOL result = YES;

	[self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		if (!block(obj)) {
			result = NO;
			*stop = YES;
		}
	}];

	return result;
}

@end
