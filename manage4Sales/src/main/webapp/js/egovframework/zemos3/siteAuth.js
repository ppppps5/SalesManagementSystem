
var SiteAuth = (function(){
	
	var siteAuthList;
	var callback;
	var iOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;

	var regions = [];
	var beacons = {};
	var beaconTimer = null;

	var geoWatchFlag = false;
	var geoOption = {
		maximumAge : 0,				// 갱신주기(1/1000초 단위)
		timeout : 5000,				// 타임아웃(1/1000초 단위)
		enableHighAccuracy : true	// 높은 정확도 사용
	};
	
	// 900 이상은 시스템 오류
	// 100 미만은 환경/input 오류
	var errorCode = {
			"unknown" : 999,							// 기타오류
			"notHybrid" : 0,							// Hybrid 환경이 아님 
			"siteAuthList" : 1,							// 권한목록이 없음.
			"deniedPermissionGPS" : 100,				// GPS 권한없음.
			"gpsLocationDisabled" : 101,				// GPS가 꺼져있음.
			"bluetoothDisabled" : 110,					// Bluetooth가 꺼져있음. (beacon때문에 사용)
			"navigator.geolocation" : 900,
			"isGpsLocationAvailable" : 901,
			"requestLocationAuthorization" : 902,
			"isLocationAuthorized" : 903,
			"isGpsLocationEnabled" : 904,
			"isBluetoothAvailable" : 920,
			"isBluetoothEnabled" : 920,
		}
	
	
	// 900 이상은 시스템 오류
	// 100 미만은 환경/input 오류
	var errorMsg = {
			"unknown" : "unknown error",						// 기타오류
			"notHybrid" : "Hybrid is not defined",				// Hybrid 환경이 아님 
			"siteAuthList" : "siteAuthList is null",			// 권한목록이 없음.
			"deniedPermissionGPS" : "deniedPermissionGPS",		// GPS 권한없음.
			"gpsLocationDisabled" : "gpsLocationDisabled",		// GPS가 꺼져있음.
			"bluetoothDisabled" : "bluetoothDisabled",			// Bluetooth가 꺼져있음.
			"navigator.geolocation" : "navigator.geolocation",
			"isGpsLocationAvailable" : "isGpsLocationAvailable",
			"requestLocationAuthorization" : "requestLocationAuthorization",
			"isLocationAuthorized" : "isLocationAuthorized",
			"isGpsLocationEnabled" : "isGpsLocationEnabled",
			"isBluetoothAvailable" : "isBluetoothAvailable",
			"isBluetoothEnabled" : "isBluetoothEnabled",
		}
	
	
	// 900 이상은 시스템 오류
	// 100 미만은 환경/input 오류
	var errorMsgKo = {
			"unknown" : "알수없는 오류입니다.",							// 기타오류
			"notHybrid" : "Hybrid 환경이 아닙니다.",					// Hybrid 환경이 아님 
			"siteAuthList" : "근태기준이 설정되어 있지 않습니다.\n회사 관리자에게 문의해 주세요.",		// 권한목록이 없음.
			"deniedPermissionGPS" : "GPS 권한이 존재하지 않습니다.",	// GPS 권한없음.
			"gpsLocationDisabled" : "GPS가 꺼져있습니다.",				// GPS가 꺼져있음.
			"bluetoothDisabled" : "Bluetooth가 꺼져있습니다.",			// Bluetooth가 꺼져있음.
			"navigator.geolocation" : "navigator.geolocation",
			"isGpsLocationAvailable" : "isGpsLocationAvailable",
			"requestLocationAuthorization" : "requestLocationAuthorization",
			"isLocationAuthorized" : "isLocationAuthorized",
			"isGpsLocationEnabled" : "isGpsLocationEnabled",
			"isBluetoothAvailable" : "isBluetoothAvailable",
			"isBluetoothEnabled" : "isBluetoothEnabled",
		}
	
	
	var init = function() {
		callback = null;
		beacons = {};
		regions = [];
		
		if (beaconTimer != null)
			clearInterval(beaconTimer);
		geoWatchFlag = false;
	}
	
	
	var startCheck = function(_siteAuthList, _callback) {
		stopCheck();

		if (typeof _callback != "function")
			return;
		
		init();
		siteAuthList = _siteAuthList;
		
		callback = _callback;
		//alert('callback > ' + callback);
		if (!Hybrid) {
			callback({
				result : false,
				message : errorMsg["notHybrid"],
				messageKo : errorMsgKo["notHybrid"],
				code : errorCode["notHybrid"]
				
			});
			return;
		}
		else if (siteAuthList.GPS.length == 0 && siteAuthList.BEACON.length == 0 && siteAuthList.WIFI.length == 0) {
			callback({
				result : false,
				message : errorMsg["siteAuthList"],
				messageKo : errorMsgKo["siteAuthList"],
				code : errorCode["siteAuthList"]
			});
			return;
		}
		
		
		// checkGeoLoaction
		Hybrid.checkGeoLocation(function() {
			// check GPS
			if (siteAuthList.GPS.length > 0) {
				getGeoLocation();
			}
			
			// check BEACON
			if (siteAuthList.BEACON.length > 0) {
				for ( var key = 0; key < siteAuthList.BEACON.length; key++  ) {
					regions.push({uuid : siteAuthList.BEACON[key].uuid.toUpperCase()});
				}
				/*
				for (var key in siteAuthList.BEACON) {
					regions.push({uuid : siteAuthList.BEACON[key].uuid.toUpperCase()});
				}
				*/
				startScanBeacon();
			}
			
			// check WIFI
			if (siteAuthList.WIFI.length > 0) {
				Hybrid.getSsid(function(ssid) {
					if (ssid != null) {
						for (var key in siteAuthList.WIFI) {
							if (siteAuthList.WIFI[key].ssid == ssid) {
								stopScanBeacon();
								callback({
									result : true,
									data : siteAuthList.WIFI[key]
								});
							}
						}
					}
				});
			}
		}, function error(error) {
			callback({
				result : false,
				message : error.message,
				messageKo : error.message,
				code : errorCode["unknown"]
			});
		});


	};
	
	
	var stopCheck = function() {
		//이거 어찌해야되는거.............. 2020.11.10 주석
		stopScanBeacon();
		Hybrid.clearWatch();
	};
	
	
	function startScanBeacon() {
		beacons = {};
		
		Hybrid.startScanBeacon(regions, function(data) {
			for (var i in data) {
				var beacon = data[i];
				beacon.timeStamp = Date.now();
				var key = beacon.uuid + ':' + beacon.major + ':' + beacon.minor;
				beacons[key.toUpperCase()] = beacon;
			}
		}, function(error) {
			console.log(error);
		});
		
		if (beaconTimer != null)
			clearInterval(beaconTimer);
		
		beaconTimer = setInterval(function() {
			var timeNow = Date.now();
			
			for (var key in beacons) {

				var beacon = beacons[key];
				
				// Only show beacons that are updated during the last 60 seconds.
				if (beacon.timeStamp + 60000 > timeNow) {
					for (var i = 0; i < siteAuthList.BEACON.length; i++) {
						if (key == (siteAuthList.BEACON[i].uuid + ':' + siteAuthList.BEACON[i].major + ':' + siteAuthList.BEACON[i].minor).toUpperCase()) {
							stopScanBeacon();
							callback({
								result : true,
								data : siteAuthList.BEACON[i]
							});
							return;
						}
					}
				}
			}
		}, 500);
	}
	function stopScanBeacon() {
		if (beaconTimer != null)
			clearInterval(beaconTimer);
		Hybrid.stopScanBeacon(regions);
	}
	
	function getGeoLocation() {
		Hybrid.watchPosition(geoSuccessCallback, geoErrorCallback, geoOption);
		//Hybrid.getGeoLocation(geoSuccessCallback, geoErrorCallback, geoOption);
	}
	
	function geoSuccessCallback(position) {
		for (var key in siteAuthList.GPS) {
			var startLatRads = siteAuthList.GPS[key].latitude * (Math.PI / 180);
			var startLongRads = siteAuthList.GPS[key].longitude * (Math.PI / 180);
			var destLatRads = position.coords.latitude * (Math.PI / 180);
			var destLongRads = position.coords.longitude * (Math.PI / 180);
			var radius = 6371 * 1000;
			var distance = Math.acos(Math.sin(startLatRads) * Math.sin(destLatRads) + Math.cos(startLatRads) * Math.cos(destLatRads) * Math.cos(startLongRads - destLongRads)) * radius;

			if (distance <= siteAuthList.GPS[key].distance) {
				try {
					stopCheck();
				} catch(e){}
				callback({
					result : true,
					data : siteAuthList.GPS[key]
				});
				return;
			}
		}

/*		
		if (!geoWatchFlag) {
			geoWatchFlag = true;
			Hybrid.watchPosition(geoSuccessCallback, geoErrorCallback, geoOption);
		}
*/
	}
	
	function geoErrorCallback(error) {
		console.log(error.code + "," + error.message);
	}

	
	return {
		startCheck : startCheck,
		stopCheck : stopCheck
	}
	
})();
