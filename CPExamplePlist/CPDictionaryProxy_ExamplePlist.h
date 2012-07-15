
//  Created by Karsten Litsche on 15.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.

#import "CPDictionaryProxy.h"

/** 
 The category defines the plist keys from ExamplePlist.plist and maps them into properties of correct type.
 */
@interface CPDictionaryProxy (ExamplePlist)

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* company;
@property (nonatomic, strong) NSNumber* age;
@property (nonatomic, strong) CPDictionaryProxy* address;

@end

/** 
 The category defines the plist keys from inner dictionary 'address' and maps them into properties of correct type.
 */
@interface CPDictionaryProxy (address)

@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* country;

@end
