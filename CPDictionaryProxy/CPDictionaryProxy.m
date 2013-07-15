
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
		self.wrapperDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
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
		// cut of the 'set' and the ':' from method signature, e.g. 'setName:' -> 'Name'
		NSString* signature = [selectorString substringWithRange:NSMakeRange(3, selectorString.length-4)];
		// change first character into lower case 
		NSString* signatureFirstChar = [[signature substringToIndex:1] lowercaseString];
		NSString* signatureFromSecondChar = [signature substringFromIndex:1];
		NSString* key = [signatureFirstChar stringByAppendingString:signatureFromSecondChar];
		// get the value
        void* value;
		[anInvocation getArgument:&value atIndex:2]; // method arguments start at index 2 (self=0 + cmd=1)
		// setting value to nil has to be interpreted as remove, so check argument
        if (value) {
            // Reconstruct invocation Step 2: change the method name to setObject:forKey:
			[anInvocation setSelector:@selector(setObject:forKey:)];
            // Reconstruct invocation Step 3: set key as first param
            [anInvocation setArgument:&value atIndex:2];
            // Reconstruct invocation Step 4: set key as second param
            [anInvocation setArgument:&key atIndex:3];
        } else {
            // Reconstruct invocation Step 2: change the method name to removeObjectForKey
            [anInvocation setSelector:@selector(removeObjectForKey:)];
            // Reconstruct invocation Step 3: set key as first param
			[anInvocation setArgument:&key atIndex:2];
        }
		[anInvocation invoke];
	} else {
		// Reconstruct invocation Step 2: change the method name to objectForKey
		[anInvocation setSelector:@selector(objectForKey:)];
		// Reconstruct invocation Step 3: use the old method name as first param
		[anInvocation setArgument:&selectorString atIndex:2]; // method arguments start at index 2 (self=0 + cmd=1)
		// execute it
		[anInvocation invoke];
		
		// Special case: A NSDictionary inside -> make a proxy for it
		void* returnValue;
		[anInvocation getReturnValue:&returnValue];
		if ([(__bridge id)returnValue isKindOfClass:[NSDictionary class]]) {
			void* wrappedReturnValue = (__bridge void*) [self proxyForSelector:calledSelector];
			[anInvocation setReturnValue:&wrappedReturnValue];
		}
	}
}

@end
