//
//  FilterSection.m
//  yelp
//
//  Created by Sarath Yalamanchili on 9/23/14.
//  Copyright (c) 2014 Sarath. All rights reserved.
//

#import "FilterSection.h"

@implementation FilterSection

- (id)initWithIdentifier:(NSString *)key label:(NSString *)label filters:(NSArray *)filters {
    self = [super init];
    if (self) {
        _key = key;
        _label = label;
        _filters = filters;
    }
    return self;
}

@end
