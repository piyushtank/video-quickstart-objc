//
//  ExampleCoreAudioDevice.m
//  ObjCVideoQuickstart
//
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

#import "ExampleCoreAudioDevice.h"

// We want to get as close to 10 msec buffers as possible, because this is what the media engine prefers.
static double kPreferredIOBufferDuration = 0.01;

@interface ExampleCoreAudioDevice()

@property (nonatomic, assign) AudioUnit audioUnit;
@property (nonatomic, strong, nullable) TVIAudioFormat *renderingFormat;
@property (nonatomic, assign) TVIAudioDeviceContext renderingContext;

@end

@implementation ExampleCoreAudioDevice

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

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
    NSAssert(self.audioUnit == NULL, @"The audio unit should not be created yet.");
    [self setupAudioUnit];

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

#pragma mark - Private

- (void)setupAVAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;

    if (![session setPreferredSampleRate:self.renderingFormat.sampleRate error:&error]) {
        NSLog(@"Error setting sample rate: %@", error);
    }

    if (![session setPreferredOutputNumberOfChannels:self.renderingFormat.numberOfChannels error:&error]) {
        NSLog(@"Error setting number of output channels: %@", error);
    }

    if (![session setPreferredInputNumberOfChannels:1 error:&error]) {
        NSLog(@"Error setting number of input channels: %@", error);
    }

    // We want to be as close as possible to the 10 millisecond buffer size that the media engine needs. If there is
    // a mismatch then TwilioVideo will ensure that appropriately sized audio buffers are delivered.
    if (![session setPreferredIOBufferDuration:kPreferredIOBufferDuration error:&error]) {
        NSLog(@"Error setting IOBuffer duration: %@", error);
    }

    AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionDefaultToSpeaker;

    if (![session setCategory:AVAudioSessionCategoryPlayback
                         mode:AVAudioSessionModeDefault
                      options:options
                        error:&error]) {
        NSLog(@"Error setting session category: %@", error);
    }

    [self registerAVAudioSessionObservers];

    if (![session setActive:YES error:&error]) {
        NSLog(@"Error activating AVAudioSession: %@", error);
    }
}

- (void)setupAudioUnit {
    // TODO:
}

- (void)registerAVAudioSessionObservers {
    // TODO:
}

- (void)unregisterAVAudioSessionObservers {
    // TODO:
}

- (void)teardownAudioUnit {
    if (_audioUnit) {
        AudioUnitUninitialize(_audioUnit);
        AudioComponentInstanceDispose(_audioUnit);
        _audioUnit = NULL;
    }
}

@end
