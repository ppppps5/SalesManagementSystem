// 전역변수 선언
var gvContextPath = "${pageContext.request.contextPath}";
var gvOperatingSystem = "";
var gvMobileYn = "";
var gvBrowserName = "";
var gvMessage = "";
var gvToken = "";
var gvTopFlag = true;
var gvTopHeight = 0;

// 초기화
$(document).ready(function () {
	
	// 전역변수 불러오기
	gvContextPath = $("#gvContextPath").val();
	gvOperatingSystem = $("#gvOperatingSystem").val();
	gvMobileYn = $("#gvMobileYn").val();
	gvBrowserName = $("#gvBrowserName").val();
	gvMessage = $("#gvMessage").val();
	
	// 경고 메세지
	if (gvMessage != null && gvMessage != "" && gvMessage != "undefined") {
		
		setTimeout(function() {
			fn_alert(gvMessage);
		},0);
	}
	
	// 헤더 스크롤
	$(document).scroll(function () {
		
		if (gvTopFlag == true) {
			
			if ($(this).scrollTop() > gvTopHeight) {
				
				$(".zemos_header1").hide();
				$(".zemos_header").css("position", "fixed");
			} else {
				
				$(".zemos_header1").show();
				$(".zemos_header").css("position", "absolute");
			}
		}
	});
	
	// 헤더2 첨부 적용
	if ($("#zemos_header2").length) {
		
		var vHtml = $("#zemos_header2").get(0).outerHTML;
		$("#zemos_header2").attr("id","zemos_header2_back");
		$("#zemos_header").append(vHtml);
		
		//var vHeight = $("#zemos_header2_back").height();
		//$("#zemos_header2_back").removeClass();
		//$("#zemos_header2_back").removeAttr("style");
		
		$("#zemos_header2_back").html("&nbsp;");
		$("#zemos_header2_back").css("background-color","#FFFFFF");
		
		//$("#zemos_header2_back").height(vHeight);
	}
	
	// 푸쉬 관련 토큰정보
	token_save_call();
	
	// 팝업 세팅
	$(".zemos_modal").click(function() {
		$(this).hide();
	});
	
	$(".zemos_modal").hide();
	
	$(".zemos_modal_content").click(function() {
		
		event.stopPropagation();
	    event.preventDefault();
	});
	
	$(".zemos_modal_content").css("max-height", fn_get_window_height()-100);
	
	// 팝업 세팅2
	$(".zemos_modal2").click(function() {
		$(this).hide();
	});
	
	$(".zemos_modal2").hide();
	
	$(".zemos_modal_content2").click(function() {
		
		event.stopPropagation();
	    event.preventDefault();
	});
	
	$(".zemos_modal_content2").css("max-height", fn_get_window_height()-100);
	
	// 로딩바 초기화
	try {
		fn_loading_hide();
	} catch(e) { }
	
	// 아이폰 확대 방지
	if (fn_get_mobile_yn() == "Y" && fn_get_mobile_os() == "iOS") {
		
		/*
		$('meta[name=viewport]').remove();
        $('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">');
        
        $('input').mousedown(function(){
			$('meta[name=viewport]').remove();
			$('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">');
        });

        $('input').focusout(function(){
        	$('meta[name=viewport]').remove();
        	$('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, user-scalable=yes">');
        });
        
        $('textarea').mousedown(function(){
			$('meta[name=viewport]').remove();
			$('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">');
        });

        $('textarea').focusout(function(){
        	$('meta[name=viewport]').remove();
        	$('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, user-scalable=yes">');
        });
        
        $('select').mousedown(function(){
			$('meta[name=viewport]').remove();
			$('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">');
        });

        $('select').focusout(function(){
        	$('meta[name=viewport]').remove();
        	$('head').append('<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=3.0, minimum-scale=1.0, user-scalable=yes">');
        });
        */
	}
	
});

// ContextPath 조회
function fn_get_context_path() {
	return gvContextPath;
}

// 모바일여부 조회
function fn_get_mobile_yn() {
	return gvMobileYn;
}

// 모바일OS 조회
function fn_get_mobile_os() {
	return gvOperatingSystem;
}

// 브라우저 조회
function fn_get_browser_name() {
	return gvBrowserName;
}

// 알림
function fn_alert(pMsg, pTitle) {
	alert(pMsg);
}

