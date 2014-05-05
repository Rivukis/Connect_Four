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

@end
















