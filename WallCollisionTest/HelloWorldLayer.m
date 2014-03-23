//
//  HelloWorldLayer.m
//  WallCollisionTest
//
//  Created by Satyarth Kumar Prasad on 23/03/14.
//  Copyright Satyarth Kumar Prasad 2014. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "TiledSprite.h"
#import "WallSprite.h"
#import "TouchSprite.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize tiledWallSpritesArray;
@synthesize touchSpritesArray;
@synthesize isTouchAllowedToMove;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)addWallsOnScreen {
  
  WallSprite *wallSprite = [WallSprite spriteWithFile:@"brick.png"];
  TiledSprite * tiledSprite = [[TiledSprite alloc] initWithSprite:wallSprite width:100 height:300];
  tiledSprite.position = ccp(400, 200);
  tiledSprite.height = [NSNumber numberWithInt:100];
  tiledSprite.width = [NSNumber numberWithInt:300];
  [self.tiledWallSpritesArray addObject:tiledSprite];
  [self addChild:tiledSprite];
}

- (void)addTouchSpritesOnScreen {
    
  TouchSprite * touchSprite = [TouchSprite spriteWithFile:@"cube.png"];
  touchSprite.position = ccp(200, 200);
  [self.touchSpritesArray addObject:touchSprite];
  [self addChild:touchSprite];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
    self.touchSpritesArray = [NSMutableArray array];
    self.tiledWallSpritesArray = [NSMutableArray array];
    self.isTouchAllowedToMove = NO;
    
    [self addWallsOnScreen];
    [self addTouchSpritesOnScreen];
    self.touchEnabled = YES;
    [self scheduleUpdate];

	}
	return self;
}

- (void)update:(ccTime)delta {
  [self checkAndUpdateWallCollidingPropertyOfTouchSprites];
}

- (void)checkAndUpdateWallCollidingPropertyOfTouchSprites {
  for (TouchSprite *touchSprite in self.touchSpritesArray) {
    for (TiledSprite *tiledSprite in self.tiledWallSpritesArray) {
      CGRect tiledRect = CGRectMake(tiledSprite.position.x, tiledSprite.position.y, [tiledSprite.width intValue], [tiledSprite.height intValue]);
      if (CGRectIntersectsRect([touchSprite boundingBox], tiledRect)) {
        touchSprite.isCollidingWithWall = YES;
        break;
      }
    }
  }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
  if (!self.isTouchAllowedToMove) {
    for (UITouch *touch in touches) {
      CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
      for (TouchSprite *touchSprite in self.touchSpritesArray) {
        CGRect spriteRect = [touchSprite boundingBox];
        if (CGRectContainsPoint(spriteRect, touchLocation)) {
          touchSprite.tag = touch.hash;
          self.isTouchAllowedToMove = YES;
        }
      }
    }
  }
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [self ccTouchesEnded:touches withEvent:event];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
  NSLog(@"touch position is %f %f", touchLocation.x, touchLocation.y);
  self.isTouchAllowedToMove = NO;
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  if (self.isTouchAllowedToMove) {
    
    for (UITouch *touch in touches) {
      CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
      for (TouchSprite *touchSprite in self.touchSpritesArray) {
        if (touchSprite.tag == touch.hash) {
          if (!touchSprite.isCollidingWithWall) {
            touchSprite.position = touchLocation;
          } else {
            if (CGPointEqualToPoint(touchLocation, touchSprite.position)) {
              
            } else {
              CGPoint previousLocation = [[CCDirector sharedDirector] convertToGL:[touch previousLocationInView:touch.view]];
              CGPoint diff = ccpSub(touchLocation, previousLocation);
              /*

                       ___2____
                      |       |
                     1|       |3
                      |_______|
                          4
               */


              // if diff.x > 0 that means you are moving towards the wall provided you had collided with face 1
              // if diff.x < 0 that means you are moving towards the wall provided you had collided with face 3
              // if diff.y < 0 that means you are moving towards the wall provided you had collided with face 2
              // if diff.y > 0 that means you are moving towards the wall provided you had collided with face 4

              CGPoint pointToAdd = CGPointMake(0, diff.y);
              touchSprite.position = ccpAdd(touchSprite.position, pointToAdd);
            }
          }
          break;
        }
      }
    }
    
  }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
