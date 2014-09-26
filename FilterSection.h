//
//  FilterSection.h
//  yelp
//
//  Created by Sarath Yalamanchili on 9/23/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSection : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSArray *filters;
@end
