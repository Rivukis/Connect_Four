//
//  RIVGridLocation.m
//  Connect Four
//
//  Created by Brian Radebaugh on 7/19/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGridLocation.h"

@implementation RIVGridLocation

- (instancetype)initWithRow:(NSInteger)row andColumn:(NSInteger)column
{
    self = [super init];
    if (self) {
        self.row = row;
        self.column = column;
    }
    return self;
}

@end