// 확인 메세지
function fn_confirm(pMsg, pTitle, pCallback) {
	return confirm(pMsg);
}

// 윈도우 세로 너비 구하기
function fn_get_window_height() {
	
	var winHeight = Number($(window).height());
	try {
		winHeight = Number($.mobile.getScreenHeight());
	} catch(e) { 
		
		try {
			winHeight = Number(document.documentElement.clientHeight);
		} catch(e) { 
			
			try {
				winHeight = Number(window.innerHeight);
			} catch(e) { 
				winHeight = Number($(window).height());
			}
		}
	}
	
	return winHeight;
}

// 로딩바 표시
function fn_loading_show(pMsg) {
	
	if (pMsg != null && pMsg != "undefined") {
		
		$("#zemos_loading_text").html(pMsg);
		$("#zemos_loading").show();
		//$("#zemos_loading_text").show();
	} else {
		
		$("#zemos_loading_text").html("　");
		$("#zemos_loading").show();
		//$("#zemos_loading_text").show();
	}
}

// 로딩바 숨기기
function fn_loading_hide() {
	$("#zemos_loading").hide();
}

// 페이지 이동
function fn_location_href(pUrl) {
	
	try {
		
		// 로딩바
		// setTimeout 안쓰면 IE에서 로딩바 안나옴 ㅡ.ㅡ
		// 모바일 아이폰 제외(캐싱 때문에 뒤로 하면 로딩바가 살아있음)
		if (!(fn_get_mobile_yn() == "Y" && fn_get_mobile_os() == "iOS") && !(fn_get_mobile_yn() == "N" && fn_get_browser_name().indexOf('Internet Explorer') >= 0)) {
			
			setTimeout(function() {
				fn_loading_show();
			},0);
		}
		
		// 리프레시
		if (pUrl == null || pUrl == "" || pUrl == "undefined") {
			
			// setTimeout 안쓰면 IE에서 로딩바 안나옴 ㅡ.ㅡ
			setTimeout(function() {
				location.reload();
			},100);
		} else if(pUrl == "#") {
			
			setTimeout(function() {
				fn_loading_hide();
			},100);
		}
		// 페이지 이동
		else {
			location.href = pUrl;
		}
	} catch(e) {
		
		fn_loading_hide();
		
		setTimeout(function() {
			fn_loading_hide();
		},100);
	}
}

// 뒤로가기 버튼
function fn_back(pGubun) {
	
	// 로딩바
	// setTimeout 안쓰면 IE에서 로딩바 안나옴 ㅡ.ㅡ
	// 모바일 아이폰 제외(캐싱 때문에 뒤로 하면 로딩바가 살아있음)
	if(!(fn_get_mobile_yn() == "Y" && fn_get_mobile_os() == "iOS") && !(fn_get_mobile_yn() == "N" && fn_get_browser_name().indexOf('Internet Explorer') >= 0)) {
		
		setTimeout(function() {
			fn_loading_show();
		},0);
	}
	
	if (pGubun != null && pGubun != "undefined") {
		
		try {
			history.go(pGubun);
		} catch(e) {
			history.back();
		}
	} else {
		history.back();
	}
}

// 모바일 팝업
function fn_mobile_pop(pUrl) {
	
	if (fn_get_mobile_os() == "Android") {
		
		try {
			var target = '_system';
			var options = 'location=yes,toolbar=no';
		    var iabRef2 = cordova.InAppBrowser.open(pUrl, target, options);
			//window.fzmosWC1.AndroidWindowOpen(pUrl);
		} catch(e) {
			window.open(pUrl);
		}
	} else if (fn_get_mobile_os() == "iOS") {
		
		try {
			//webkit.messageHandlers.callbackHandler.postMessage(pUrl);
			webkit.messageHandlers.windowopen.postMessage(pUrl);
		} catch(e) {
			window.open(pUrl);
		}
	} else {
		window.open(pUrl);
	}
}

// 모바일 다운로드
function fn_mobile_download(pUrl) {
	if (fn_get_mobile_os() == "Android") {
		
		try {
			var target = '_system';
			var options = 'location=yes,toolbar=no';
		    var iabRef2 = cordova.InAppBrowser.open(pUrl, target, options);
		} catch(e) {
			fn_pc_download(pUrl);
		}
	} else if (fn_get_mobile_os() == "iOS") {
		
		try {
			//webkit.messageHandlers.callbackHandler.postMessage(pUrl);
			webkit.messageHandlers.windowopen.postMessage(pUrl);
		} catch(e) {
			fn_pc_download(pUrl);
		}
	} else {
		fn_pc_download(pUrl);
	}
}

