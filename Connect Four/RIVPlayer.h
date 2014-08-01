//
//  RIVPlayer.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RIVGamePiece.h"

@interface RIVPlayer : NSObject

@property (readonly, nonatomic) NSMutableArray *unplayedPieces;
@property (readonly, nonatomic) RIVGamePieceColor color;

- (instancetype)initWithColor:(RIVGamePieceColor)color andPieceCount:(NSInteger)count;

- (void)removePieceFromPlayerPool;

@end