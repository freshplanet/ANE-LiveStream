/*
 * Copyright 2017 FreshPlanet
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "AirLiveStream.h"
#import "BroadcastMenuViewController.h"
#import "FPANEUtils.h"

@implementation AirLiveStream

- (id)initWithContext:(FREContext)extensionContext {
    
    if (self = [super init])
        _context = extensionContext;
    
    return self;
}
- (void) sendLog:(NSString*)log {
    [self sendEvent:@"log" level:log];
}

- (void) sendEvent:(NSString*)code {
    [self sendEvent:code level:@""];
}

- (void) sendEvent:(NSString*)code level:(NSString*)level {
    FREDispatchStatusEventAsync(_context, (const uint8_t*)[code UTF8String], (const uint8_t*)[level UTF8String]);
}

- (void) broadcastController:(RPBroadcastController*)broadcastController didFinishWithError:(NSError * __nullable)error {
    
}

- (void) broadcastController:(RPBroadcastController*)broadcastController
       didUpdateServiceInfo:(NSDictionary <NSString*, NSObject <NSCoding>*>*)serviceInfo {
    
    
}

- (void) loadBroadcast {
    
    [RPBroadcastActivityViewController loadBroadcastActivityViewControllerWithHandler:^(RPBroadcastActivityViewController * _Nullable broadcastActivityViewController,
                                                                                        NSError * _Nullable error) {
        
        if (error)
            [self sendEvent:@"broadcastLoadFailed" level:[error localizedDescription]];
        else {
            
            [self sendEvent:@"broadcastDidLoad"];
            
            if (!broadcastActivityViewController)
                [self sendEvent:@"broadcastLoadFailed"];
            else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIApplication* app = [UIApplication sharedApplication];
                    UIWindow* keyWindow = app.keyWindow;
                    UIViewController* rootViewController = keyWindow.rootViewController;
                    
                    broadcastActivityViewController.delegate = self;
                    
                    [rootViewController presentViewController:broadcastActivityViewController animated:YES completion:^{
                        [self sendEvent:@"broadcastOptionsDidShow"];
                    }];
                });
            }
        }
    }];
}

- (void) broadcastActivityViewController:(RPBroadcastActivityViewController *)broadcastActivityViewController
        didFinishWithBroadcastController:(nullable RPBroadcastController *)broadcastController
                                   error:(nullable NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [broadcastActivityViewController dismissViewControllerAnimated:YES completion:^{
            
            if (error)
                [self sendEvent:@"broadcastOptionsFailed" level:[error localizedDescription]];
            else {
                
                _broadcastController = broadcastController;
                [self sendEvent:@"broadcastOptionsDidFinish"];
                [self sendEvent:@"broadcastIsReady"];
            }
        }];
    });
}

- (void) startBroadcast {
    
    [self sendLog:@"startBroadcast"];
    
    [_broadcastController startBroadcastWithHandler:^(NSError * _Nullable error) {
        
        [self sendLog:@"startBroadcastWithHandler"];
        
        if (error)
            [self sendEvent:@"broadcastStartFailed" level:[error localizedDescription]];
        else {
            [self sendEvent:@"broadcastDidStart"];
        }
    }];
}

- (void) stopBroadcast {
    
    if (_broadcastController) {
        
        [_broadcastController finishBroadcastWithHandler:^(NSError * _Nullable error) {
            
            if (_broadcastMenuWindow) {
                
                _broadcastMenuWindow.hidden = YES;
                _broadcastMenuWindow = nil;
            }
            
            _broadcastController = nil;
            
            if (error)
                [self sendEvent:@"broadcastDidStopWithError" level:[error localizedDescription]];
            else
                [self sendEvent:@"broadcastDidStop"];
        }];
    }
}

- (void) pauseBroadcast {
    
    if (_broadcastController && !_broadcastController.isPaused) {
        
        [_broadcastController pauseBroadcast];
        [self sendEvent:@"broadcastDidPause"];
    }
}

- (void) resumeBroadcast {
    
    if (_broadcastController && _broadcastController.isPaused) {
        
        [_broadcastController resumeBroadcast];
        [self sendEvent:@"broadcastDidResume"];
    }
}

- (BOOL) isPaused {
    return _broadcastController && _broadcastController.isPaused;
}

- (BOOL) isBroadcasting {
    return _broadcastController && _broadcastController.isBroadcasting;
}

- (void) setIsMicrophoneEnabled:(BOOL)enabled {
    
}

- (void) setIsCameraEnabled:(BOOL)enabled {
    
    [RPScreenRecorder sharedRecorder].cameraEnabled = enabled;
    
    UIApplication* app = [UIApplication sharedApplication];
    UIWindow* keyWindow = app.keyWindow;
    
    UIView* camera = [[RPScreenRecorder sharedRecorder] cameraPreviewView];
    
    if (enabled && ![keyWindow.subviews containsObject:camera]) {
        
        CGRect cameraRect = CGRectMake(0, 0, 0, 0);
        [camera setFrame:cameraRect];
        [keyWindow addSubview:camera];
    }
    else if ([keyWindow.subviews containsObject:camera]) {
        [camera removeFromSuperview];
    }
}

@end

AirLiveStream* FPGetContextNativeData(FREContext context) {
    
    CFTypeRef controller;
    FREGetContextNativeData(context, (void**)&controller);
    return (__bridge AirLiveStream*)controller;
}

DEFINE_ANE_FUNCTION(loadBroadcast) {
    
    AirLiveStream* controller = [[AirLiveStream alloc] initWithContext:context];
    FRESetContextNativeData(context, (void*)CFBridgingRetain(controller));
    
    [controller loadBroadcast];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(startBroadcast) {
    
    AirLiveStream* controller = FPGetContextNativeData(context);
    
    if (!controller)
        return FPANE_CreateError(@"context's AirLiveStream is null", 0);
    
    [controller startBroadcast];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(stopBroadcast) {
    
    AirLiveStream* controller = FPGetContextNativeData(context);
    
    if (!controller)
        return FPANE_CreateError(@"context's AirLiveStream is null", 0);
    
    [controller stopBroadcast];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(pauseBroadcast) {
    
    AirLiveStream* controller = FPGetContextNativeData(context);
    
    if (!controller)
        return FPANE_CreateError(@"context's AirLiveStream is null", 0);
    
    [controller pauseBroadcast];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(resumeBroadcast) {
    
    AirLiveStream* controller = FPGetContextNativeData(context);
    
    if (!controller)
        return FPANE_CreateError(@"context's AirLiveStream is null", 0);
    
    [controller resumeBroadcast];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(isPaused) {
    
    AirLiveStream* controller = FPGetContextNativeData(context);
    
    if (!controller)
        return FPANE_BOOLToFREObject(false);
    
    FREObject freObj = FPANE_BOOLToFREObject([controller isPaused]);
    
    return freObj;
}

DEFINE_ANE_FUNCTION(isBroadcasting) {
    
    AirLiveStream* controller = FPGetContextNativeData(context);
    
    if (!controller)
        return FPANE_BOOLToFREObject(false);
    
    FREObject freObj = FPANE_BOOLToFREObject([controller isBroadcasting]);
    
    return freObj;
}

DEFINE_ANE_FUNCTION(isMicrophoneEnabled) {
    
    BOOL enabled = [RPScreenRecorder sharedRecorder].microphoneEnabled;
    FREObject freObj = FPANE_BOOLToFREObject(enabled);
    
    return freObj;
}

DEFINE_ANE_FUNCTION(setIsMicrophoneEnabled) {
    
    BOOL enabled = FPANE_FREObjectToBool(argv[0]);
    [RPScreenRecorder sharedRecorder].microphoneEnabled = enabled;
    
    return NULL;
}

DEFINE_ANE_FUNCTION(isCameraEnabled) {
    
    BOOL enabled = [RPScreenRecorder sharedRecorder].cameraEnabled;
    FREObject freObj = FPANE_BOOLToFREObject(enabled);
    
    return freObj;
}

DEFINE_ANE_FUNCTION(setIsCameraEnabled) {
    
    BOOL enabled = FPANE_FREObjectToBool(argv[0]);
    [RPScreenRecorder sharedRecorder].cameraEnabled = enabled;
    
    return NULL;
}

void AirLiveStreamContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    static FRENamedFunction functions[] = {
        MAP_FUNCTION(loadBroadcast, NULL),
        MAP_FUNCTION(startBroadcast, NULL),
        MAP_FUNCTION(stopBroadcast, NULL),
        MAP_FUNCTION(pauseBroadcast, NULL),
        MAP_FUNCTION(resumeBroadcast, NULL),
        MAP_FUNCTION(isPaused, NULL),
        MAP_FUNCTION(isBroadcasting, NULL),
        MAP_FUNCTION(isMicrophoneEnabled, NULL),
        MAP_FUNCTION(setIsMicrophoneEnabled, NULL),
        MAP_FUNCTION(isCameraEnabled, NULL),
        MAP_FUNCTION(setIsCameraEnabled, NULL)
    };
    
    *numFunctionsToTest = sizeof(functions) / sizeof(FRENamedFunction);
    *functionsToSet = functions;
}

void AirLiveStreamContextFinalizer(FREContext ctx) {
    
    CFTypeRef controller;
    FREGetContextNativeData(ctx, (void**)&controller);
    CFBridgingRelease(controller);
}

void AirLiveStreamInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirLiveStreamContextInitializer;
    *ctxFinalizerToSet = &AirLiveStreamContextFinalizer;
}

void AirLiveStreamFinalizer(void *extData) {
    
}

