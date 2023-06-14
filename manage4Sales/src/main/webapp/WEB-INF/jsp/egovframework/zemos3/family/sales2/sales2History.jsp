<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	<!-- selectbox 검색기능 css -->
  	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/zemos3/selectbox.css"/>
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/engine/mobiscroll/Scripts/mobiscroll-2.13.2.full.min.js'></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/engine/mobiscroll/Content/mobiscroll-2.13.2.full.min.css"/>
	
	<style type="text/css">
		.table-container{
			width:100%;
			/* display: inline-block; */
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
		//전역변수
		var zemosIdx 	= "${params.zemosIdx[0]}";
		var salesabun = "${params.salesabun[0]}";
		var wrkplcIdx   = "${params.wrkplcIdx[0]}";
		var zemosNm 	= "${params.zemosNm[0]}";
		var pageNo 		= "${pageNo}";
		var numOfRows 	= "${numOfRows}";
		var type 	    = "${params.type[0]}";
		var startDate   = "${params.startDate[0]}";
		var endDate     = "${params.endDate[0]}";
		var pageReloadGbn = "${pageReloadGbn}";
		var userAdminGbn = "${userAdminGbn}";
		var storeSeq = "${storeSeq}";
		var yyyy = "${params.yyyy[0]}";
		var mm = "${params.mm[0]}";
		
		$(document).ready(function () {
			  $("#storeSeq").select2(); //storeSeq는 selectbox id
			  $(".select2-selection__arrow").hide();
			//출근일시 시간
			$('#startDate').mobiscroll().date({
		        theme: 'android-holo-light',
		        display: 'modal',
		        mode: 'scroller',
		        dateOrder: 'yy mm dd',
		        dateFormat : "yy-mm-dd",
		        maxDate: new Date(2099, 11, 31) // 2099-12-31 까지
		    });
			
			//퇴근일시 시간
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
		    var day  	= now.getDate() > 9 ? '' + now.getDate() : '0' + now.getDate();
		    var current = year + mon + day;
		    
		    if ( startDate == null || startDate == "" ) {
		    	$('#startDate').val(year + '-' + mon + '-' + day);
				$('#startDate').mobiscroll("setDate", new Date(year + '-' + mon + '-' + day));	
		    }
		    
		    if ( endDate == null || endDate == "" ) {
				$('#endDate').val(year + '-' + mon + '-' + day);
				$('#endDate').mobiscroll("setDate", new Date(year + '-' + mon + '-' + day));
		    }
		    
		    if ( pageReloadGbn == "N" ) {
		    	fn_reload('select');
		    }
		    
		    if ( userAdminGbn == "U" ) {
		    	$("#pageName").text("수정요청이력");
		    } else {
		    	$("#pageName").text("실적변경이력조회");
		    }
		    
		});
		
		//조회
		function fn_reload(type, value1, value2) {
			var startDate     = $("#startDate").val();
			var endDate       = $("#endDate").val();
			var selectText    = $("#selectText").val();
			
			//-을 구분자로 연,월,일로 잘라내어 배열로 반환
			var startArray = startDate.split('-');
			var endArray = endDate.split('-');
			
			//배열에 담겨있는 연,월,일을 사용해서 Date 객체 생성
			var start_date = new Date(startArray[0], startArray[1], startArray[2]);
			var end_date = new Date(endArray[0], endArray[1], endArray[2]);
			
			//날짜를 숫자형태의 날짜 정보로 변환하여 비교한다.
			if(start_date.getTime() > end_date.getTime()) {
			    alert("종료날짜보다 시작날짜가 작아야합니다.");
			    return false;
			}
			
			if ( type == "pageNo" ) {
				pageNo = value1;
			}
			
			if ( type == "select" ) {
				pageNo = 1;
			}
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&type="	         + type;
			url += "&zemosIdx="	     + zemosIdx;
			url += "&salesabun=" + salesabun;
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&userAdminGbn="  + userAdminGbn;
			url += "&storeSeq="		 + $("#storeSeq option:selected").val();
			url += "&startDate="     + startDate;
			url += "&endDate="       + endDate;
			url += "&wrkplcIdx="	 + wrkplcIdx;
			url += "&yyyy="+yyyy;
			url += "&mm="+mm;
			
			fn_location_href(url);
		}
		
		function fnRequestCancel(itemSeq, resultSeq, resultDetailSeq, storeSeq, historySeq, detailHistorySeq) {
			var params = {};
			params.zemosIdx = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			params.itemSeq = itemSeq;
			params.resultSeq = resultSeq;
			params.resultDetailSeq = resultDetailSeq;
			params.storeSeq = storeSeq;
			params.historySeq = historySeq;
			params.detailHistorySeq = detailHistorySeq;
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales/salesRequestCancel.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("수정요청이 취소되었습니다.");
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fnExcel(gbn) {
			var startDate  = $("#startDate").val();
			var endDate    = $("#endDate").val();
			var excelGubun = gbn;
			
			//var vUrl = "${common.fullContext}/zemos3/family/sales2/sales2PresentExcelDown.do";
			var vUrl = "https://m.zemos.co.kr/zemos3/family/sales2/sales2PresentExcelDown.do";
			//vUrl += "?pageNo="	      + pageNo;
			//vUrl += "&numOfRows="	  + numOfRows;
			//vUrl += "&zemosIdx="	  + zemosIdx;
			//vUrl += "&salesabun=" + salesabun;
			//vUrl += "&zemosNm="	      + encodeURIComponent(zemosNm);
			//vUrl += "&startDate="     + startDate;
			//vUrl += "&endDate="       + endDate;
			//vUrl += "&excelGubun="	  + excelGubun;
			//vUrl += "&storeSeq=" + $("#storeSeq option:selected").val();	
			//vUrl += "&yyyy="+yyyy;
			//vUrl += "&mm="+mm;
			
			vUrl += "?pageNo="	     + pageNo;
			vUrl += "&numOfRows="	 + numOfRows;
			vUrl += "&type="	         + type;
			vUrl += "&zemosIdx="	     + zemosIdx;
			vUrl += "&salesabun=" + salesabun;
			vUrl += "&zemosNm="	     + encodeURIComponent(zemosNm);
			vUrl += "&userAdminGbn="  + userAdminGbn;
			vUrl += "&storeSeq="		 + $("#storeSeq option:selected").val();
			vUrl += "&startDate="     + startDate;
			vUrl += "&endDate="       + endDate;
			vUrl += "&wrkplcIdx="	 + wrkplcIdx;
			vUrl += "&excelGubun="	  + excelGubun;
			vUrl += "&yyyy="+yyyy;
			vUrl += "&mm="+mm;
			
			
			
			fn_mobile_download(vUrl);
		}
		
		function fnMessage(rejectDesc) {
			if ( rejectDesc == null || rejectDesc == '' ) {
				alert('반려사유가 없습니다.');
			} else {
				alert(rejectDesc);	
			}
			return;
		}
		
		function fn_sales_file_download (imageIdxEnc) {
			var params = {};
			params.idxVal = imageIdxEnc;
		
			//<a href="#" onclick="javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=${item.imageIdxEnc}'); return false;">
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2FileCheck.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					fn_mobile_download('https://m.zemos.co.kr/com/file/download.do?idxVal='+imageIdxEnc); //운영
					//fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal='+imageIdxEnc); //local
				} else {
					alert("첨부파일이 없습니다.");
					return;
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			if ( userAdminGbn == 'U' ) {
				<c:if test="${loginVO.zemosAuth == '12000' || userAdminGbn eq 'A'}">
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn="+userAdminGbn+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm);
				</c:if>
				<c:if test="${loginVO.zemosAuth == '11000' && userAdminGbn eq 'U'}">
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx="+zemosIdx+"&salesabun="+salesabun+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn="+userAdminGbn+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm);
				</c:if>
			} else {
// 				fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSales2Admin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&userAdminGbn="+userAdminGbn+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm);
				fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx);
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
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;" id="pageName"></span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    
    <!--조회조건시작-->
    <div class="zemos_label_search1">
		<span class="fl mb5" style="width:100%; padding-right:12%;">
			<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%">
				<option value="">매장전체</option>
	   			<c:forEach items="${storeList}" var="item" varStatus="status">
	   			<option value="${item.storeSeq}" <c:if test="${item.storeSeq eq storeSeq}">selected</c:if>>${item.storeNm}</option>
	   			</c:forEach>
			</select>
		</span>
		<span class="fr mb5" style="position:absolute; right:5%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
	</div>
	<div class="zemos_label_search1">
		<div style="width:13%;">
			<span class="fl mb5" style="width:100%; padding-top:18%;">
				시작일
			</span>
		</div>
		<div style="width:27%; float: left;">
			<input id="startDate" name="startDate" type="text" class="zemos_input1" style="width:100%; font-size:10px;" value="${params.startDate[0]}"/>
		</div>
		<div style="width:13%; float: left;">
			<span class="fl mb5" style="width:100%; padding-top:18%;">
				종료일
			</span>
		</div>
		<div style="width:27%; float: left;">
			<input id="endDate" name="endDate" type="text" class="zemos_input1" style="width:100%; font-size:10px;" value="${params.endDate[0]}"/>
		</div>
		<div style="width:20%; float: left; text-align: center;">
			<span class="fr mb5" style="position:absolute; right:5%; width:15%;">
				<a href="javascript:void(0);" onclick="javascript:fnExcel('H'); return false;" class="zemos_form_span_btn_blue">
					<span style="font-size:10px;">엑셀</span>
				</a>
			</span>
		</div>
	</div>
	<!--조회조건끝-->
    
    
    
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <p class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${salesHistoryCnt.cnt}</span>건
        </p>
    </div>
    <!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
	    <table class="zemos_table1 table-container" style="margin-top: 0px;">
    		<colgroup>
    			<col width="8%" />
    			<col width="14%" />
		        <col width="14%" />
				<col width="10%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="8%" />
				<col width="20%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding: 5px;">순번</th>
	        		<th style="padding: 5px;">매장명</th>
	        		<th style="padding: 5px;">품목</th>
	        		<th style="padding: 5px;">일자</th>
	        		<th style="padding: 5px;">금액</th>
	        		<th style="padding: 5px;">수량</th>
	        		<th style="padding: 5px;">변경금액</th>
	        		<th style="padding: 5px;">변경수량</th>
	        		<th style="padding: 5px;">첨부</th>
	        		<th style="padding: 5px;">결과</th>
	        		<th style="padding: 5px;">요청취소</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(salesHistory) > 0}">
		        	<c:set var="totSumResultAmt" value="0"/>
                    <c:set var="totSumResultQty" value="0"/>
                    <c:set var="totSumChangeAmt" value="0"/>
                    <c:set var="totSumChangeQty" value="0"/>
		        		<c:forEach items="${salesHistory}" var="item" varStatus="status">
		        		
		        <tr>
	        		<td style="padding: 10px 5px; text-align: center;">${status.count}</td>
	        		<td style="padding: 10px 5px; text-align: center;">${item.storeNm}</td>
	        		<td style="padding: 10px 5px; text-align: center;">${item.itemNm}</td>
	        		<td style="padding: 10px 5px; text-align: center;">${item.modifyDt}</td>
	        		<td style="padding: 10px 5px; text-align: right;">
	        			${item.resultAmt}원
	        			<c:set var="totSumResultAmt" value="${fn:replace(totSumResultAmt, ',', '') + fn:replace(item.resultAmt, ',', '')}"/>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: right;">
	        			${item.resultQty}
	        			<c:set var="totSumResultQty" value="${fn:replace(totSumResultQty, ',', '') + fn:replace(item.resultQty, ',', '')}"/>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: right;">
	        			${item.changeAmt}원
	        			<c:set var="totSumChangeAmt" value="${fn:replace(totSumChangeAmt, ',', '') + fn:replace(item.changeAmt, ',', '')}"/>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: right;">
	        			${item.changeQty}
	        			<c:set var="totSumChangeQty" value="${fn:replace(totSumChangeQty, ',', '') + fn:replace(item.changeQty, ',', '')}"/>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: center;">
	        			<c:if test="${item.idx ne null}">
						<%-- <a href="#" onclick="javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=${item.imageIdxEnc}'); return false;"> --%>
						<a href="#" onclick="javascript:fn_sales_file_download('${item.imageIdxEnc}'); return false;">
						<%-- <a href="#" onclick="javascript:fn_mobile_download('https://m.zemos.co.kr/com/file/download.do?idxVal=${item.imageIdxEnc}'); return false;"> --%>
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/clip.png" width="100%" alt="첨부파일">
						</a>
		        		</c:if>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: center;">
	        			<c:if test="${item.requestYn eq 'W'}">대기</c:if>
	        			<c:if test="${item.requestYn eq 'Y'}">승인</c:if>
	        			<c:if test="${item.requestYn eq 'N'}">
	        				<a href="javascript:fnMessage('${item.rejectDesc}');">
								<span style="color:red;">반려</span>
							</a>
	        			</c:if>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: center;">
	        			<c:if test="${item.requestYn eq 'W'}">
	        			<a href="javascript:void(0);" onclick="javascript:fnRequestCancel('${item.itemSeq}','${item.resultSeq}','${item.resultDetailSeq}','${item.storeSeq}','${item.historySeq}','${item.detailHistorySeq}'); return false;" class="zemos_form_span_btn_blue">
							<span style="font-size:12px;">취소</span>
						</a>
	        			</c:if>
	        		</td>
	        	</tr>
		        		</c:forEach>
		        	</c:when>
		        	<c:otherwise>
		        <tr>
		        	<td colspan="11">
		        		등록된 이력이 없습니다.
		        	</td>
		        </tr>
		        	</c:otherwise>
		        </c:choose>
	        </tbody>
	        <tfoot>
                <tr style="background-color:#CEE3F6; font-weight:bold;">
                	<td></td>
                    <td style="padding: 5px; text-align: center; font-size: 12px;">합계</td>
                    <td></td>
                    <td></td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${salesHistoryCnt.resultAmt}" pattern="#,###" />원</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${salesHistoryCnt.resultQty}" pattern="#,###" /></td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${salesHistoryCnt.changeAmt}" pattern="#,###" />원</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${salesHistoryCnt.changeQty}" pattern="#,###" /></td>
                    <td></td>
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