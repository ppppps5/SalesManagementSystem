// 초기화 함수
$(document).ready(fnInit);
function fnInit() {
	// 쿠키 불러오기
	if(getCookie("save1") == "on") {
		$("#name").val(getCookie("name"));
		$("#ihidNumShort").val(getCookie("ihidNumShort"));
		$("#save1").val(getCookie("save1"));
		$("#save1").flipswitch( "refresh" );
	}
	if(getCookie("save2") == "on") {
		$("#save2").val(getCookie("save2"));
		$("#save2").flipswitch( "refresh" );
	}
	
	// 이름/생년월일 저장 변경 이벤트
	$("#save1").change(function () {
		var expdate = new Date();
		expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 3000); // 3000일
		var vSave1 = $(this).val();
		if(vSave1 != "on") {
			expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
		}
		setCookie("save1", vSave1, expdate);
		setCookie("name", $("#name").val(), expdate);
		setCookie("ihidNumShort", $("#ihidNumShort").val(), expdate);
	});
	
	// 자동로그인 저장 변경 이벤트
	$("#save2").change(function () {
		var expdate = new Date();
		expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 3000); // 3000일
		var vSave2 = $(this).val();
		if(vSave2 != "on") {
			expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
		}
		setCookie("save2", vSave2, expdate);
	});
	
	// 입력 기본 설정
	$('input').on("keypress", function(e) {
	    if (e.keyCode == 13) {
	    	if($(this).attr('name') == "name") $("#ihidNumShort").focus();
	    	else if($(this).attr('name') == "ihidNumShort") $("#password").focus(); 
	    	else if($(this).attr('name') == "password") actionLogin();
	        return false;
	    }
	});
	
	// 포커스 관련
	$("input").focus(function() {
	   $(this).select();
	});
	if($("#name").val() == "") $("#name").focus();
	else if($("#ihidNumShort").val() == "") $("#ihidNumShort").focus();
	else $("#password").focus();
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
}