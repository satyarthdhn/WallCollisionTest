//
//  TouchSprite.m
//  20SecGame
//
//  Created by Satyarth Kumar Prasad on 07/02/14.
//  Copyright (c) 2014 Satyarth Kumar Prasad. All rights reserved.
//

#import "TouchSprite.h"

@implementation TouchSprite

@synthesize isBeingDragged;
@synthesize isCollidingWithWall;
@synthesize stencilSprite;
@synthesize isInvisible;

- (id)initWithFile:(NSString *)filename {
  if (self = [super initWithFile:filename]) {
    //do nothing
  }
  self.isBeingDragged = NO;
  self.isCollidingWithWall = NO;
  self.isInvisible = NO;
  self.stencilSprite = nil;
  return self;
}

-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
  sprite.scaleX = width / sprite.contentSize.width;
  sprite.scaleY = height / sprite.contentSize.height;
}

- (void)onExit {
  isBeingDragged = nil;
  isCollidingWithWall = nil;
  [stencilSprite release];
  stencilSprite = nil;
  isInvisible = nil;
}

- (void)dealloc {
  [super dealloc];
}


@end
