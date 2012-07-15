
//  Created by Karsten Litsche on 15.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.

#import <Foundation/Foundation.h>

/** 
 A CPDictionaryProxy wraps a given NSDictionary so you can use it as a normal object with properties.
 Instead of [dict objectForKey:@"key"] you can call 'dictProxy.key'!
 
 Note The init and new initializers are not supported by a NSProxy because it do not derive from NSObject, but we 
		ensure you can use them by implementing them here. 
 */
@interface CPDictionaryProxy : NSProxy

/** We use this dictionary for reading/storing the values. */
@property (nonatomic, strong) NSMutableDictionary* wrapperDict;

#pragma mark initializers that create an empty NSMutableDictionary

- (id) init;
+ (id) new;

#pragma mark initializers that use the given NSDictionary

/** 
 Initialize a proxy for the dictionary provided. 
 If dict is a NSMutableDictionary it will be used directly, if not the dict will be wrapped inside a newly created NSMutableDictionary.
 */
- (id) initWithDictionary:(NSDictionary*)dict;
/** 
 Creates a proxy with the given dictionary.
 If dict is a NSMutableDictionary it will be used directly, if not the dict will be wrapped inside a newly created NSMutableDictionary.
 */
+ (CPDictionaryProxy*) newWithDictionary:(NSDictionary*)dict;

@end
