//
//  HelloWorldLayer.h
//  WallCollisionTest
//
//  Created by Satyarth Kumar Prasad on 23/03/14.
//  Copyright Satyarth Kumar Prasad 2014. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@property (nonatomic,retain) NSMutableArray *tiledWallSpritesArray;
@property (nonatomic,retain) NSMutableArray *touchSpritesArray;
@property (readwrite) BOOL isTouchAllowedToMove;

@end
