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
#import "RIVGridLocation.h"

const NSInteger numberOfRows = 6;
const NSInteger numberOfColumns = 7;

@implementation RIVGameBoard

- (instancetype)initWithPlayers
{
    self = [super init];
    if (self) {
        // Make and Add Players
        RIVPlayer *firstPlayer = [[RIVPlayer alloc] initWithColor:RIVGamePieceColorBlack andPieceCount:21];
        RIVPlayer *secondPlayer = [[RIVPlayer alloc] initWithColor:RIVGamePieceColorRed andPieceCount:21];
        self.players = @[firstPlayer, secondPlayer];
        
        // Randomly Choose Who Goes First
        NSInteger playerToActIndex = arc4random_uniform(self.players.count);
        self.playerToAct = self.players[playerToActIndex];
    }
    return self;
}


#pragma mark - Helper Methods


// Returns YES if piece was played successfully
- (BOOL)playGamePiece:(RIVGamePiece *)gamePiece onColumn:(NSInteger)column fromPlayer:(RIVPlayer *)player
{
    // Check for Errors and Return NO if Found
    if (!gamePiece || !player || column < 0 || column >= numberOfColumns) return NO;
    
    // Find Next Empty GridLocation in Column
    RIVGridLocation *tempGridLocation;
    NSInteger row = 0;
    while (row < numberOfRows && !tempGridLocation) {
        tempGridLocation = self.grid[row][column];
        if (tempGridLocation.piece) tempGridLocation = nil;
    }
    
    // If No Playable Location then Return NO
    if (!tempGridLocation) return NO;
    
    // Add Piece to GameBoard and Remove Piece from Player
    tempGridLocation.piece = gamePiece;
    [player.unplayedPieces removeObject:gamePiece];
    
    return YES;
}


#pragma mark - Lazy Instantiation


//            (7) Columns
//
//    5                         (6)
//    4                          R
//    3                          o
//    2                          w
//    1                          s
//    0, 1, 2, 3, 4, 5, 6
- (NSArray *)grid
{
    if (!_grid) {
        NSMutableArray *rows = [NSMutableArray new];
        NSMutableArray *columns;
        RIVGridLocation *gridLocation;
        
        for (NSInteger row = 0; row < numberOfRows; row++) {
            columns = [NSMutableArray new];
            for (NSInteger col = 0; col < numberOfColumns; col++) {
                gridLocation = [RIVGridLocation new];
                [columns addObject:gridLocation];
            }
            [rows addObject:[columns copy]];
        }
        _grid = [rows copy];
    }
    return _grid;
}

- (NSArray *)players
{
    if (!_players) _players = [NSArray new];
    return _players;
}

@end