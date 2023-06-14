<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	
	<script type="text/javascript">
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		
		$(document).ready(function () {
			$("#useYnChkLabel").click(function() {
				var isChecked = $("#useYn").is(":checked");
				//alert("isChecked > " + isChecked);
				if (isChecked) {
					$("#useYn").prop("checked", false);
				} else {
					$("#useYn").prop("checked", true);
				}
	    	});
			
			$("#classynChkLabel").click(function() {
				var isChecked = $("#classyn").is(":checked");
				//alert("isChecked > " + isChecked);
				if (isChecked) {
					$("#classyn").prop("checked", false);
				} else {
					$("#classyn").prop("checked", true);
				}
	    	});
		});
		
		//조회
		function fn_reload(type, value1, value2) {
			var storeNm = $("#storeNm").val();
			var useYn = $("#selectUseYn").val();
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeNm=" + storeNm;
			if ( useYn != '' || useYn != null ) {
				url += "&selectUseYn=" + useYn;	
			}
			
			fn_location_href(url);
		}
		
		//매장상세설정 이동
		function fnShopInfoDetail(idx, storeSeq) {
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreNewDetail.do";
			url += "?zemosIdx=" + idx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq="+storeSeq;
			
			fn_location_href(url);
		}
		
		//매장추가 이동
		function fnShopAdd() {
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreNewAdd.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			
			fn_location_href(url);
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
		
		function fbSabunChange(obj) {
			//alert("fbSabunChange val > " + obj.value);
		}
		
		function fbSabun2Change(obj) {
			//alert("fbSabun2Change val > " + obj.value);
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx=" + wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;"> ${storeUseName[0].storeUseNm}관리</span>
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
    		<input id="storeNm" name="storeNm" type="text" class="zemos_input1" style="float:left; width:67%; margin-left:10px;" value="${params.storeNm[0]}" placeholder="검색어(${storeUseName[0].storeUseNm}명) 입력" onKeyPress="javascript:if(event.keyCode == 13) fn_reload('select');" onfocus="$(this).select();" maxlength="100">
    	</span>
    	<span class="fr mb5" style="position:absolute; margin-top:1px; right:1%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
		
    </div>
    <!--조회된자료끝-->
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(storeList)}</span>건
        </span> 
        <span class="fr mb5" style="position:absolute; margin-top:4px; right:8px; width:18%;">
			<a href="javascript:void(0);" onclick="fnShopAdd();" class="zemos_form_span_btn_blue">
				<span style="font-size:13px;"> ${storeUseName[0].storeUseNm}추가</span>
			</a>
		</span>
    </div>
    <!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <!-- <div class="zemos_form1" id="testContent"> -->
    <div id="testContent">
    	<!-- <table class="zemos_table1 table-container" style="margin-top: 0px;"> -->
    	<table class="zemos_table1" style="margin-top: 0px;">
    		<colgroup>
		        <col width="80%" />
		        <col width="19%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th colspan="2" style="padding: 10px;"> ${storeUseName[0].storeUseNm}명</th>
	        	</tr>
	        </thead>
	        <tbody>
	        <c:choose>
	        	<c:when test="${fn:length(storeList) > 0}">
	        		<c:forEach items="${storeList}" var="item" varStatus="status">
	        	<tr>
	        		<td style="padding:10px; text-align:left; font-weight:bold;" onClick="javascript:fnShopInfoDetail('${item.zemosIdx}','${item.storeSeq}');">
	        			${item.storeNm}
	        			<input type="hidden" id="hStoreNm${status.count}" name="hStoreNm" value="${item.storeNm}" />
	        		</td>
	        		<td style="padding: 10px; text-align: left;">
		        		
					</td>
	        	</tr>
	        		</c:forEach>
	        	</c:when>
		        <c:otherwise>
			    <tr>
			    	<td colspan="2">
			    		등록되어있는 ${storeUseName[0].storeUseNm}이 없습니다.
			    	</td>
			    </tr>
			    </c:otherwise>
		    </c:choose>
	        </tbody>
    	</table>
	    <!--팝업시작-->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/popup/store2AddPopup.jsp"%>
	    <!--팝업끝-->
    </div>
    <!--조회된자료끝-->
    
</body>
</html>