//
//  Connect_FourTests.m
//  Connect FourTests
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>

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

- (void)testTwoPlusTwoEqualsFour
{
    NSInteger firstNumber = 2;
    NSInteger secondNumber = 2;
    
    XCTAssertEqual(firstNumber + secondNumber, 4, @"two plus two should equal four.");
    
    
}

@end
