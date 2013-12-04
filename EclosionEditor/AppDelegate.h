//
//  AppDelegate.h
//  EclosionEditor
//
//  Created by Tsubasa on 13-12-1.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "cocos2d.h"
@class ECGameScene;
@interface EclosionEditorAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
    ECGameScene *gameScene_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;
@property (retain) IBOutlet NSTextField	*currentLevelLabel;
@property (retain) IBOutlet NSTextField	*totalLevelLabel;

- (IBAction)toggleFullScreen:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)deleteItem:(id)sender;
- (IBAction)newFile:(id)sender;
- (IBAction)saveFile:(id)sender;
- (IBAction)cleanFile:(id)sender;
- (IBAction)editLevel:(id)sender;
- (IBAction)runLevel:(id)sender;
@end
