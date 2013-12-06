//
//  ECLevelManager.m
//  Eclosion
//
//  Created by Tsubasa on 13-11-4.
//
//

#import "ECLevelManager.h"

static ECLevelManager * _sharedManager;

@implementation ECLevelManager

+ (ECLevelManager *)manager {
    if ( _sharedManager == nil ) {
        _sharedManager = [[ECLevelManager alloc] init];
    }
    return _sharedManager;
}


- (id)init {
    if ( self = [super init] ) {
        NSFileManager * fm = [NSFileManager defaultManager];
        NSArray * array = [fm contentsOfDirectoryAtPath:ECLevelFilePath error:NULL];
        self.totalLevel = [array count];
    }
    return self;
}

- (void)newLevel {
    self.totalLevel += 1;
    self.currentLevel = self.totalLevel - 1;
}

- (void)setCurrentLevel:(int)aCurrentLevel {
    NSAssert(aCurrentLevel < self.totalLevel, @"Error! Level index beyond the bounds!");
    
    // 保存并更新关卡数据
    [self saveLevelFile];
    
    NSString *filename = [NSString stringWithFormat:@"level%d.plist",aCurrentLevel];
    NSString *path = [NSString stringWithFormat:@"%@%@",ECLevelFilePath,filename];
    self.levelContent = [NSDictionary dictionaryWithContentsOfFile:path];
    if ( self.levelContent == nil ) {
        self.levelContent = [NSDictionary dictionary];
    }
    
    // 更新关卡数
    _currentLevel = aCurrentLevel;
}

- (void)saveLevelFile {
    NSString *filename = [NSString stringWithFormat:@"level%d.plist",_currentLevel];
    NSString *path = [NSString stringWithFormat:@"%@%@",ECLevelFilePath,filename];
    NSLog(@"savesuccess: %d", [self.levelContent writeToFile:path atomically:YES]);
}
@end
