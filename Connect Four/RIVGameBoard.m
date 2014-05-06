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
#import "RIVPlaySpot.h"

@implementation RIVGameBoard

- (instancetype)initWithPlayers
{
    self = [super init];
    if (self) {
        // Make and Add Players
        RIVPlayer *firstPlayer = [[RIVPlayer alloc] initWithColor:[UIColor blackColor] andPieceCount:21];
        RIVPlayer *secondPlayer = [[RIVPlayer alloc] initWithColor:[UIColor redColor] andPieceCount:21];
        self.players = @[firstPlayer, secondPlayer];
        
        // Randomly Choose Who Goes First
        ((RIVPlayer *)self.players[arc4random_uniform(self.players.count)]).isCurrentTurn = YES;
    }
    return self;
}

- (NSMutableArray *)playedPieces
{
    if (!_playedPieces) {
        _playedPieces = [NSMutableArray new];
    }
    return _playedPieces;
}

- (BOOL)playPlayers:(RIVPlayer *)player gamePiece:(RIVGamePiece *)gamePiece onColumn:(NSInteger)column
{
    NSIndexPath *indexPath;
    RIVPlaySpot *tempSpot;
    
    // Find Lowest Row in Given Column
    for (NSInteger row = 0; row < 6; row++) {
        tempSpot = self.spots[column][row];
        if (!tempSpot.hasPiece) {
            indexPath = [NSIndexPath indexPathForRow:row inSection:column];
            break;
        }
    }
    if (indexPath) {
        // Add Piece to GameBoard
        tempSpot.piece = gamePiece;
        tempSpot.hasPiece = YES;
        // Remove Piece from Player
        [player.unplayedPieces removeObject:gamePiece];
        return YES;
    } else {
        return NO;
    }
}

- (NSArray *)spots
{
//            (7) Columns
//    
//    6                         (6)
//    5                          R
//    4                          o
//    3                          w
//    2                          s
//    1, 2, 3, 4, 5, 6, 7
    
    if (!_spots) {
        NSMutableArray *columns = [NSMutableArray new];
        NSMutableArray *rows;
        RIVPlaySpot *spot;
        
        for (NSInteger col = 0; col < 7; col++) {
            rows = [NSMutableArray new];
            for (NSInteger row = 0; row < 6; row++) {
                spot = [RIVPlaySpot new];
                [rows addObject:spot];
            }
            [columns addObject:[rows copy]];
        }
        _spots = [columns copy];
    }
    return _spots;
}

@end
