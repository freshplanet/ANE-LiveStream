//
//  AirLiveStream.h
//  AirLiveStream
//
//  Created by Adam Schlesinger on 11/18/16.
//  Copyright © 2016 Freshplanet, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReplayKit/ReplayKit.h>
#import "FlashRuntimeExtensions.h"

@interface AirLiveStream : NSObject <RPBroadcastActivityViewControllerDelegate, RPBroadcastControllerDelegate> {
    RPBroadcastController* _broadcastController;
    UIWindow* _broadcastMenuWindow;
    FREContext _context;
}

@end

void AirLiveStreamContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AirLiveStreamContextFinalizer(FREContext ctx);
void AirLiveStreamInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AirLiveStreamFinalizer(void *extData);
