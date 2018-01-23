//
//  ExampleCoreAudioDevice.h
//  ObjCVideoQuickstart
//
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

#import <TwilioVideo/TwilioVideo.h>

/*
 *  ExampleCoreAudioDevice uses a RemoteIO audio unit to playback stereo audio at up to 48 kHz.
 *  In contrast to `TVIDefaultAudioDevice`, this device does not record audio and is intended for high quality playback
 *  only. Since playback and recording is not needed this device does not use the built in echo cancellation provided
 *  by the VoiceProcessingIO audio unit.
 */
@interface ExampleCoreAudioDevice : NSObject <TVIAudioDevice>

- (nullable TVIAudioFormat *)renderFormat;

- (BOOL)initializeRenderer;

- (BOOL)startRendering:(nonnull TVIAudioDeviceContext)context;

- (BOOL)stopRendering;

- (nullable TVIAudioFormat *)captureFormat;

- (BOOL)initializeCapturer;

- (BOOL)startCapturing:(nonnull TVIAudioDeviceContext)context;

- (BOOL)stopCapturing;

@end
