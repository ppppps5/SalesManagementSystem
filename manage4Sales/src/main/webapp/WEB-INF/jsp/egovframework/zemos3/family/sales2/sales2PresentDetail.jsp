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
			display: inline-block;
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
		var zemosIdx 	= "${params.zemosIdx[0]}";
		var wrkplcIdx   = "${params.wrkplcIdx[0]}";
		var zemosNm 	= "${params.zemosNm[0]}";
		var pageNo 		= "${pageNo}";
		var numOfRows 	= "${numOfRows}";
		var type 		= "${params.type[0]}";
		var startDate   = "${params.startDate[0]}";
		var endDate     = "${params.endDate[0]}";
		var storeSeq	= "${params.storeSeq[0]}";
		var resultSeq	= "${params.resultSeq[0]}";
		var userAdminGbn = "${userAdminGbn}";
		var resultDt     = "${params.resultDt[0]}";
		var yyyy     = "${params.yyyy[0]}";
		var mm     = "${params.mm[0]}";
		var salesabun = "${params.salesabun[0]}";
		var storeSeq = "${params.storeSeq[0]}";
		var unitSeq = "${params.unitSeq[0]}";
		var itemSeq = "${params.itemSeq[0]}";
		var onoffNm = "${params.onoffNm[0]}";
		
		//출퇴근현황
		$(document).ready(function () {
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
		    
		    //if ( pageReloadGbn == "N" ) {
		    //	fn_reload('select');
		    //}
		});
		
		function fn_reload(type, value1, value2) {
			var startDateS = $("#startDate").val();
			var endDateS   = $("#endDate").val();
			
			//-을 구분자로 연,월,일로 잘라내어 배열로 반환
			var startArray = startDateS.split('-');
			var endArray = endDateS.split('-');
			
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
			url += "?zemosIdx="	     + zemosIdx;
			url += "&wrkplcIdx="	 + wrkplcIdx
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&type="	         + type;
			url += "&startDate="     + startDateS;
			url += "&endDate="       + endDateS;
			url += "&userAdminGbn="  + userAdminGbn;
			url += "&yyyy=" + yyyy;
			url += "&mm=" + mm;
			url += "&salesabun=" + salesabun;
			if ( $("#selectText").val() != null || $("#selectText").val() != "" ) {
				url += "&selectText=" + $("#selectText").val();	
			}
// 			url += "&resultSeq="	 + resultSeq;
			
			fn_location_href(url);
		}
		
		function fnPopupSearch(obj) {
			var arr = new Array();
			<c:forEach items="${selectSalesPresentDetail}" var="item">
				arr.push({
					resultSeq : "${item.resultSeq}"
					, resultDetailSeq : "${item.resultDetailSeq}"
					, storeNm : "${item.storeNm}"
					, storeSeq : "${item.storeSeq}"
					, itemSeq : "${item.itemSeq}"
					, resultDt : "${item.resultDt}"
					, amt : "${item.amt}"
					, qty : "${item.qty}"
					, requestYn : "${item.requestYn}"
				});
			</c:forEach>
			
			for ( var i = 0; i < arr.length; i++ ) {
				if ( arr[i].itemSeq == $(obj).val() ) {
					$("#resultSeq").val(arr[i].resultSeq);
					$("#resultDetailSeq").val(arr[i].resultDetailSeq);
					$("#storeNm").val(arr[i].storeNm);
					$("#storeSeq").val(arr[i].storeSeq);
					$("#itemSeq").val(arr[i].itemSeq);
					$("#resultDt").val(arr[i].resultDt);
					$("#resultAmt").val(arr[i].amt);
					$("#resultQty").val(arr[i].qty);
					$("#requestYn").val(arr[i].requestYn);
				}
			}
		}
		
		function fnExcel(gbn) {
			var startDateP  = $("#startDate").val();
			var endDateP    = $("#endDate").val();
			var excelGubunP = gbn;
			
			//-을 구분자로 연,월,일로 잘라내어 배열로 반환
			var startArray = startDateP.split('-');
			var endArray = endDateP.split('-');
			
			//배열에 담겨있는 연,월,일을 사용해서 Date 객체 생성
			var start_date = new Date(startArray[0], startArray[1], startArray[2]);
			var end_date = new Date(endArray[0], endArray[1], endArray[2]);
			
			//날짜를 숫자형태의 날짜 정보로 변환하여 비교한다.
			if(start_date.getTime() > end_date.getTime()) {
			    alert("종료날짜보다 시작날짜가 작아야합니다.");
			    return false;
			}
			
			//var vUrl = "${common.fullContext}/zemos3/family/sales2/sales2PresentExcelDown.do";
			var vUrl = "https://m.zemos.co.kr/zemos3/family/sales2/sales2PresentExcelDown.do";
			vUrl += "?pageNo="	      + pageNo;
			vUrl += "&numOfRows="	  + numOfRows;
			vUrl += "&zemosIdx="	  + zemosIdx;
			vUrl += "&wrkplcIdx="	  + wrkplcIdx
			vUrl += "&zemosNm="	      + encodeURIComponent(zemosNm);
			//vUrl += "&startDate="     + startDateP;
			//vUrl += "&endDate="       + endDateP;
			vUrl += "&resultDt="      + resultDt;
			vUrl += "&excelGubun="	  + excelGubunP;
			vUrl += "&resultSeq="	  + resultSeq;
			vUrl += "&yyyy=" + yyyy;
			vUrl += "&mm=" + mm;
			vUrl += "&salesabun=" + salesabun;
			if ( $("#selectText").val() != null || $("#selectText").val() != "" ) {
				vUrl += "&selectText=" + $("#selectText").val();	
			}
			
			fn_mobile_download(vUrl);
		}
		
		function fnResultModifyPopup(resultSeq, resultDetailSeq, storeNm, itemSeq, resultDt, amt, qty, requestYn, storeSeq) {
			$("#resultSeq").val(resultSeq);
			$("#resultDetailSeq").val(resultDetailSeq);
			$("#storeNm").val(storeNm);
			$("#storeSeq").val(storeSeq);
			$("#itemSeq").val(itemSeq);
			$("#resultDt").val(resultDt);
			$("#resultAmt").val(amt);
			$("#resultQty").val(qty);
			$('#changeAmt').val('');
			$('#changeQty').val('');
			$('#requestYn').val(requestYn);
						
			$("#salesResultModifyPopup").show();
		}
		
		function fnResultModifySave() {
			var url = "";
			url = "/zemos3/family/sales/salesAdminResultModifySave.do";
			
			var changeAmt = $('#changeAmt').val();
			var changeQty = $('#changeQty').val();
			var requestYn = $('#requestYn').val();
			if(changeAmt == "" || changeAmt == null){
				alert("수정할 금액을 입력하세요.");
				return;
			}
			if(changeQty == "" || changeQty == null){
				alert("수정할 수량을 입력하세요.");
				return;
			}
			if(requestYn == "Y"){
				alert("이미 수정된 품목입니다.");
				return;
			} 
			
			$("#zemosIdx").val(zemosIdx);
			$("#wrkplcIdx").val(wrkplcIdx);
			var amt = $("#Amt").val(changeAmt);
			var qty = $("#Qty").val(changeQty);
			
			$.ajax({
				url 		: gvContextPath + url,
				type		: 'POST',
			    dataType 	: 'json',
			    data		: $("#zemosForm").serialize()
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("실적이 수정되었습니다.");
					fn_reload('select');
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fn_back2() {
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2Present.do";
			url += "?zemosIdx="	     + zemosIdx;
			url += "&wrkplcIdx="	 + wrkplcIdx;
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&type="	         + type;
			url += "&startDate="     + startDate;
			url += "&endDate="       + endDate;
			url += "&userAdminGbn="  + userAdminGbn;
// 			url += "&yyyy=" + yyyy;
// 			url += "&mm=" + mm;
			url += "&salesabun="     + salesabun;
			url += "&storeSeq="      + storeSeq;
			url += "&unitSeq="       + unitSeq;
			url += "&itemSeq="       + itemSeq;
			url += "&onoffNm="       + onoffNm;
			
			fn_location_href(url);
		}
		
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">판매관리 현황상세</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
		<span class="zemos_title1_right" style="display: none;">
			<a href="#" onclick="javascript:fn_location_href('${pageContext.request.contextPath}/zemos3/zemos/menu/menuManager2.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/menu01${menu01}.png" alt="홈">
			</a>
		</span>
	</div>
    <!--타이틀끝-->
    
	<form id="zemosForm" name="zemosForm" method="post" onsubmit="return false;" class="form-horizontal">
	<input type="hidden" id="zemosIdx" name="zemosIdx"/>
	<input type="hidden" id="wrkplcIdx" name="wrkplcIdx"/>
    
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <span class="fl" style="width:15%; font-size: 15px; text-align: right; padding:10px 0px;">
       		<b>${selectSalesPresentDetail[0].storeNm}</b>
        </span>
        <span class="fl" style="width:5%; text-align: right; padding:10px 0px;">
        </span>
        <span class="fl" style="width: *; font-size: 15px; padding:10px 0px;">
       		<b>(${selectSalesPresentDetail[0].resultDate} / ${selectSalesPresentDetail[0].onoffNm}라인 / ${selectSalesPresentDetail[0].unitNm})</b>
        </span>
    </div>
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
			<table class="zemos_table1" style="margin-top: 0px;">
				<colgroup>
					<col width="10%" />
					<col width="45%" />
					<col width="10%" />
					<col width="35%" />
				</colgroup>
				<thead>
					<tr>
						<th style="padding: 10px 5px;">번호</th>
						<th style="padding: 10px 5px;">${itemUseName[0].itemUseNm}명</th>
						<th style="padding: 10px 5px;">수량</th>
						<th style="padding: 10px 5px;">금액</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(selectSalesPresentDetail) > 0}">
							<c:forEach items="${selectSalesPresentDetail}" var="item" varStatus="status">
								<tr>

									<td style="padding: 10px 5px; text-align: center;">
										<fmt:formatNumber value="${item.rowNum}" />
									</td>

									<td style="padding: 10px 5px; text-align: center;">
										${item.itemNm}
									</td>

									<td style="padding: 10px 5px; text-align: center;">
										<fmt:formatNumber value="${item.qty}" />
									</td>

									<td style="padding: 10px 5px; text-align: center;">
										<fmt:formatNumber value="${item.amt}" pattern="#,###" />
									</td>

								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">등록된 판매관리 현황이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<!-- 페이징 처리 -->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosPaging.jsp"%>
	    <!-- 페이징 처리 -->
    </div>
    <!--조회된자료끝-->
    </form>
</body>
</html>