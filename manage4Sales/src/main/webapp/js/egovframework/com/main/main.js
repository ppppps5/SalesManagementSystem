var gvContextPath = "";
var gvMActive = 0;
var gvPopPageChk = false;
var gvActivPage = "mainPage";
var gvOperatingSystem = "";
var gvMobileYn = "";
var gvToken = "";
var gvTheme = "";
var gvGpsAgreYn = "";
var gvPageHistory1 = {};
var gvPageHistory2 = {};

// 지도(근태등록)
var gvDclzMap = null;
var gvDclzMapOptions = null;
var gvDclzMarker = null;
var gvDclzInfoWindow = null;

// 지도(제모스 현장/지점)
var gvWrkplcMap = null;
var gvWrkplcMapOptions = null;
var gvWrkplcMarker = null;

// 초기화
$(document).ready(function () {
	
	// 전역변수
	gvContextPath = $("input[name='contextPath']").val();
	gvOperatingSystem = $("input[name='operatingSystem']").val();
	gvMobileYn = $("input[name='mobileYn']").val();
	gvTheme = $("input[name='theme']").val();
	gvGpsAgreYn = $("input[name='gpsAgreYn']").val();
	
	// 스크롤 통제
//	$(document).scroll(function () {
//		fn_scroll($(this).scrollTop());
//	});
	
	// 스크롤 통제 (조금 덜 빈번함)
	$(document).on("scrollstop",function () {
		// 공통 스크롤 이벤트
		if($(document).height() > $(window).height()) {
			// 활성화 된 경우만
			if($("#mainPage").hasClass("ui-page-active")) {
				// 맨밑
		        if($(this).scrollTop() == $(document).height() - $(window).height()) {
		        	if (fn_get_main_active() == 5) {
		        		//getNoticeList();
		        	} else if (fn_get_main_active() == 2) {
		        		var scrollEventYn = 'Y';
		        		getCommunityList(scrollEventYn);
		        	} else if (fn_get_main_active() == 3) {
		        		getNtcnList();
		        	}
		        }
			} else if($("#"+fn_get_active_page()).hasClass("ui-page-active")) {
				// 맨밑
		        if($(this).scrollTop() == $(document).height() - $(window).height()) {
		        	if($("#"+fn_get_active_page()+" input[name='scrollBottom']").length) {
		        		$("#"+fn_get_active_page()+" input[name='scrollBottom']").trigger("click");
		        	}
		        }
			}
	    }
	});
	
	// 메뉴 스와이프
	fn_set_main_active(Number($("input[name='mActive']").val()));
	var swiper = new Swiper('.swiper-container-main', {
        pagination: '.swiper-pagination-main',
        paginationClickable: true,
        //loop: true,
        autoHeight: true,
        initialSlide: (fn_get_main_active()-1),
        onInit: function(swiper) {
        	// 최초 처리
    		fn_menu_move_after((Number(swiper.activeIndex)+1));
    		// 읽음 처리
		    $.ajax({
				type : "post",
				url : fn_get_context_path()+"/com/main/menu"+(Number(swiper.activeIndex)+1)+"Read.do"
			});
        },
        onTouchStart: function(swiper, event) {
        	// 이동 전 처리
        	$("input[name='mScroll"+fn_get_main_active()+"']").val($(document).scroll().scrollTop());
        },
        onSlideChangeStart: function(swiper) {
        	if(fn_get_main_active() != (Number(swiper.activeIndex)+1)) {
	        	// 이동 전 처리
	    	    //fn_menu_move_before((Number(swiper.activeIndex)+1));
        	}
        },
        onSlideChangeEnd: function(swiper) {
    		// 이동 후 처리
    		fn_menu_move_after((Number(swiper.activeIndex)+1));
    		
    		// 이동 후 값 저장
    		fn_set_main_active(Number((Number(swiper.activeIndex)+1)));
        }
    });
	
	// 타이틀 클릭 이벤트
	$("#main_title").click(function() {
		fn_menu_move(Number(fn_get_main_active()));
	});
	
	// 메인메뉴 불러오기
	fn_loading_show();
	fn_menu_call("1");
	fn_menu_call("2");
	fn_menu_call("3");
	fn_menu_call("4");
	//fn_menu_call("5");
	
	// 푸쉬 관련 토큰정보
	fn_get_token();
	
	// 화면 사이즈 재조정
	fn_menu_resize("main");
	
	// 최소사이즈 지정
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
	
	var header = $(".ui-header").hasClass("ui-header-fixed") ? $(".ui-header").outerHeight()  - 1 : $(".ui-header").outerHeight();
	var footer = $(".ui-footer").hasClass("ui-footer-fixed") ? $(".ui-footer").outerHeight() - 1 : $(".ui-footer").outerHeight();
	var contentCurrent = $(".ui-content").outerHeight() - $(".ui-content").height();
	var content = winHeight - header - footer - contentCurrent;
	
	var minHeight = Number(content);
	if(minHeight < 550) minHeight = 550;
	$("#mainPageContent").css("min-height", minHeight+"px");
	$("#menu1").css("min-height", minHeight+"px");
	$("#menu2").css("min-height", minHeight+"px");
	$("#menu3").css("min-height", minHeight+"px");
	$("#menu4").css("min-height", minHeight+"px");
	//$("#menu5").css("min-height", minHeight+"px");
});

