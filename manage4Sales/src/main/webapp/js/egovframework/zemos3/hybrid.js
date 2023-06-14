
var Hybrid = (function(){
	
	var isHybrid = false;
	var eventListener = {};
	/* 기존 2020.12.14
	 * iOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;*/
	/* 변경 2020.12.14 */
	var iOS = (['iPad Simulator','iPhone Simulator','iPod Simulator','iPad','iPhone','iPod'].includes(navigator.platform)|| (navigator.userAgent.includes("Mac") && "ontouchend" in document));
	
	var confirmBuletooth = false;
	
	var init = function() {
		isHybrid = (window.device) ? true : false;
	};
	
	/**
	 * 900 이상은 시스템 오류
	 */
	var errorCode = {
		"deniedPermissionGPS" : 100,				// GPS 권한없음.
		"gpsLocationDisabled" : 101,				// GPS가 꺼져있음.
		"bluetoothDisabled" : 110,					// Bluetooth가 꺼져있음.
		"isAppVersionCheck" : 200,					// App Version 체크 실패
		"navigator.geolocation" : 900,
		"isGpsLocationAvailable" : 901,
		"requestLocationAuthorization" : 902,
		"isLocationAuthorized" : 903,
		"isGpsLocationEnabled" : 904,
		"isBluetoothAvailable" : 920,
		"isBluetoothEnabled" : 920,
	}
	
	/**
	 * 900 이상은 시스템 오류
	 */
	var errorMsg = {
		"deniedPermissionGPS" : "사용자가 GPS 접근 권한을 거부하였습니다!",		// GPS 권한없음.
		"gpsLocationDisabled" : "GPS가 꺼져 있습니다!",							// GPS가 꺼져있음.
		"bluetoothDisabled" : "Bluetooth가 꺼져있습니다!",						// Bluetooth가 꺼져있음.
		"isAppVersionCheck" : "App Version 체크에 실패하였습니다.",				// App Version 체크 실패
		"navigator.geolocation" : "navigator.geolocation not supported!",
		"isGpsLocationAvailable" : "cordova.plugins.diagnostic.isGpsLocationAvailable error",
		"requestLocationAuthorization" : "cordova.plugins.diagnostic.requestLocationAuthorization error",
		"isLocationAuthorized" : "cordova.plugins.diagnostic.isLocationAuthorized error",
		"isGpsLocationEnabled" : "cordova.plugins.diagnostic.isGpsLocationEnabled error",
		"isBluetoothAvailable" : "cordova.plugins.diagnostic.isBluetoothAvailable error",
		"isBluetoothEnabled" : "cordova.plugins.diagnostic.isBluetoothEnabled error",
	}
	

	/**
	 * Device 정보를 가져온다
	 * * device.cordova : cordova version <br/>
	 * * device.model : phone model <br/>
	 * * device.platform : Android <br/>
	 * * device.uuid <br/>
	 * * device.version <br/>
	 * * device.manufacturer <br/>
	 * * device.isVirtual <br/>
	 * * device.serial <br/>
	 */
	var getDeviceInfo = function() {
		return isHybrid ? window.device : null; 
	};
	
	
	/**
	 * Token 정보를 가져온다
	 */
	var getToken = function(successCallback, errorCallback) {
		var i = 0;
		if (iOS) {
			cordova.plugins.firebase.messaging.requestPermission().then(function() {
				cordova.plugins.firebase.messaging.getToken().then(function(token) {
					successCallback(token);
				});			    
			}).catch(function (error) {
				setTimeout(function() {
					Hybrid.getToken(successCallback, errorCallback)
				}, 100);
			});
		} else if (FCM) {
			FCM.getToken().then(function(token) {
				if (typeof successCallback === 'function')
					successCallback(token);
			}).catch(function(error) {
				if (typeof errorCallback === 'function')
					errorCallback(error);
			});
		} else {			
			FCMPlugin.getToken(function(token) {				
				if (typeof successCallback === 'function') {					
					if (typeof token != "undefined" && token != null && token != "") {
						successCallback(token);
					} else {
						successCallback(window.device ? window.device.uuid : '');
					}
				}
				
			}, function(error) {				
				if (typeof errorCallback === 'function') {					
					if (typeof window.device != "undefined" && window.device != null && window.device != "") {
						successCallback(window.device.uuid);
					} else {
						errorCallback(error);
					}
				}
			});
		}
	};
	
	
	/**
	 * Push notification 등록 
	 */
	var onNotification = function(notiCallback, successCallback, errorCallback) {
		if (!isHybrid) {
			if (typeof errorCallback === 'function')
				errorCallback();
			return
		}
		
		if (iOS) {
			FCMPlugin.onNotification(function(data) {
				if (typeof notiCallback === 'function')
					notiCallback(data);
			}, function(message) {
				if (typeof successCallback === 'function')
					successCallback(message);
			}, function(error) {
				if (typeof errorCallback === 'function')
					errorCallback(error);
			});	
		} else if (FCM) {
			FCM.onNotification(function(payload) {
				notiCallback(payload);
			})
		} else {
			FCMPlugin.onNotification(function(data) {
				if (typeof notiCallback === 'function')
					notiCallback(data);
			}, function(message) {
				if (typeof successCallback === 'function')
					successCallback(message);
			}, function(error) {
				if (typeof errorCallback === 'function')
					errorCallback(error);
			});		
		}
	};
	
	
	// GPS 활성화 여부 체크
	var isEnableGps = function(callback) {
		//alert('typeof callback >'+typeof callback);
		if (typeof callback != "function")
			return;
		
		//alert("iOS >>> " + iOS);
		if (iOS) {
			cordova.plugins.diagnostic.isLocationAvailable(function(available) {
				callback({
					result : true,
					data : available
				});
			}, function(error) {
				callback({
					result : false,
					code : errorCode["isGpsLocationAvailable"], 
					message : errorMsg["isGpsLocationAvailable"]
				});
			});
		}
		else {
			cordova.plugins.diagnostic.isGpsLocationAvailable(function(available) {
				callback({
					result : true,
					data : available
				});
			}, function(error) {
				callback({
					result : false,
					code : errorCode["isGpsLocationAvailable"], 
					message : errorMsg["isGpsLocationAvailable"]
				});
			});
		}
	};
	
	
	// GPS 셋팅 메뉴로 이동
	var goGpsSetting = function(callback) {
		if (typeof callback != "function")
			return;

		cordova.plugins.diagnostic.isLocationAuthorized(function(authorized) {
			if (authorized) {
				checkDeviceSetting(callback);
			}
			else {
				cordova.plugins.diagnostic.requestLocationAuthorization(function(status) {
					switch(status){
						case cordova.plugins.diagnostic.permissionStatus.GRANTED:
							checkDeviceSetting(callback);
							break;
						case cordova.plugins.diagnostic.permissionStatus.DENIED:
						case cordova.plugins.diagnostic.permissionStatus.DENIED_ALWAYS:
						default :
							callback({
								result : false,
								code : errorCode["deniedPermissionGPS"], 
								message : errorMsg["deniedPermissionGPS"]
							});
							break;
					}
				}, function(error) {
					callback({
						result : false,
						code : errorCode["requestLocationAuthorization"], 
						message : errorMsg["requestLocationAuthorization"]
					});
				});
			}
		}, function(error) {
			callback({
				result : false,
				code : errorCode["isLocationAuthorized"], 
				message : errorMsg["isLocationAuthorized"]
			});
		});
		
		
		var checkDeviceSetting = function(callback) {
			if (iOS) {
				cordova.plugins.diagnostic.isLocationEnabled(function(enabled) {
					if (!enabled) {
						callback({
							result : true,
							data : true
						});
						//cordova.plugins.diagnostic.switchToLocationSettings();
					}
				}, function(error) {
					callback({
						result : false,
						code : errorCode["isGpsLocationEnabled"], 
						message : errorMsg["isGpsLocationEnabled"]
					});
				});
			}
			else {
				cordova.plugins.diagnostic.isGpsLocationEnabled(function(enabled) {
					if (!enabled) {
						callback({
							result : true,
							data : true
						});
						cordova.plugins.diagnostic.switchToLocationSettings();
					}
				}, function(error) {
					callback({
						result : false,
						code : errorCode["isGpsLocationEnabled"], 
						message : errorMsg["isGpsLocationEnabled"]
					});
				});
			}
		};
	};



	/**
	 * @return
	 * 	successCallback
	 * 		position
	 * 			Coordinates coords: 위치 정보
	 * 				double latitude: 위도
	 * 				double longitude: 경도
	 * 				double altitude (옵션): 고도
	 * 				double accuracy: 정확도
	 * 				double altitudeAccuracy (옵션): 고도 정확도
	 * 				double heading (옵션): 현재 향하고 있는 방향
	 * 				double speed (옵션): 현재 속도
	 * 	errorCallback
	 * 		error
	 * 			unsigned short code: 오류 코드
	 * 				1: 사용자가 위치 정보 수집을 거부, 
	 * 				2: 위치 정보 수집 불가(예: GPS 동작 불가 지역 등), 
	 * 				3: 위치 정보를 수집하기 전에 먼저 옵션의 timeout 값 시간이 소모)
	 * 				9: 기타
	 * 			DOMString message: 오류 메세지
	 * 	options
	 * 		maximumAge : 3000,			// 갱신주기(1/1000초 단위)
	 * 		timeout : 5000,				// 타임아웃(1/1000초 단위)
	 * 		enableHighAccuracy : true	// 높은 정확도 사용
	 */
	var checkOnly = false;
	var checkGeoLocation = function(successCallback, errorCallback) {
		checkOnly = true;
		getGeoLocation(successCallback, errorCallback, {})
	}
	var getGeoLocation = function(successCallback, errorCallback, options) {
		options = options || {
			maximumAge : 0,				// 갱신주기(1/1000초 단위)
			timeout : 5000,				// 타임아웃(1/1000초 단위)
			enableHighAccuracy : true	// 높은 정확도 사용
		};

		if (!navigator.geolocation) {
			errorCallback({code : errorCode["navigator.geolocation"], message : errorMsg["navigator.geolocation"]})
			return;
		}
		
		var checkAvailability = function() {
			if (iOS) {
				cordova.plugins.diagnostic.isLocationAvailable(function(available) {
					if (available)
						getCurrentPosition();
					else
						checkAuthorization();
				}, function(error) {
					errorCallback({code : errorCode["isGpsLocationAvailable"], message : errorMsg["isGpsLocationAvailable"]})
				});
			}
			else {
				cordova.plugins.diagnostic.isGpsLocationAvailable(function(available) {
					if (available)
						getCurrentPosition();
					else
						checkAuthorization();
				}, function(error) {
					errorCallback({code : errorCode["isGpsLocationAvailable"], message : errorMsg["isGpsLocationAvailable"]})
				});
			}
		};
		
		var checkAuthorization = function() {
			cordova.plugins.diagnostic.isLocationAuthorized(function(authorized) {
				if (authorized) {
					checkDeviceSetting();
				}
				else {
					cordova.plugins.diagnostic.requestLocationAuthorization(function(status) {
						switch(status){
							case cordova.plugins.diagnostic.permissionStatus.GRANTED:
								checkDeviceSetting();
								break;
							case cordova.plugins.diagnostic.permissionStatus.DENIED:
							case cordova.plugins.diagnostic.permissionStatus.DENIED_ALWAYS:
							default :
								// User denied permission
								errorCallback({code : errorCode["deniedPermissionGPS"], message :  errorMsg["deniedPermissionGPS"]});
								//errorCallback({code : 1, message : 'User denied permission'});
								break;
						}
					}, function(error) {
						errorCallback({code : errorCode["requestLocationAuthorization"], message : errorMsg["requestLocationAuthorization"]});
					});
				}
				
			}, function(error) {
				errorCallback({code : errorCode["isLocationAuthorized"], message : errorMsg["isLocationAuthorized"]});
			});
		};
		
		
		var checkDeviceSetting = function() {
			if (iOS) {
				cordova.plugins.diagnostic.isLocationEnabled(function(enabled) {
					if (!enabled) {
						alert("GPS를 활성화 해주세요!");
						cordova.plugins.diagnostic.switchToLocationSettings();
						errorCallback({code : errorCode["gpsLocationDisabled"], message : errorMsg["gpsLocationDisabled"]});
						//errorCallback({code : 2, message : 'isGpsLocationEnabled false'});
					}
				}, function(error) {
					errorCallback({code : errorCode["isGpsLocationEnabled"], message : errorMsg["isGpsLocationEnabled"]});
				});
			}
			else {
				cordova.plugins.diagnostic.isGpsLocationEnabled(function(enabled) {
					if (!enabled) {
						alert("GPS를 활성화 해주세요!");
						cordova.plugins.diagnostic.switchToLocationSettings();
						errorCallback({code : errorCode["gpsLocationDisabled"], message : errorMsg["gpsLocationDisabled"]});
						//errorCallback({code : 2, message : 'isGpsLocationEnabled false'});
					}
				}, function(error) {
					errorCallback({code : errorCode["isGpsLocationEnabled"], message : errorMsg["isGpsLocationEnabled"]});
				});
			}
		};

		
		var getCurrentPosition = function() {
			if (checkOnly) {
				successCallback();
				checkOnly = false;
				return;
			}

			navigator.geolocation.getCurrentPosition(function(position) {
				if (typeof successCallback === 'function')
					successCallback(position);
			}, function(error) {
				if (typeof self.errorCallback === 'function')
					errorCallback(error);
			}, options);
		};
		
		checkAvailability();
	};
	
	var watchId;
	var watchPosition = function(successCallback, errorCallback, options) {
		options = options || {
			maximumAge : 0,				// 갱신주기(1/1000초 단위)
			timeout : 5000,				// 타임아웃(1/1000초 단위)
			enableHighAccuracy : true	// 높은 정확도 사용
		};
		options = options || {};
		Hybrid.clearWatch();
		watchId = navigator.geolocation.watchPosition(function(position) {
			if (typeof successCallback === 'function')
				successCallback(position);
		}, function(error) {
			if (typeof self.errorCallback === 'function')
				errorCallback(error);
		}, options);
	};
	
	var clearWatch = function() {
		if (watchId != null) {
			navigator.geolocation.clearWatch(watchId);
		}
	}

	
	// for beacon
	var notificationID = 0;
	var startScanBeacon = function(regions, successCallback, errorCallback) {
		
	
		var checkAvailability = function() {
			cordova.plugins.diagnostic.isBluetoothAvailable(function(available) {
				if (available)
					scanBeacon();
				else
					checkDeviceSetting();
			}, function(error) {
				errorCallback({code : errorCode["isBluetoothAvailable"], message : errorMsg["isBluetoothAvailable"]})
			});
		};
		
		
		var checkDeviceSetting = function() {
			if (iOS) {
				cordova.plugins.diagnostic.getBluetoothState(function(state) {
					if(state == cordova.plugins.diagnostic.bluetoothState.POWERED_OFF || state == cordova.plugins.diagnostic.bluetoothState.POWERING_OFF) {
						alert("Bluetooth를 활성화 해주세요!");
						errorCallback({code : errorCode["bluetoothDisabled"], message : errorMsg["bluetoothDisabled"]});
					}
					else {
						scanBeacon();
					}
				}, function(error) {
					errorCallback({code : errorCode["isBluetoothEnabled"], message : errorMsg["isBluetoothEnabled"]});
				});
			}
			else {
				cordova.plugins.diagnostic.isBluetoothEnabled(function(enabled) {
					if (!enabled) {
						if (!confirmBuletooth) {
							confirmBuletooth = true;
							setTimeout(function() {confirmBuletooth = false;}, 15*60*1000);
							if (confirm("Bluetooth가 꺼져있습니다.\nBuletooth를 활성화 하시겠습니까?"))
								cordova.plugins.diagnostic.switchToBluetoothSettings();
						}
						//alert("Bluetooth를 활성화 해주세요!");
						errorCallback({code : errorCode["bluetoothDisabled"], message : errorMsg["bluetoothDisabled"]});
						//errorCallback({code : 2, message : 'isBluetoothEnabled false'});
					}
				}, function(error) {
					errorCallback({code : errorCode["isBluetoothEnabled"], message : errorMsg["isBluetoothEnabled"]});
				});
			}
		};
		
		if(!iOS){
			var checkLocationPermission = function() {
			  var permissions = cordova.plugins.permissions;
			  permissions.hasPermission(permissions.ACCESS_FINE_LOCATION, function(status) {
				var version = device.version;
				if(version>=12){
					if(status.hasPermission) {
				      checkBluetoothPermission();
				    }
				    else {
				      requestLocationPermission();
				    }
				}else{
					if(status.hasPermission) {
				      scanBeacon();
				    }
				    else {
				      requestLocationPermission();
				    }
				}
			  });
			};
			
			var requestLocationPermission = function() {
			  var permissions = cordova.plugins.permissions;
			
			  permissions.requestPermission(permissions.ACCESS_FINE_LOCATION, function(status) {
			    if(status.hasPermission) {
					var version = device.version;
					if(version>=12) {
				     	checkBluetoothPermission();
					}else{
						scanBeacon();
					}
			    }
			    else {
			      errorCallback({code : errorCode["locationPermissionDenied"], message : errorMsg["locationPermissionDenied"]});
			    }
			  }, function() {
			    errorCallback({code : errorCode["locationPermissionDenied"], message : errorMsg["locationPermissionDenied"]});
			  });
			};
			
			var checkBluetoothPermission = function() {
			  var permissions = cordova.plugins.permissions;
			
			  permissions.hasPermission(permissions.BLUETOOTH_SCAN, function(status) {
			    if(status.hasPermission) {
					scanBeacon();
			    }else{
					requestBluetoothPermission();
				}
			  });
			};
			
			var requestBluetoothPermission = function() {
			  var permissions = cordova.plugins.permissions;
			  permissions.requestPermission(permissions.BLUETOOTH_SCAN, function(status) {
				if(status.hasPermission) {
			    	scanBeacon();
				}else {
			      errorCallback({code : errorCode["bluetoothPermissionDenied"], message : errorMsg["bluetoothPermissionDenied"]});
			    }
			  }, function() {
			    errorCallback({code : errorCode["bluetoothPermissionDenied"], message : errorMsg["bluetoothPermissionDenied"]});
			  });
			};
		}
		
		var scanBeacon = function() {
			window.locationManager = cordova.plugins.locationManager;
			var delegate = new locationManager.Delegate();
			
			// Called continuously when ranging beacons.
			delegate.didRangeBeaconsInRegion = function(pluginResult) {
				//console.log('didRangeBeaconsInRegion: ' + JSON.stringify(pluginResult))
				if (typeof successCallback === 'function' && pluginResult.beacons)
					successCallback(pluginResult.beacons);
			};


			// Called when starting to monitor a region.
			// (Not used in this example, included as a reference.)
			delegate.didStartMonitoringForRegion = function(pluginResult) {
				//console.log('didStartMonitoringForRegion:' + JSON.stringify(pluginResult))
			};

			
			// Called when monitoring and the state of a region changes.
			// If we are in the background, a notification is shown.
			delegate.didDetermineStateForRegion = function(pluginResult) {
/*
				if (isBackground) {
					// Show notification if a beacon is inside the region.
					if (pluginResult.region.typeName == 'BeaconRegion' && pluginResult.state == 'CLRegionStateInside') {
						cordova.plugins.notification.local.schedule({
							id: ++notificationID,
							title: 'Beacon in range',
							text: 'iBeacon Scan detected a beacon, tap here to open app.'
						});
					}
				}
*/
			};


			// Set the delegate object to use.
			locationManager.setDelegate(delegate);


			// Request permission from user to access location info.
			// This is needed on iOS 8.
			locationManager.requestAlwaysAuthorization();

			
			// Start monitoring and ranging beacons.
			for (var i in regions) {
				var beaconRegion = new locationManager.BeaconRegion(i + 1, regions[i].uuid);

				// Start ranging.
				locationManager.startRangingBeaconsInRegion(beaconRegion).fail(console.error).done();

				// Start monitoring.
				// (Not used in this example, included as a reference.)
				locationManager.startMonitoringForRegion(beaconRegion).fail(console.error).done();
			}
		};

		
		checkAvailability();
	};
	
	
	var stopScanBeacon = function(regions) {
		if (!regions || regions.length == 0)
			return;

		for (var i = 0; i < regions.length ; i++) {
			try {
				var beaconRegion = new locationManager.BeaconRegion((i + 1) + "", regions[i].uuid);
				// stop ranging.
				locationManager.stopRangingBeaconsInRegion(beaconRegion).fail(console.error).done();
			} catch (e) {alert(e.toString());}
		}
	}
	
	
	var getSsid = function(callback) {
		if (typeof callback !== 'function')
			return;

		var networkState = navigator.connection.type;
		if (networkState === Connection.WIFI) {
			WifiWizard.getCurrentSSID(function(ssid) {
				if (ssid != null && ssid.length > 3 && ssid[0] === '"' && ssid[ssid.length-1] === '"')
					ssid = ssid.substring(1, ssid.length-1);
				callback(ssid);
			}, function(fail) {
				callback(null);
			});
		}
		else {
			callback(null);
		}
	};

	
	var openUrl = function(url) { 
		cordova.InAppBrowser.open(url, "_system"); 
	}; 

	
	var appVersion = function(callback) {
		
		cordova.getAppVersion.getVersionNumber(function (version) {
			
			callback({
				result : true,
				data : version
			});
		}, function(error) {
			
			callback({
				result : false,
				code : errorCode["isAppVersionCheck"], 
				message : errorMsg["isAppVersionCheck"]
			});
		});
	};
	

	var addEventListener = function(name, cb) {
		eventListener[name] = cb;
		document.addEventListener(name, cb, false);
	};


	/**
	 * option
	 * 	quality : default 25
	 * 	destinationType : 0 (Return image as base64-encoded string), 1 (Return image file URI)
	 * 	sourceType : 0(PHOTOLIBRARY), 1(CAMERA), 2(SAVEDPHOTOALBUM)
	 */
	var getPicture = function(successCallback, errorCallback, option) {
		option.quality = option.quality || 25;
		option.encodingType = Camera.EncodingType.JPEG;
		option.saveToPhotoAlbum = true;
		option.correctOrientation = true;
		navigator.camera.getPicture(successCallback, errorCallback, option);
	};

	
	return {
		init : init,
		isHybrid : isHybrid,
		getDeviceInfo : getDeviceInfo,
		getToken : getToken,
		onNotification : onNotification,
		isEnableGps : isEnableGps,
		goGpsSetting : goGpsSetting,
		checkGeoLocation : checkGeoLocation,
		getGeoLocation : getGeoLocation,
		watchPosition : watchPosition,
		clearWatch : clearWatch,
		startScanBeacon : startScanBeacon,
		stopScanBeacon : stopScanBeacon,
		getSsid : getSsid,
		openUrl : openUrl,
		appVersion : appVersion,
		getPicture : getPicture,
		addEventListener : addEventListener
	}
	
})();
