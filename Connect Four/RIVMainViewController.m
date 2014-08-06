//
//  RIVMainViewController.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVMainViewController.h"
#import "RIVGameBoard.h"
#import "RIVPlayer.h"
#import "RIVGamePiece.h"
#import "StyleKitName.h"

const NSInteger PieceViewWidth = 35;
const NSInteger PieceViewHeight = 37;

@interface RIVMainViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *playPieceView;
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;
@property (weak, nonatomic) IBOutlet UILabel *gameEndedLabel;


@property (weak, nonatomic) IBOutlet UIView *columnLine0;
@property (weak, nonatomic) IBOutlet UIView *columnLine1;
@property (weak, nonatomic) IBOutlet UIView *columnLine2;
@property (weak, nonatomic) IBOutlet UIView *columnLine3;
@property (weak, nonatomic) IBOutlet UIView *columnLine4;
@property (weak, nonatomic) IBOutlet UIView *columnLine5;
@property (weak, nonatomic) IBOutlet UIView *columnLine6;
@property (weak, nonatomic) IBOutlet UIView *columnLine7;
@property (strong, nonatomic) NSArray *columnLines;
@property (assign, nonatomic) NSInteger highlightedColumn;

@property (strong, nonatomic) RIVGameBoard *gameboard;
@property (strong, nonatomic) UIImageView *currentPiece;
@property (assign, nonatomic) CGPoint originalTouch;
@property (strong, nonatomic) NSDate *lastPiecePlayedDate;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) UIDynamicItemBehavior *elasticity;

@end

@implementation RIVMainViewController

#pragma mark - Setup

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameImageView.image = [StyleKitName imageOfConnect4Board];
    self.lastPiecePlayedDate = [NSDate date];
    self.highlightedColumn = -2;
    [self setupBarriers];
    [self setupAnimator];
    [self setupPlayPieceView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupBarriers
{
    [self.collision addBoundaryWithIdentifier:@"Horizontal1" fromPoint:CGPointMake(37, 530) toPoint:CGPointMake(283, 530)];
    [self.collision addBoundaryWithIdentifier:@"Vertical1" fromPoint:CGPointMake(37, 314) toPoint:CGPointMake(37, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical2" fromPoint:CGPointMake(72, 314) toPoint:CGPointMake(72, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical3" fromPoint:CGPointMake(107, 314) toPoint:CGPointMake(107, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical4" fromPoint:CGPointMake(142, 314) toPoint:CGPointMake(142, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical5" fromPoint:CGPointMake(177, 314) toPoint:CGPointMake(177, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical6" fromPoint:CGPointMake(212, 314) toPoint:CGPointMake(212, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical7" fromPoint:CGPointMake(247, 314) toPoint:CGPointMake(247, 533)];
    [self.collision addBoundaryWithIdentifier:@"Vertical8" fromPoint:CGPointMake(282, 314) toPoint:CGPointMake(282, 533)];
}

- (void)setupAnimator
{
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
    [self.animator addBehavior:self.elasticity];
}

- (void)setupPlayPieceView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attemptPlayPieceWithGesture:)];
    tapGesture.delegate = self;
    [self.playPieceView addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(attemptPlayPieceWithGesture:)];
    panGesture.delegate = self;
    panGesture.maximumNumberOfTouches = 1;
    [self.playPieceView addGestureRecognizer:panGesture];
}


#pragma mark - Playing the Game


- (void)attemptPlayPieceWithGesture:(id)sender
{
    if (self.gameboard.gameHasEnded || [self.lastPiecePlayedDate timeIntervalSinceNow] > -0.7) return;
    
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = sender;
        CGPoint location = [tap locationInView:self.view];
        CGRect newFrame = [self cgRectForPieceWithOriginalRect:CGRectMake(location.x, location.y, PieceViewWidth, PieceViewHeight)];
        
        [self addNextPieceToViewWithFrame:newFrame];
        [self playPiece];
        
    } else if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = sender;
        CGPoint translation = [pan translationInView:self.playPieceView];
        CGPoint location = [pan locationInView:self.view];
        
        if (pan.state == UIGestureRecognizerStateBegan) self.originalTouch = location;
        CGRect newFrame = [self cgRectForPieceWithOriginalRect:CGRectMake(self.originalTouch.x + translation.x, self.originalTouch.y + translation.y, PieceViewWidth, PieceViewHeight)];
        
        switch (pan.state) {
            case UIGestureRecognizerStateBegan: {
                [self addNextPieceToViewWithFrame:newFrame];
                break;
            }
            case UIGestureRecognizerStateChanged: {
                
                self.currentPiece.frame = newFrame;
                [self showColumnLinesForCurrentPiece];
//                NSLog(@"column: %d", [self columnForCurrentPiece]);
                break;
            }
            case UIGestureRecognizerStateEnded: {
                [self playPiece];
                break;
            }
            case UIGestureRecognizerStateCancelled: {
                [self.currentPiece removeFromSuperview];
                self.currentPiece = nil;
                break;
            }
            default:
                break;
        }
    }
}

