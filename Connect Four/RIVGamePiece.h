//
//  RIVGamePiece.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RIVGamePieceColor) {
    RIVGamePieceColorRed = 1,
    RIVGamePieceColorBlue
};

@interface RIVGamePiece : NSObject

@property (readonly, nonatomic) RIVGamePieceColor color;
//@property (readonly, nonatomic) UIImageView *view;

@property (assign, nonatomic) NSInteger startingX;
@property (assign, nonatomic) NSInteger startingY;
@property (assign, nonatomic) NSInteger playedX;
@property (assign, nonatomic) NSInteger playedY;

- (instancetype)initWithColor:(RIVGamePieceColor)color;

@end