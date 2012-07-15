
//  Created by Karsten Litsche on 13.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.

#import "CPViewController.h"
#import "CPDictionaryProxy_ExamplePlist.h"

@implementation CPViewController

@synthesize labelAge, labelName, labelCompany, labelCountry;
@synthesize labelAgeProxy, labelNameProxy, labelCompanyProxy, labelCountryProxy;
@synthesize labelAgeSet, labelNameSet, labelCompanySet, labelCountrySet;
@synthesize labelAgeSetProxy, labelNameSetProxy, labelCompanySetProxy, labelCountrySetProxy;

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
		self.labelCountry.text = [[dict objectForKey:@"address"] objectForKey:@"country"];
		// SETTER
		[dict setObject:@"john doe" forKey:@"name"];
		[dict setObject:@"unknown" forKey:@"company"];
		[dict setObject:[NSNumber numberWithInt:42] forKey:@"age"];
		NSMutableDictionary* innerDict = [dict objectForKey:@"address"];
			[innerDict setObject:@"austria" forKey:@"country"];
		[dict setObject:innerDict forKey:@"address"];
		self.labelNameSet.text = [dict objectForKey:@"name"];
		self.labelCompanySet.text = [dict objectForKey:@"company"];
		self.labelAgeSet.text = ((NSNumber*)[dict objectForKey:@"age"]).stringValue;
		self.labelCountrySet.text = [[dict objectForKey:@"address"] objectForKey:@"country"];
	}

	// this is the proxy solution
	{
		// GETTER
		NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
		CPDictionaryProxy* dictProxy = [CPDictionaryProxy newWithDictionary:dict];
		self.labelNameProxy.text = dictProxy.name;
		self.labelCompanyProxy.text = dictProxy.company;
		self.labelAgeProxy.text = dictProxy.age.stringValue;
		self.labelCountryProxy.text = dictProxy.address.country;
		// SETTER
		dictProxy.name = @"john doe";
		dictProxy.company = @"unknown";
		dictProxy.age = [NSNumber numberWithInt:42];
		dictProxy.address.country = @"austria";
		self.labelNameSetProxy.text = dictProxy.name;
		self.labelCompanySetProxy.text = dictProxy.company;
		self.labelAgeSetProxy.text = dictProxy.age.stringValue;
		self.labelCountrySetProxy.text = dictProxy.address.country;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
