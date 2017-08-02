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

package com.freshplanet.ane.AirLiveStream {

    import flash.events.Event;

    public class AirLiveStreamEvent extends Event{

        public static const BROADCAST_DID_LOAD:String = "broadcastDidLoad";
        public static const BROADCAST_DID_START:String = "broadcastDidStart";
        public static const BROADCAST_DID_STOP:String = "broadcastDidStop";
        public static const BROADCAST_DID_PAUSE:String = "broadcastDidPause";
        public static const BROADCAST_DID_RESUME:String = "broadcastDidResume";

        public static const BROADCAST_IS_READY:String = "broadcastIsReady";

        public static const BROADCAST_OPTIONS_DID_SHOW:String = "broadcastOptionsDidShow";
        public static const BROADCAST_OPTIONS_DID_FINISH:String = "broadcastOptionsDidFinish";

        public static const BROADCAST_LOAD_FAILED:String = "broadcastLoadFailed";
        public static const BROADCAST_START_FAILED:String = "broadcastStartFailed";
        public static const BROADCAST_OPTIONS_FAILED:String = "broadcastOptionsFailed";

        public static const BROADCAST_DID_STOP_WITH_ERROR:String = "broadcastDidStopWithError";

        public function AirLiveStreamEvent(type:String,  bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
        }
    }
}
