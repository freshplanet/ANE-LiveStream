package com.freshplanet.ane.AirLiveStream {

    import flash.events.EventDispatcher;
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class AirLiveStream extends EventDispatcher {

        /**
         *
         * PUBLIC
         *
         */

        public static var DEBUG_ENABLED:Boolean = false;

        public static function get instance():AirLiveStream {

            if (!_instance)
                new AirLiveStream();

            return _instance;
        }

		public static function get isSupported():Boolean {
			return _isIOS();// || _isAndroid();
		}

        public function loadBroadcast():void {
            _call("loadBroadcast");
        }

        public function startBroadcast():void {
            _call("startBroadcast");
        }

        public function stopBroadcast():void {
            _call("stopBroadcast");
        }

        public function pauseBroadcast():void {
            _call("pauseBroadcast");
        }

        public function resumeBroadcast():void {
            _call("resumeBroadcast");
        }

        public function isPaused():Boolean {
            return _call("isPaused");
        }

        public function isBroadcasting():Boolean {
            return _call("isBroadcasting");
        }

        public function isMicrophoneEnabled():Boolean {
            return _call("isMicrophoneEnabled");
        }

        public function setIsMicrophoneEnabled(enabled:Boolean):void {
            _call("setIsMicrophoneEnabled", enabled);
        }

        /**
         *
         * PRIVATE
         *
         */

        private static const EXTENSION_ID:String = "com.freshplanet.ane.AirLiveStream";
        private static var _instance:AirLiveStream = null;
        private var _context:ExtensionContext;

        function AirLiveStream() {

            if (!_instance) {

                if (isSupported) {

                    _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);

                    if (_context)
                        _context.addEventListener(StatusEvent.STATUS, _handleStatusEvent);
                }

                _instance = this;
            }
        }

        private function _handleStatusEvent(event:StatusEvent):void {

            if (DEBUG_ENABLED)
                trace("AirLiveStream", "EVENT", event.code, event.level);

            this.dispatchEvent(new AirLiveStreamEvent(event.code));
        }

        private function _call(functionName:String, ...vars):* {

            if (!_context)
                return false;

            var ret:Object = null;

            if (!vars || vars.length == 0)
                ret = _context.call(functionName);
            else {

                vars.unshift(functionName);
                ret = _context.call.apply(null, vars);
            }

            if (ret is Error)
                throw ret;

            return ret;
        }

        private static function _isAndroid():Boolean {
            return Capabilities.manufacturer.indexOf("Android") > -1;
        }

        private static function _isIOS():Boolean {
            return Capabilities.manufacturer.indexOf("iOS") > -1 && _iOSVersion >= 10;
        }

        private static function get _iOSVersion():uint {

            var iosVersion:String = Capabilities.os.match(/([0-9]\.?){2,3}/)[0];
            iosVersion = iosVersion.substr(0, iosVersion.indexOf("."));

            return Number(iosVersion);
        }
	}
}