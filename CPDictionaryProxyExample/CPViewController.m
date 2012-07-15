
//  Created by Karsten Litsche on 13.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.

#import "CPViewController.h"
#import "CPDictionaryProxy_ExamplePlist.h"

@implementation CPViewController

@synthesize labelAge, labelName, labelCompany;
@synthesize labelAgeProxy, labelNameProxy, labelCompanyProxy;

- (void)viewDidLoad {
    [super viewDidLoad];
	NSString* fileName = [[NSBundle mainBundle] pathForResource:@"ExamplePlist" ofType:@"plist"];
	NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfFile:fileName];
	
	// this is the apple way
	self.labelName.text = [dict objectForKey:@"name"];
	self.labelCompany.text = [dict objectForKey:@"company"];
	self.labelAge.text = ((NSNumber*)[dict objectForKey:@"age"]).stringValue;

	// this is the proxy solution
	CPDictionaryProxy* dictProxy = [CPDictionaryProxy newWithDictionary:dict];
	self.labelNameProxy.text = dictProxy.name;
	self.labelCompanyProxy.text = dictProxy.company;
	self.labelAgeProxy.text = dictProxy.age.stringValue;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
