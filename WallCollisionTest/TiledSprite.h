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

#import "cocos2d.h"

@interface TiledSprite : CCSprite

@property (nonatomic, retain) NSNumber *width;
@property (nonatomic, retain) NSNumber *height;

- (id) initWithSprite:(CCSprite*)p_sprite width:(int)p_width height:(int)p_height;

@end