//
// Cocos2d Tiled Sprite
//
// Ebyan Alvarez-Buylla
// http://www.nolithius.com
//
// Creates a tiled sprite from the source sprite's texture, tiling it or clipping it to the desired width and height.
// Usage: [[TiledSprite alloc] initWithSprite:spriteWithTextureOrSubtexture width:640 height:480];
//
// Further details and screenshot at:
// http://www.nolithius.com/game-development/cocos2d-iphone-repeating-sprite
//


#import "TiledSprite.h"

@implementation TiledSprite

@synthesize width;
@synthesize height;

- (id) initWithSprite:(CCSprite *)p_sprite width:(int)p_width height:(int)p_height
{
  if (self = [super init])
  {
    // Only bother doing anything if the sizes are positive
    if (p_width > 0 && p_height > 0)
    {
      CGRect spriteBounds = p_sprite.textureRect;
      int sourceX = spriteBounds.origin.x;
      int sourceY = spriteBounds.origin.y;
      int sourceWidth = spriteBounds.size.width;
      int sourceHeight = spriteBounds.size.height;
      CCTexture2D* texture = p_sprite.texture;
      
      // Case 1: both width and height are smaller than source sprite, just clip
      if (p_width <= sourceWidth && p_height <= sourceHeight)
      {
        CCSprite* sprite = [CCSprite spriteWithTexture:texture rect:CGRectMake(sourceX, sourceY + sourceHeight - p_height, p_width, p_height)];
        sprite.anchorPoint = ccp(0, 0);
        [self addChild:sprite];
      }
      // Case 2: only width is larger than source sprite
      else if (p_width > sourceWidth && p_height <= sourceHeight)
      {
        // Stamp sideways until we can
        int ix = 0;
        while (ix < p_width - sourceWidth)
        {
          CCSprite* sprite = [CCSprite spriteWithTexture:texture rect:CGRectMake(sourceX, sourceY + sourceHeight - p_height, sourceWidth, p_height)];
          sprite.anchorPoint = ccp(0, 0);
          sprite.position = ccp(ix, 0);
          [self addChild:sprite];
          
          ix += sourceWidth;
        }
        
        // Stamp the last one
        CCSprite* sprite = [CCSprite spriteWithTexture:texture rect:CGRectMake(sourceX, sourceY + sourceHeight - p_height, p_width - ix, p_height)];
        sprite.anchorPoint = ccp(0, 0);
        sprite.position = ccp(ix, 0);
        [self addChild:sprite];
      }
      // Case 3: only height is larger than source sprite
      else if (p_height >= sourceHeight && p_width <= sourceWidth)
      {
        // Stamp down until we can
        int iy = 0;
        while (iy < p_height - sourceHeight)
        {
          CCSprite* sprite = [CCSprite spriteWithTexture:texture rect:CGRectMake(sourceX, sourceY, p_width, sourceHeight)];
          sprite.anchorPoint = ccp(0, 0);
          sprite.position = ccp(0, iy);
          [self addChild:sprite];
          
          iy += sourceHeight;
        }
        
        // Stamp the last one
        int remainingHeight = p_height - iy;
        CCSprite* sprite = [CCSprite spriteWithTexture:texture rect:CGRectMake(sourceX, sourceY + sourceHeight - remainingHeight, p_width, remainingHeight)];
        sprite.anchorPoint = ccp(0, 0);
        sprite.position = ccp(0, iy);
        [self addChild:sprite];
      }
      // Case 4: both width and height are larger than source sprite (Composite together several Case 2's, as needed)
      else
      {
        // Stamp down until we can
        int iy = 0;
        while (iy < p_height - sourceHeight)
        {
          TiledSprite* sprite = [[TiledSprite alloc] initWithSprite:p_sprite width:p_width height:sourceHeight];
          sprite.anchorPoint = ccp(0, 0);
          sprite.position = ccp(0, iy);
          [self addChild:sprite];
          
          iy += sourceHeight;
        }
        
        // Stamp the last one
        TiledSprite* sprite = [[TiledSprite alloc] initWithSprite:p_sprite width:p_width height:p_height - iy];
        sprite.anchorPoint = ccp(0, 0);
        sprite.position = ccp(0, iy);
        [self addChild:sprite];
      }
    }
  }
  
  return self;
}

- (void)onExit {
  [width release];
  width = nil;
  [height release];
  height = nil;
}

- (void)dealloc {
  [super dealloc];
}


@end