// PC 다운로드
function fn_pc_download(pUrl) {
	
	location.href = pUrl;
	
    /*var hiddenIFrameID = 'hiddenDownloader',
        iframe = document.getElementById(hiddenIFrameID);
    if (iframe === null) {
        iframe = document.createElement('iframe');
        iframe.id = hiddenIFrameID;
        iframe.style.display = 'none';
        document.body.appendChild(iframe);
    }
    iframe.src = pUrl;*/
	
}

// 모바일 GPS
function fn_mobile_gps(id, gubun) {
	
	if (fn_get_mobile_os() == "Android") {
		window.WishroomAndroidApp1.callgps(id, gubun);
	} else if (fn_get_mobile_os() == "iOS") {
		webkit.messageHandlers.gpssend.postMessage({id:id,gubun:gubun});
	}
}

// 모바일 GPS CALLBACK(공통말고 개별로사용)
/*
function getgpsinfo(str1,str2, pId, pGubun) {

	if (pGubun == "dclz") {
	
		var gubun = $("#"+pId+" input[name='selectGps']").val();
		
		fn_loading_hide();
		
		try {
		
			if (str1.substr(0,1) == "0" || str2.substr(0,1) == "0") {
				//fn_alert('GPS 정보 수신 실패');
				return;
			} 
		}
		catch(e) {
			//fn_alert('GPS 정보 수신 실패');
			return;
		}
		
		$("#"+pId+"GpsX").val(str2);
		$("#"+pId+"GpsY").val(str1);
		
		var vWrkplcGpsX = $("#"+pId+"WrkplcGpsX").val();
		var vWrkplcGpsY = $("#"+pId+"WrkplcGpsY").val();
		
		//if(vWrkplcGpsX == "") vWrkplcGpsX = "127.010342";
		//if (vWrkplcGpsY == "") vWrkplcGpsY = "37.492554";
		
		var dstnc = gvDclzMap.getProjection().getDistance(new naver.maps.LatLng(vWrkplcGpsY, vWrkplcGpsX),new naver.maps.Point(str2, str1));
		var point = new naver.maps.Point(str2, str1);
		
		gvDclzMap.setCenter(point);
		
		$("#"+pId+"Dstnc").val(dstnc);
		
		if (vWrkplcGpsX == "" || vWrkplcGpsX == "0") {
			$("#"+pId+"MyLc").html("내 위치 (GPS 등록 필요)");
		}
		else {
			$("#"+pId+"MyLc").html("내 위치 ("+Math.round(Number(dstnc))+"미터)");
		}
		
		var markerOptions = {
		
		    position: point,
		    map: gvDclzMap,
		    title: "내 위치",
		    zIndex: 100
		};
		
		if (gvDclzMarker != null) gvDclzMarker.setMap(null);
		
		gvDclzMarker = new naver.maps.Marker(markerOptions);
		
		if (gubun != "1") {
			$("#"+pId+" input[name='selectSave']").click();
		}
	} else if(pGubun == "wrkplc") {
	
		fn_loading_hide();
		
		try {
		
			if (str1.substr(0,1) == "0" || str2.substr(0,1) == "0") {
				//fn_alert('GPS 정보 수신 실패');
				return;
			} 
		}
		catch(e) {
			//fn_alert('GPS 정보 수신 실패');
			return;
		}
		
		$("#"+pId+"WrkplcGpsX").val(str2);
		$("#"+pId+"WrkplcGpsY").val(str1);
		
		var point = new naver.maps.Point(str2, str1);
		gvWrkplcMap.setCenter(point);
		
		var markerOptions = {
		
		    position: point,
		    map: gvWrkplcMap,
		    title: "내 위치",
		    zIndex: 100
		};
		
		if(gvWrkplcMarker != null) gvWrkplcMarker.setMap(null);
		
		gvWrkplcMarker = new naver.maps.Marker(markerOptions);
		
		var tm128 = naver.maps.TransCoord.fromLatLngToTM128(point);
		
	    naver.maps.Service.reverseGeocode({
	    
	        location: tm128,
	        coordType: naver.maps.Service.CoordType.TM128
	    }, function(status, response) {
	    
	        var items = response.result.items;
	        for (var i=0, ii=items.length, item; i<ii; i++) {
	        
	            item = items[i];
	            if(item.isAdmAddress) { // 지번주소만
	            	$("#"+pId+"WrkplcAdres").val(item.address);
	            }
	        }
	    });
	}
}
*/

