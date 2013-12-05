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

@property (nonatomic, assign) int currentLevel;                 
@property (nonatomic, assign) bool editing;                     // 是否正在编辑
@property (nonatomic, assign) int  totalLevel;                  // 是否正在编辑
@property (nonatomic, retain) NSDictionary *levelContent;       // 关卡文件内容

+ (ECLevelManager *)manager;
- (void)saveLevelFile;
@end
