//
//  TouchSprite.h
//  20SecGame
//
//  Created by Satyarth Kumar Prasad on 07/02/14.
//  Copyright (c) 2014 Satyarth Kumar Prasad. All rights reserved.
//

#import "CCSprite.h"

@interface TouchSprite : CCSprite


@property (readwrite) BOOL isBeingDragged;
@property (readwrite) BOOL isCollidingWithWall;
@property (readwrite) BOOL isInvisible;
@property (nonatomic,retain) CCSprite *stencilSprite;

- (id)initWithFile:(NSString *)filename;
- (void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height;
@end
