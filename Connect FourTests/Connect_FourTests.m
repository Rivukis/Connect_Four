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

@end

@implementation Connect_FourTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testColorOfNewPiece
{
    RIVGamePiece *redPiece = [RIVGamePiece redPiece];
    RIVGamePiece *blackPiece = [RIVGamePiece blackPiece];
    
    XCTAssertEqual(blackPiece.color, [UIColor blackColor], @"blackPiece should be black");
    XCTAssertEqual(redPiece.color, [UIColor redColor], @"redPiece should be red");
    
}

@end