- (CGRect)cgRectForPieceWithOriginalRect:(CGRect)originalRect
{
    // new X
    NSInteger newX = originalRect.origin.x - originalRect.size.width / 2;
    NSInteger minX = self.playPieceView.frame.origin.x;
    NSInteger maxX = self.playPieceView.frame.origin.x + self.playPieceView.frame.size.width - originalRect.size.width;
    
    newX = roundf((newX - self.playPieceView.frame.origin.x) / PieceViewWidth) * PieceViewWidth + self.playPieceView.frame.origin.x;
    if (newX < minX) newX = minX;
    if (newX > maxX) newX = maxX;
    
    // new Y
    NSInteger newY = originalRect.origin.y - originalRect.size.height / 2;
    NSInteger minY = self.playPieceView.frame.origin.y;
    NSInteger maxY = self.playPieceView.frame.origin.y + self.playPieceView.frame.size.height - originalRect.size.height;
    
    if (newY < minY) newY = minY;
    if (newY > maxY) newY = maxY;
    
    return CGRectMake(newX, newY, originalRect.size.width, originalRect.size.height);
}

- (UIImageView *)newGamePieceViewForColor:(RIVGamePieceColor)color withFrame:(CGRect)frame
{
    UIImageView *newPiece = [[UIImageView alloc] initWithFrame:frame];
    switch (color) {
        case RIVGamePieceColorBlue: newPiece.image = [StyleKitName imageOfBluePiece];  break;
        case RIVGamePieceColorRed:  newPiece.image = [StyleKitName imageOfRedPiece];   break;
    }
    
    return newPiece;
}

- (void)addNextPieceToViewWithFrame:(CGRect)frame
{
    self.currentPiece = [self newGamePieceViewForColor:self.gameboard.playerToAct.color withFrame:frame];
    [self.view addSubview:self.currentPiece];
    [self.view bringSubviewToFront:self.gameImageView];
}

- (void)showColumnLinesForCurrentPiece
{
    [self turnLineAtIndex:self.highlightedColumn toColor:[UIColor clearColor]];
    [self turnLineAtIndex:self.highlightedColumn + 1 toColor:[UIColor clearColor]];
    
    if (self.currentPiece) self.highlightedColumn = [self columnForCurrentPiece];
    else self.highlightedColumn = -2;
    
    [self turnLineAtIndex:self.highlightedColumn toColor:[UIColor blackColor]];
    [self turnLineAtIndex:self.highlightedColumn + 1 toColor:[UIColor blackColor]];
}

- (void)turnLineAtIndex:(NSInteger)index toColor:(UIColor *)color
{
    if (index >= 0 && index < self.columnLines.count) {
        UIImageView *line = self.columnLines[index];
        line.backgroundColor = color;
    }
}