// 스크롤 이벤트
function fn_scroll(pScrollTop) {
	try {
		if (pScrollTop > 43) {
			//$(".main_header1").hide(300);
			//$(".main_header1").slideUp(300);
			$(".main_header1").hide();
			//$(".ui-header-fixed").css("position", "fixed");
		} else {
			//$(".main_header1").show(300);
			//$(".main_header1").slideDown(300);
			$(".main_header1").show();
			//$(".ui-header-fixed").css("position", "absolute");
		}
	} catch(e) { }
}

// 메인메뉴 불러오기
function fn_menu_call(pIdx) {
	/*var params = {};
	params.test = "hello";
	$.ajax({
		type : "post",
		url : fn_get_context_path()+"/com/main/menu"+pIdx+".do",
		data : params,
		dataType : "html",
		success : function(data) {
			$("#menu"+pIdx).html(data);
			fn_menu_resize("main");
			fn_set_main_active(Number($("input[name='mActive']").val()));
			if(pIdx+"" == ""+fn_get_main_active()) {
				fn_loading_hide();
			}
		}
	});*/
	$("#menu" + pIdx).load(fn_get_context_path() + "/com/main/menu" + pIdx + ".do", {pageId : "mainPageMenu"+pIdx} , function(response, status, xhr) {
		var vHtml = $(this).html();
		if(vHtml.indexOf("제니엘 모바일 로그인") >= 0) {
			window.location.href = fn_get_context_path()+"/";
		}
		if ( status == "error" ) {
			window.location.href = fn_get_context_path()+"/";
		}
		$(this).trigger('create');
		fn_menu_resize("main");
		$(this).ready(function() {
			fn_menu_resize("main");	
		});
		//fn_set_main_active(Number($("input[name='mActive']").val()));
		if(pIdx+"" == ""+fn_get_main_active()) {
			fn_loading_hide();
		}
	});
}


function fn_get_main_active() {
	return Number(gvMActive);
}

function fn_set_main_active(pIdx) {
	gvMActive = Number(pIdx);
}

function fn_get_active_page() {
	return gvActivPage;
}

function fn_set_active_page(pId) {
	gvActivPage = pId;
}

