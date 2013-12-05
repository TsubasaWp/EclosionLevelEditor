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

- (void)setCurrentLevel:(int)aCurrentLevel {
    NSAssert(aCurrentLevel < self.totalLevel, @"Error! Level index beyond the bounds!");
    
    // 保存并更新关卡数据
    NSString *filename = [NSString stringWithFormat:@"level%d",_currentLevel];
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    [self.levelContent writeToFile:path atomically:YES];
    
    filename = [NSString stringWithFormat:@"level%d",aCurrentLevel];
    path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    self.levelContent = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // 更新关卡数
    _currentLevel = aCurrentLevel;
}

- (void)saveLevelFile {
    NSString *filename = [NSString stringWithFormat:@"level%d",_currentLevel];
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    [self.levelContent writeToFile:path atomically:YES];
}

- (id)init {
    if ( self = [super init] ) {
        NSFileManager * fm = [NSFileManager defaultManager];
        NSArray * array = [fm contentsOfDirectoryAtPath:ECLevelFilePath error:NULL];
        self.totalLevel = [array count];
    }
    return self;
}

@end
