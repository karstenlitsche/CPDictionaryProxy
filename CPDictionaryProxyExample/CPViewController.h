//
//  CPViewController.h
//  CPDictionaryProxyExample
//
//  Created by Karsten Litsche on 13.07.12.
//  Copyright (c) 2012 Compeople. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel* labelName;
@property (nonatomic, weak) IBOutlet UILabel* labelNameProxy;
@property (nonatomic, weak) IBOutlet UILabel* labelCompany;
@property (nonatomic, weak) IBOutlet UILabel* labelCompanyProxy;
@property (nonatomic, weak) IBOutlet UILabel* labelAge;
@property (nonatomic, weak) IBOutlet UILabel* labelAgeProxy;

@end