// 메인화면 좌우 이동
function fn_menu_move(pIdx) {
	// 스크롤 리사이즈
	fn_menu_resize("main");
	
	// 이동
	//var vIdxA = Number($('.swiper-container-main .swiper-wrapper .swiper-slide-active').attr("idx"));
	var vIdxA = Number(fn_get_main_active());
	if(vIdxA == Number(pIdx)) {
		$("input[name='mActive']").val(pIdx);
		fn_loading_show();
		$('html, body').animate({scrollTop : 0}, 100);
		fn_menu_call(""+pIdx);
	}
	else {
		// 이동 전 처리
	    fn_menu_move_before(Number(pIdx));
	    //$("input[name='mScroll"+fn_get_main_active()+"']").val($(document).scroll().scrollTop());
	    //var vScrollT = Number($("input[name='mScroll"+pIdx+"']").val());
	    //$('html, body').animate({scrollTop : vScrollT}, 0);
	    
	    // 이동 후 값 저장
	    fn_set_main_active(Number(pIdx));
		
		// 이동
		var vTimevalue = 200;
		var mySwiper = $('.swiper-container-main')[0].swiper;
		//mySwiper.slideTo(index, speed, runCallbacks);
		mySwiper.slideTo((Number(pIdx)-1), vTimevalue);
		//$('.swiper-pagination-main span.swiper-pagination-bullet')[(pIdx-1)].click();
		
		setTimeout( function() {
			// 이동 후 처리
			fn_menu_move_after(Number(pIdx));
			
			// 이동 후 값 저장
			fn_set_main_active(Number(pIdx));
        },(vTimevalue+100));
	}
}
// 메인화면 좌우 이동 전 처리
function fn_menu_move_before(pIdx) {
	$("input[name='mScroll"+fn_get_main_active()+"']").val($(document).scroll().scrollTop());
	var vScrollT = Number($("input[name='mScroll"+pIdx+"']").val());
	$('html, body').animate({scrollTop : vScrollT}, 0);
}

// 메인화면 좌우 이동 후 처리
function fn_menu_move_after(pIdx) {
    //var vIdxT = Number($('.swiper-container-main .swiper-wrapper .swiper-slide-active').attr("idx"));
    //var vTitleT = $('.swiper-container-main .swiper-wrapper .swiper-slide-active').attr("title");
	var vIdxT = Number(pIdx);
	var vTitleT = $('#menu'+vIdxT).attr("title");
    var vScrollT = Number($("input[name='mScroll"+vIdxT+"']").val());
    $('html, body').animate({scrollTop : vScrollT}, 0);
    $('.main_header2 img.main_header_icon').each(function( key, value ) {
    	  var vSrc = $(this).attr("src");
    	  vSrc = vSrc.replace(/_on/g, "");
    	  vSrc = vSrc.replace("0"+vIdxT, "0"+vIdxT+"_on");
    	  $(this).attr("src", vSrc);
    });
    $("#main_title").html(vTitleT);
    $('#ui-li-count-main'+vIdxT).hide();
    fn_menu_resize("main");
    
    // 읽음 처리
    $.ajax({
		type : "post",
		url : fn_get_context_path()+"/com/main/menu"+pIdx+"Read.do"
	});
    
    if (vIdxT == 2) {
		$('#communityButton').show();
		//$('#notice').hide();
	} else if (vIdxT == 5) {
		//$('#notice').show();
		$('#communityButton').hide();
	} else {
		$('#communityButton').hide();
		//$('#notice').hide();
	}
}

// 메인화면 슬라이드 리사이즈 (안하면 스크롤 안바뀜)
function fn_menu_resize(pName) {
	var mySwiper = $('.swiper-container-'+pName)[0].swiper;
	mySwiper.onResize();
}

// 화면 페이지 이동
function fn_page_move(pUrl) {
	//window.open(pUrl);
	//fn_loading_show();
	window.location.href = pUrl;
}

//ContextPath 조회
function fn_get_context_path() {
	return gvContextPath;
}

//모바일여부 조회
function fn_get_mobile_yn() {
	return gvMobileYn;
}

//모바일OS 조회
function fn_get_mobile_os() {
	return gvOperatingSystem;
}

//GPS 동의 여부 저장
function fn_set_gps_agre_yn(pGpsAgreYn) {
	gvGpsAgreYn = pGpsAgreYn;
	var params = {};
	params.gpsAgreYn = pGpsAgreYn;
    $.ajax({
		type : "post",
		url : fn_get_context_path()+"/com/main/gpsAgreYn.do",
		data : params
	});
}

//GPS 동의 여부 불러오기
function fn_get_gps_agre_yn() {
	return gvGpsAgreYn;
}

// 레이어 팝업 호출전 체크 (중복호출 방지)
function fn_page_pop_chk(pPopPageChk) {
	if(pPopPageChk != null && pPopPageChk != 'undefined' && (pPopPageChk == true || pPopPageChk == false)) gvPopPageChk = pPopPageChk;
	return gvPopPageChk;
}

