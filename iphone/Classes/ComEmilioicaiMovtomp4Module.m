/**
 * movToMp4
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "ComEmilioicaiMovtomp4Module.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation ComEmilioicaiMovtomp4Module

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"326ea198-3e62-473e-8cf1-a0abfeaab5fc";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.emilioicai.movtomp4";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

- (void) convert:(id)args {
    if ([args count] > 0) {
        NSString *inputUrlString = [args objectAtIndex:0];
        NSURL *inputURL = [NSURL fileURLWithPath: inputUrlString];
        //Check if the file already exists then remove the previous file
        if (![[NSFileManager defaultManager]fileExistsAtPath:inputUrlString])
        {
            NSLog(@"Input file doesn't exist: %@", inputUrlString);
            return;
        }
        // Create the asset url with the video file
        AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
        NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
        // Check if video is supported for conversion or not
        if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality])
        {
            //Create Export session
            AVAssetExportSession *exportSession = [[AVAssetExportSession       alloc]initWithAsset:avAsset presetName:AVAssetExportPresetLowQuality];
            
            NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@.mp4", inputUrlString]];
            NSLog(@"Exporting to: %@", [NSString stringWithFormat:@"%@.mp4", inputUrlString]);
            
            exportSession.outputURL = url;
            //set the output file format if you want to make it in other file format (ex .3gp)
            exportSession.outputFileType = AVFileTypeMPEG4;
            exportSession.shouldOptimizeForNetworkUse = YES;

            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                switch ([exportSession status])
                {
                    case AVAssetExportSessionStatusFailed:
                        NSLog(@"Error Exporting: %@", [exportSession error]);
                        break;
                    case AVAssetExportSessionStatusCancelled:
                        NSLog(@"Export canceled");
                        break;
                    case AVAssetExportSessionStatusCompleted:
                    {
                        //Video conversion finished
                        NSLog(@"Successful!");
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
        else
        {
            NSLog(@"Video file not supported!");
        }
    }
}


@end
