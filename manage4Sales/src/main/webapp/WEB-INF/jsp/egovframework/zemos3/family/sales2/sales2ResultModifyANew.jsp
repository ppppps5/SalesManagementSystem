<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>

	<script type='text/javascript' src='${pageContext.request.contextPath}/engine/mobiscroll/Scripts/mobiscroll-2.13.2.full.min.js'></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/engine/mobiscroll/Content/mobiscroll-2.13.2.full.min.css"/>
	
	<style type="text/css">
		.table-container{
			width:100%;
			/*display: inline-block;*/
			vertical-align: top;
			overflow-x: scroll;
			overflow-y:hidden;
			white-space: nowrap;
			border-collapse: collapse;
			border-spacing: 0;
			-webkit-transform: translateZ(0);
		}
	</style>
	
	<script type="text/javascript">
		//전역변수
		var zemosIdx      = "${params.zemosIdx[0]}";
		var wrkplcIdx	  = "${params.wrkplcIdx[0]}";
		var zemosNm       = "${params.zemosNm[0]}";
		var resultDt      = "${resultDt}";
		var pageNo 		  = "${pageNo}";
		var numOfRows 	  = "${numOfRows}";
		var type 	      = "${params.type[0]}";
		var startDate     = "${params.startDate[0]}";
		var endDate       = "${params.endDate[0]}";
		var pageReloadGbn = "${pageReloadGbn}";
		var userAdminGbn  = "${userAdminGbn}";
		var storeSeq      = "${params.storeSeq[0]}";
		var resultSeq     = "${params.resultSeq[0]}";
		var yyyy = "${params.yyyy[0]}";
		var mm = "${params.mm[0]}";
		var dyyyy = "${params.dyyyy[0]}";
		var dmm = "${params.dmm[0]}";
		var salesabun = "${params.salesabun[0]}";
		var pstoreSeq = "${params.pstoreSeq[0]}";
		var requestYn = "${params.requestYn[0]}";
		var jspGbn = "${params.jspGbn[0]}"; //YN 이면 승인/반려 된 건.
		
		$(document).ready(function () {
			console.log('jspGbn > ' + jspGbn);
			show();
			rejectShowAndHide();
		});
		
		function rejectShowAndHide(){
			if($("#requestYnB option:selected").val()=="Y"){
				$("#rejectDiv").hide();
				return;
			}else if($("#requestYnB option:selected").val()=="N"){
				$("#rejectDiv").show();
				return;
			}
		}
		
		// 오늘 날짜를 보여주는 함수
		function show(){
			//년도 월 일 요일
			var str = "";
			var year = resultDt.substring(0,4); // 0은 시작 index입니다 4는 마지막 index입니다.
			var month = resultDt.substring(5,7);
			var day = resultDt.substring(8,10);
			resultDt = replaceAll(resultDt, ".", "-");
			str += year + "년 ";
			str += month + "월 ";
			str += day + "일 ";
			str += week(resultDt) + "요일 ";
			
			$("#spanToday").text(str);
			$("#modifyDt").val(resultDt);
		}
		
		function replaceAll(str, searchStr, replaceStr) {
		   return str.split(searchStr).join(replaceStr);
		}
		
		function week(yyyyMmDd) {
			var week = ['일', '월', '화', '수', '목', '금', '토'];
			var dayOfWeek = week[new Date(yyyyMmDd).getDay()];
			return dayOfWeek;
		}
		
		function fnResultModifySave() {
			var url = "";
			var trRow = '${fn:length(resultDetailList)}';
			//$("#trRow").val(trRow);
			
			
			$("#wrkplcIdx").val(wrkplcIdx);
			
			if($("#requestYnB option:selected").val()=="N"){
				if ($('#rejectDesc').val().length < 5) {
					alert("반려가 있을 시 반려사유는 필수입니다. 5자 이상 입력하세요."); 
					return; 
				} 
			}
			
				

			url = "/zemos3/family/sales2/salesResultModifySaveOkAndReject.do";
			
			fn_loading_show();
			
			$.ajax({
				url 		: gvContextPath + url,
				type		: 'POST',
			    dataType 	: 'json',
			    data		: $("#zemosForm").serialize()
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("승인/반려 처리가 완료되었습니다.");
					fn_back2();
				} else if ( response.result === "R" ) {
					alert("이미 수정처리 되었습니다.");
					fn_back2();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
			
		}
		
		function fnFile() {
			var imgDiv = "#imgDiv";
			if ($(imgDiv).css("display") == "block") {
				$(imgDiv).slideUp("slow");
			} else if ($(imgDiv).css("display") == "none") {
				$(imgDiv).slideDown("slow");
			}
		}
		
		function fn_sales_file_download (imageIdxEnc) {
			var params = {};
			params.idxVal = imageIdxEnc;
		
			//<a href="#" onclick="javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=${item.imageIdxEnc}'); return false;">
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales/salesFileCheck.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					//fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal='+imageIdxEnc); //local
					fn_mobile_download('https://m.zemos.co.kr/com/file/download.do?idxVal='+imageIdxEnc); //운영
				} else {
					alert("첨부파일이 없습니다.");
					return;
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fnListSearch() {
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales/salesResultModifySaveOkAndReject.do";
			url += "?zemosIdx="	     + zemosIdx;
			url += "&wrkplcIdx="	+ wrkplcIdx;
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&type="	         + type;
			url += "&startDate="     + startDate;
			url += "&endDate="       + endDate;
			url += "&userAdminGbn="  + userAdminGbn;
			url += "&storeSeq="      + storeSeq;	
			url += "&resultSeq="     + resultSeq;
			url += "&resultDt="      + resultDt;
			url += "&requestYnSearch=" + $("#requestYnSearch option:selected").val();	
			url += "&yyyy="      + yyyy;
			url += "&mm="      + mm;
			url += "&dyyyy=" + dyyyy;
			url += "&dmm=" + dmm;
			url += "&salesabun=" + salesabun;
			
			fn_location_href(url);
		}
		
		function fn_back2() {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&pageNo="+pageNo+"&numOfRows="+numOfRows+"&type="+type+"&startDate="+startDate+"&endDate="+endDate+"&userAdminGbn="+userAdminGbn+"&wrkplcIdx="+wrkplcIdx+"&yyyy="+yyyy+"&mm="+mm+"&dyyyy="+dyyyy+"&dmm="+dmm+"&yyyyMm="+dyyyy+dmm+"&pageReloadGbn2=N"+"&storeSeq="+storeSeq+"&salesabun=" + salesabun+"&userAdminGbn" +userAdminGbn);
		}
		
	</script>
	<style type="text/css">
	.zemos_table1 td {
    border-bottom: 1px solid #e0e1e6;
    font-size: 10px;
    line-height: 20px;
    color: #000000;
    text-align: center;
    padding: 10px 15px;
	}
	</style>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">수정요청관리</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <form id="zemosForm" name="zemosForm" method="post" onsubmit="return false;" class="form-horizontal">
    <input type="hidden" id="modifyDt" name="modifyDt"/>
    <input type="hidden" id="trRow" name="trRow"/>
    <input type="hidden" id="modifyGbn" name="modifyGbn"/>
    <input type="hidden" id="saveGbn" name="saveGbn"/>
    <input type="hidden" id="zemosIdx" name="zemosIdx" value="${params.zemosIdx[0]}"/>
    <input type="hidden" id="userAdminGbn" name="userAdminGbn" value="${userAdminGbn}"/>
    <input type="hidden" id="historySeqM" name="historySeqM" value="${result.historySeq}"/>
    <input type="hidden" id="fileListLength" name="fileListLength" />
	<input type="hidden" id="fileList" name="fileList" />
	<input type="hidden" id="imageIdx" name="imageIdx" />
	<input type="hidden" id="wrkplcIdx" name="wrkplcIdx" />
	<input type="hidden" id="new" name="new" />
    
    <div>
    	<table class="zemos_table1 table-container" style="margin-top:0px;">
	    	<colgroup>
		    	<col width="25%" />
				<col width="25%" />
				<col width="25%" />
				<col width="25%" />
	    	</colgroup>
    		<thead>
	        	<tr style="height:20px; background-color:#eff0f4;">
	        		<th style="padding:5px;">${storeUseName[0].storeUseNm}</th>
	        		<th style="padding:5px;">요청일자</th>
	        		<th style="padding:5px;">실적일자</th>
	        		<th style="padding:5px;">요청자</th>
	        	</tr>
	        </thead>
	       	<tbody>
	       		<tr style="height:20px; padding:4px 4px;">
			     	<td style="text-align:center; padding:4px 4px;">
			     	 ${result.storeNm}
			     	</td>
			     	<td style="text-align:center; padding:4px 4px;">
			     		${result.regDttm}
			     	</td>
			     	<td style="text-align:center; padding:4px 4px;">
			     		${result.modifyDt}
			     	</td>
			     	<td style="text-align:center; padding:4px 4px;">
			     		${result.requestName}
			     	</td>
		    	</tr>
	       	</tbody>
    	</table>
    </div>
    
    <!-- 관리자 -->
    <c:if test="${not empty result.idx}">
    <div id="imgDiv" class="zemos_form2" style="display:none;" onclick="fn_sales_file_download('${item.imageIdxEnc}'); return false;">
		<img style="max-width: 100%;" src="${pageContext.request.contextPath}/com/file/download.do?idxVal=${result.imageIdxEnc}">
	</div>
	</c:if>
	
    <!-- 품목 -->
    <div class="zemos_label_search2">
        <span style="width:70%;padding:10px 0px;">
        	조회<span class="zemos_label_data_grey2">${fn:length(resultDetailList)}</span>건
        </span>
        
    </div>
    
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table id="resultTable" class="zemos_table1 table-container" style="margin-top:0px;">
    		<colgroup>
		        <col width="10%" />
		        <col width="20%" />
		        <col width="20%" />
		        <col width="10%" />
		        <col width="20%" />
		        <col width="20%" />
		        <!-- <col width="20%" /> -->
	        </colgroup>
	        <thead>
	        	<tr style="height:50px; background-color:#eff0f4;">
	        		<th style="padding:5px;">${itemNm[0].itemUseNm}</th>
	        		<th style="padding:5px;">온/오프</th>
	        		<th style="padding:5px;">기준단위</th>
	        		<th style="padding:5px;">수량/실적</th>
	        		<th style="padding:5px;">기존</th>
	        		<th style="padding:5px;">수정</th>
	        		<!-- <th style="padding:5px;">승인/반려</th> -->
	        	</tr>
	        </thead>
	        <tbody>
	        <c:choose>
	        	<c:when test="${fn:length(resultDetailList) > 0}">
	        		<c:set var="requestYnBtn" value="Y" />
	        		<c:forEach items="${resultDetailList}" var="item" varStatus="status">
		        <tr style="height:50px; padding:4px 4px;" class="requestYnClass_${item.requestYn}">
		        	<td style="text-align:center; padding:4px 4px;">
						${item.itemNm}
						<input type="hidden" id="itemNm${status.count-1}" name="itemNm" value="${item.itemNm}"/>
						<input type="hidden" id="itemSeq${status.count-1}" name="itemSeq" value="${item.itemSeq}"/>
						<input type="hidden" id="zemosIdx${status.count-1}" name="zemosIdx" value="${item.zemosIdx}"/>
						<input type="hidden" id="storeSeq${status.count-1}" name="storeSeq" value="${item.storeSeq}"/>
						<input type="hidden" id="resultSeq${status.count-1}" name="resultSeq" value="${item.resultSeq}"/>
						<input type="hidden" id="resultDetailSeq${status.count-1}" name="resultDetailSeq" value="${item.resultDetailSeq}"/>
						<input type="hidden" id="requestYn${status.count-1}" name="requestYn" value="${item.requestYn}"/>
						<input type="hidden" id="historySeq${status.count-1}" name="historySeq" value="${item.historySeq}"/>
						<input type="hidden" id="resultChangeSeq${status.count-1}" name="resultChangeSeq" value="${item.resultChangeSeq}"/>
						
						<c:if test="${item.detailHistorySeq != null}">
						<input type="hidden" id="detailHistorySeq${status.count-1}" name="detailHistorySeq" value="${item.detailHistorySeq}"/>
						</c:if>
						<c:if test="${item.requestYn == null || item.requestYn eq '' || item.requestYn eq 'W'}">
						<input type="hidden" id="requestYnA${status.count-1}" name="requestYnA" value="${item.requestYn}"/>
						</c:if>
					</td>
					<td>
						<c:if test="${item.onOffYn == '0'}">오프라인</c:if>
						<c:if test="${item.onOffYn == '1'}">온라인</c:if>
					</td>
					<td>
						<c:out value="${item.unitNm}"/> 
					</td>
					<td>
						<span style="width:100%;">
							<span style="width:100%; float:left;">수량</span>
						</span>
						<br/>
						<span style="width:100%; display:inline-block; margin-top:15px;">
							<span style="width:100%; float:left;">실적</span>
						</span>
					</td>
					<td style="text-align:center; padding:4px 4px;">
						<span style="width:100%;">
							<!-- <span style="width:20%; float:left;">수량</span> -->
							<span style="width:100%; float:right; text-align:right;">${item.resultQty}</span>
							<input type="hidden" id="resultQty${status.count-1}" name="resultQty" value="${item.resultQty}"/>
						</span>
						<br/>
						<span style="width:100%; display:inline-block; margin-top:15px;">
							<!-- <span style="width:20%; float:left;">실적</span> -->
							<span style="width:100%; float:right; text-align:right;">${item.resultAmt}</span>
							<input type="hidden" id="resultAmt${status.count-1}" name="resultAmt" value="${item.resultAmt}"/>
						</span>
					</td>
					<!-- 변경 수량실적 입력 -->
					<td style="text-align:right;">
						<span style="width:100%;">
							${item.changeQty}
						</span>
						<br/>
						<span style="width:100%; display:inline-block; margin-top:15px;">
							${item.changeAmt}
						</span>
					</td>
					<!-- 변경 수량실적 입력 -->
					
					<!--
					<c:if test="${(status.count-1) eq 0}">
					<td style="text-align:center; padding:4px 4px;" rowspan="${fn:length(resultDetailList)}">
						<c:if test="${item.requestYn == null || item.requestYn eq '' || item.requestYn eq 'W'}">
						<select id="requestYnB" name="requestYnB" class="zemos_select1" style="width:100%" onchange="javascript:fnRequestYnB(this.value);">
							<option value="Y" <c:if test="${item.requestYn eq 'Y'}">selected</c:if>>승인</option>
							<option value="N" <c:if test="${item.requestYn eq 'N'}">selected</c:if>>반려</option>
						</select>
						</c:if>
						<c:if test="${item.requestYn eq 'Y' || item.requestYn eq 'N'}">
							<c:if test="${item.requestYn eq 'Y'}">승인</c:if>
							<c:if test="${item.requestYn eq 'N'}">반려</c:if>
						</c:if>
					</td> 
					</c:if>
					-->
		        </tr>
		        	</c:forEach>
		        </c:when>
		        <c:otherwise>
		        </c:otherwise>
		    </c:choose>
	        </tbody>
    	</table>
    </div>
    <!-- 품목 -->
    
	<div style="width:100%; margin-top:30px;">
    	<table style="width: 100%; margin-top:20px;">
    		<colgroup>
		        <col width="20%" />
		        <col width="80%" /> 
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td style="text-align:center; height:30px; font-size:13px;">
	        			수정사유
	        		</td>
	        		<td style=" font-size:13px;">
	        			<textarea id="description" name="description" rows="5" style="width:90%; padding:3;" maxlength="1000" disabled="disabled">${result.description}</textarea>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
    
    <div style="width:100%; margin-top:20px;">
    	<table style="width: 100%; margin-top:20px;">
    		<colgroup>
		        <col width="20%" />
		        <col width="80%" /> 
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td style="text-align:center; height:30px; font-size:13px;">
	        			승인/반려
	        		</td>
	        		<td style=" font-size:13px;">
	        			<select id="requestYnB" name="requestYnB" class="zemos_select1" style="width:90%; padding:3;" onchange="javascript:rejectShowAndHide();">
							<option value="Y" <c:if test="${item.requestYn eq 'Y'}">selected</c:if>>승인</option>
							<option value="N" <c:if test="${item.requestYn eq 'N'}">selected</c:if>>반려</option>
						</select>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
    
    <div style="width:100%;" id="rejectDiv">
    	<table style="width: 100%; margin-top:20px;">
    		<colgroup>
		        <col width="20%" />
		        <col width="80%" />
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td style="text-align:center; height:30px; font-size:13px;">
	        			반려사유
	        		</td>
	        		<td style=" font-size:13px;">
	        			<textarea id="rejectDesc" name="rejectDesc" rows="5" style="width:90%; padding:3;" maxlength="1000">${result.rejectDesc}</textarea>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
	</form>
   
	<div style="width:100%;margin-top:10px;">
		<span class="mb5" style="width:100%; height:29px; text-align:left; position:absolute; left:5%; width:100%;">
			<a href="javascript:void(0);" onclick="javascript:fnResultModifySave(); return false;" class="zemos_form_span_btn_blue" style="width:90%;">
				<span style="font-size:15px;">저 장</span>
			</a>
		</span>
	</div>    
	
</body>
</html>