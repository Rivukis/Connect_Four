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

@interface RIVMainViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *playPieceView;
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;

@property (strong, nonatomic) RIVGameBoard *gameboard;
@property (strong, nonatomic) UIImageView *currentPiece;
@property (assign, nonatomic) CGPoint originalTouch;

@property (strong, nonatomic) NSMutableArray *allPieces;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) UIDynamicItemBehavior *elasticity;

@end

@implementation RIVMainViewController

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
    
    [self setupBarriers];
    [self setupAnimator];
    [self setupPlayPieceView];
    
    self.gameImageView.image = [StyleKitName imageOfConnect4Board];
}

- (void)setupAnimator
{
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
    [self.animator addBehavior:self.elasticity];
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

- (void)setupPlayPieceView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPiece:)];
    tapGesture.delegate = self;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(playPiece:)];
    panGesture.delegate = self;
    panGesture.maximumNumberOfTouches = 1;
    [self.playPieceView addGestureRecognizer:tapGesture];
    [self.playPieceView addGestureRecognizer:panGesture];
}

- (void)playPiece:(id)sender
{
    
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"tap gesture");
        UITapGestureRecognizer *tap = sender;
        
        
    } else if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = sender;
        CGPoint translation = [pan translationInView:self.playPieceView];
//        CGPoint location = [pan locationInView:self.view];
        
        if (pan.state == UIGestureRecognizerStateBegan) self.originalTouch = [pan locationInView:self.view];
        CGRect newRect = [self cgRectForPieceWithOriginalRect:CGRectMake(self.originalTouch.x + translation.x,
                                                                         self.originalTouch.y + translation.y,
                                                                         35,
                                                                         37)];
        
        
        switch (pan.state) {
            case UIGestureRecognizerStateBegan: {
                self.currentPiece = [self newGamePieceViewForColor:self.gameboard.playerToAct.color withFrame:newRect];
                [self.view addSubview:self.currentPiece];
                [self.view bringSubviewToFront:self.gameImageView];
                
                break;
            }
            case UIGestureRecognizerStateChanged: {
                self.currentPiece.frame = newRect;
                break;
            }
            case UIGestureRecognizerStateEnded: {
                
                
                RIVGameBoardPlayState gameState = [self.gameboard playGamePieceonColumn:[self columnForCurrentPiece] fromPlayer:self.gameboard.playerToAct];
                if (gameState != RIVGameBoardPlayStateNotPlayable) {
                    [self.gravity addItem:self.currentPiece];
                    [self.collision addItem:self.currentPiece];
                    [self.elasticity addItem:self.currentPiece];
                } else {
                    [self.currentPiece removeFromSuperview];
                }
                
                
                NSLog(@"played state: %d", gameState);
                break;
            }
            case UIGestureRecognizerStateCancelled: {
                NSLog(@"pan Cancelled");
                break;
            }
            default:
                break;
        }
        
//        NSLog(@"translation .X: %f .Y %f", translation.x, translation.y);
//        NSLog(@"original .X: %f .Y %f", self.originalTouch.x, self.originalTouch.y);
    }
}

- (CGRect)cgRectForPieceWithOriginalRect:(CGRect)originalRect
{
    // new X
    NSInteger newX = originalRect.origin.x - originalRect.size.width / 2;
    NSInteger minX = self.playPieceView.frame.origin.x;
    NSInteger maxX = self.playPieceView.frame.origin.x + self.playPieceView.frame.size.width - originalRect.size.width;
    
    newX = roundf((newX - self.playPieceView.frame.origin.x) / 35) * 35 + self.playPieceView.frame.origin.x;
    
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

- (NSInteger)columnForCurrentPiece
{
    return (self.currentPiece.frame.origin.x - self.playPieceView.frame.origin.x) / 35;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        _gravity.magnitude = 0.5;
    }
    return _gravity;
}

- (UICollisionBehavior *)collision
{
    if (!_collision) {
        _collision = [UICollisionBehavior new];
//        _collision.translatesReferenceBoundsIntoBoundary = YES;
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

@end
