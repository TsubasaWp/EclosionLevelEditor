//
//  ECGameScene.m
//  Blocks_Cocos
//
//  Created by ; on 13-9-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ECGameScene.h"
#import "ECTileMap.h"
#import "ECLevelManager.h"
#import "ECTile.h"

@interface ECGameScene()

@end

@implementation ECGameScene
@synthesize map = _map;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	ECGameScene *layer = [ECGameScene node];
	[scene addChild: layer];
	return scene;
}

-(void) onEnter
{
	[super onEnter];
    
    // Set background
    CC_CREATE_SPRITE_CENTER(background, @"bg_game.png", 0);
    
    // Load game
    [self edit];

}

- (void)loadGame {
    if ( _map ) {
        [_map removeFromParentAndCleanup:YES];
    }
    _map = [ECTileMap mapBuildWithFile:
                        [NSString stringWithFormat:@"level%d",[ECLevelManager manager].currentLevel]];
    _map.position = ccp(22,5);
    [self addChild:_map];
}

-(void) run {
    [ECLevelManager manager].editing = NO;
}

- (void)stop {
}

-(void) edit {
    [ECLevelManager manager].editing = YES;
    [self loadGame];
}

#pragma Editor Menu

-(void)editorAddObject {
    
}


@end
