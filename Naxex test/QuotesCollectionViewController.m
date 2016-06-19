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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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
    cell.symbolLabel.text = [quote objectForKey:@"DisplayName"];
    cell.buyPriceLabel.text = [quote objectForKey:@"Bid"];
    cell.sellPriceLabel.text = [quote objectForKey:@"Ask"];
    NSNumber *changeOrientation = [quote objectForKey:@"ChangeOrientation"];
    if (changeOrientation.integerValue == 1) {
        cell.buyTriangleImage.hidden = NO;
        cell.buyTriangleImage.image = [UIImage imageNamed:@"triangle_up"];
    }else if (changeOrientation.integerValue == 2){
        cell.buyTriangleImage.hidden = NO;
        cell.buyTriangleImage.image = [UIImage imageNamed:@"triangle_down"];
    }else{
        cell.buyTriangleImage.hidden = YES;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

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
