//
//  AppDelegate.h
//  EclosionEditor
//
//  Created by Tsubasa on 13-12-1.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

#import "cocos2d.h"

@interface EclosionEditorAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;
@property (retain) IBOutlet NSTextField	*currentLevelLabel;
@property (retain) IBOutlet NSTextField	*totalLevelLabel;

- (IBAction)toggleFullScreen:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)deleteItem;
- (IBAction)newFile;
- (IBAction)saveFile;
- (IBAction)cleanFile;
- (IBAction)editLevel;
- (IBAction)runLevel;
@end
