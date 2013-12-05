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

- (void)setCurrentLevel:(int)currentLevel {
    NSAssert(currentLevel < self.totalLevel, @"Error! Level index beyond the bounds!");
    _currentLevel = currentLevel;
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
