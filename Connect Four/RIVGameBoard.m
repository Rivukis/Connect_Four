//
//  RIVGameBoard.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGameBoard.h"
#import "RIVPlayer.h"
#import "RIVGamePiece.h"

@implementation RIVGameBoard

- (instancetype)initWithPlayers
{
    self = [super init];
    if (self) {
        RIVPlayer *firstPlayer = [[RIVPlayer alloc] initWithColor:[UIColor blackColor]];
        RIVPlayer *secondPlayer = [[RIVPlayer alloc] initWithColor:[UIColor redColor]];
        self.players = @[firstPlayer, secondPlayer];
        
//        self.pieces = 
    }
    return self;
}

- (NSArray *)pieces
{
    if (!_pieces) {
        NSMutableArray *tempArray = [NSMutableArray new];
        for (NSInteger i = 0; i < 42; i++) {
            RIVGamePiece *tempPiece = [RIVGamePiece new];
            [tempArray addObject:tempPiece];
        }
        _pieces = tempArray;
    }
    
    return _pieces;
}

@end
