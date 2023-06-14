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
			
			var trCntLength = $("#closeTable > tbody tr").length;
			var trSeq = 0;
			for ( var i = 0; i < trCntLength; i++ ) {
				trSeq = i + 1;
				fnRowCheck(trSeq);
				fnCheckBox(trSeq);
			}

			
			
			//사용여부 change이벤트
			$('input[name=closeYn]').on('change',function(){	
				var index = $(this).parent().parent().index();
				var rowIndex = index + 1;
				var closeYn = $("#closeYn"+rowIndex).val();
				var hcloseYn = $("#closeYn"+rowIndex).val();
				
				if ( $("#closeYn"+rowIndex).is(":checked") == true ) {
					closeYn = "Y";
				} else {
					closeYn = "N";
				}	
				
			});
			
		});
		
		//조회
		function fn_reload(type, value1, value2) {
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&yyyy="			 + $("#yyyy option:selected").val();
			
			fn_location_href(url);
		}
		
		//마감저장
		function fnCloseSave() {
			var closeYn = "";
			var saveGbn = "";
			var closeCnt = ${closeCnt};
			var trCnt = 0 ;
			
			
			for ( var i = 0; i < closeCnt; i++ ) {
				
			trCnt = i + 1;
				
			var closeYn = $("#closeYn"+trCnt).val();
			var closeSeq = $("#closeSeq"+trCnt).val();
			var YyyyMm = $("#YyyyMm"+trCnt).val();
			var Yyyy = $("#Yyyy"+trCnt).val();
			
			
			if ( $("#closeYn"+trCnt).is(":checked") == true ) {
				closeYn = "Y";
			} else {
				closeYn = "N";
			}			
			
			if ( closeSeq == '' || closeSeq == null ) {
				saveGbn = "insert";
			} else {
				saveGbn = "update";
			}
			
			
			var params = {};
			params.closeYn     = closeYn;
			params.closeSeq = closeSeq;
			params.Yyyy   = Yyyy;
			params.saveGbn   = saveGbn;
			params.zemosIdx  = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/closeSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			   data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
			
			if (trCnt == 12) {
					alert("마감이 저장되었습니다.");
					fn_reload();
				}	
			}
		}
		
		function fnRowCheck(trCnt) {
			var closeYn = "";
			if ( $("#closeYn"+trCnt).is(":checked") == true ) {
				closeYn = "Y";
			} else {
				closeYn = "N";
			}	
		
		}
		
		function fnCheckBox(trCnt) {
			var closeYn = "";
			if ( $("#closeYn"+trCnt).is(":checked") == true ) {
				closeYn = "Y";
			} else {
				closeYn = "N";
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
			fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">마감관리</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <!--조회조건시작-->
    <div class="zemos_label_search1">
    	<span class="fl mb5" style="width:30%; padding-right:2%;">
	    	<select id="yyyy" class="zemos_select1" style="width:100%" onchange="javascript:fn_reload('select');">
				<c:forEach items="${yyyyList}" var="item" varStatus="status">
					<option value="${item.yyyy}" <c:if test="${item.yyyy eq yyyy}">selected</c:if>>${item.yyyy}</option>
				</c:forEach>
			</select>
		</span>
    	
		<!-- <span class="fr mb5" style="position: absolute; margin-top: 1px; right: 20px;">
			<a href="javascript:void(0);" onclick="javascript:fncloseAdd(); return false;" class="zemos_form_span_btn_red" style="width: 60;">
				<span style="font-size:13px;">추 가</span>
			</a>
		</span> -->
    </div>
    <!--조회된자료끝-->
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <%-- <p class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(closeList)}</span>건   ${closeCnt}
        </p> --%>
        <span class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(closeList)}</span>건
        </span>
        <span class="fr mb5" style="margin-top:5px; width:21%;">
			<a href="javascript:void(0);" onclick="javascript:fnCloseSave(); return false;" class="zemos_form_span_btn_red">
				<span style="font-size:13px;">저장</span>
			</a>
		</span>
    </div>
    <div style="overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table class="zemos_table1" id="closeTable" style="margin-top: 0px;">
    		<colgroup>
		        <col width="67%" />
		        <col width="33%" />
		       
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding: 10px;">년월</th>
	        		<th style="padding: 10px;">마감여부</th>
	        		<th style="padding: 10px;"></th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(closeList) > 0}">
		        		<c:forEach items="${closeList}" var="close" varStatus="status">
	        	<tr id="closeTableTr${status.count}">
	        		<td style="text-align: left;">
	        			<input id="closeSeq${status.count}" name="closeSeq" type="hidden" value="${close.closeSeq}">
	        			<input id="YyyyMm${status.count}" name="YyyyMm" value="${close.YyyyMm}" type="hidden" class="zemos_input1" style="float: left; width:100%;" placeholder="" maxlength="99">
	        			<input id="Mm${status.count}" name="Mm" type="hidden" value="${close.Mm}">
	        			${close.YyyyMm}
	        		</td>
	        	
	        		<td style="text-align: center;">
	        			<input id="closeYn${status.count}" name="closeYn" <c:if test="${close.closeYn eq 'Y'}">checked="checked"</c:if> onChange="javascript:fnCheckBox('${status.count}');" type="checkbox" class="checkbox-style" style="display:block;">
	        			<span style="display:none;">${close.closeYn}</span> 
	        			<input type="hidden" id="hcloseYn${status.count}" name="hcloseYn" value="${close.closeYn}"/>
	        			<input type="hidden" id="Yyyy${status.count}" name="Yyyy" value="${close.Yyyy}"/>
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