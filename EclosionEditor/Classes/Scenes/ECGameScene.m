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
    _map.delegate = self;
    _map.position = ccp(22,5);
    [self addChild:_map];
}

-(void) run {
    [ECLevelManager manager].editing = NO;
}

- (void)restart {
    [ECLevelManager manager].editing = YES;
    [self loadGame];
}

-(void) edit {
    [self restart];
}

#pragma Editor Menu

-(void)editorAddObject:(int)objectId {
    NSDictionary *mapping = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"Hero",@"0",
                         @"Wall",@"1",
                         @"Star",@"2",
                         @"Tree",@"3",
                         @"Trap",@"4",
                         @"End",@"5",
                         @"MovH1",@"6",
                         @"MovH2",@"7",
                         @"MovH3",@"8",
                         @"MovL2",@"9",
                         @"MovL3",@"10",
                         nil];
    // Hero
    if ( objectId == 0 ) {
        NSDictionary *objDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:0],@"x",
                                 [NSNumber numberWithInt:0],@"y",nil] ,@"position", nil];
        
        NSMutableDictionary *levelDic =
        [NSMutableDictionary dictionaryWithDictionary:[ECLevelManager manager].levelContent];
        [levelDic setObject:objDic forKey:@"hero"];
        [ECLevelManager manager].levelContent = levelDic;
    }
    // Object
    else {
        NSString *filename = [mapping objectForKey:[NSString stringWithFormat:@"%d",objectId]];
        if ( [filename length] > 0 ) {
            NSDictionary *objDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     filename,@"type",
                                     [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:0],@"x",
                                      [NSNumber numberWithInt:0],@"y",nil] ,@"position", nil];

            NSMutableArray *array = [[ECLevelManager manager].levelContent objectForKey:@"map"];
            [array addObject:objDic];
            NSMutableDictionary *levelDic =
            [NSMutableDictionary dictionaryWithDictionary:[ECLevelManager manager].levelContent];
            [levelDic setObject:array forKey:@"map"];
            [ECLevelManager manager].levelContent = levelDic;
        }
    }
    
    [[ECLevelManager manager] saveLevelFile];
    [self restart];
}

-(void)editorDeleteSelectObject {
    [_map removeSelectObject];
}

-(void)editorClean {
    [_map cleanAllObjects];
    [self restart];
}

-(void)editorSave {
    [_map saveEditedLevel];
}


#pragma Map delegate

-(void)tileMapDidEndGame {
    [self restart];
}

@end
