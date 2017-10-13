//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject fn(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

#define ROOT_VIEW_CONTROLLER [[[UIApplication sharedApplication] keyWindow] rootViewController]

void AirLiveStream_FPANE_DispatchEvent(FREContext context, NSString *eventName);
void AirLiveStream_FPANE_DispatchEventWithInfo(FREContext context, NSString *eventName, NSString *eventInfo);
void AirLiveStream_FPANE_Log(FREContext context, NSString *message);

NSString * AirLiveStream_FPANE_FREObjectToNSString(FREObject object);
NSArray * AirLiveStream_FPANE_FREObjectToNSArrayOfNSString(FREObject object);
NSDictionary * AirLiveStream_FPANE_FREObjectsToNSDictionaryOfNSString(FREObject keys, FREObject values);
BOOL AirLiveStream_FPANE_FREObjectToBool(FREObject object);
NSInteger AirLiveStream_FPANE_FREObjectToInt(FREObject object);

FREObject AirLiveStream_FPANE_BOOLToFREObject(BOOL boolean);
FREObject AirLiveStream_FPANE_IntToFREObject(NSInteger i);
FREObject AirLiveStream_FPANE_DoubleToFREObject(double d);
FREObject AirLiveStream_FPANE_NSStringToFREObject(NSString *string);

FREObject AirLiveStream_FPANE_CreateError( NSString* error, NSInteger* id );