// 레이어 팝업 호출
function fn_page_pop(pId, pUrl, pTransition, pData) {
	// 일반 팝업
	if(pUrl != null && pUrl != "undefined" && (pUrl.indexOf("http:") > -1 || pUrl.indexOf("https:") > -1)) {
		fn_mobile_pop(pUrl);
		return;
	}
	
	if(fn_page_pop_chk() == true) return;
	fn_page_pop_chk(true);
	fn_loading_show();
	try {
		var vId = fn_page_pop_make(pId, pUrl, pTransition);
		var vIdBefore = fn_get_active_page();
		fn_set_active_page(vId);
		if(pData == null) {
			pData = {};
		}
		pData.pageId = vId;
		if(pData.pageIdBefore == null || pData.pageIdBefore == "") pData.pageIdBefore = vIdBefore;
		
		gvPageHistory2 = gvPageHistory1;
		gvPageHistory1 = {id : pId, url : pUrl, params : pData};
		$("#" + vId).load(pUrl, pData, function(response, status, xhr) {
			var vHtml = $(this).html();
			if(vHtml.indexOf("제니엘 모바일 로그인") >= 0) {
				window.location.href = fn_get_context_path()+"/";
			}
			if ( status == "error" ) {
				window.location.href = fn_get_context_path()+"/";
			}
			$(this).trigger('create');
			var vOption = { };
			vOption.type = "post";
			vOption.transition = "slideup";
			if(pTransition != null) {
				vOption.transition = pTransition;
			}
			$.mobile.changePage('#'+vId, vOption);
			fn_loading_hide();
			fn_page_pop_chk(false);
		});
	} catch(e) {
		fn_loading_hide();
		fn_page_pop_chk(false);
	}
}

function fn_page_refresh(pLoading, pLoading2) {
	if(gvPageHistory1.id == null || gvPageHistory1.id == "") return;
	if(pLoading == null || pLoading == "undefined" || pLoading == true) fn_loading_show();
	$("#" + gvPageHistory1.id).load(gvPageHistory1.url, gvPageHistory1.params, function(response, status, xhr) {
		var vHtml = $(this).html();
		if(vHtml.indexOf("제니엘 모바일 로그인") >= 0) {
			window.location.href = fn_get_context_path()+"/";
		}
		if ( status == "error" ) {
			window.location.href = fn_get_context_path()+"/";
		}
		$(this).trigger('create');
		if(pLoading2 == null || pLoading2 == "undefined" || pLoading2 == true) fn_loading_hide();
	});
}

function fn_page_before_refresh(pLoading, pLoading2) {
	if(gvPageHistory2.id == null || gvPageHistory2.id == "") return;
	if(pLoading == null || pLoading == "undefined" || pLoading == true) fn_loading_show();
	$("#" + gvPageHistory2.id).load(gvPageHistory2.url, gvPageHistory2.params, function(response, status, xhr) {
		var vHtml = $(this).html();
		if(vHtml.indexOf("제니엘 모바일 로그인") >= 0) {
			window.location.href = fn_get_context_path()+"/";
		}
		if ( status == "error" ) {
			window.location.href = fn_get_context_path()+"/";
		}
		$(this).trigger('create');
		if(pLoading2 == null || pLoading2 == "undefined" || pLoading2 == true) fn_loading_hide();
	});
}

function fn_page_before_refresh_back(pLoading, pLoading2) {
	if(gvPageHistory2.id == null || gvPageHistory2.id == "") return;
	if(pLoading == null || pLoading == "undefined" || pLoading == true) fn_loading_show();
	$("#" + gvPageHistory2.id).load(gvPageHistory2.url, gvPageHistory2.params, function(response, status, xhr) {
		var vHtml = $(this).html();
		if(vHtml.indexOf("제니엘 모바일 로그인") >= 0) {
			window.location.href = fn_get_context_path()+"/";
		}
		if ( status == "error" ) {
			window.location.href = fn_get_context_path()+"/";
		}
		$(this).trigger('create');
		if(pLoading2 == null || pLoading2 == "undefined" || pLoading2 == true) fn_loading_hide();
		gvPageHistory1 = gvPageHistory2;
		gvPageHistory2 = {};
		fn_back();
	});
}

