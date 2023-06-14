<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>

	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/engine/mobiscroll/Scripts/mobiscroll-2.13.2.full.min.js'></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/engine/mobiscroll/Content/mobiscroll-2.13.2.full.min.css"/>
	<!-- selectbox 검색기능 css -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/zemos3/selectbox.css"/>
	
	<style type="text/css">
		.table-container{
			width:100%;
			/*display: inline-block;*/
			vertical-align: top;
			/*max-width: 100%;*/
			overflow-x: scroll;
			overflow-y:hidden;
			white-space: nowrap;
			border-collapse: collapse;
			border-spacing: 0;
			-webkit-transform: translateZ(0);
		}
	</style>
	
	<script type="text/javascript">
		var zemosIdx 	= "${params.zemosIdx[0]}";
		var zemosNm 	= "${params.zemosNm[0]}";
		var wrkplcIdx   = "${params.wrkplcIdx[0]}";
		var storeSeq = "${params.storeSeq[0]}";
		var pageNo 		= "${pageNo}";
		var numOfRows 	= "${numOfRows}";
		var type 	    = "${params.type[0]}";
		var startDate   = "${params.startDate[0]}";
		var endDate     = "${params.endDate[0]}";
		var pageReloadGbn = "${pageReloadGbn}";
		var pageReloadGbn2 = "${params.pageReloadGbn2[0]}";
		var userAdminGbn = "${userAdminGbn}";
		var storeSeq = "${params.storeSeq[0]}";
		var yyyy = "${params.yyyy[0]}";
		var mm = "${params.mm[0]}";
		var salesabun = "${params.salesabun[0]}";
		
		$(document).ready(function () {
			$("#storeSeq").select2();
			$(".select2-selection__arrow").hide();
			
			$('#startDate').mobiscroll().date({
		        theme: 'android-holo-light',
		        display: 'modal',
		        mode: 'scroller',
		        dateOrder: 'yy mm dd',
		        dateFormat : "yy-mm-dd",
		        maxDate: new Date(2099, 11, 31) // 2099-12-31 까지
		    });
			
			
			$('#endDate').mobiscroll().date({
		        theme: 'android-holo-light',
		        display: 'modal',
		        mode: 'scroller',
		        dateOrder: 'yy mm dd',
		        dateFormat : "yy-mm-dd",
		        maxDate: new Date(2099, 11, 31) // 2099-12-31 까지
		    });
			
			var now 	= new Date();
		    var year 	= now.getFullYear();
		    var mon  	= (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1) : '0' + (now.getMonth() + 1);
		    var beforeDay = (now.getDate()-1) > 9 ? '' + (now.getDate()-1) : '0' + (now.getDate()-1);
		    var day  	= now.getDate() > 9 ? '' + now.getDate() : '0' + now.getDate();
		    var current = year + mon + day;
		    
		    if ( startDate == null || startDate == "" ) {
		    	$('#startDate').val(year + '-' + mon + '-' + beforeDay);
				$('#startDate').mobiscroll("setDate", new Date(year + '-' + mon + '-' + beforeDay));	
		    }
		    if(beforeDay == "00"){
 				var sDate = new Date(year + '-' + mon + '-' + day);
		    	var yesterday = new Date(sDate.setDate(sDate.getDate() - 1));
		    	var year_n = yesterday.getFullYear();
		    	var month_n = (yesterday.getMonth() + 1 > 9) ? yesterday.getMonth() + 1 : '0' + (yesterday.getMonth() + 1);
		    	var day_n = (yesterday.getDate() > 9) ? yesterday.getDate() : '0' +  yesterday.getDate();
		    	$('#startDate').val(year_n + '-' + month_n + '-' + day_n);
		    }
		    if ( endDate == null || endDate == "" ) {
				$('#endDate').val(year + '-' + mon + '-' + day);
				$('#endDate').mobiscroll("setDate", new Date(year + '-' + mon + '-' + day));
		    }
		    console.log("pageReloadGbn > " + pageReloadGbn);
		    if ( pageReloadGbn == "N" || pageReloadGbn2 == "N" ) {
		    	fn_reload('select');
		    }
		});
		
		function fn_reload(type, value1, value2) {
			//alert(storeSeq);
			var startDateS = $("#startDate").val();
			var endDateS   = $("#endDate").val();
			
			if ( type == "pageNo" ) {
				pageNo = value1;
			}
			
			if ( type == "select" ) {
				pageNo = 1;
			}
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx="	     + zemosIdx;
			url += "&wrkplcIdx="	 + wrkplcIdx;
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&type="	         + type;
			url += "&startDate="     + startDateS;
			url += "&endDate="       + endDateS;
			url += "&userAdminGbn="  + userAdminGbn;
			url += "&yyyy="  + yyyy;
			url += "&mm="  + mm;
			url += "&salesabun=" + salesabun;
			var pagegbn = 'W';
			url += "&pagegbn="  + pagegbn;	
			//if ( $("#storeSeq").val() != 'A' ) {
			if ( $("#storeSeq").val() != '' ) {
				url += "&storeSeq=" + $("#storeSeq option:selected").val();	
			} else {
				if ( pageReloadGbn == "N" ) {
					url += "&storeSeq=" + storeSeq;
				} else {
					url += "&storeSeq=" + "";
				}
			}
			
			fn_location_href(url);
		}
			
		function fnMyDeleteRequest(resultSeq, resultDt, storeSeq, requestYn, cRequestYn) {
			if ( !fn_confirm("실적정보 삭제 승인 하시겠습니까?") ) {
				return;
			}
			
			var params = {};
			params.resultSeq = resultSeq;
			params.resultDt  = resultDt;
			params.storeSeq  = storeSeq;
			params.requestYn = 'D';
			params.zemosIdx  = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2ResultDelete.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("삭제가 완료되었습니다.");
					fn_reload('select');
				} else {
					fn_reload('select');
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fnMyModifyRequest(resultSeq, resultDt, storeSeq, requestYn, cRequestYn) {
			var startDateS = $("#startDate").val();
			var endDateS   = $("#endDate").val();
			if ( requestYn != 'D' ) {
				var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2ResultModify.do";
				url += "?zemosIdx="	     + zemosIdx;
				url += "&wrkplcIdx="	+ wrkplcIdx;
				url += "&zemosNm="	     + encodeURIComponent(zemosNm);
				url += "&pageNo="	     + pageNo;
				url += "&numOfRows="	 + numOfRows;
				url += "&type="	         + type;
				url += "&startDate="     + startDateS;
				url += "&endDate="       + endDateS;
				url += "&userAdminGbn="  + userAdminGbn;
				url += "&storeSeq=" + $("#storeSeq option:selected").val();
				url += "&resultSeq="     + resultSeq;
				url += "&resultDt="      + resultDt;
				url += "&yyyy="  + yyyy;
				url += "&mm="  + mm;
				url += "&salesabun=" + salesabun;
				url += "&requestYn=" + requestYn;
				url += "&cRequestYn=" + cRequestYn;
				
				fn_location_href(url);
			}
		}
		
		function fn_sales_file_download (imageIdxEnc) {
			var params = {};
			params.idxVal = imageIdxEnc;
		
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2FileCheck.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal='+imageIdxEnc); //local
					//fn_mobile_download('https://m.zemos.co.kr/com/file/download.do?idxVal='+imageIdxEnc); //운영
				} else {
					alert("첨부파일이 없습니다.");
					return;
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fn_back2() {
			var storeSeqVal = "";
			if ( $("#storeSeq").val() != 'A' ) {
				storeSeqVal = $("#storeSeq option:selected").val();
			} else {
				storeSeqVal = "";
			}
			if ( userAdminGbn == "A" ) {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeqVal+"&yyyy="+yyyy+"&mm="+mm+"&salesabun="+salesabun);
			} else {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeqVal+"&yyyy="+yyyy+"&mm="+mm+"&salesabun="+salesabun);
			}
		}
		
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">수정요청관리</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
		<span class="zemos_title1_right" style="display: none;">
			<a href="#" onclick="javascript:fn_location_href('${pageContext.request.contextPath}/zemos3/zemos/menu/menuManager2.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/menu01${menu01}.png" alt="홈">
			</a>
		</span>
	</div>
    <!--타이틀끝-->
    
    <!--조회조건시작-->
	<div class="zemos_label_search1">
		<span class="fl mb5" style="width:100%; padding-right:10%;">
			<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%">
	   			<option value="" <c:if test="${ params.storeSeq[0] eq ''}">selected</c:if>>매장전체</option>
	   			<c:forEach items="${storeList}" var="item" varStatus="status">
	   			<option value="${item.storeSeq}" <c:if test="${item.storeSeq eq params.storeSeq[0]}">selected</c:if>>${item.storeNm}</option>
	   			</c:forEach>
			</select>
		</span>
		<span class="fr mb5" style="position: absolute; margin-top: 1px; right:5%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
	</div>
	<c:if test="${loginVO.zemosAuth == '12000'}"> 
	<div class="zemos_label_search1">
		<div style="width:15%;">
			<span class="fl mb5" style="width:100%; padding-top:18%;">
				시작일
			</span>
		</div>
		<div style="width:30%; float: left;">
			<input id="startDate" name="startDate" type="text" class="zemos_input1" style="width:100%; font-size:10px;" value="${params.startDate[0]}"/>
		</div>
		<div style="width:15%; float: left;">
			<span class="fl mb5" style="width:100%; padding-top:18%;">
				종료일
			</span>
		</div>
		<div style="width:30%; float: left;">
			<input id="endDate" name="endDate" type="text" class="zemos_input1" style="width:100%; font-size:10px;" value="${params.endDate[0]}"/>
		</div>
	</div>
	</c:if>
	
    <!--조회조건끝-->
    
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
    	<span style="padding:10px 0px;">
    		조회<span class="zemos_label_data_grey2">${selectSalesPresentCnt}</span>건
    	</span>
    </div>
    <!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
	    <table class="zemos_table1 table-container" style="margin-top: 0px;">
	        <colgroup>
		        <col width="8%"  /><!-- 순번 -->
				<col width="22%" /><!-- 매장명 -->
				<col width="12%" /><!-- 일자 -->
				<col width="14%" /><!-- 원 -->
				<col width="14%" /><!-- 달러 -->
				<col width="14%" /><!-- 수량 -->
				<col width="8%" /><!-- 첨부파일 -->
				<col width="8%" /><!-- 요청 -->
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th rowspan="2" style="padding: 10px 5px;">순번</th>
	        		<th rowspan="2" style="padding: 10px 5px;">매장</th>
	        		<th rowspan="2" style="padding: 10px 5px;">일자</th>
	        		<th colspan="3" style="padding: 10px 5px;">매출(실적)</th>
	        		<c:if test="${userAdminGbn eq 'A'}">
	        		<th rowspan="2" style="padding: 10px 5px;">첨부<br/>파일</th>
	        		<th rowspan="2" style="padding: 10px 5px;">요청</th>
	        		</c:if>
	        	</tr>
	        	<tr>
	        		<th style="padding: 10px 5px;">원</th>
	        		<th style="padding: 10px 5px;">$(달러)</th>
	        		<th style="padding: 10px 5px;">수량</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(selectSalesPresent) > 0}">
		        		<c:forEach items="${selectSalesPresent}" var="item" varStatus="status">
		        <tr>
	        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;">${status.count}</td>
	        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;">${item.storeNm}</td>
	        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;">${item.resultDt}</td>
	        		<td style="padding: 10px 5px; text-align: right;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;">${item.amt}원</td>
	        		<td style="padding: 10px 5px; text-align: right;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;"><fmt:formatNumber value="${item.dollarAmt}" pattern="#,###.##" />$</td>
	        		<td style="padding: 10px 5px; text-align: right;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;">${item.qty}</td>
					<td style="padding: 10px 5px; text-align: center;">
						<c:if test="${item.idx ne null}">
						<a href="#" onclick="javascript:fn_sales_file_download('${item.imageIdxEnc}'); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/clip.png" style="width:22px;" alt="첨부파일">
						</a>
		        		</c:if>
					</td>
					<td style="padding: 10px 5px; text-align: center;">
						<c:if test="${item.cRequestYn eq 'W'}">수정</c:if>
						<c:if test="${item.requestYn eq 'D'}">
						<a href="javascript:void(0);" onclick="javascript:fnMyDeleteRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;" class="zemos_form_span_btn_blue" id="btnA${status.count}">
							<span id="btnSpan${status.count}" style="font-size:13px;">삭제</span>
						</a>
						</c:if>
					</td>
	        	</tr>
		        		</c:forEach>
		        	</c:when>
		        	<c:otherwise>
		        <tr>
		        	<td colspan="8">
		        		수정요청현황이 없습니다.
		        	</td>
		        </tr>
		        	</c:otherwise>
		        </c:choose>
	        </tbody>
	        <tfoot>
                <tr style="background-color:#CEE3F6; font-weight:bold;">
                    <td colspan="3" style="padding: 5px; text-align: center; font-size: 12px;">합계</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${selectSalesPresentTotal.amt}" pattern="#,###" />원</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><%-- <fmt:formatNumber value="${selectSalesPresentTotal.dollarAmt}" pattern="#,###.##" /> --%>${selectSalesPresentTotal.dollarAmt}$</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${selectSalesPresentTotal.qty}" pattern="#,###" /></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
	    </table>
	    <!-- 페이징 처리 -->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosPaging.jsp"%>
	    <!-- 페이징 처리 -->
    </div>
   
    <!--조회된자료끝-->
    
</body>
</html>