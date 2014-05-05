//
//  Connect_FourTests.m
//  Connect FourTests
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RIVGamePiece.h"
#import "RIVGameBoard.h"
#import "RIVPlayer.h"

@interface Connect_FourTests : XCTestCase

@property (strong, nonatomic) RIVGameBoard *gameBoard;

@end

@implementation Connect_FourTests

- (void)setUp
{
    [super setUp];
    
    self.gameBoard = [[RIVGameBoard alloc] initWithPlayers];
}

- (void)tearDown
{
    _gameBoard = nil;
    
    [super tearDown];
}

- (void)testColorOfNewPiece
{
    RIVGamePiece *redPiece = [RIVGamePiece redPiece];
    RIVGamePiece *blackPiece = [RIVGamePiece blackPiece];
    
    XCTAssertEqual(blackPiece.color, [UIColor blackColor], @"blackPiece should be black");
    XCTAssertEqual(redPiece.color, [UIColor redColor], @"redPiece should be red");
    
}

- (void)testNewGamePlayerCount
{
    XCTAssertTrue(self.gameBoard.players.count == 2, @"new gameBoard should have two players");
}

- (void)testNewPlayersColor
{
    RIVPlayer *firstPlayer = [self.gameBoard.players firstObject];
    RIVPlayer *secondPlayer = [self.gameBoard.players lastObject];
    
    XCTAssertNotEqual(firstPlayer.color, secondPlayer.color, @"players should have different colors");
    
    XCTAssertTrue([firstPlayer.color isEqual:[UIColor blackColor]] || [secondPlayer.color isEqual:[UIColor blackColor]] , @"One player's color should be black");
    XCTAssertTrue([firstPlayer.color isEqual:[UIColor redColor]] || [secondPlayer.color isEqual:[UIColor redColor]] , @"One player's color should be red");
}

- (void)testNewGamePlayersExist
{
    for (NSInteger i = 0; i < self.gameBoard.players.count; i++) {
        XCTAssertNotNil(self.gameBoard.players[i], @"player %d should exist", i);
    }
}

- (void)testGameBoardForPieces
{
    for (RIVGamePiece *piece in self.gameBoard.pieces) {
        XCTAssertEqualObjects(piece.gameboard, self.gameBoard, @"pieces should reference their gameboard");
    }
}

- (void)testPieceColorEqualsPlayerColor
{
    for (RIVPlayer *player in self.gameBoard.players) {
        for (RIVGamePiece *piece in player.gamePieces) {
            XCTAssertEqual(piece.color, player.color, @"player color should equal the color of every piece the player has");
        }
    }
}

@end



















