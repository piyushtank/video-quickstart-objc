//
//  ExampleCoreAudioDevice.m
//  ObjCVideoQuickstart
//
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

#import "ExampleCoreAudioDevice.h"

@interface ExampleCoreAudioDevice()

@property (nonatomic, assign) TVIAudioDeviceContext renderingContext;

@end

@implementation ExampleCoreAudioDevice

#pragma mark - TVIAudioDeviceRenderer.

- (nullable TVIAudioFormat *)renderFormat {
    // TODO: Use the real value from AVAudioSession here!
    TVIAudioFormat *format = [[TVIAudioFormat alloc] initWithChannels:TVIAudioChannelsStereo
                                                           sampleRate:TVIAudioSampleRate48000
                                                      framesPerBuffer:TVIAudioSampleRate48000 / 100];

    return format;
}

- (BOOL)initializeRenderer {
    // Setup AVAudioSession and size buffers here.
    return YES;
}

- (BOOL)startRendering:(nonnull TVIAudioDeviceContext)context {
    self.renderingContext = context;

    // TODO: Start core audio graph here.

    return YES;
}

- (BOOL)stopRendering {
    // TODO: Stop and destroy core audio graph here.
    return YES;
}

#pragma mark - TVIAudioDeviceCapturer.

- (nullable TVIAudioFormat *)captureFormat {
    // We don't support capturing, and return a nil format to indicate this. The other TVIAudioDeviceCapturer methods
    // are simply stubs.
    return nil;
}

- (BOOL)initializeCapturer {
    return NO;
}

- (BOOL)startCapturing:(nonnull TVIAudioDeviceContext)context {
    return NO;
}

- (BOOL)stopCapturing {
    return NO;
}

@end