// 레이어 팝업 호출 용 껍데기 생성
function fn_page_pop_make(pId, pUrl, pTransition) {
	if(pId != null && pId != "") {
		var vCnt = "";
		var vId = pId;
		if(!$("#"+pId+"Cnt").length) {
			var input = $('<input>');
			input.attr("type", "hidden");
			input.attr("id", pId+"Cnt");
			input.val("1");
			$("#mainPage").after(input);
		}
		
		if ($("#"+vId).length) {
			return vId;
		}
		
		while ($("#"+vId).length) {
			vCnt = ""+(Number($("#"+vId+"Cnt").val()) + 1);
			$("#"+vId+"Cnt").val(vCnt);
			vId = pId;
			vId = vId+vCnt;
		}
		
		var div = $('<div/>');
		div.addClass("popPage");
		div.attr("id", vId);
		div.attr("name", "popPage");
		div.attr("data-role", "page");
		div.attr("data-url", vId);
		if(pTransition == null || pTransition == "undefined") pTransition = "slideup";
		div.attr("data-transition", pTransition);
		//div.attr("data-external-page", "true");
		div.attr("data-theme", "pop");
		//div.attr("tabindex", "0");
		//div.attr("class", "pop ui-page ui-page-theme-a ui-page-active");
		//div.attr("style", "min-height: 594px;");
		$("#"+pId+"Cnt").after(div);
	}
	return vId;
}

// 레이어 팝업 호출(임시)
function fn_page_pop_temp(pGubun) {
	fn_loading_show();
	//window.location.href = pUrl;
	//window.location.href = "#"+pGubun;
	var vOption = { };
	vOption.transition = "slideup";
	$.mobile.changePage('#'+pGubun, vOption);
	fn_loading_hide();
}

// 로딩바 표시
function fn_loading_show(pMsg) {
	if(pMsg != null && pMsg != "undefined") {
		$.mobile.loading( 'show', {
			text: pMsg,
			textVisible: true,
			theme: 'pop',
			html: ""
		});
	} else {
		$.mobile.loading( 'show' );
	}
}

// 로딩바 숨기기
function fn_loading_hide() {
	$.mobile.loading( 'hide' );
}

// 알림
function fn_alert(pMsg, pTitle) {
	//alert(pMsg);
	var vTitle = "알림";
	if(pTitle != null && pTitle != "undefined") {
		vTitle = pTitle;
	}
	jAlert(pMsg, vTitle, 'd');
}

// 확인 메세지
function fn_confirm(pMsg, pTitle, pCallback) {
	var vTitle = "확인";
	if(pTitle != null && pTitle != "undefined") {
		vTitle = pTitle;
	}
	var vCallback = function(e){ alert(e); };
	if(pCallback != null && pCallback != "undefined") {
		vCallback = pCallback;
	}
	jConfirm(pMsg, vTitle, 'd', vCallback);
	//return fn_confirm(pMsg);
}

// 페이지팝업닫기
function fn_page_pop_close(pGubun) {
	if(pGubun != null) {
		if(pGubun == "main") {
			fn_back(pGubun);
			return;
			/*var vOption = { };
			vOption.transition = "slidedown";
			vOption.changeHash = false;
			$.mobile.changePage('#mainPage', vOption);
			return;*/
		}
	}
	fn_back(pGubun);
}

// 뒤로가기 버튼
function fn_back(pGubun) {
	$.mobile.back();
}

