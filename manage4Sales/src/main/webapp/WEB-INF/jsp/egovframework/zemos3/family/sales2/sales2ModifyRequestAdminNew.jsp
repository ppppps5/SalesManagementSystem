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
	
	<!-- 달력 -->
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/zemos/report/common/carendar.jsp"%>
	
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
			 setCarendarDay('#carendarYmd1', '#carendarYmd2', true);
			 
			 <c:if test="${startDate != null && startDate != ''}">
				$("#carendarYmd1").val("${startDate}");
			 </c:if>

			 <c:if test="${endDate != null && endDate != ''}">
			 	$("#carendarYmd2").val("${endDate}");
			 </c:if>
			 
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
		
		function fnResultRecordPopup(historySeq, requestYn){
			var innerHtml = "";
			var buttonHtml = "";
			var historySeq;
			var storeNm;
			var storeSeqA;
			var resultSeqA;
			<c:forEach items="${resultDetailList}" var="item" varStatus="status">
			if(<c:out value="${item.historySeq}"/> == historySeq){
				var qty = "<fmt:formatNumber value="${item.resultQty}" pattern="#,###" />";
				var amt = "<fmt:formatNumber value="${item.resultAmt}" pattern="#,###" />";
				var changeQty = "<fmt:formatNumber value="${item.changeQty}" pattern="#,###" />";
				var changeAmt = "<fmt:formatNumber value="${item.changeAmt}" pattern="#,###" />";
				innerHtml += '<tr style="height:50px; padding:4px 4px;" class = "'+${item.historySeq}+'">';
				innerHtml += '<td style="text-align:center; padding:4px 4px;">';
				innerHtml += '	${item.itemNm}';
				innerHtml += '	<input type="hidden"  name="historySeq" class="historySeq" value="'+${item.historySeq}+'"/>';
				innerHtml += '</td>';
				innerHtml += '<td>';
				<c:if test="${item.onOffYn == '0'}">innerHtml += '오프라인'</c:if>
				<c:if test="${item.onOffYn == '1'}">innerHtml += '온라인'</c:if>
				innerHtml += '</td>';
				innerHtml += '<td>';
				innerHtml += '<c:out value="${item.unitNm}"/>' ;
				innerHtml += '</td>';
				innerHtml += '<td>';
				innerHtml += '<span style="width:100%;">';
				innerHtml += '<span style="width:100%; float:left;">수량</span>';
				innerHtml += '</span>';
				innerHtml += '<br/>';
				innerHtml += '<span style="width:100%; display:inline-block; margin-top:15px;">';
				innerHtml += '<span style="width:100%; float:left;">실적</span>';
				innerHtml += '</span>';
				innerHtml += '</td>';
				innerHtml += '<td style="text-align:center; padding:4px 4px;">';
				innerHtml += '<span style="width:100%;">';
				innerHtml += '<span style="width:100%; float:right; text-align:right;">'+qty+'</span>';
				innerHtml += '</span>';
				innerHtml += '<br/>';
				innerHtml += '<span style="width:100%; display:inline-block; margin-top:15px;">';
				innerHtml += '<span style="width:100%; float:right; text-align:right;">'+amt+'</span>';
				innerHtml += '</span>';
				innerHtml += '</td>';
				innerHtml += '<td style="text-align:right;">';
				innerHtml += '<span style="width:100%;">';
				innerHtml += changeQty;
				innerHtml += '</span>';
				innerHtml += '<br/>';
				innerHtml += '<span style="width:100%; display:inline-block; margin-top:15px;">';
				innerHtml += changeAmt;
				innerHtml += '</span>';
				innerHtml += '</td>';
				innerHtml += '</tr>';
				historySeq = '${item.historySeq}';
				storeSeqA = '${item.storeSeq}';
				storeNm = '${item.storeNm}';
				resultSeqA = '${item.resultSeq}';
			}
			</c:forEach>
			if(requestYn == "W"){
				buttonHtml += '<span class="mb5" style="width:100%; height:29px; text-align:left; position:absolute; left:5%; width:100%;">';
				buttonHtml += '<a href="javascript:void(0);" onclick="javascript:deleteResult('+historySeq+', '+storeSeqA+', '+resultSeqA+'); return false;" class="zemos_form_span_btn_blue" style="width:90%;">';
				buttonHtml += '<span style="font-size:15px;">요청취소</span>';
				buttonHtml += '</a>';
				buttonHtml += '</span>';
			}
			var modUserHtml = "";
			<c:forEach items="${result}" var="item" varStatus="status">
				if(<c:out value="${item.historySeq}"/> == historySeq){
					modUserHtml += '<span>요청일시 : '+'${item.regDttm}'+' / '+'${item.requestName}'+'</span><br/>';
					modUserHtml += '<span>승인일시 : '+'${item.modDttm}'+' / '+'${item.rejectUser}'+'</span>';
					var text;
					$("#regDttmTd").text("${item.regDt}")
					$("#modifyDtTd").text("${item.modifyDt}")
					<c:if test="${item.requestYn== 'Y'}">text = "승인";</c:if>
					<c:if test="${item.requestYn== 'N'}">text = "반려";
						modUserHtml += '<br/><span>반려사유 : '+'${item.rejectDesc}'+'</span>';
					</c:if>
					<c:if test="${item.requestYn== 'D'}">text = "취소";</c:if>
					<c:if test="${item.requestYn== 'W'}">text = "대기";</c:if>
					$("#requestYnTd").text(text);
				}
			</c:forEach>
			$("#modUserTd").html(modUserHtml);
			$("#headStoreNm").text(storeNm);
			$("#deleteButton").html(buttonHtml);
			$("#resultDetailListBody").html(innerHtml);
			$("#salesResultRecordPopup").show();
		}
		
		function deleteResult(historySeq, storeSeqA, resultSeqA){
			<c:if test="${closeYn[0].closeYn == 'Y'}">
			alert("마감된 달의 수정요청은 취소할 수 없습니다.");
			return;
			</c:if>
			var params = {};
			params.requestYn = 'D';
			params.historySeq  = historySeq;
			params.zemosIdx  = zemosIdx;
			params.storeSeq  = storeSeqA;
			params.resultSeq  = resultSeqA;
			params.wrkplcIdx  = wrkplcIdx;
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2ResultDeleteNew.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("취소가 완료되었습니다.");
					fn_reload('select');
				} else {
					if(response.YN == "Y"){		
						alert("승인처리된 요청은 삭제할 수 없습니다.")
						fn_reload('select');
					}else if(response.YN == "N"){
						alert("반려처리된 요청은 삭제할 수 없습니다.")
						fn_reload('select');
					}
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fn_reload(type, value1, value2) {
			//alert(storeSeq);
			var startDateS = $("#carendarYmd1").val();
			var endDateS   = $("#carendarYmd2").val();
			var requestYn = $("#requestYn").val();
			
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
			if($("#requestYn").val() != ''){
				url += "&requestYn=" + $("#requestYn option:selected").val();
			}
			if("${params.pages[0]}" == 'record'){
				url += "&pages=" + "${params.pages[0]}";
			}
			if("${params.pages[0]}" == 'record2'){
				url += "&pages=" + "${params.pages[0]}";
			}
			
			fn_location_href(url);
		}
			
		
		function fnMyModifyRequest(resultSeq, resultDt, storeSeq, requestYn) {
			var startDateS = $("#carendarYmd1").val();
			var endDateS   = $("#carendarYmd2").val();
			<c:if test="${closeYn[0].closeYn == 'Y'}">
				alert("마감된 달의 수정요청은 처리할 수 없습니다.");
				return;
			</c:if>
			if(requestYn == "Y"){
				alert("승인된 요청은 처리하실 수 없습니다. ")
				return;
			}else if(requestYn == "N"){
				alert("반려된 요청은 처리하실 수 없습니다. ")
				return;
			}else if(requestYn == "D"){
				alert("취소된 요청은 처리하실 수 없습니다. ")
				return;
			}else {
				var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2ResultModifyANew.do";
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
			if(userAdminGbn='A'){
				<c:choose>
				<c:when test="${params.pages[0] == 'record2'}">
					fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx="+zemosIdx+"&salesabun="+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn=" +userAdminGbn);
				</c:when>
				<c:otherwise>
					fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?zemosIdx="+zemosIdx+"&salesabun="+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn=" +userAdminGbn);
				</c:otherwise>
				</c:choose>
			}else{
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx="+zemosIdx+"&salesabun="+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn=" +userAdminGbn);
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
    	<c:choose>
    		<c:when test="${params.pages[0] == 'record'}">
				<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">수정요청이력</span>
    		</c:when>
    		<c:when test="${params.pages[0] == 'record2'}">
				<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">실적변경이력조회</span>
    		</c:when>
    		<c:otherwise>
				<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">수정요청관리</span>
    		</c:otherwise>
    	</c:choose>
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
		<!--기간선택-->
      	<!-- 매장선택 -->
          <span class="fl mb5" style="width:100%; padding-right:10%;">
              <select id="storeSeq" name="storeSeq" class="zemos_select1"
                  style="width:100%; text-align:left;">
                  <option value="">${storeUseName[0].storeUseNm}전체</option>
                  <c:forEach items="${storeList}" var="item" varStatus="status">
                      <option value="${item.storeSeq}" <c:if test="${item.storeSeq eq params.storeSeq[0]}">
                          selected</c:if>>${item.storeNm}
                      </option>
                  </c:forEach>
              </select>
          <span class="fl mb5" style="width:40%; margin-top: 2%;">
              <select id="requestYn" name="requestYn" class="zemos_select1"
                  style="width:100%; text-align:left;">
                  <option value="" <c:if test="${params.requestYn[0] == ''}">
                          selected</c:if>>전체</option>
                      <option value="W" <c:if test="${params.requestYn[0] == 'W'}">
                          selected</c:if>>대기
                      </option>
                      <option value="Y" <c:if test="${params.requestYn[0] == 'Y'}">
                          selected</c:if>>승인
                      </option>
                      <option value="N" <c:if test="${params.requestYn[0]} == 'N'">
                          selected</c:if>>반려
                      </option>
                      <option value="D" <c:if test="${params.requestYn[0]} == 'N'">
                          selected</c:if>>삭제
                      </option>
              </select>
          </span>
          <span class="fr mb5" style="position:absolute; right:3%; margin-top: 2%;">
              <a href="#" onclick="javascript:fn_reload('select'); return false;"
                  class="zemos_label_search1_search_image"></a>
          </span>
			<input id="carendarYmd1" type="text" class="zemos_input1" style="width: 27%; margin-bottom: 2px; font-size: 11px; margin-top: 2%;">
			<span style="border-left-width: 0px; font-size:15px; font-weight:600;">~</span>
			<input id="carendarYmd2" type="text" class="zemos_input1" style="width: 27%; margin-bottom: 2px; font-size: 11px; margin-top: 2%;">	
			
			
	</div>
    <!--조회조건끝-->
    
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
    	<span style="padding:10px 0px;">
    		조회<span class="zemos_label_data_grey2">${fn:length(selectSalesPresent)}</span>건
    	</span>
    </div>
    <!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
	    <table class="zemos_table1 table-container" style="margin-top: 0px;">
	        <colgroup>
		        <col width="25%"  /><!-- 순번 -->
				<col width="25%" /><!-- 매장명 -->
				<col width="25%" /><!-- 일자 -->
				<col width="25%" /><!-- 상태 -->
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th rowspan="1" style="padding: 10px 5px;">순번</th>
	        		<th rowspan="1" style="padding: 10px 5px;"><c:out value="${storeUseName[0].storeUseNm}"/></th>
	        		<th rowspan="1" style="padding: 10px 5px;">일자</th>
	        		<th rowspan="1" style="padding: 10px 5px;">상태</th>
	        		
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(selectSalesPresent) > 0}">
		        		<c:forEach items="${selectSalesPresent}" var="item" varStatus="status">
		        <tr>
		        <c:choose>
		    		<c:when test="${params.pages[0] == 'record' || params.pages[0] == 'record2'}">
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnResultRecordPopup('${item.historySeq}','${item.requestYn}');">${status.count}</td>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnResultRecordPopup('${item.historySeq}','${item.requestYn}');">${item.storeNm}</td>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnResultRecordPopup('${item.historySeq}','${item.requestYn}');">${item.resultDt}</td>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnResultRecordPopup('${item.historySeq}','${item.requestYn}');">
							<c:if test="${item.requestYn == 'W'}"><span style="font-weight: bold; color: #53BFEC">대기</span></c:if>
							<c:if test="${item.requestYn == 'Y'}"><span style="font-weight: bold; color: #4C7903">승인</span></c:if>
							<c:if test="${item.requestYn == 'N'}"><span style="font-weight: bold; color: #D9001B;">반려</span></c:if>
							<c:if test="${item.requestYn == 'D'}"><span style="font-weight: bold; color: #D9001B;">취소</span></c:if>
						</td>
		    		</c:when>
		    		<c:otherwise>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}'); return false;">${status.count}</td>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}'); return false;">${item.storeNm}</td>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}'); return false;">${item.resultDt}</td>
		        		<td style="padding: 10px 5px; text-align: center;" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}'); return false;">
							<c:if test="${item.requestYn == 'W'}"><span style="font-weight: bold; color: #53BFEC">대기</span></c:if>
							<c:if test="${item.requestYn == 'Y'}"><span style="font-weight: bold; color: #4C7903">승인</span></c:if>
							<c:if test="${item.requestYn == 'N'}"><span style="font-weight: bold; color: #D9001B;">반려</span></c:if>
							<c:if test="${item.requestYn == 'D'}"><span style="font-weight: bold; color: #D9001B;">취소</span></c:if>
						</td>
		    		</c:otherwise>
	    		</c:choose>
	        	</tr>
		        		</c:forEach>
		        	</c:when>
		        	<c:otherwise>
				        <tr>
				        <c:choose>
				    		<c:when test="${params.pages[0] == 'record'}">
								<td colspan="8">
					        		수정요청이력이 없습니다.
					        	</td>
				    		</c:when>
				    		<c:when test="${params.pages[0] == 'record2'}">
								<td colspan="8">
					        		실적변경이력이 없습니다.
					        	</td>
				    		</c:when>
				    		<c:otherwise>
								<td colspan="8">
					        		수정요청현황이 없습니다.
					        	</td>
				    		</c:otherwise>
				    	</c:choose>
				        </tr>
		        	</c:otherwise>
		        </c:choose>
	        </tbody>
	        <tfoot>
            </tfoot>
	    </table>
	    <!-- 페이징 처리 -->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosPaging.jsp"%>
	    <!-- 페이징 처리 -->
	    <!--팝업시작-->
    	<%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/popup/salesResultRecordPopup.jsp"%>
   		<!--팝업끝-->
    </div>
   
    <!--조회된자료끝-->
    
</body>
</html>