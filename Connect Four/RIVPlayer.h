//
//  RIVPlayer.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVGameBoard;

@interface RIVPlayer : NSObject

@property (strong, nonatomic) NSMutableArray *unplayedPieces;
@property (assign, nonatomic) UIColor *color;
@property (readwrite, nonatomic) BOOL isCurrentTurn;

- (instancetype)initWithColor:(UIColor *)color andPieceCount:(NSInteger)count;

@end
