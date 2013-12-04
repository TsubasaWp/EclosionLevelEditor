//
//  BaseTile.m
//  Eclosion
//
//  Created by Tsubasa on 13-10-2.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BaseTile.h"
#import "ECLevelManager.h"

#define RUN_ACTION_TAG 9
#define ITEM_SPEED 6 // 每帧移动的距离

@implementation BaseTile

- (id)init {
    if ( self = [super init]) {
        self.anchorPoint = ccp(0.5,0.5);
        self.forceDirection = ECDirectionNone;
        self.movebal = NO;
        self.walkball = YES;
        self.direction = ECDirectionNone;
        self.speed = ITEM_SPEED;
        self.preDirection = ECDirectionLeft;
    }
    return self;
}

- (void)setMyTexture:(CCTexture2D *)texture {
    // Set texture
    [self setTexture: texture];
    CGRect rect = CGRectZero;
    rect.size = texture.contentSize;
    [self setTextureRect:rect];
}

- (void)setTextureFile:(NSString *)file highlight:(NSString *)highlightFile {
    _texture = [[[CCTextureCache sharedTextureCache] addImage:file] retain];
    _highlightTexture = [[[CCTextureCache sharedTextureCache] addImage:highlightFile] retain];
    [self setMyTexture:_texture];
}

- (void)setSpeed:(float)speed {
    _speed = MIN(speed, ECTileSize - 1);
}

- (void)dealloc {
    [_texture release];
    [_highlightTexture release];
    [super dealloc];
}

- (void)cleanup {
    [super cleanup];
    [[[CCDirector sharedDirector] eventDispatcher] removeMouseDelegate:self];
}
- (void)fpsUpdate:(ccTime)interval {

}

- (void)fixUpdate:(ccTime)interval {
    self.tileX = _x / ECTileSize;
    self.tileY = _y / ECTileSize;
}

bool CCRectContainsPoint(CGRect rect, CGPoint point) {
    return ((point.x >= rect.origin.x ) && ( point.x <= ( rect.origin.x + rect.size.width )) &&
             (point.y >= rect.origin.y ) && ( point.y <= ( rect.origin.y + rect.size.height )));
}

- (BOOL)containsTouchLocation:(NSEvent *)event
{
    CGPoint location = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
    
    if ( [self.parent isKindOfClass:[CCSprite class]] ) {
        location.x -= (((CCSprite *)self.parent).position.x + WINSIZE.width/2 - 320/2);
        location.y -= (((CCSprite *)self.parent).position.y + WINSIZE.height/2 - 480/2);
    }
    
    CGRect myRect = CGRectMake(_x - _tileW/2, _y - _tileH/2, self.contentSize.width, self.contentSize.height);
    return CCRectContainsPoint(myRect, location);
}

- (void)setForceDirection:(ECDirection)aForceDirection {
    if ( ! _movebal ) return;
    
    if ( (_forceDirection != ECDirectionNone) && (aForceDirection != ECDirectionNone) ) return;

    if ((aForceDirection == ECDirectionNone ) || (self.alowingDirection & aForceDirection)) {
        _forceDirection = aForceDirection;
    }
}

- (void)setMovebal:(BOOL)amovebal {
    _movebal = amovebal;
    if ( _movebal ) {
        [[[CCDirector sharedDirector] eventDispatcher] addMouseDelegate:self priority:0];
    }
}


#pragma Touch Delegate

- (BOOL)ccMouseDown:(NSEvent *)event
{
    if ( EDITING_LEVEL ) {
        return NO;
    }
    
	if ([self containsTouchLocation:event]) {
        _beginPoint = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
        [self setMyTexture:_highlightTexture];
        return YES;
    }
    return NO;
}
-(BOOL) ccMouseDragged:(NSEvent *)event
{
    if ( EDITING_LEVEL ) {
        return NO;
    }
    
    if ([self containsTouchLocation:event]) {
        if (_forceDirection != ECDirectionNone) return YES;
        
        CGPoint endPoint = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
        
        float x = endPoint.x - _beginPoint.x;
        float y = endPoint.y - _beginPoint.y;
        if ( x*x > y*y ) {
            if ( x > 0 ) {
                self.forceDirection = ECDirectionRight;
            } else {
                self.forceDirection = ECDirectionLeft;
            }
        } else {
            if ( y > 0 ) {
                self.forceDirection = ECDirectionUp;
            } else {
                self.forceDirection = ECDirectionDown;
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)ccMouseUp:(NSEvent *)event
{
    if ( EDITING_LEVEL ) {
        return NO;
    }
    
    [self setMyTexture:_texture];
    if ([self containsTouchLocation:event]) return YES;
    return NO;
}

@end