- (void)playPiece
{
    RIVGameBoardPlayState gameState = [self.gameboard playGamePieceonColumn:[self columnForCurrentPiece]
                                                                 fromPlayer:self.gameboard.playerToAct];
    switch (gameState) {
        case RIVGameBoardPlayStateDraw:
        case RIVGameBoardPlayStateWinningMove:
            [self gameEndedWithPlayState:gameState];
        case RIVGameBoardPlayStatePlayed:
            [self.gravity addItem:self.currentPiece];
            [self.collision addItem:self.currentPiece];
            [self.elasticity addItem:self.currentPiece];
            self.lastPiecePlayedDate = [NSDate date];
            break;
        case RIVGameBoardPlayStateNotPlayable:
        default:
            [self.currentPiece removeFromSuperview];
            break;
    }
    
    self.currentPiece = nil;
    [self showColumnLinesForCurrentPiece];
}

- (void)gameEndedWithPlayState:(RIVGameBoardPlayState)gameState
{
    [self.view bringSubviewToFront:self.gameEndedLabel];
    
    if (gameState == RIVGameBoardPlayStateDraw) {
        self.gameEndedLabel.textColor = [UIColor blackColor];
        self.gameEndedLabel.text = @"The game is a draw";
    } else if (gameState == RIVGameBoardPlayStateWinningMove) {
        if (self.gameboard.playerToAct.color == RIVGamePieceColorBlue) {
            self.gameEndedLabel.textColor = [UIColor blueColor];
            self.gameEndedLabel.text = @"Blue Player Wins";
        } else if (self.gameboard.playerToAct.color == RIVGamePieceColorRed) {
            self.gameEndedLabel.textColor = [UIColor redColor];
            self.gameEndedLabel.text = @"Red Player Wins";
        }
    }
}

- (NSInteger)columnForCurrentPiece
{
    return (self.currentPiece.frame.origin.x - self.playPieceView.frame.origin.x) / PieceViewWidth;
}


#pragma mark - User Actions


- (IBAction)newGamePressed:(UIButton *)sender
{
    self.gameEndedLabel.textColor = [UIColor blackColor];
    self.gameEndedLabel.text = @"New Game";
    [self.collision removeAllBoundaries];
    [self performSelector:@selector(resetGame) withObject:nil afterDelay:1.5];
}

- (void)resetGame
{
    [self.animator removeAllBehaviors];
    self.gravity = nil;
    self.elasticity = nil;
    self.collision = nil;
    
    [self setupBarriers];
    [self setupAnimator];
    
    self.gameboard = nil;
    self.gameEndedLabel.text = @"";
}


#pragma mark - UIGestureRecognizer Delegate


//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (gestureRecognizer.numberOfTouches > 1) return NO;
//    
//    self.originalTouch = [gestureRecognizer locationInView:self.view];
//    
//    return YES;
//}


#pragma mark - Lazy Instantiation


- (RIVGameBoard *)gameboard
{
    if (!_gameboard) _gameboard = [[RIVGameBoard alloc] initWithTwoPlayers];
    return _gameboard;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    return _animator;
}

- (UIGravityBehavior *)gravity
{
    if (!_gravity) {
        _gravity = [UIGravityBehavior new];
        _gravity.magnitude = 1.0;
    }
    return _gravity;
}

- (UICollisionBehavior *)collision
{
    if (!_collision) {
        _collision = [UICollisionBehavior new];
    }
    return _collision;
}

- (UIDynamicItemBehavior *)elasticity
{
    if (!_elasticity) {
        _elasticity = [UIDynamicItemBehavior new];
        _elasticity.elasticity = 0.5f;
    }
    return _elasticity;
}

- (NSArray *)columnLines
{
    if (!_columnLines) {
        NSMutableArray *columnLines = [NSMutableArray new];
        [columnLines addObject:self.columnLine0];
        [columnLines addObject:self.columnLine1];
        [columnLines addObject:self.columnLine2];
        [columnLines addObject:self.columnLine3];
        [columnLines addObject:self.columnLine4];
        [columnLines addObject:self.columnLine5];
        [columnLines addObject:self.columnLine6];
        [columnLines addObject:self.columnLine7];
        _columnLines = columnLines.copy;
    }
    return _columnLines;
}

@end
