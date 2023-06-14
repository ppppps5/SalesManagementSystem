<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	<style>
	.disabledbutton {
	    pointer-events: none;
	    opacity: 0.4;
	}
	</style>
	<script type="text/javascript">
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var pageNo    = "${pageNo}";
		var numOfRows = "${numOfRows}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		
		$(document).ready(function () {
			console.log('wrkplcIdx > ' + wrkplcIdx);
			$("input[type=checkbox]").css("display", "block");
			
			var trCntLength = $("#class4Table > tbody tr").length;
			var trSeq = 0;
			for ( var i = 0; i < trCntLength; i++ ) {
				trSeq = i + 1;
				fnRowCheck(trSeq);
				fnCheckBox(trSeq);
			}

			//분류3명 keyup이벤트
			//$('input[name=class4Nm]').on('keyup keypress',function(){ 
			$('input[name=class4Nm]').on('keyup',function(){	
				var index = $(this).parent().parent().index();
				var rowIndex = index + 1;
				var class4Nm = $("#class4Nm"+rowIndex).val();
				var hclass4Nm = $("#hclass4Nm"+rowIndex).val();
				var useYn = $("#useYn"+rowIndex).val();
				var huseYn = $("#huseYn"+rowIndex).val();
				
				if ( $("#useYn"+rowIndex).is(":checked") == true ) {
					useYn = "Y";
				} else {
					useYn = "N";
				}	
				
				if ( class4Nm == hclass4Nm ) {
					if ( useYn != huseYn) {
						$("#btnA"+rowIndex).removeClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("수정");
					} else {
						$("#btnA"+rowIndex).addClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("저장");	
					}
				} else {
					$("#btnA"+rowIndex).removeClass("disabledbutton");
					$("#btnSpan"+rowIndex).text("수정");
				}
			});
			
			//사용여부 change이벤트
			$('input[name=useYn]').on('change',function(){	
				var index = $(this).parent().parent().index();
				var rowIndex = index + 1;
				var class4Nm = $("#class4Nm"+rowIndex).val();
				var hclass4Nm = $("#hclass4Nm"+rowIndex).val();
				var useYn = $("#useYn"+rowIndex).val();
				var huseYn = $("#huseYn"+rowIndex).val();
				
				if ( $("#useYn"+rowIndex).is(":checked") == true ) {
					useYn = "Y";
				} else {
					useYn = "N";
				}	
				
				if ( useYn == huseYn ) {
					if ( class4Nm != hclass4Nm ) {
						$("#btnA"+rowIndex).removeClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("수정");
					} else {
						$("#btnA"+rowIndex).addClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("저장");	
					}
				} else {
					$("#btnA"+rowIndex).removeClass("disabledbutton");
					$("#btnSpan"+rowIndex).text("수정");
				}
			});
			
		});
		
		//조회
		function fn_reload(type, value1, value2) {
			var class4Nm = $("#class4Nm").val();
			var useYn = $("#selectUseYn").val();
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			if ( class4Nm != '' || class4Nm != null ) {
				url += "&class4Nm=" + class4Nm;	
			}
			if ( useYn != '' || useYn != null ) {
				url += "&selectUseYn=" + useYn;	
			}
			
			fn_location_href(url);
		}
		
		//분류2 추가
		function fnClass4Add() {
			var innerHtml = "";
			var trCnt = $("#class4Table > tbody tr").length + 1;
			
			innerHtml += "<tr id=\"class4TableTr"+trCnt+"\">";
	    	innerHtml += "	<td style=\"text-align: left;\">";
	    	innerHtml += "		<input id=\"class4Nm"+trCnt+"\" name=\"class4Nm\" type=\"text\" class=\"zemos_input1\" style=\"float: left; width:100%;\" placeholder=\"${class4UseName[0].class4UseNm}명\"  maxlength=\"99\">";
	    	innerHtml += "	</td>";
	    	innerHtml += "	<td style=\"text-align: left;\">";
	    	innerHtml += "		<input id=\"useYn"+trCnt+"\" name=\"useYn\" type=\"checkbox\" class=\"checkbox-style\" style=\"display:block;\" checked=\"checked\">"; 
	    	innerHtml += "	</td>";
	    	innerHtml += "	<td style=\"text-align: left;\">";
	    	innerHtml += "		<a href=\"javascript:void(0);\" onclick=\"javascript:fnClass4Save('"+trCnt+"'); return false;\" class=\"zemos_form_span_btn_blue\">";
			innerHtml += "			<span style=\"font-size:13px;\">저장</span>";
			innerHtml += "		</a>";
	    	innerHtml += "	</td>";
	    	innerHtml += "</tr>";
			
	    	$("input[type=checkbox]").css("display", "block");
	        $("#class4Table > tbody:last").append(innerHtml);
	        $("#class4Nm"+trCnt).focus();
		}
		
		function replaceAll(str, searchStr, replaceStr) {
		   return str.split(searchStr).join(replaceStr);
		}
		
		//분류3저장
		function fnClass4Save(trCnt) {
			var useYn = "";
			var saveGbn = "";
			
			var class4Nm = $("#class4Nm"+trCnt).val();
			var class4Seq = $("#class4Seq"+trCnt).val();
			
			//class4Nm = class4Nm.replaceAll("","");
			
			
			if ( class4Nm == '' || class4Nm == null ) {
				alert("${class4UseName[0].class4UseNm}명을 입력해 주세요.");
				$("#class4Nm"+trCnt).focus();
				return;
			}
			
			if ( Number(byteCheck($("#class4Nm"+trCnt))) > 100 ) {
				alert("${class4UseName[0].class4UseNm}명의 글자수를 초과하였습니다.\n${class4UseName[0].class4UseNm}명은 한글 50글자, 영문 100글자까지 입니다.");
				$("#class4Nm"+trCnt).focus();
				return;
			}
			
			if ( $("#useYn"+trCnt).is(":checked") == true ) {
				useYn = "Y";
			} else {
				useYn = "N";
			}			
			
			if ( class4Seq == '' || class4Seq == null ) {
				saveGbn = "insert";
			} else {
				saveGbn = "update";
			}
			
			var params = {};
			params.class4Nm  = class4Nm;
			params.useYn     = useYn;
			params.class4Seq = class4Seq;
			params.saveGbn   = saveGbn;
			params.zemosIdx  = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/class4Save.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("${class4UseName[0].class4UseNm}이 저장되었습니다.");
					fn_reload();
				} else {
					if ( response.resultError == '1' ) {
						alert("중복되는 ${class4UseName[0].class4UseNm}이 있습니다.");
					}
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
			
		}
		
		function fnRowCheck(trCnt) {
			var useYn = "";
			if ( $("#useYn"+trCnt).is(":checked") == true ) {
				useYn = "Y";
			} else {
				useYn = "N";
			}	
		
			if ( $("#class4Nm"+trCnt).val() == $("#hclass4Nm"+trCnt).val() && useYn == $("#huseYn"+trCnt).val()) {
				$("#btnA"+trCnt).addClass("disabledbutton");
				$("#btnSpan"+trCnt).text("저장");
			} else {
				$("#btnA"+trCnt).removeClass("disabledbutton");
				$("#btnSpan"+trCnt).text("수정");
			}
		}
		
		function fnCheckBox(trCnt) {
			if ( $("#useYn"+trCnt).is(":checked") == true ) {
				$("#class4Nm"+trCnt).attr("disabled", false); 
			} else {
				$("#class4Nm"+trCnt).attr("disabled", true); 
			}
		}
		
		//바이트수 반환  
		function byteCheck(el){
		    var codeByte = 0;
		    for (var idx = 0; idx < el.val().length; idx++) {
		        var oneChar = escape(el.val().charAt(idx));
		        if ( oneChar.length == 1 ) {
		            codeByte ++;
		        } else if (oneChar.indexOf("%u") != -1) {
		            codeByte += 2;
		        } else if (oneChar.indexOf("%") != -1) {
		            codeByte ++;
		        }
		    }
		    return codeByte;
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx=" + wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">${class4UseName[0].class4UseNm} 등록</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <!--조회조건시작-->
    <div class="zemos_label_search1">
    	<span class="fl mb5" style="width:100%; padding-right:1%;">
    		<select id="selectUseYn" class="zemos_select1" style="float: left; width: 25%;">
    			<option value=""  <c:if test="${params.selectUseYn[0] == ''}" >selected</c:if>>전체</option>
				<option value="Y" <c:if test="${params.selectUseYn[0] == 'Y'}">selected</c:if>>사용</option>
				<option value="N" <c:if test="${params.selectUseYn[0] == 'N'}">selected</c:if>>미사용</option>
			</select>
    		<input id="class4Nm" name="class4Nm" type="text" class="zemos_input1" style="float:left; width:65%; margin-left: 4px;" value="${params.class4Nm[0]}" placeholder="검색어(${class4UseName[0].class4UseNm}명) 입력" onKeyPress="javascript:if(event.keyCode == 13) fn_reload('select');" onfocus="$(this).select();" maxlength="99">
    	</span>
    	<span class="fr mb5" style="position: absolute; right:3%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
    </div>
    <!--조회된자료끝-->
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(class4List)}</span>건
        </span>
        <span class="fr mb5" style="margin-top:5px; width:21%;">
			<a href="javascript:void(0);" onclick="javascript:fnClass4Add(); return false;" class="zemos_form_span_btn_red">
				<span style="font-size:13px;">추 가</span>
			</a>
		</span>
    </div>
    <div style="overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table class="zemos_table1" id="class4Table" style="margin-top: 0px;">
    		<colgroup>
		        <col width="67%" />
		        <col width="13%" />
		        <col width="20%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding: 10px;">${class4UseName[0].class4UseNm}명</th>
	        		<th style="padding: 10px;">사용</th>
	        		<th style="padding: 10px;"></th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(class4List) > 0}">
		        		<c:forEach items="${class4List}" var="item" varStatus="status">
	        	<tr id="class4TableTr${status.count}">
	        		<td style="text-align: left;">
	        			<input id="class4Seq${status.count}" name="class4Seq" type="hidden" value="${item.class4Seq}">
	        			<input id="class4Nm${status.count}" name="class4Nm" value="${item.class4Nm}" type="text" class="zemos_input1" style="float: left; width:100%;" placeholder="${class4UseName[0].class4UseNm}명" maxlength="99">
	        			<span style="display:none;">${item.class4Nm}</span>
	        		</td>
	        		<td style="text-align: center;">
	        			<input id="useYn${status.count}" name="useYn" <c:if test="${item.useYn eq 'Y'}">checked="checked"</c:if> onChange="javascript:fnCheckBox('${status.count}');" type="checkbox" class="checkbox-style" style="display:block;">
	        			<span style="display:none;">${item.useYn}</span> 
	        		</td>
	        		<td style="text-align: center;">
	        			<a href="javascript:void(0);" onclick="javascript:fnClass4Save('${status.count}'); return false;" class="zemos_form_span_btn_blue" id="btnA${status.count}">
							<span id="btnSpan${status.count}" style="font-size:13px;">저장</span>
						</a>
						<input type="hidden" id="hrow${status.count}" name="hrow" value="${status.count}"/>
						<input type="hidden" id="hclass4Nm${status.count}" name="hclass4Nm" value="${item.class4Nm}"/>
						<input type="hidden" id="huseYn${status.count}" name="huseYn" value="${item.useYn}"/>
	        		</td>
	        	</tr>
	        			</c:forEach>
		        	</c:when>
			        <c:otherwise>
			        </c:otherwise>
		        </c:choose>
	        </tbody>
    	</table>
    </div>
    <!--조회된자료끝-->
</body>
</html>