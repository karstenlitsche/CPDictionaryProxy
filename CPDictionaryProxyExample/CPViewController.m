
//  Created by Karsten Litsche on 13.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.

#import "CPViewController.h"
#import "CPDictionaryProxy_ExamplePlist.h"

@implementation CPViewController

@synthesize labelAge, labelName, labelCompany;
@synthesize labelAgeProxy, labelNameProxy, labelCompanyProxy;
@synthesize labelAgeSet, labelNameSet, labelCompanySet;
@synthesize labelAgeSetProxy, labelNameSetProxy, labelCompanySetProxy;

- (void)viewDidLoad {
    [super viewDidLoad];
	NSString* fileName = [[NSBundle mainBundle] pathForResource:@"ExamplePlist" ofType:@"plist"];
	
	// this is the apple way
	{
		// GETTER
		NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
		self.labelName.text = [dict objectForKey:@"name"];
		self.labelCompany.text = [dict objectForKey:@"company"];
		self.labelAge.text = ((NSNumber*)[dict objectForKey:@"age"]).stringValue;
		// SETTER
		[dict setObject:@"john doe" forKey:@"name"];
		[dict setObject:@"unknown" forKey:@"company"];
		[dict setObject:[NSNumber numberWithInt:42] forKey:@"age"];
		self.labelNameSet.text = [dict objectForKey:@"name"];
		self.labelCompanySet.text = [dict objectForKey:@"company"];
		self.labelAgeSet.text = ((NSNumber*)[dict objectForKey:@"age"]).stringValue;
	}

	// this is the proxy solution
	{
		// GETTER
		NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfFile:fileName];
		CPDictionaryProxy* dictProxy = [CPDictionaryProxy newWithDictionary:dict];
		self.labelNameProxy.text = dictProxy.name;
		self.labelCompanyProxy.text = dictProxy.company;
		self.labelAgeProxy.text = dictProxy.age.stringValue;
		// SETTER
//		dictProxy.name = @"john doe";
//		dictProxy.company = @"unknown";
//		dictProxy.age = [NSNumber numberWithInt:42];
//		self.labelNameSetProxy.text = dictProxy.name;
//		self.labelCompanySetProxy.text = dictProxy.company;
//		self.labelAgeSetProxy.text = dictProxy.age.stringValue;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
