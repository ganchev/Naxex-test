//
//  CurrencySelectTableViewController.h
//  Naxex test
//
//  Created by Miroslav Ganchev on 6/20/16.
//  Copyright © 2016 Miroslav Ganchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencySelectTableViewController : UITableViewController

@property (atomic) NSArray *currencyList;
@property (atomic) NSMutableArray *selectedCurrencyList;

@end