// 모바일 비콘
function fn_mobile_beacon(id, gubun) {
	
	if(fn_get_mobile_os() == "Android") {
		window.fzmosBicon.AndroidBicon(id, gubun);
	} else if (fn_get_mobile_os() == "iOS") {
		webkit.messageHandlers.biconstr.postMessage({id:id,gubun:gubun});
	}
}

// 모바일 비콘 CALLBACK(공통말고 개별로사용)
/*
function fn_mobile_beacon_callback(pId, pGubun, pUuid, pMajor, pMinor) {

	if (pGubun == "dclz") {
	
		fn_loading_hide();
		
		$("#"+pId+"BeaconUuid").val(pUuid);
		$("#"+pId+"BeaconMajor").val(pMajor);
		$("#"+pId+"BeaconMinor").val(pMinor);
		
		var vGubun = $("#"+pId+" input[name='selectGps']").val();
		if (vGubun != "1") {
			$("#"+pId+" input[name='selectSave']").click();
		}
	} else if(pGubun == "select") {
	
		fn_loading_hide();
		
		$("#"+pId+"BeaconUuid").val(pUuid);
		$("#"+pId+"BeaconMajor").val(pMajor);
		$("#"+pId+"BeaconMinor").val(pMinor);
	}
}
*/

//모바일 전화걸기
function fn_mobile_phonecall(pStr) {
	
	if (fn_get_mobile_os() == "Android") {
		
		try {
			window.fzmosCall.AndroidCall(pStr);
		} catch(e) {
			
			try {
				location.href='tel:'+pStr;
			} catch(e) { }
		}
	} else if (fn_get_mobile_os() == "iOS") {
		
		try {
			webkit.messageHandlers.telcall.postMessage(pStr);
		} catch(e) {
			
			try {
				location.href='tel:'+pStr;
			} catch(e) { }
		}
	} else {
		
		/*
		try {
			location.href='tel:'+pStr;
		} catch(e) { }
		*/
	}
}

// 모바일 카메라 업로드 콜 (성공 true, 실패 false)
function fn_image_upload_call_camera(url, id, gubun, userIdx, fileOwner, fileSe, fileGbn) {
	
	if (fn_get_mobile_os() == "Android") {

		try {
			//기존
			//window.fzmosCamara.AndroidCamara(url, id, gubun, userIdx, fileOwner, fileSe);
			if ( fileGbn == "editorFile" ) {
				navigator.camera.getPicture(onEditorPhotoDataSuccess, onFail, {
					quality : 50,
					destinationType : destinationType.DATA_URL,
					saveToPhotoAlbum: false,
					//destinationType : destinationType.FILE_URI,
					encodingType : Camera.EncodingType.JPEG,
					sourceType : 1,
					correctOrientation : true 
				});
			} else {
				navigator.camera.getPicture(onPhotoDataSuccess, onFail, {
					quality : 50,
					destinationType : destinationType.DATA_URL,
					saveToPhotoAlbum: false,
					//destinationType : destinationType.FILE_URI,
					encodingType : Camera.EncodingType.JPEG,
					sourceType : 1,
					correctOrientation : true 
				});
			}
			
			return true;
		} catch(e) {
			return false;
		}
	} else if (fn_get_mobile_os() == "iOS") {
		
		try {
			webkit.messageHandlers.camaracall.postMessage({url:url,id:id,gubun:gubun,userIdx:userIdx,fileOwner:fileOwner,fileSe:fileSe});
			return true;
		} catch(e) { 
			return false;
		}
	}
	
	return false;
}

