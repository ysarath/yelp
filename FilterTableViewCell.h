//
//  FilterTableViewCell.h
//  yelp
//
//  Created by Sarath Yalamanchili on 9/23/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *filterCellSwitch;
@property (weak, nonatomic) IBOutlet UILabel *filterCellLabel;


@end
