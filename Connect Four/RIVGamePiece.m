//
//  RIVGamePiece.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGamePiece.h"
#import "StyleKitName.h"

@interface RIVGamePiece ()

@property (assign, nonatomic) RIVGamePieceColor color;
@property (strong, nonatomic) UIImageView *view;

@end

@implementation RIVGamePiece

- (instancetype)initWithColor:(RIVGamePieceColor)color
{
    self = [super init];
    if (self) {
        self.color = color;
//        self.view = [[UIImageView alloc] initWithFrame:CGRectMake(0, -35, 34, 37)];
//        switch (self.color) {
//            case RIVGamePieceColorRed:
//                self.view.image = [StyleKitName imageOfRedPiece];
//                break;
//            case RIVGamePieceColorBlue:
//                self.view.image = [StyleKitName imageOfBluePiece];
//            default:
//                self.view.image = nil;
//                break;
//        }
    }
    return self;
}

@end