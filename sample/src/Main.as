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
package {


import com.freshplanet.ane.AirLiveStream.AirLiveStream;
import com.freshplanet.ane.AirLiveStream.AirLiveStreamEvent;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.events.Event;

import com.freshplanet.ui.ScrollableContainer;
import com.freshplanet.ui.TestBlock;

[SWF(backgroundColor="#057fbc", frameRate='60')]
public class Main extends Sprite {

    public static var stageWidth:Number = 0;
    public static var indent:Number = 0;

    private var _scrollableContainer:ScrollableContainer = null;

    public function Main() {
        this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    private function _onAddedToStage(event:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        this.stage.align = StageAlign.TOP_LEFT;

        stageWidth = this.stage.stageWidth;
        indent = stage.stageWidth * 0.025;

        _scrollableContainer = new ScrollableContainer(false, true);
        this.addChild(_scrollableContainer);

        if (!AirLiveStream.isSupported) {
            trace("AirLiveStream ANE is NOT supported on this platform!");
            return;
        }

        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_DID_LOAD, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_DID_PAUSE, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_DID_RESUME, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_DID_START, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_DID_STOP, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_DID_STOP_WITH_ERROR, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_IS_READY, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_LOAD_FAILED, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_OPTIONS_DID_FINISH, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_OPTIONS_DID_SHOW, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_OPTIONS_FAILED, onEvent);
        AirLiveStream.instance.addEventListener(AirLiveStreamEvent.BROADCAST_START_FAILED, onEvent);

        var blocks:Array = [];

	    blocks.push(new TestBlock("loadBroadcast", function():void {
		    AirLiveStream.instance.loadBroadcast();
	    }));
        blocks.push(new TestBlock("startBroadcast", function():void {
	        AirLiveStream.instance.startBroadcast();
        }));
        blocks.push(new TestBlock("stopBroadcast", function():void {
	        AirLiveStream.instance.stopBroadcast();
        }));
        blocks.push(new TestBlock("pauseBroadcast", function():void {
            AirLiveStream.instance.pauseBroadcast();
        }));
        blocks.push(new TestBlock("resumeBroadcast", function():void {
            AirLiveStream.instance.resumeBroadcast();
        }));
        blocks.push(new TestBlock("isPaused", function():void {
            trace("isPaused ", AirLiveStream.instance.isPaused);
        }));
        blocks.push(new TestBlock("isBroadcasting", function():void {
            trace("isBroadcasting ", AirLiveStream.instance.isBroadcasting);
        }));
        blocks.push(new TestBlock("isMicrophoneEnabled", function():void {
            trace("isBroadcasting ", AirLiveStream.instance.isMicrophoneEnabled);
        }));
        blocks.push(new TestBlock("disable microphone", function():void {
            AirLiveStream.instance.isMicrophoneEnabled = false;
        }));



        /**
         * add ui to screen
         */

        var nextY:Number = indent;

        for each (var block:TestBlock in blocks) {

            _scrollableContainer.addChild(block);
            block.y = nextY;
            nextY +=  block.height + indent;
        }
    }

    private function onEvent(event:AirLiveStreamEvent):void {
        trace("Received event: ", event.type);
    }



}
}
