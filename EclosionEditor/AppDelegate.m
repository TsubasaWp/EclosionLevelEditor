//
//  AppDelegate.m
//  EclosionEditor
//
//  Created by Tsubasa on 13-12-1.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "AppDelegate.h"
#import "ECGameScene.h"

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

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

- (IBAction)addItem:(id)sender {

}

- (IBAction)deleteItem:(id)sender {

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

@end
