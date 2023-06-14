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
		#userListTable {
		    width: 100%;
		    border: 0px;
		    border-collapse: collapse;
		}
		
		#userListTable th {
		    position: sticky;
		    top: 0px;
		    background-color: #eff0f4;
		    border-bottom: 1px solid #e0e1e6;
		    font-size: 13px;
		    line-height: 20px;
		    color: #000000;
		    text-align: center;
		    padding: 10px;
		    font-weight: normal;
		}
		
		.box11 {
			width: 80%;
		    height: 50%;
		    margin-top: 2px;
		    margin-left: 1%;
		    border-radius: 6px 6px;
		    background-color: #294a91;
 		    line-height: 200%; 
		    float: left;
		    vertical-align: middle;
		}
		
		.box11 td { 
			color:#ffffff;
			font-size: 12px;
		    font-weight: bold; 
		    vertical-align: middle;
		}
		
		.box22 {
			width: 15%;
		    height: 50%;
		    margin-top: 2px;
		    margin-left: 1%;
		    text-align: center;
		    border-radius: 6px 6px;
		    float: left;
		    background-color: #f0b25f;
		    color: black;
		    display: table;
		    vertical-align: middle;
 		    line-height: 200%;
		    float: left;
		}
		
		.box22 td{
			font-size: 12px;
		    font-weight: bold;
		    vertical-align: middle;
		    text-align : center;
		    word-break:break-all;
		}
		
		.footer { 
			float: left; 
			width: 100%; 
			padding-right: 20px; 
			padding-left: 25px; 
			margin: 0 auto; 
			text-align: center; 
			position:fixed; 
			bottom:0;
		} 
		
		.footer ul { 
			list-style: none; 
		}
		
		.footer ul li { 
			width:30%;
			color: black; 
			padding-bottom: 5px; 
			font-size: 14px; 
			font-family: Arial, Helvetica, sans-serif; 
			display:inline-block; 
			padding-right: 10px; 
		}
		
		.footer ul li span { 
			display:block;
			margin-top:5px;
		}
		
		.footer2 { 
			float: left; 
			width: 100%; 
			/*padding-right: 20px; 
			padding-left: 25px;*/ 
			margin: 0 auto; 
			text-align: center; 
/* 			position:fixed;  */
			bottom:0;
		} 
		
		.footer2 ul { 
			list-style: none; 
			display: flex;
		} 
		
		.footer2 ul li { 
			width:16.5%;
			color: black; 
			padding-bottom: 5px; 
			font-size: 11px; 
			font-family: Arial, Helvetica, sans-serif; 
			display:inline-block; 
			padding-right: 10px; 
		}
		
		.footer2 ul li span { 
			display:block;
			margin-top:5px;
		}
		
	</style>
	
	<script type="text/javascript">
	
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var salesabun = "${params.salesabun[0]}";
		var yyyy02 = "${params.yyyy01[0]}";
		var Mm02 = "${params.Mm01[0]}";
		var pageNo    = "${pageNo}";
		var numOfRows = "${numOfRows}";
		var userAdminGbn = "${userAdminGbn}";
		var storeSeq = "";
		var wrkplcIdx = "";

		$(document).ready(function () {
			genRowspan("storeNm");
			
			if ( '${params.wrkplcIdx[0]}' == null || '${params.wrkplcIdx[0]}' == '' ) {
				wrkplcIdx = "${wrkplcIdx}";
			} else {
				wrkplcIdx = "${params.wrkplcIdx[0]}";
			}
			
			$("#storeSeq").select2(); //storeSeq는 selectbox id
			$(".select2-selection__arrow").hide();
		});
		
		//조회
		//gbn이 D이면 매장명 select, I이면 품목 리스트 사용여부
		function fnSearch(gbn) {
		
			//var url = "${pageContext.request.contextPath}/zemos3/family/sales/salesUserMain.do";
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&salesabun=" + salesabun;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq=" + $("#storeSeq option:selected").val();
			url += "&yyyyMm=" + $("#yyyy").val() + $("#mm").val();
			url += "&yyyy=" + $("#yyyy").val();
			url += "&mm=" + $("#mm").val();
			
			if ( gbn == 'I' ) {
				url += "&itemUseYn=" + $("#selectItemUseYn option:selected").val();
			}
			url += "&userAdminGbn=" + userAdminGbn;
			
			fn_location_href(url);
		}
		
		function fnLocationHref(url) {
			
			url += "&storeSeq=" + $("#storeSeq option:selected").val();
			url += "&yyyy=" + $("#yyyy option:selected").val();
			url += "&mm=" + $("#mm option:selected").val();
			url += "&salesabun=" + salesabun;
			console.log('url > ' + url);
			
			fn_location_href(url);
			
		}
		
		function fnLocationHref01(url) {
			if ( $("#storeSeq option:selected").val() == null || $("#storeSeq option:selected").val() == "" ) {
				alert("매장을 선택해 주세요.");
				$("#storeSeq").focus();
				
				return;
			}
			
			url += "&storeSeq=" + $("#storeSeq option:selected").val();
			url += "&yyyy=" + $("#yyyy option:selected").val();
			url += "&mm=" + $("#mm option:selected").val();
			url += "&salesabun=" + salesabun;
			console.log('url > ' + url);
			
			fn_location_href(url);
		}

		//제모스 판매관리 메뉴이동
		function fn_back2() {
			//admin
			///zenielMWeb/zemos3/zemos/menu/menuManager2.do
			if ( userAdminGbn == "A" ) {
				fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/menu/menuManager2.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx);
			} else {
				fn_location_href("${pageContext.request.contextPath}/zemos3/main/main1.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx);
			}
		}
		
		// 메인 하단 조회 지점명 rowspan
		function genRowspan(className){
		    $("." + className).each(function() {
		        var rows = $("." + className + ":contains('" + $(this).text() + "')");
		        if (rows.length > 1) {
		            rows.eq(0).attr("rowspan", rows.length);
		            rows.not(":eq(0)").remove();
		        }
		    });
		}
		
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">${params.zemosNm[0]} 판매관리</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    
    <!--조회조건시작-->
    <div class="zemos_label_search1">
    
		<div style="width:45%; float: left;" >
			<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:95%" onchange="javascript:fnSearch('D');">
				<option value="">${storeUseName[0].storeUseNm}전체</option>
	   			<c:forEach items="${storeList}" var="store" varStatus="status">
	   				<option value="${store.storeSeq}" <c:if test="${store.storeSeq eq storeSeq}">selected</c:if>>${store.storeNm}</option>
	   			</c:forEach>
			</select>
		</div>
		
		<div style="width:25%; float: left;">
			<select id="yyyy" class="zemos_select1" style="width:95%" onchange="javascript:fnSearch('D');">
				<c:forEach items="${yyyyList}" var="item" varStatus="status">
					<option value="${item.yyyy}" <c:if test="${item.yyyy eq params.yyyy[0] || item.yyyy eq yyyy}">selected</c:if>>${item.yyyy}</option>
				</c:forEach>
			</select>
		</div>
		
		<div style="width:25%; float: left;">
			<select id="mm" class="zemos_select1" class="zemos_select1" style="width:95%" onchange="javascript:fnSearch('D');">
				<option value="01"  <c:if test="${params.mm[0] eq '01' || mm eq '01'}">selected</c:if>>01월</option>
				<option value="02"  <c:if test="${params.mm[0] eq '02' || mm eq '02'}">selected</c:if>>02월</option>
				<option value="03"  <c:if test="${params.mm[0] eq '03' || mm eq '03'}">selected</c:if>>03월</option>
				<option value="04"  <c:if test="${params.mm[0] eq '04' || mm eq '04'}">selected</c:if>>04월</option>
				<option value="05"  <c:if test="${params.mm[0] eq '05' || mm eq '05'}">selected</c:if>>05월</option>
				<option value="06"  <c:if test="${params.mm[0] eq '06' || mm eq '06'}">selected</c:if>>06월</option>
				<option value="07"  <c:if test="${params.mm[0] eq '07' || mm eq '07'}">selected</c:if>>07월</option>
				<option value="08"  <c:if test="${params.mm[0] eq '08' || mm eq '08'}">selected</c:if>>08월</option>
				<option value="09"  <c:if test="${params.mm[0] eq '09' || mm eq '09'}">selected</c:if>>09월</option>
				<option value="10"  <c:if test="${params.mm[0] eq '10' || mm eq '10'}">selected</c:if>>10월</option>
				<option value="11"  <c:if test="${params.mm[0] eq '11' || mm eq '11'}">selected</c:if>>11월</option>
				<option value="12"  <c:if test="${params.mm[0] eq '12' || mm eq '12'}">selected</c:if>>12월</option>
			</select>
			<span class="fr mb5" style="position:absolute; right:3%;">
				<a href="#" onclick="javascript:fnSearch('D'); return false;" class="zemos_label_search1_search_image"></a>
			</span>
		</div>
		
	</div>
    <!--조회된자료끝-->
    
    <!-- 상단 목표 실적 달성률 시작 -->
    <div style="height:29px; padding-top: 0px;">
    	<table class="zemos_table5" style="margin-left: 1%; margin-bottom: 1%;"> 
    		<tbody>
    			<c:choose>
					<c:when test="${fn:length(goalResultTot) > 0}">
						<c:forEach items="${goalResultTot}" var="item" varStatus="status">
							<table class="box11">
								<tr>
									<td style="width:15%; text-align: center;">
										${item.unitNm}
									</td>
									<td style="width:35%; text-align: center;">
										<fmt:formatNumber value="${item.totSumGoal}" pattern="#,###" />
									</td>
									
									<td style="width:35%; text-align: center;">
										<fmt:formatNumber value="${item.totSumResult}" pattern="#,###" />
									</td>

								</tr>
							</table>
							<table class="box22">
								<tr>
									<td class="achRate" style="width:15%;">
										<c:choose>
				        					<c:when test="${empty item.achRate}">
				        						0.0%
				        					</c:when>
				        					<c:otherwise>
				        						<fmt:formatNumber value="${item.achRate}" pattern="#,##0.0" />%
				        					</c:otherwise>
				        				</c:choose>
									</td>
								</tr>
							</table>
						</c:forEach>
					</c:when>
					<c:otherwise>
				        <table class="box11">
								<tr>
									<td style="width:85%; text-align: center;" colspan="3">
										표시할 자료가 없습니다.
									</td>
								</tr>
							</table>
							<table class="box22">
								<tr>
									<td class="achRate" style="width:15%;">
										%
									</td>
								</tr>
							</table>
		        	</c:otherwise>
				</c:choose>
    		</tbody>
        </table>
    </div>
	<!-- 상단 목표 실적 달성률 종료 -->

    <!-- 목표/ 실적 메인 조회 -->
    <div class="zemos_label_search2">
        <p class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(selectUserMain)}</span>건
        </p>
    </div>
	<!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <div style="height:40%; padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch; overflow: auto; border-top: 2px solid #777777;">
    	<!-- <table class="zemos_table1 table-container" id="userListTable" style="margin-top:0px;"> -->
    	<table class="zemos_table1" id="userListTable" style="margin-top:0px;">
    		<colgroup>
    			<col width="20%" />
    			<col width="15%" />
		        <col width="25%" />
				<col width="25%" />
				<col width="15%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding:5px; height:28px;">${storeUseName[0].storeUseNm}명</th>
	        		<th style="padding:5px; height:28px;">단위</th>
	        		<th style="padding:5px; height:28px;">목표</th>
	        		<th style="padding:5px; height:28px;">실적</th>
	        		<th style="padding:5px; height:28px;">달성률</th>
	        	</tr>
	        </thead>
	        <tbody class="userMain">
	        	<!-- selectUserMain -->
	        	<c:choose>
		        	<c:when test="${fn:length(selectUserMain) > 0}">
		        		<c:forEach items="${selectUserMain}" var="item" varStatus="status">
					        <tr>
					        	<td class="storeNm" style="padding: 5px; text-align:center; height:28px; font-size:11px;">
				        			${item.storeNm}
				        		</td>
					        	<td style="padding: 5px; text-align:center; height:28px; font-size:11px;">
				        			${item.unitNm}
				        		</td>
				        		<td style="padding: 5px; text-align:center; height:28px; font-size:11px;">
				        			<fmt:formatNumber value="${item.storeGoal}" pattern="#,###" />
				        		</td>
				        		<td style="padding: 5px; text-align:center; height:28px; font-size:11px;">
				        			<fmt:formatNumber value="${item.storeResult}" pattern="#,###" />
				        		</td>
				        		<td style="padding: 5px; text-align:center; height:28px; font-size:11px;">
				        			<c:choose>
				        				<c:when test="${empty item.achRate}">0.0%</c:when>
				        				<c:otherwise>
				        					<fmt:formatNumber value="${item.achRate}" pattern="#,##0.0" />%
				        				</c:otherwise>
				        			</c:choose>
				        		</td>
				        	</tr>
		        		</c:forEach>
		        	</c:when>
		        	<c:otherwise>
				        <tr>
				        	<td style="padding: 5px; text-align:center; height:28px; font-size:11px;" colspan="5">
			        			담당 매장이 없습니다.
			        		</td>
				        </tr>	
		        	</c:otherwise>
	        	</c:choose>	
	        </tbody>
    	</table>
    </div>
    <!--조회된자료끝-->
   
   <!-- 현장관리자 + 현장근무자   -->
    <c:if test="${userAdminGbn eq 'U'}">
	    <div class="footer2" style="margin-top: 15px;"> 
			<ul style="margin-top: 20px;">
			
			<!-- 현장관리자 -->
			<c:if test="${loginVO.zemosAuth == '12000'}">
				<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserResultSaveNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/regResult.png" alt="실적등록" width="35px">
					<span>실적등록</span>
				</li>
				<c:if test="${storeAppList[0].uploadYn == 'Y'}">
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/uploadResult.png" alt="실적업로드" width="35px">
						<span>실적업로드</span>
					</li>
				</c:if>
				
				<c:if test="${storeAppList[0].uploadYn == 'Y' && storeAppList[0].approvalYn == 'Y'}">
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/Result.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/uploadResultApp.png" alt="실적업로드승인" width="35px">
						<span>실적업로드승인</span>
					</li>
				</c:if>
			
				<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2MyResultNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/regResultStatus.png" alt="실적등록현황" width="35px">
					<span>실적등록현황</span>
				</li>
				
				<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Present.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/salesManage.png" alt="판매관리현황" width="35px">
					<span>판매관리현황</span>
				</li>
				
				<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/ModRequestHistory.png" alt="수정요청이력" width="35px">
					<span>수정요청이력</span>
				</li>
				
				<c:if test="${storeAppList[0].approvalYn == 'Y'}">
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/ModRequestManage.png" alt="수정요청관리" width="35px">
						<span>수정요청관리</span>
					</li>
				</c:if>
				
			</c:if>	
			
			<!-- 현장근무자 -->
			<c:if test="${loginVO.zemosAuth != '12000'}">
				<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserResultNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/regResult.png" alt="실적등록" width="35px">
					<span>실적등록</span>
				</li>
				
				<c:if test="${storeAppList[0].uploadYn == 'Y'}">
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?ex=y&userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/uploadResult.png" alt="실적업로드" width="35px">
						<span>실적업로드</span>
					</li>
				</c:if>
				
				<c:if test="${storeAppList[0].uploadYn == 'Y' && storeAppList[0].approvalYn == 'Y'}">
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/uploadResultApp.png" alt="실적업로드승인" width="35px">
						<span>실적업로드승인</span>
					</li>
				</c:if>
				
				<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2MyResultNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/regResultStatus.png" alt="실적등록현황" width="35px">
					<span>실적등록현황</span>
				</li>
				
				<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Present.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/salesManage.png" alt="판매관리현황" width="35px">
					<span>판매관리현황</span>
				</li>
				
				<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&pages=record&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
					<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/ModRequestHistory.png" alt="수정요청이력" width="35px">
					<span>수정요청이력</span>
				</li>
				
				<c:if test="${storeAppList[0].approvalYn == 'Y'}">
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/ModRequestManage.png" alt="수정요청관리" width="35px">
						<span>수정요청관리</span>
					</li>
				</c:if>
				
			</c:if>	
			
			</ul> 
		</div>
	</c:if>
	
	<!-- 관리자, 잡컨설턴트 -->
	<c:if test="${userAdminGbn eq 'A'}">
		<c:if test="${loginVO.userId != 'demo9000'}">
		    <div class="footer2"> 
				<ul style="margin-top: 20px;">
				
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Present.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/salesManage.png" alt="판매관리현황" width="35px">
						<span>판매관리현황</span>
					</li>
					
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserResultNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/regResult.png" alt="실적등록" width="35px">
						<span>실적등록</span>
					</li>
					
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2MyResultNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/regResultStatus.png" alt="실적등록현황" width="35px">
						<span>실적등록현황</span>
					</li>
					
					<li onclick="javascript:fnLocationHref01('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?ex=y&userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/uploadResult.png" alt="실적업로드" width="35px">
						<span>실적업로드</span>
					</li>
					
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?app=y&userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/uploadResultApp.png" alt="실적업로드승인" width="35px">
						<span>실적업로드승인</span>
					</li>
					
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&pages=record&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/ModRequestHistory.png" alt="수정요청이력" width="35px">
						<span>수정요청이력</span>
					</li>
					
				</ul>
				
				<ul style="margin-top: 20px;">
				
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2ModifyRequestAdminNew.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/ModRequestManage.png" alt="수정요청관리" width="35px">
						<span>수정요청관리</span>
					</li>
									
					<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Statistics.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
						<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/staticsManage.png" alt="통계관리" width="35px">
						<span>통계관리</span>
					</li>
						
					<li>
					</li>
					<li>
					</li>
					<li>
					</li>
					<li>
					</li>
				</ul> 
				
			</div>
		</c:if>
	</c:if>
	
	<!-- 업체 사용 권한 (세라젬) -->
	<c:if test="${userAdminGbn eq 'A'}">
		<c:if test="${loginVO.userId == 'demo9000'}">
    <div class="footer2"> 
		<ul> 
			<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Present.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/salesPresent.png" alt="판매관리현황" width="35px">
				<span>판매관리현황</span>
			</li>
			 
			<li onclick="javascript:fnLocationHref('${pageContext.request.contextPath}/zemos3/family/sales2/sales2Statistics.do?userAdminGbn=${userAdminGbn}&zemosIdx=${params.zemosIdx[0]}&wrkplcIdx=<c:if test="${params.wrkplcIdx[0] == null}">${wrkplcIdx}</c:if><c:if test="${params.wrkplcIdx[0] != null}">${params.wrkplcIdx[0]}</c:if>&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/salesStatistics.png" alt="통계관리" width="35px">
				<span>통계관리</span>
			</li>
			
		</ul> 
	</div>
		</c:if>
	</c:if>

</body>
</html>