// 모바일 이미지 업로드 콜 (성공 true, 실패 false)
function fn_image_upload_call_image(url, id, gubun, userIdx, fileOwner, fileSe) {
	
	if (fn_get_mobile_os() == "Android") {
		
		try {
			window.fzmosGallery.AndroidGallery(url, id, gubun, userIdx, fileOwner, fileSe);
			return true;
		} catch(e) {
			return false;
		}
	} else if (fn_get_mobile_os() == "iOS") {
		
		try {
			webkit.messageHandlers.gallerycall.postMessage({url:url,id:id,gubun:gubun,userIdx:userIdx,fileOwner:fileOwner,fileSe:fileSe});
			return true;
		} catch(e) { 
			return false;
		}
	}
	
	return false;
}

// 모바일 이미지 업로드 CALLBACK (에디터)
function fn_image_upload(pId, pGubun, pData) {
	
	try {
		
		if (pGubun == "ckEditor") {
			
			var editor = CKEDITOR.instances[pId];
			var vHtml = "<img style=\"max-width: 100%;\" src=\""+fn_get_context_path()+"/images/egovframework/com/noImage.png\">";
			
			try {
				
				var list = pData.resultList;
				if (list != null && list.length > 0) {
					
					for (var i = 0 ; i < list.length; i++) {
						vHtml = "<img style=\"max-width: 100%;\" src=\""+fn_get_context_path()+"/com/file/downloadImgCk.do?idxVal="+list[i].idxVal+"\">";
					}
				}
			} catch(e) { }
			
			editor.insertHtml(vHtml);
			
			editor.execCommand( 'enter' );
			
		}
		/* 
		else if (pGubun == "zemosIcon") {
		
			try {
			
				var list = pData.resultList;
				if (list != null && list.length > 0) {
				
					for (var i = 0 ; i < list.length; i++) {
					
						$("#"+pId+"Yn").val("Y");
						$("#"+pId+"Idx").val(list[i].idx);
						$("#"+pId+"Image").css("background-image","url('"+fn_get_context_path()+"/com/file/download.do?idxVal="+list[i].idxVal+"')");
					}
				}
			} catch(e) { }
		} else if (pGubun == "zemosLogo") {
		
			try {
			
				var list = pData.resultList;
				if (list != null && list.length > 0) {
				
					for (var i = 0 ; i < list.length; i++) {
					
						var params = {};
						
						params.zemosIdx = $("#"+pId+"ZemosIdx").val();
						params.idxVal = list[i].idxVal;
						
						var vIdxVal = list[i].idxVal;
						
						// ajax 시작
						$.ajax({
						
						    url: fn_get_context_path()+"/zemos/zemossetup/zemosSetupLogoUploadAfter.do",
						    type: 'post',
						    dataType : 'json',
						    data: params
						}).done(function (data) { // 완료
						
							var result = Number(data.result);
							var resultMsg = data.resultMsg;
							if (result > 0) {
								
								var selectList = $("#"+pId+" ul[name='selectList']");
								var vStart = (Number(selectList.data("start"))+1);
								
								selectList.data("start",vStart);
								
								var vHtml = "";
								vHtml += "<li name=\"line_"+vStart+"\"data-icon=\"false\"><a class=\"ui-li-theme\" href=\"#\" name=\"select\" useYn=\"Y\" idx=\""+result+"\">";
								vHtml += "<p>";
								vHtml += "<img style=\"width:auto; height:auto; max-height: 30px;\" src=\""+fn_get_context_path()+"/com/file/download.do?idxVal="+vIdxVal+"\">";
								vHtml += "</p>";
								vHtml += "</a></li>";
								
								selectList.append(vHtml);
								selectList.listview('refresh');
								
								var selectLi = selectList.children('li:last-child');
								selectLi.find("a").attr("lineName","line_"+vStart);
								selectLi.find("a").attr("logoYn","Y");
								selectLi.find("a").attr("logoIdx",result);
								
								selectLi.find("a").click(function() {
								
									var lineName = $(this).attr("lineName");
									var logoYn = $(this).attr("logoYn");
									var logoIdx = $(this).attr("logoIdx");
									$("#"+pId+"LineName").val(lineName);
									$("#"+pId+"LogoYn").val(logoYn);
									$("#"+pId+"LogoIdx").val(logoIdx);
									
									var vOption = {};
									vOption.transition = "pop";
									//vOption.reverse = true;
									//vOption.positionTo = $(this).find("div[name='popup']");
									//vOption.positionTo = $(this).find("a");
									$("#"+pId+"Popup").popup("open", vOption);
								});
							} else {
								// 메세지
								fn_alert(resultMsg);
							}
						}).fail(function (data) { // 실패
							fn_alert("작업 중 오류가 발생하였습니다. 관리자에게 문의하여 주십시오.");
							// 화면리셋
							// window.location.href = fn_get_context_path()+"/";
						}).always(function(data) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
							// 후처리(안함)
							fn_loading_hide();
							$("#"+pId+" input[name='selectFlag']").val("stop");
						});
						// ajax 끝
					}
				}
			} catch(e) { }
		}
		*/
	} catch(e) { }
}


