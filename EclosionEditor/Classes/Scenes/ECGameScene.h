//
//  ECGameScene
//  Blocks_Cocos
//
//  Created by Tsubasa on 13-9-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class ECPauseScene;
@class ECTileMap;
@interface ECGameScene : CCSprite {
    ECPauseScene *_pauseScene;
    ECTileMap    *_map;
}
@property (retain, nonatomic) ECTileMap *map;

+(CCScene *) scene;
-(void) run;
-(void) edit;
@end
