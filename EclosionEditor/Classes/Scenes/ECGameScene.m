//
//  ECGameScene.m
//  Blocks_Cocos
//
//  Created by ; on 13-9-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ECGameScene.h"
#import "ECPauseScene.h"
#import "ECLevelScene.h"
#import "ECMenuScene.h"
#import "ECTileMap.h"
#import "ECLevelManager.h"
#import "ECTile.h"

@interface ECGameScene()<ECPauseSceneDelegate>

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
    
    // Play button
    CC_CREATE_MENUITEM(pauseBtn, @"roundbuttonoff.png", @"roundbuttonon.png", run);
    pauseBtn.position = ccp(320 - 35, 480 - 35);
    CC_MENUITEM_ADD_ICON(pauseBtn, @"play.png");
    
    // Menu
    CCMenu * m = [CCMenu menuWithItems:pauseBtn, nil];
    m.position = CGPointZero;
    [background addChild:m];
    
    // Load game
    _map = [ECTileMap mapBuildWithFile:
            [NSString stringWithFormat:@"level%d",[ECLevelManager manager].currentLevel]];
    _map.position = ccp(22,5);
    [background addChild:_map];
    
    // Update
    [self schedule:@selector(fpsUpdate:)];
    [self schedule:@selector(fixUpdate:) interval:1.f/ECFixFPS];
    
    [[CCDirector sharedDirector] pause];
    
}

-(void) onExit {
    //[_map release];
}

-(void) run {
    [[CCDirector sharedDirector] resume];
}

-(void) pause {
    [self pauseSchedulerAndActions];
    if ( !_pauseScene ) {
        _pauseScene = [[ECPauseScene alloc] init];
        _pauseScene.delegate = self;
    }
    
	[self addChild: _pauseScene];
}

- (void)fpsUpdate:(ccTime)interval {
    [_map fpsUpdate:interval];
}

- (void)fixUpdate:(ccTime)interval {
    [_map fixUpdate:interval];
}

#pragma PauseScene Delegate
-(void) resumeGame {
    [self resumeSchedulerAndActions];
    [_pauseScene removeFromParentAndCleanup:YES];
    _pauseScene = nil;
}

-(void) restartGame {
    CC_TRANSLATE_SCENE([ECGameScene scene]);
}

-(void) gotoLevelScene {
    CC_TRANSLATE_SCENE([ECLevelScene scene]);
}

-(void) gotoMenuScene {
    CC_TRANSLATE_SCENE([ECMenuScene scene]);
}

#pragma Editor Menu

-(void)editorAddObject {
    
}


@end