// 푸쉬 토큰 입력받기 호출
function token_save_call() {
	
	if (fn_get_mobile_os() == "Android") {
		
		try {
			window.fzmosGetToken.AndroidGetToken("empty");
		} catch(e) { }
	} else if (fn_get_mobile_os() == "iOS") {
		
		try {
			//webkit.messageHandlers.callbackHandler2.postMessage('empty');
			webkit.messageHandlers.tokensend.postMessage('empty');
		} catch(e) { }
	}
}

// 푸쉬 토큰 입력받기 (모바일 앱에서 자바스크립트 함수를 호출)
function token_save_return(pStr) {
	fn_set_token(pStr);
}

// 푸쉬 토큰 조회
function fn_get_token() {
	return gvToken;
}

// 푸쉬 토큰 세팅
function fn_set_token(pStr) {
	
	try {
		
		gvToken = pStr;
		
		// 토큰 저장
		var vParams = {};
		var vMode = "0";
		
		if(fn_get_mobile_os() == "Android") {
			vMode = "1";
		} else if (fn_get_mobile_os() == "iOS") {
			vMode = "2";
		}
		
		vParams.mobileTy = vMode;
		vParams.mobileToken = pStr;
		
		$.ajax({
			
			type : "post",
			url : fn_get_context_path()+"/com/push/saveToken.do",
			data : vParams
		});
		
	} catch(e) { }
}

// 날짜 요일 구하기('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일')
function fn_get_day_of_week(pStr) {
	
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
	var today = new Date(pStr).getDay();
	var todayLabel = week[today];
	
	return todayLabel;
}

// 날짜 내일 날짜(YYYY-MM-DD)
function fn_get_tommorrow(pStr) {
	
	var today = new Date(pStr);
	var tommorrow = new Date(today.valueOf() + (24*60*60*1000));
	
	return tommorrow.getFullYear()+"-"+("0"+(tommorrow.getMonth()+1)).slice(-2)+"-"+("0"+tommorrow.getDate()).slice(-2);
}

// 날짜 일 차이 구하기(YYYY-MM-DD)
function fn_get_date_diff_days(pStr1, pStr2) {
	
	try {
		
		// Set the unit values in milliseconds.
		var msecPerMinute = 1000 * 60;
		var msecPerHour = msecPerMinute * 60;
		var msecPerDay = msecPerHour * 24;
	
		// Set a date and get the milliseconds
		var date1 = new Date(pStr1);
		var date2 = new Date(pStr2);
		
		var dateMsec1 = date1.getTime();
		var dateMsec2 = date2.getTime();
	
		// Get the difference in milliseconds.
		var interval = dateMsec1 - dateMsec2;
	
		// Calculate how many days the interval contains. Subtract that
		// many days from the interval to determine the remainder.
		var days = Math.floor(interval / msecPerDay );
		interval = interval - (days * msecPerDay );
		
		return Math.abs(days)+1;
	} catch(e) {
		return 1;
	}
}

// 일단.. yyyyMMdd 만
function fn_MakeDateFormat( src ) {
	
	if( src.length == 8 ) {
		return src.substring( 0, 4 ) + "." + src.substring( 4, 6 ) + "." + src.substring( 6, 8 );
	} else {
		return src;
	}
}

// escapeXml 메소드 추가
String.prototype.escapeXml = function() {
	
	try {
		return $('<div/>').text(this.toString()).html();
	} catch(e) {
		return this;
	}
};

// contains 메소드 추가
Array.prototype.contains = function(element) {
	
	for (var i = 0; i < this.length; i++) {
		
		if (this[i] == element) {
			return true;
		}
	}
	
	return false;
};

// null check
function fn_check_null(pStr) {
	
	if (pStr == null || pStr == "" || pStr == "undefined") {
		return true;
	}
	
	return false;
}