// 모바일 팝업
function fn_mobile_pop(pUrl) {
	if(fn_get_mobile_os() == "Android") {
		try {
			window.fzmosWC1.AndroidWindowOpen(pUrl);
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

//모바일 다운로드
function fn_mobile_download(pUrl) {
	if(fn_get_mobile_os() == "Android") {
		try {
			window.fzmosWC1.AndroidWindowOpen(pUrl);
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

//PC 다운로드
function fn_pc_download(pUrl) {
    var hiddenIFrameID = 'hiddenDownloader',
        iframe = document.getElementById(hiddenIFrameID);
    if (iframe === null) {
        iframe = document.createElement('iframe');
        iframe.id = hiddenIFrameID;
        iframe.style.display = 'none';
        document.body.appendChild(iframe);
    }
    iframe.src = pUrl;
};

//모바일 GPS
function fn_mobile_gps(id, gubun) {
	if(fn_get_mobile_os() == "Android") {
		window.WishroomAndroidApp1.callgps(id, gubun);
	} else if (fn_get_mobile_os() == "iOS") {
		webkit.messageHandlers.gpssend.postMessage({id:id,gubun:gubun});
	}
}

//모바일 GPS CALLBACK
function getgpsinfo(str1,str2, pId, pGubun) {
	if(pGubun == "dclz") {
		var gubun = $("#"+pId+" input[name='selectGps']").val();
		fn_loading_hide();
		try {
			if(str1.substr(0,1) == "0" || str2.substr(0,1) == "0") {
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
		if(vWrkplcGpsX == "" || vWrkplcGpsX == "0") {
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
		
		if(gvDclzMarker != null) gvDclzMarker.setMap(null);
		gvDclzMarker = new naver.maps.Marker(markerOptions);
		
		if(gubun != "1") {
			$("#"+pId+" input[name='selectSave']").click();
		}
	} else if(pGubun == "wrkplc") {
		fn_loading_hide();
		try {
			if(str1.substr(0,1) == "0" || str2.substr(0,1) == "0") {
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


//모바일 비콘
function fn_mobile_beacon(id, gubun) {
	if(fn_get_mobile_os() == "Android") {
		window.fzmosBicon.AndroidBicon(id, gubun);
	} else if (fn_get_mobile_os() == "iOS") {
		webkit.messageHandlers.biconstr.postMessage({id:id,gubun:gubun});
	}
}

//모바일 비콘 CALLBACK
function fn_mobile_beacon_callback(pId, pGubun, pUuid, pMajor, pMinor) {
	if(pGubun == "dclz") {
		fn_loading_hide();
		$("#"+pId+"BeaconUuid").val(pUuid);
		$("#"+pId+"BeaconMajor").val(pMajor);
		$("#"+pId+"BeaconMinor").val(pMinor);
		var vGubun = $("#"+pId+" input[name='selectGps']").val();
		if(vGubun != "1") {
			$("#"+pId+" input[name='selectSave']").click();
		}
	} else if(pGubun == "select") {
		fn_loading_hide();
		$("#"+pId+"BeaconUuid").val(pUuid);
		$("#"+pId+"BeaconMajor").val(pMajor);
		$("#"+pId+"BeaconMinor").val(pMinor);
	}
}

//모바일 전화걸기
function fn_mobile_phonecall(pStr){
	if(fn_get_mobile_os() == "Android") {
		try {
			window.fzmosCall.AndroidCall(pStr);
		} catch(e) { }
	} else if (fn_get_mobile_os() == "iOS") {
		try {
			webkit.messageHandlers.telcall.postMessage(pStr);
		} catch(e) { }
	}
}

//페이지팝업
function fn_download(pUrl) {
	fn_alert("다운로드");
}

// 푸쉬 토큰 가져오기 (앱에서 token_save_return(pStr); 을 호출함)
function fn_get_token() {
	if(fn_get_mobile_os() == "Android") {
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

// 모바일 카메라 업로드 콜 (성공 true, 실패 false)
function fn_image_upload_call_camera(url, id, gubun, userIdx, fileOwner, fileSe) {
	if(fn_get_mobile_os() == "Android") {
		try {
			window.fzmosCamara.AndroidCamara(url, id, gubun, userIdx, fileOwner, fileSe);
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

//모바일 이미지 업로드 콜 (성공 true, 실패 false)
function fn_image_upload_call_image(url, id, gubun, userIdx, fileOwner, fileSe) {
	if(fn_get_mobile_os() == "Android") {
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

//모바일 이미지 업로드 CALLBACK
function fn_image_upload(pId, pGubun, pData) {
	try {
		if(pGubun == "ckEditor") {
			var editor = CKEDITOR.instances[pId];
			var vHtml = "<img style=\"max-width: 100%;\" src=\""+fn_get_context_path()+"/images/egovframework/com/noImage.png\">";
			try{
				var list = pData.resultList;
				if(list != null && list.length > 0) {
					for(var i = 0 ; i < list.length; i++) {
						vHtml = "<img style=\"max-width: 100%;\" src=\""+fn_get_context_path()+"/com/file/downloadImgCk.do?idxVal="+list[i].idxVal+"\">";
					}
				}
			} catch(e) { }
			editor.insertHtml(vHtml);
			editor.execCommand( 'enter' );
		} else if(pGubun == "zemosIcon") {
			try{
				var list = pData.resultList;
				if(list != null && list.length > 0) {
					for(var i = 0 ; i < list.length; i++) {
						$("#"+pId+"Yn").val("Y");
						$("#"+pId+"Idx").val(list[i].idx);
						$("#"+pId+"Image").css("background-image","url('"+fn_get_context_path()+"/com/file/download.do?idxVal="+list[i].idxVal+"')");
					}
				}
			} catch(e) { }
		} else if(pGubun == "zemosLogo") {
			try{
				var list = pData.resultList;
				if(list != null && list.length > 0) {
					for(var i = 0 ; i < list.length; i++) {
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
							if(result > 0) {
								
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
							// 화면리셋
							window.location.href = fn_get_context_path()+"/";
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
	} catch(e) { }
}

//푸쉬 토큰 입력받기 (모바일 앱에서 자바스크립트 함수를 호출)
function token_save_return(pStr){
	fn_set_token(pStr);
	try {
		token_save_return2(pStr);
	} catch(e) { }
}

//푸쉬 토큰 조회
function fn_get_token_value() {
	return gvToken;
}

//푸쉬 토큰 세팅
function fn_set_token(pStr) {
	try {
		gvToken = pStr;
		
		//토큰 저장
		var vParams = {};
		var vMode = "0";
		if(fn_get_mobile_os() == "Android") {
			vMode = "1";
		} else if (fn_get_mobile_os() == "iOS") {
			vMode = "2";
		}
		vParams.mobileTy = vMode;
		vParams.mobileToken = gvToken;
		$.ajax({
			type : "post",
			url : fn_get_context_path()+"/com/push/saveToken.do",
			data : vParams
		});
		
		//임시 테스트
		//var vParams = {};
		/*var vMode = "";
		if(fn_get_mobile_os() == "Android") {
			vMode = "1";
		} else if (fn_get_mobile_os() == "iOS") {
			vMode = "2";
		}
		vParams.mode = vMode;
		vParams.token = gvToken;
		vParams.title = "안녕하세요.";
		vParams.text = "테스트입니다.";
		$.ajax({
			type : "post",
			url : fn_get_context_path()+"/com/push/sendPush2.do",
			data : vParams
			,dataType : "html"
		});*/
	} catch(e) { }
}

// 제모스 권한 조회
// 사용 예제
// alert(fn_get_zemos_auth("16", "1").contains("21000"));
function fn_get_zemos_auth(pZemosIdx, pWrkplcIdx) {
	var returnList = [];
	var params = {};
	params.zemosIdx = pZemosIdx;
	params.wrkplcIdx = pWrkplcIdx;
	
	// ajax 시작
	$.ajax({
	    url: fn_get_context_path()+"/zemos/zemos/zemosAuth.do",
	    type: 'post',
	    dataType : 'json',
	    data: params,
	    async: false
	}).done(function (data) { // 완료
		var resultList = data.resultList;
		if(resultList != null && resultList.length > 0) {
			returnList = resultList;
		}
	}).fail(function (data) { // 실패
		// 화면리셋
		window.location.href = fn_get_context_path()+"/";
	}).always(function(data) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
		// 후처리
		//fn_loading_hide();
		//$("#"+lvPageId+" input[name='selectFlag']").val("stop");
	});
	// ajax 끝
	return returnList;
}

//contains 메소드 추가
Array.prototype.contains = function(element) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == element) {
			return true;
		}
	}
	return false;
}

// 날짜 요일 구하기
function fn_get_day_of_week(pStr) {
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
	var today = new Date(pStr).getDay();
	var todayLabel = week[today];
	return todayLabel;
}

// 날짜 내일 날짜
function fn_get_tommorrow(pStr) {
	var today = new Date(pStr);
	var tommorrow = new Date(today.valueOf() + (24*60*60*1000));
	return tommorrow.getFullYear()+"-"+("0"+(tommorrow.getMonth()+1)).slice(-2)+"-"+("0"+tommorrow.getDate()).slice(-2);
}