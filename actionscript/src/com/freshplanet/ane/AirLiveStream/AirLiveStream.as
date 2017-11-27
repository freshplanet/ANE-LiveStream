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

    import flash.events.EventDispatcher;
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class AirLiveStream extends EventDispatcher {

        // --------------------------------------------------------------------------------------//
        //																						 //
        // 									   PUBLIC API										 //
        // 																						 //
        // --------------------------------------------------------------------------------------//

        public static var logEnabled:Boolean = false;

        /** supported on iOS devices. */
        public static function get isSupported():Boolean {
            return _isIOS();// || _isAndroid();
        }

		/**
		 * AirLiveStream instance
         */
        public static function get instance():AirLiveStream {

            if (!_instance)
                new AirLiveStream();

            return _instance;
        }

        /**
         * Load broadcast
         */
        public function loadBroadcast():void {
            _call("loadBroadcast");
        }

        /**
         * Start broadcast
         */
        public function startBroadcast():void {
            _call("startBroadcast");
        }

        /**
         * Stop broadcast
         */
        public function stopBroadcast():void {
            _call("stopBroadcast");
        }

        /**
         * Pause broadcast
         */
        public function pauseBroadcast():void {
            _call("pauseBroadcast");
        }

        /**
         * Resume broadcast
         */
        public function resumeBroadcast():void {
            _call("resumeBroadcast");
        }

		/**
         * Is the broadcast paused
         * @return
         */
        public function get isPaused():Boolean {
            return _call("isPaused");
        }

        /**
         * Is currently broadcasting
         * @return
         */
        public function get isBroadcasting():Boolean {
            return _call("isBroadcasting");
        }

        /**
         * Is microphone enabled
         * @return
         */
        public function get isMicrophoneEnabled():Boolean {
            return _call("isMicrophoneEnabled");
        }

		/**
         * Set isMicrophone enabled
         * @param enabled
         */
        public function set isMicrophoneEnabled(enabled:Boolean):void {
            _call("setIsMicrophoneEnabled", enabled);
        }

        // --------------------------------------------------------------------------------------//
        //																						 //
        // 									 	PRIVATE API										 //
        // 																						 //
        // --------------------------------------------------------------------------------------//

        private static const EXTENSION_ID:String = "com.freshplanet.ane.AirLiveStream";
        private static var _instance:AirLiveStream = null;
        private var _context:ExtensionContext = null;

        /**
         * "private" singleton constructor
         */
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

            if (logEnabled)
                trace("AirLiveStream", "EVENT", event.code, event.level);

            this.dispatchEvent(new AirLiveStreamEvent(event.code));
        }

        private function _call(functionName:String, ...vars):* {

            if (!_context)
                return false;

            if(!isSupported)
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
			return Capabilities.manufacturer.indexOf("iOS") > -1 && Capabilities.os.indexOf("x86_64") < 0 && Capabilities.os.indexOf("i386") < 0 && _iOSVersion >= 10;
        }

        private static function get _iOSVersion():uint {

            var iosVersion:String = Capabilities.os.match(/([0-9]\.?){2,3}/)[0];
            iosVersion = iosVersion.substr(0, iosVersion.indexOf("."));

            return Number(iosVersion);
        }
	}
}