//
//  QuotesCollectionViewCell.h
//  Naxex test
//
//  Created by Miroslav Ganchev on 6/19/16.
//  Copyright © 2016 Miroslav Ganchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sellTriangleImage;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *buyTriangleImage;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) NSDictionary *quote;
@end
