//
//  YelpResultsCell.h
//  yelp
//
//  Created by Sarath Yalamanchili on 9/22/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YelpResultsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resturantImageView;
@property (weak, nonatomic) IBOutlet UILabel *resturantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *resturantRatingsImageView;
@property (weak, nonatomic) IBOutlet UILabel *resturantReviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *resturantAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *resturantCategoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *resturantDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *resturantPriceLabel;


@end
