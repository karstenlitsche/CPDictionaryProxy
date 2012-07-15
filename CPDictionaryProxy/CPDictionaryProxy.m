
//  Created by Karsten Litsche on 15.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.

#import "CPDictionaryProxy.h"

@implementation CPDictionaryProxy

@synthesize wrapperDict;

#pragma mark - initializers that create an empty NSMutableDictionary

- (id) init {
    NSDictionary* dict = [NSMutableDictionary new];
	return [self initWithDictionary:dict];
}
+ (id) new {
	return [[CPDictionaryProxy alloc] init];
}

#pragma mark - initializers that use the given NSDictionary

- (id) initWithDictionary:(NSDictionary*)dict {
	if (self) {
		if ([dict isKindOfClass:[NSMutableDictionary class]]) {
			self.wrapperDict = (id)dict;	
		} else {
			self.wrapperDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
		}
	}
	return self;
}
+ (CPDictionaryProxy*) newWithDictionary:(NSDictionary*)dict {
	return [[CPDictionaryProxy alloc] initWithDictionary:dict];
}

#pragma mark - the invocation manipulation

- (BOOL) selectorIsASetter:(SEL)aSelector {
	NSString* selectorString = NSStringFromSelector(aSelector);
	return ([selectorString hasPrefix:@"set"]);
}

- (NSMethodSignature*) methodSignatureForSelector:(SEL)aSelector {
	return [self.wrapperDict methodSignatureForSelector:([self selectorIsASetter:aSelector] ? 
														 @selector(setObject:forKey:) :
														 @selector(objectForKey:))];
}

- (CPDictionaryProxy*) proxyForSelector:(SEL)aSelector {
	return [CPDictionaryProxy newWithDictionary:[self.wrapperDict objectForKey:NSStringFromSelector(aSelector)]];
}

- (void) forwardInvocation:(NSInvocation*)anInvocation {
	// Reconstruct invocation Step 1: change the target from self to self.wrapperDict
	[anInvocation setTarget:self.wrapperDict];
	
	SEL calledSelector = [anInvocation selector];
	NSString* selectorString = NSStringFromSelector(calledSelector);
	if ([self selectorIsASetter:calledSelector]) {
		NSAssert(NO, @"setter not supported yet");
	} else {
		// Reconstruct invocation Step 2: change the method name to objectForKey
		[anInvocation setSelector:@selector(objectForKey:)];
		// Reconstruct invocation Step 3: use the old method name as first param
		[anInvocation setArgument:&selectorString atIndex:2]; // method arguments start at index 2 (self=0 + cmd=1)
		// execute it
		[anInvocation invoke];
	}
}

@end
