//
//  ECLevelManager.h
//  Eclosion
//
//  Created by Tsubasa on 13-11-4.
//
//

#import <Foundation/Foundation.h>
#import "ECLevel.h"

#define LEVEL_PER_STAGE 9
#define MAX_STAGE 8
#define MAX_LEVEL (MAX_STAGE * LEVEL_PER_STAGE)
#define EDITING_LEVEL [ECLevelManager manager].editing

@interface ECLevelManager : NSObject {
}

@property (nonatomic, assign) int currentLevel;                 // ( 0 - MAX_LEVEL - 1 )
@property (nonatomic, assign) int currentStage;                 // ( 0 - MAX_STAGE - 1 )
@property (nonatomic, retain) NSMutableArray *levelDataArray;    // store ECLevel
@property (nonatomic, assign) bool editing;                     // 是否正在编辑

+ (ECLevelManager *)manager;
- (ECLevel *)getCurrentLevelData;
- (void)save;
@end
