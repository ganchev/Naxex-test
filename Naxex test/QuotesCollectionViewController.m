//
//  QuotesCollectionViewController.m
//  Naxex test
//
//  Created by Miroslav Ganchev on 6/19/16.
//  Copyright © 2016 Miroslav Ganchev. All rights reserved.
//

#import "QuotesCollectionViewController.h"
#import "QuotesCollectionViewCell.h"

@interface QuotesCollectionViewController ()

@end

@implementation QuotesCollectionViewController

static NSString * const reuseIdentifier = @"quoteCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getQuotes:) name:@"getQuotes" object:nil];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
     [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.quotesList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QuotesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *quote = [self.quotesList objectAtIndex:indexPath.row];
    cell.quote = quote;
    cell.buyButton.tag = indexPath.row;
    cell.sellButton.tag = indexPath.row;
    cell.symbolLabel.text = [quote objectForKey:@"DisplayName"];
    NSString *buyPrice = [quote objectForKey:@"Bid"];
    NSString *sellPrice = [quote objectForKey:@"Ask"];
    const NSRange range = NSMakeRange(4, 2);
    NSNumber *changeOrientation = [quote objectForKey:@"ChangeOrientation"];
    if (changeOrientation.integerValue == 1) {
        // Create the attributes
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont fontWithName:@"HelveticaNeue-Light" size:12], NSFontAttributeName,
                                [UIColor greenColor], NSForegroundColorAttributeName, nil];
        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"HelveticaNeue-Light" size:16], NSFontAttributeName,
                                  [UIColor greenColor], NSForegroundColorAttributeName,nil];
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:buyPrice attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        cell.buyPriceLabel.attributedText = attributedText;
        attributedText = [[NSMutableAttributedString alloc] initWithString:sellPrice attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        cell.sellPriceLabel.attributedText = attributedText;
        cell.buyTriangleImage.hidden = NO;
        cell.buyTriangleImage.image = [UIImage imageNamed:@"triangle_up"];
        cell.sellTriangleImage.hidden = NO;
        cell.sellTriangleImage.image = [UIImage imageNamed:@"triangle_up"];
    }else if (changeOrientation.integerValue == 2){
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont fontWithName:@"HelveticaNeue-Light" size:12], NSFontAttributeName,
                               [UIColor redColor], NSForegroundColorAttributeName, nil];
        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"HelveticaNeue-Light" size:16], NSFontAttributeName,
                                  [UIColor redColor], NSForegroundColorAttributeName,nil];
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:buyPrice attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        cell.buyPriceLabel.attributedText = attributedText;
        attributedText = [[NSMutableAttributedString alloc] initWithString:sellPrice attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        cell.sellPriceLabel.attributedText = attributedText;
        cell.buyTriangleImage.hidden = NO;
        cell.buyTriangleImage.image = [UIImage imageNamed:@"triangle_down"];
        cell.sellTriangleImage.hidden = NO;
        cell.sellTriangleImage.image = [UIImage imageNamed:@"triangle_down"];
    }else{
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont fontWithName:@"HelveticaNeue-Light" size:12], NSFontAttributeName,
                               [UIColor darkTextColor], NSForegroundColorAttributeName, nil];
        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"HelveticaNeue-Light" size:16], NSFontAttributeName,
                                  [UIColor darkTextColor], NSForegroundColorAttributeName,nil];
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:buyPrice attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        cell.buyPriceLabel.attributedText = attributedText;
        attributedText = [[NSMutableAttributedString alloc] initWithString:sellPrice attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        cell.sellPriceLabel.attributedText = attributedText;
        cell.buyTriangleImage.hidden = YES;
        cell.sellTriangleImage.hidden = YES;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"quotesHeader" forIndexPath:indexPath];
        return reusableview;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 120);
}

#pragma mark Actions

- (IBAction)onSell:(UIButton *)sender {
    NSDictionary *quote = [self.quotesList objectAtIndex:sender.tag];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Current Ask" message:[NSString stringWithFormat:@"Currency: %@ price: %@", [quote objectForKey:@"DisplayName"],[quote objectForKey:@"Ask"]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (IBAction)onBuy:(UIButton *)sender {
    NSDictionary *quote = [self.quotesList objectAtIndex:sender.tag];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Current Bid" message:[NSString stringWithFormat:@"Currency: %@ price: %@", [quote objectForKey:@"DisplayName"],[quote objectForKey:@"Bid"]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void) getQuotes:(NSNotification *) notification{
    if ([notification.object isKindOfClass:[NSArray class]])
    {
        self.quotesList = [notification object];
        [self.collectionView reloadData];
    }
    else
    {
        NSLog(@"Error, object not recognised.");
    }
}

@end
