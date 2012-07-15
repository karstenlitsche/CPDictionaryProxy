
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

// TODO

@end
