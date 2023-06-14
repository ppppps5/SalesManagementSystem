<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	<script type="text/javascript">
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm   = "${params.zemosNm[0]}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		var storeSeq  = "${params.storeSeq[0]}";
		var year      = "${params.year[0]}";
		
		var unitYn      = "${params.unitYn[0]}";
		var unitSeq      = "${params.unitSeq[0]}";
		var offYn      = "${params.offYn[0]}";
		var onYn      = "${params.onYn[0]}";
		var unitNm      = "${params.unitNm[0]}";
		var onoffNM      = "${params.onoffNM[0]}";
		
		
		$(document).ready(function () {
			genRowspan("first");
		});
		
		//rowspan 합치기
		function genRowspan(className){
		    $("." + className).each(function() {
		        var rows = $("." + className + ":contains('" + $(this).text() + "')");
		        if (rows.length > 1) {
		            rows.eq(0).attr("rowspan", rows.length);
		            rows.not(":eq(0)").remove();
		        }
		    });
		}
		
		//조회(storeSeq, year, storeNm, unitYn, unitSeq, offYn, onYn,unitNm,onoffNM)
		function fn_reload(type, value1, value2, value3, value4, value5, value6, value7, value8) {
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx="  + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm="   + encodeURIComponent(zemosNm);
			url += "&storeSeq="  + storeSeq;
			url += "&unitYn=" 	 + unitYn;
			url += "&unitSeq="   + unitSeq;
			url += "&offYn=" 	 + offYn;
			url += "&onYn=" 	 + onYn;
			url += "&unitNm=" 	 + unitNm;
			url += "&onoffNM=" 	 + onoffNM;
			url += "&year="      + year;
			
			fn_location_href(url);
		}

		//저장
		function fnGoalSave(trCnt) {
			var params = {};

			params.zemosIdx  = $("#zemosIdx"+trCnt).val();
			params.wrkplcIdx = $("#wrkplcIdx"+trCnt).val();
			params.storeSeq  = $("#storeSeq"+trCnt).val();
			params.goalSeq   = $("#goalSeq"+trCnt).val();
			params.year      = $("#year"+trCnt).val();
			params.mm        = $("#mm"+trCnt).val();
			params.itemSeq   = $("#itemSeq"+trCnt).val();
			params.amt       = $("#amt"+trCnt).val();
			
			params.unitSeq       = $("#unitSeq"+trCnt).val();
			params.unitNm       = $("#unitNm"+trCnt).val();
			params.onoffNM       = $("#onoffNM"+trCnt).val();
			params.unitYn       = $("#unitYn"+trCnt).val();
			params.offYn       = $("#offYn"+trCnt).val();
			params.onYn       = $("#onYn"+trCnt).val();
			params.unitYn       = $("#unitYn"+trCnt).val();
			// unitYn =1 unit_sql1
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2GoalSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert($("#year"+trCnt).val() + "년 " + $("#mm"+trCnt).val() + "월" + " 목표등록이 저장되었습니다.");
					fn_reload();
				} else {
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2Goal.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">목표등록상세</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			 단위 : ${goalDetailList[0].unitNm}
			 <br><br>
			 온/오프라인 : ${goalDetailList[0].onoffNM}
        </span>
    </div>
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table class="zemos_table1 table-container" style="margin-top: 0px;">
    		<colgroup>
		        <col width="30%" />
		        <col width="25%" />
				<col width="30%" />
				<col width="15%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding: 5px;" nowrap>${storeUseName[0].storeUseNm}명</th>
	        		<th style="padding: 5px;" nowrap>년월</th>
	        		<th style="padding: 5px;" nowrap>금액</th>
	        		<th style="padding: 5px;" nowrap></th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<!-- goalDetailList -->
	        	<c:forEach items="${goalDetailList}" var="item" varStatus="status">
	        	<tr>
	        		<td class="first" style="padding: 5px; text-align: center;">
	        			${item.storeNm}
	        			<br>/
	        			${item.itemNm}
	        		</td>
	        		<td style="padding: 5px; text-align: center;">
	        			${item.year}년 ${item.mm}월
	        		</td>
	        		<td style="padding:5px; text-align:right;">
		        		<input type="hidden" id="zemosIdx${status.count}" name="zemosIdx" value="${item.zemosIdx}"/>
						<input type="hidden" id="wrkplcIdx${status.count}" name="wrkplcIdx" value="${item.wrkplcIdx}"/>
						<input type="hidden" id="storeSeq${status.count}" name="storeSeq" value="${item.storeSeq}"/>
						<input type="hidden" id="goalSeq${status.count}" name="goalSeq" value="${item.goalSeq}"/>
						<input type="hidden" id="year${status.count}" name="year" value="${item.year}"/>
						<input type="hidden" id="mm${status.count}" name="mm" value="${item.mm}"/>
						<input type="hidden" id="itemSeq${status.count}" name="itemSeq" value="${item.itemSeq}"/>
						
						<input type="hidden" id="unitSeq${status.count}" name="unitSeq" value="${item.unitSeq}"/>
						<input type="hidden" id="unitNm${status.count}" name="unitNm" value="${item.unitNm}"/>
						<input type="hidden" id="onoffNM${status.count}" name="onoffNM" value="${item.onoffNM}"/>
						<input type="hidden" id="unitYn${status.count}" name="unitYn" value="${item.unitYn}"/>
						<input type="hidden" id="offYn${status.count}" name="offYn" value="${item.offYn}"/>
						<input type="hidden" id="onYn${status.count}" name="onYn" value="${item.onYn}"/>
						<input type="hidden" id="unitYn${status.count}" name="unitYn" value="${item.unitYn}"/>
	        			<input type="text" id="amt${status.count}" name="amt" style="width:85%; background-color:white; text-align: right;" class="zemos_input1" value="${item.amt}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>원
	        		</td>
	        		<td style="padding:5px; text-align: center;">
	        			<a href="javascript:void(0);" onclick="javascript:fnGoalSave('${status.count}'); return false;" class="zemos_form_span_btn_blue">
							<span style="font-size:12px;">저장</span>
						</a>
	        		</td>
	        	</tr>
	        	</c:forEach>
	        </tbody>
    	</table>
    </div>
    <!--조회된자료끝-->
    <form id="dataFileForm" method="post" enctype="multipart/form-data" action="" style="display:none;">
		<input type="file" id="dataFile" name="dataFile">
	</form>
</body>
</html>