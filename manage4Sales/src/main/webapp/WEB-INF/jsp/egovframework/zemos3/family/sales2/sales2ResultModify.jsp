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
			console.log('requestYn > ' + requestYn);
			console.log('resultDt > ' + resultDt);
			show();
			fnRequestYnB('Y');
			/*
			//zemos_input1
			//숫자만
	        $(".zemos_input1").keyup(function(event){
	            var str;
	            if(event.keyCode != 8){
	                if (!(event.keyCode >=37 && event.keyCode<=40)) {
	                    var inputVal = $(this).val();
	                    str = inputVal.replace(/[^-0-9]/gi,'');
	                    if(str.lastIndexOf("-")>0){ //중간에 -가 있다면 replace
	                        if(str.indexOf("-")==0){ //음수라면 replace 후 - 붙여준다.
	                            str = "-"+str.replace(/[-]/gi,'');
	                        }else{
	                            str = str.replace(/[-]/gi,'');
	                        }
	                    }
	                    $(this).val(str);
	                }                    
	            }
	        });
			*/
		});
		
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
			
			console.log('str > ' + str);
			
			$("#spanToday").text(str);
			$("#modifyDt").val(resultDt);
		}
		
		function replaceAll(str, searchStr, replaceStr) {
		   return str.split(searchStr).join(replaceStr);
		}
		
		function week(yyyyMmDd) {
			console.log('week yyyyMmDd > ' + yyyyMmDd);
			console.log('new Date(2021-08-25).getDay() > ' + new Date("2021-08-25").getDay());
			var week = ['일', '월', '화', '수', '목', '금', '토'];
			var dayOfWeek = week[new Date(yyyyMmDd).getDay()];
			console.log('week dayOfWeek > ' + dayOfWeek);
			return dayOfWeek;
		}
		
		function fnResultModifySave(gbn, newGbn) {
			var url = "";
			var trRow = '${fn:length(resultDetailList)}';
			//$("#trRow").val(trRow);
			
			if ( newGbn == 'N' && jspGbn == 'YN' ) {
				$("#new").val('YN');
			}
			
			$("#modifyGbn").val(gbn);
			$("#wrkplcIdx").val(wrkplcIdx);
			
			if ( $('input[name="detailHistorySeq"]').length > 0 ) {
				$("#saveGbn").val("update");
			} else {
				$("#saveGbn").val("insert");	
			}
			
			if ( userAdminGbn == "U" ) {
				//var k = 1;
				var k = 0;
				var i = 0;
				var f = 0;
				for ( i = 0; i < $("#resultTable > tbody > tr").length; i++ ) {
					if ( $("#changeQty"+i).val() == null || $("#changeQty"+i).val() ==  "" ) {
						alert($("#itemNm"+i).val() + " 품목의 수량을 입력하세요.");
						$("#changeQty"+i).focus();
						return;
					} else if ( $("#changeAmt"+i).val() == null || $("#changeAmt"+i).val() ==  "" ) {
						alert($("#itemNm"+i).val() + " 품목의 금액을 입력하세요.");
						$("#changeAmt"+i).focus();
						return;
					}
				}
			}

			url = "/zemos3/family/sales2/sales2ResultModifySave.do";
			
			fn_loading_show();
			
			$.ajax({
				url 		: gvContextPath + url,
				type		: 'POST',
			    dataType 	: 'json',
			    data		: $("#zemosForm").serialize()
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("수정요청이 완료되었습니다.");
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
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales/salesResultModify.do";
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
		
		function fnRequestYnB(val) {
			for ( i = 0; i < $("#resultTable > tbody > tr").length; i++ ) {
				$("#requestYnA"+i).val(val);
			}
		}
		
		function fn_back2() {
			if ( userAdminGbn == "A" ) {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdmin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&pageNo="+pageNo+"&numOfRows="+numOfRows+"&type="+type+"&startDate="+startDate+"&endDate="+endDate+"&userAdminGbn="+userAdminGbn+"&wrkplcIdx="+wrkplcIdx+"&yyyy="+yyyy+"&mm="+mm+"&dyyyy="+dyyyy+"&dmm="+dmm+"&yyyyMm="+dyyyy+dmm+"&pageReloadGbn2=N"+"&storeSeq="+storeSeq+"&salesabun=" + salesabun);
			} else {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2MyResult.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn="+userAdminGbn+"&resultSeq="+resultSeq+"&resultDt="+resultDt+"&wrkplcIdx="+wrkplcIdx+"&yyyy="+yyyy+"&mm="+mm+"&dyyyy="+dyyyy+"&dmm="+dmm+"&yyyyMm="+dyyyy+dmm+"&pageReloadGbn2=N"+"&storeSeq="+storeSeq+"&salesabun=" + salesabun);	
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
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">수정요청</span>
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
    	<table style="margin-top: 0px; width: 100%; margin-top: 5px;">
    		<colgroup>
		        <col width="50%" />
		        <col width="50%" />
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td colspan="2" style="text-align:center; height:30px;">
	        			<span id="spanToday" style="margin-left: auto; margin-right: auto; padding:7px 10px; text-align:center; font-size:17px; font-weight:800;"></span>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
	
    <!-- 품목 -->
    <div class="zemos_label_search2">
        <span style="width:49%;padding:10px 0px;">
        	조회<span class="zemos_label_data_grey2">${fn:length(resultDetailList)}</span>건
        </span>
        <span style="width:49%; text-align:right;">
        	<select id="requestYnSearch" name="requestYnSearch" class="zemos_select1" style="width:100%" onchange="javascript:fnListSearch(this);">
	   			<option value=""  <c:if test="${params.requestYnSearch[0] eq null}">selected</c:if>>전체</option>
        		<option value="W" <c:if test="${params.requestYnSearch[0] eq 'W'}">selected</c:if>>대기</option>
        		<option value="Y" <c:if test="${params.requestYnSearch[0] eq 'Y'}">selected</c:if>>승인</option>
        		<option value="N" <c:if test="${params.requestYnSearch[0] eq 'N'}">selected</c:if>>반려</option>
			</select>
        </span>
    </div>
    
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table id="resultTable" class="zemos_table1 table-container" style="margin-top:0px;">
    		<colgroup>
		        <col width="30%" />
		        <col width="10%" />
		        <col width="30%" />
		        <col width="30%" />
	        </colgroup>
	        <thead>
	        	<tr style="height:50px; background-color:#eff0f4;">
	        		<th style="padding:5px;">품목</th>
	        		<th style="padding:5px;">수량/실적</th>
	        		<th style="padding:5px;">기존</th>
	        		<th style="padding:5px;">수정</th>
	        	</tr>
	        </thead>
	        <tbody>
	        <c:choose>
	        	<c:when test="${fn:length(resultDetailList) > 0}">
	        		<c:set var="descriptionYn" value="Y" />
	        		<c:set var="newGbn" value="Y" />
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
						<c:if test="${item.detailHistorySeq != null}">
						<input type="hidden" id="detailHistorySeq${status.count-1}" name="detailHistorySeq" value="${item.detailHistorySeq}"/>
						</c:if>
						<c:if test="${item.requestYn == null || item.requestYn eq '' || item.requestYn eq 'W'}">
						<input type="hidden" id="requestYnA${status.count-1}" name="requestYnA" value="${item.requestYn}"/>
						</c:if>
						<input type="hidden" id="resultChangeSeq${status.count-1}" name="resultChangeSeq" value="${item.resultChangeSeq}"/>
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
							<span style="width:100%; float:right; text-align:right;">
								${item.qty}
							</span>
							<input type="hidden" id="resultQty${status.count-1}" name="resultQty" value="${item.qty}"/>
						</span>
						<br/>
						<span style="width:100%; display:inline-block; margin-top:15px;">
							<!-- <span style="width:20%; float:left;">실적</span> -->
							<span style="width:100%; float:right; text-align:right;">
								${item.amt}
							</span>
							<input type="hidden" id="resultAmt${status.count-1}" name="resultAmt" value="${item.amt}"/>
						</span>
					</td>
					<!-- 변경 수량실적 입력 -->
					<td style="text-align:right;">
						<span style="width:100%;">
							<input type="text" id="changeQty${status.count-1}" name="changeQty" value="${item.changeQty}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
							<!--
							<c:choose>
								<c:when test="${item.rRequestYn eq 'W' && (item.hRequestYn == null || item.hRequestYn eq '')}">
									<input type="text" id="changeQty${status.count-1}" name="changeQty" value="${item.qty}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:when test="${item.rRequestYn eq 'W' && item.hRequestYn eq 'W'}">
									<input type="text" id="changeQty${status.count-1}" name="changeQty" value="${item.changeQty}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:when test="${(item.rRequestYn eq 'Y' || item.rRequestYn eq 'N') && (item.hRequestYn eq 'Y' || item.hRequestYn eq 'N')}">
									<c:set var="descriptionYn" value="N" />
									<c:set var="newGbn" value="N" />
									<input type="text" id="changeQty${status.count-1}" name="changeQty" value="${item.qty}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:when test="${(item.rRequestYn eq 'Y' || item.rRequestYn eq 'N') && (item.hRequestYn eq 'W')}">
									<c:set var="descriptionYn" value="Y" />
									<c:set var="newGbn" value="Y" />
									<input type="text" id="changeQty${status.count-1}" name="changeQty" value="${item.changeQty}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							-->
						</span>
						<br/>
						<span style="width:100%; display:inline-block; margin-top:5px;">
							<input type="text" id="changeAmt${status.count-1}" name="changeAmt" value="${item.changeAmt}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
							<!--
							<c:choose>
								<c:when test="${item.rRequestYn eq 'W' && (item.hRequestYn == null || item.hRequestYn eq '')}">
									<input type="text" id="changeAmt${status.count-1}" name="changeAmt" value="${item.amt}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:when test="${item.rRequestYn eq 'W' && item.hRequestYn eq 'W'}">
									<input type="text" id="changeAmt${status.count-1}" name="changeAmt" value="${item.changeAmt}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:when test="${(item.rRequestYn eq 'Y' || item.rRequestYn eq 'N') && (item.hRequestYn eq 'Y' || item.hRequestYn eq 'N')}">
									<input type="text" id="changeAmt${status.count-1}" name="changeAmt" value="${item.amt}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								
								<c:when test="${(item.rRequestYn eq 'Y' || item.rRequestYn eq 'N') && (item.hRequestYn eq 'W')}">
									<input type="text" id="changeAmt${status.count-1}" name="changeAmt" value="${item.changeAmt}" pattern="[0-9]*" inputmode="numeric" style="width:100%; text-align:right;" class="zemos_input1" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="10"/>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							-->
						</span>
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
					<c:if test="${descriptionYn eq 'N'}">
						<textarea id="description" name="description" rows="5" style="width:90%; padding:3;" maxlength="1000"></textarea>
					</c:if>
	        		<c:if test="${descriptionYn eq 'Y'}">
						<textarea id="description" name="description" rows="5" style="width:90%; padding:3;" maxlength="1000">${result.description}</textarea>
					</c:if>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
	</form>
   
	<div style="width:100%;margin-top:10px;">
    	<span class="mb5" style="width:100%; height:29px; text-align:left; position:absolute; left:5%; width:100%;">
			<a href="javascript:void(0);" onclick="javascript:fnResultModifySave('U','${newGbn}'); return false;" class="zemos_form_span_btn_blue" style="width:90%;">
				<span style="font-size:15px;">저 장</span>
			</a>
		</span>
	</div>    
	
</body>
</html>