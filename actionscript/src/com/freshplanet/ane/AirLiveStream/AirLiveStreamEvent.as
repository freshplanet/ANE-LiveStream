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
