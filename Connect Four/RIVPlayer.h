//
//  RIVPlayer.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RIVPlayer : NSObject

@property (assign, nonatomic) UIColor *color;
@property (weak, nonatomic) NSArray *gamePieces;
@property (readwrite, nonatomic) BOOL isCurrentTurn;

- (instancetype)initWithColor:(UIColor *)color;

@end
