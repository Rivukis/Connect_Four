//
//  RIVPlaySpot.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVGamePiece;

@interface RIVPlaySpot : NSObject

@property (nonatomic) BOOL hasPiece;
@property (strong, nonatomic) RIVGamePiece *piece;

@end
