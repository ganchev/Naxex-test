//
//  QuotesTableViewController.m
//  Naxex test
//
//  Created by Miroslav Ganchev on 6/19/16.
//  Copyright © 2016 Miroslav Ganchev. All rights reserved.
//

#import "QuotesTableViewController.h"
#import "QuotesTableViewCell.h"

@interface QuotesTableViewController ()

@end

@implementation QuotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getQuotes:) name:@"getQuotes" object:nil];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.quotesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quoteCell" forIndexPath:indexPath];
    NSDictionary *quote = [self.quotesList objectAtIndex:indexPath.row];
    cell.quote = quote;
    cell.symbolLabel.text = [quote objectForKey:@"DisplayName"];
    cell.buyPriceLabel.text = [quote objectForKey:@"Bid"];
    cell.sellPriceLabel.text = [quote objectForKey:@"Ask"];
    NSNumber *changeOrientation = [quote objectForKey:@"ChangeOrientation"];
    if (changeOrientation.integerValue == 1) {
        cell.buyTriangleImage.hidden = NO;
        cell.buyTriangleImage.image = [UIImage imageNamed:@"triangle_up"];
        cell.sellTriangleImage.hidden = NO;
        cell.sellTriangleImage.image = [UIImage imageNamed:@"triangle_up"];
    }else if (changeOrientation.integerValue == 2){
        cell.buyTriangleImage.hidden = NO;
        cell.buyTriangleImage.image = [UIImage imageNamed:@"triangle_down"];
        cell.sellTriangleImage.hidden = NO;
        cell.sellTriangleImage.image = [UIImage imageNamed:@"triangle_down"];
    }else{
        cell.buyTriangleImage.hidden = YES;
        cell.sellTriangleImage.hidden = YES;
    }
    
    return cell;
}

- (void) getQuotes:(NSNotification *) notification{
    if ([notification.object isKindOfClass:[NSArray class]])
    {
        self.quotesList = [notification object];
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"Error, object not recognised.");
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
