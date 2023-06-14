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
		var zemosIdx  = "${params.zemosIdx[0]}";
		var salesabun = "${params.salesabun[0]}";
		var storeSeq = "${params.storeSeq[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		var yyyyMm = "${params.yyyyMm[0]}";
		var pageNo    = "${pageNo}";
		var numOfRows = "${numOfRows}";
		var userAdminGbn = "${userAdminGbn}";
		var storeSeq = "${params.storeSeq[0]}";
		var yyyy = "${params.yyyy[0]}";
		var mm = "${params.mm[0]}";
		var salesabun = "${params.salesabun[0]}";
		
		$(document).ready(function () {
			
		});
		
		//조회
		//gbn이 D이면 매장명 select, I이면 품목 리스트 사용여부
		function fnSearch(type, value1, value2) {
			//alert(yyyyMm);
			if(type == "pageNo") {
				pageNo = value1;
			}
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/salesMy2Result.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&salesabun=" + salesabun;
			url += "&storeSeq=" + storeSeq;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&yyyyMm=" + $("#yyyy").val() + $("#mm").val();
			url += "&pageNo="+pageNo;
			url += "&numOfRows="+numOfRows;
			url += "&userAdminGbn="+userAdminGbn;
			url += "&yyyy="+yyyy;
			url += "&mm="+mm;
			url += "&dyyyy=" + $("#yyyy").val();
			url += "&dmm=" + $("#mm").val();
			url += "&salesabun=" + salesabun;
			
			fn_location_href(url);
		}
		
		function fn_reload(type, value1, value2) {
			if(type == "pageNo") {
				pageNo = value1;
			}
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2MyResult.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&salesabun=" + salesabun;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&yyyyMm=" + $("#yyyy").val() + $("#mm").val(); //화면에서 선택한 년월
			url += "&pageNo="+pageNo;
			url += "&numOfRows="+numOfRows;
			url += "&userAdminGbn="+userAdminGbn;
			url += "&storeSeq="+storeSeq;
			url += "&yyyy="+yyyy; //main화면에서 넘어온 년도
			url += "&mm="+mm; //main화면에서 넘어온 월
			url += "&dyyyy=" + $("#yyyy").val(); //화면에서 선택한 년도
			url += "&dmm=" + $("#mm").val(); //화면에서 선택한 월
			url += "&salesabun=" + salesabun;
			
			fn_location_href(url);
		}
		
		//수정요청
		function fnMyModifyRequest(resultSeq, resultDt, storeSeq, requestYn, cRequestYn) {
			if ( requestYn == 'D' ) {
				alert("삭제요청을한 실적정보는 수정요청을 할 수 없습니다.");
				return;
			}
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2ResultModify.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq=" + storeSeq;
			url += "&resultSeq=" + resultSeq;
			url += "&resultDt=" + resultDt;
			url += "&userAdminGbn=" + userAdminGbn;
			url += "&yyyy="+yyyy;
			url += "&mm="+mm;
			url += "&dyyyy=" + $("#yyyy").val();
			url += "&dmm=" + $("#mm").val();
			url += "&salesabun=" + salesabun;
			url += "&requestYn=" + requestYn;
			url += "&cRequestYn=" + cRequestYn;
			if ( requestYn == 'Y' || requestYn == 'N' ) {
				url += "&jspGbn=YN"; 
			}
			
			fn_location_href(url);
		}
		
		//삭제요청
		function fnDeleteRequest(resultSeq, resultDt, storeSeq, requestYn, cRequestYn) {
			//수정요청을 한 정보는 삭제할수 없음. 메세지 추가해야됨.
			console.log('cRequestYn > ' + cRequestYn);
			
			
			if ( cRequestYn == null || cRequestYn == '' ) {
				if ( requestYn == 'W' || requestYn == '' || requestYn == null ) {
					if ( !fn_confirm("실적등록 정보를 삭제하시겠습니까?") ) {
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
						url 		: gvContextPath + "/zemos3/family/sales2/sales2ResultRequestDelete.do",
						type		: 'POST',
					    dataType 	: 'json',
					    data		: params
					}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
					}).done(function (response) { // 완료
						if ( response.result === true ) {
							alert("삭제요청이 완료되었습니다.");
							fn_reload();
						} else {
							fn_reload();
						}
					}).fail(function (response) { // 실패
					}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
					});
				} else {
					alert("수정요청한 실적등록 정보는 삭제할 수 없습니다.");
					return;
				}
			} else {
				alert("수정요청을 한 실적정보는 삭제할 수 없습니다.");
				return;
			}
		}

		//제모스 판매관리 메뉴이동
		function fn_back2() {
			<c:if test="${loginVO.zemosAuth == '12000'}">
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm+"&salesabun=" + salesabun);
			</c:if>
			<c:if test="${loginVO.zemosAuth == '11000'}">
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx="+zemosIdx+"&salesabun="+salesabun+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm+"&salesabun=" + salesabun);
			</c:if>
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">나의등록현황</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <!--조회조건시작-->
    <div class="zemos_label_search1">
		<div style="width:50%; float: left;">
			<select id="yyyy" class="zemos_select1" style="width:98%" onchange="javascript:fn_reload();">
				<c:forEach items="${yyyyList}" var="item" varStatus="status">
					<option value="${item.yyyy}" <c:if test="${item.yyyy eq yyyy || item.yyyy eq params.dyyyy[0]}">selected="selected"</c:if> >${item.yyyy}</option>
				</c:forEach>
			</select>
		</div>
		<div style="width:50%; float: left;">
			<select id="mm" class="zemos_select1" class="zemos_select1" style="width:98%" onchange="javascript:fn_reload();">
				<option value="01" <c:if test="${params.dmm[0] eq '01' || mm eq '01'}">selected="selected"</c:if> >01월</option>
				<option value="02" <c:if test="${params.dmm[0] eq '02' || mm eq '02'}">selected="selected"</c:if> >02월</option>
				<option value="03" <c:if test="${params.dmm[0] eq '03' || mm eq '03'}">selected="selected"</c:if> >03월</option>
				<option value="04" <c:if test="${params.dmm[0] eq '04' || mm eq '04'}">selected="selected"</c:if> >04월</option>
				<option value="05" <c:if test="${params.dmm[0] eq '05' || mm eq '05'}">selected="selected"</c:if> >05월</option>
				<option value="06" <c:if test="${params.dmm[0] eq '06' || mm eq '06'}">selected="selected"</c:if> >06월</option>
				<option value="07" <c:if test="${params.dmm[0] eq '07' || mm eq '07'}">selected="selected"</c:if> >07월</option>
				<option value="08" <c:if test="${params.dmm[0] eq '08' || mm eq '08'}">selected="selected"</c:if> >08월</option>
				<option value="09" <c:if test="${params.dmm[0] eq '09' || mm eq '09'}">selected="selected"</c:if> >09월</option>
				<option value="10" <c:if test="${params.dmm[0] eq '10' || mm eq '10'}">selected="selected"</c:if> >10월</option>
				<option value="11" <c:if test="${params.dmm[0] eq '11' || mm eq '11'}">selected="selected"</c:if> >11월</option>
				<option value="12" <c:if test="${params.dmm[0] eq '12' || mm eq '12'}">selected="selected"</c:if> >12월</option>
			</select>
		</div>
	</div>
    <!--조회된자료끝-->
    
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <p class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${selectMyResultCnt}</span>건
        </p>
    </div>
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
	    <table class="zemos_table1 table-container" style="margin-top: 0px;">
	        <colgroup>
		        <col width="8%"  /><!-- 순번 -->
				<col width="20%" /><!-- 매장명 -->
				<col width="12%" /><!-- 일자 -->
				<col width="14%" /><!-- 원 -->
				<col width="14%" /><!-- 달러 -->
				<col width="12%" /><!-- 수량 -->
				<col width="10%" /><!-- 수정버튼 -->
				
				<col width="10%" /><!-- 삭제버튼 -->
				
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th rowspan="2" style="padding: 10px 5px;">순번</th>
	        		<th rowspan="2" style="padding: 10px 5px;">매장</th>
	        		<th rowspan="2" style="padding: 10px 5px;">일자</th>
	        		<th colspan="3" style="padding: 10px 5px;">매출(실적)</th>
	        		<th rowspan="2" style="padding: 10px 5px;">수정요청</th>
	        		
	        		<th rowspan="2" style="padding: 10px 5px;"></th>
	        		
	        	</tr>
	        	<tr>
	        		<th style="padding: 10px 5px;">원</th>
	        		<th style="padding: 10px 5px;">$(달러)</th>
	        		<th style="padding: 10px 5px;">수량</th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(selectMyResult) > 0}">
		        		<c:forEach items="${selectMyResult}" var="item" varStatus="status">
	        	<tr>
	        		<td style="padding: 10px 5px; text-align: center;">${status.count}</td>
	        		<td style="padding: 10px 5px; text-align: left;">${item.storeNm}</td>
	        		<td style="padding: 10px 5px; text-align: center;">${item.resultDt}</td>
	        		<td style="padding: 10px 5px; text-align: right;">
	        			${item.amt}원
	        			<c:set var="totSumAmt" value="${fn:replace(totSumAmt, ',', '') + fn:replace(item.amt, ',', '')}"/>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: right;">
	        			${item.dollarAmt}$
	        		</td>
	        		<td style="padding: 10px 5px; text-align: center;">
	        			${item.qty}
	        		</td>
	        		<td style="padding: 10px 5px; text-align: center;">
	        			<a href="javascript:void(0);" onclick="javascript:fnMyModifyRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;" class="zemos_form_span_btn_blue">
							<span style="font-size:12px;">수정</span>
						</a>
	        		</td>
	        		<td style="padding: 10px 5px; text-align: center;">
	        		<!-- 
	        			<c:if test="${item.requestYn eq 'W' && (item.cRequestYn == null || item.cRequestYn eq '')}">
	        			<a href="javascript:void(0);" onclick="javascript:fnDeleteRequest('${item.resultSeq}','${item.resultDt}','${item.storeSeq}','${item.requestYn}','${item.cRequestYn}'); return false;" class="zemos_form_span_btn_blue">
							<span style="font-size:12px;">삭제</span>
						</a>
						</c:if>
					 -->	
						<c:if test="${item.requestYn eq 'D'}">
						삭제요청
						</c:if>
	        		</td>
	        	</tr>
		        		</c:forEach>
		        	</c:when>
			        <c:otherwise>
				    <tr>
				    	<td colspan="8">
				    		나의등록현황 자료가 없습니다.
				    	</td>
				    </tr>
				    </c:otherwise>
			    </c:choose>
	        </tbody>
	        <tfoot>
                <tr style="background-color:#CEE3F6; font-weight:bold;">
                	<td colspan="3" style="padding: 5px; text-align: center; font-size: 12px;">합계</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${selectMyResultTot.amt}" pattern="#,###" />원</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${selectMyResultTot.dollarAmt}" pattern="#,###.##" />$</td>
                    <td style="padding: 5px; text-align: center; font-size: 12px;"><fmt:formatNumber value="${selectMyResultTot.qty}" pattern="#,###" /></td>
                    <td style="padding: 5px; text-align: center; font-size: 12px;"></td>
                    <td style="padding: 5px; text-align: center; font-size: 12px;"></td>
                </tr>
            </tfoot>
	    </table>
	    <!-- 페이징 처리 -->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosPaging.jsp"%>
	    <!-- 페이징 처리 -->
    </div>
    
</body>
</html>