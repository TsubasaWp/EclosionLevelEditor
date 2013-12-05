//
//  AppDelegate.m
//  EclosionEditor
//
//  Created by Tsubasa on 13-12-1.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "AppDelegate.h"
#import "ECGameScene.h"
#import "ECLevelManager.h"

@implementation EclosionEditorAppDelegate
@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];

	// enable FPS and SPF
	[director setDisplayStats:YES];
	
	// connect the OpenGL view with the director
	[director setView:glView_];

	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
	[director setResizeMode:kCCDirectorResize_AutoScale];
	
	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:NO];
	
	// Center main window
	[window_ center];
	
    // Init Files
    [self initLevelFiles];
    [ECLevelManager manager].currentLevel = 0;
    
    // Init UI
    [self initUI];
    
    // ECGameScene
    gameScene_ = [[ECGameScene node] retain];
    CCScene *scene = [CCScene node];
	[scene addChild: gameScene_];
	[director runWithScene:scene];

}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[[CCDirector sharedDirector] end];
	[window_ release];
	[super dealloc];
}

#pragma UI
- (void)initUI {
    _totalLevelLabel.stringValue = [NSString stringWithFormat:@" / %d", [ECLevelManager manager].totalLevel];
}

#pragma mark File
- (void)initLevelFiles {

    NSError * error= nil;
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * array = [fm contentsOfDirectoryAtPath:ECLevelFilePath error:&error];
    // 如果存储目录~/Documents/EclosionLevels/是空的, 则创建目录将包中自带的关卡拷过去
    if( error) {
        BOOL ret = [fm createDirectoryAtPath:ECLevelFilePath withIntermediateDirectories:YES attributes:nil error:&error];
        if ( ret ) {
            for ( int i = 0; i < MAX_LEVEL; i++ ) {
                NSString *filename = [NSString stringWithFormat:@"level%d",i];
                [fm copyItemAtPath:[[NSBundle mainBundle] pathForResource:filename ofType:@"plist"]
                            toPath:[NSString stringWithFormat:@"%@%@.plist",ECLevelFilePath,filename] error:&error];
            }
        }
        array = [fm contentsOfDirectoryAtPath:ECLevelFilePath error:&error];
    }
    else
    {
        NSLog(@"array=%@",array);
    }
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

- (IBAction)addItem:(NSButton *)sender {
    [gameScene_ editorAddObject:(int)sender.tag];
}

- (IBAction)deleteItem:(id)sender {
    [gameScene_ editorDeleteSelectObject];
}

- (IBAction)newFile:(id)sender {

}

- (IBAction)saveFile:(id)sender {

}

- (IBAction)cleanFile:(id)sender {

}

- (IBAction)editLevel:(id)sender {
    [gameScene_ edit];
}

- (IBAction)runLevel:(id)sender {
    [gameScene_ run];
    
}

#pragma NSTextField Delegate
- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
    
    // Valate
    if ( control != _currentLevelLabel ) return NO;
    int level = [fieldEditor.string intValue];
    if (( level < 0 ) || ( level >= [ECLevelManager manager].totalLevel)) return NO;
    
    // Show Level number
    NSString *value = [NSString stringWithFormat:@"%d", level];
    control.stringValue = value;
    
    // Load level
    [ECLevelManager manager].currentLevel = level;
    [self editLevel:nil];
    
    return YES;
}

@end
