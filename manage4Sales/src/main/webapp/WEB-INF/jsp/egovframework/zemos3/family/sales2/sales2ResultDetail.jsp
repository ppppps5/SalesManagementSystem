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
		var storeNm  = "${params.storeNm[0]}";
		var startDay  = "${params.startDay[0]}";
		var endDay  = "${params.endDay[0]}";
		var unitYn      = "${params.unitYn[0]}";
		var unitSeq      = "${params.unitSeq[0]}";
		var unitNm      = "${params.unitNm[0]}";
		var onoffNM      = "${params.onoffNM[0]}";
		var ex = "${params.ex[0]}";
		var app = "${params.app[0]}";
		
		$(document).ready(function () {
			if(ex == 'y' || ex == 'y2'){
				$(".appBtn").css("visibility","hidden");
			}
			
			if(app == 'y'){
				$(".saveBtn").css("visibility","hidden");
			}
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
			if (ex == 'y' || ex == 'y2'){
          		url += "?ex=" + ex;
            } else if (app == 'y') {
            	url += "?app=" + app;	
            }
                        
			url += "&zemosIdx=" 	+ zemosIdx;
  			url += "&wrkplcIdx=" 	+ wrkplcIdx;
  			url += "&zemosNm=" 		+ encodeURIComponent(zemosNm);
  			url += "&storeSeq=" 	+ storeSeq;
  			url += "&unitYn=" 		+ unitYn;
  			url += "&unitSeq=" 		+ unitSeq;
  			url += "&unitNm=" 		+ unitNm;
  			url += "&storeNm=" 		+ storeNm;
  			url += "&onoffNM=" 		+ onoffNM;
  			url += "&startDay=" 	+ startDay;
  			url += "&endDay=" 		+ endDay;
  			
			fn_location_href(url);
		}

		//저장
		function fnResultSave(trCnt) {
			<c:if test = "${closeYn[0].closeYn == 'Y'}">
			alert("마감된 달의 실적은 저장할 수 없습니다.");
			return;
			</c:if>
			var params = {};

			params.zemosIdx  	 = $("#zemosIdx"+trCnt).val();
			params.wrkplcIdx 	 = $("#wrkplcIdx"+trCnt).val();
			params.storeSeq  	 = $("#storeSeq"+trCnt).val();
			params.resultexSeq   = $("#resultexSeq"+trCnt).val();
			params.year      	 = $("#year"+trCnt).val();
			params.mm        	 = $("#mm"+trCnt).val();
			params.dd        	 = $("#dd"+trCnt).val();
			params.yearMmdd  	 = $("#yearMmdd"+trCnt).val();
			params.qty       	 = $("#qty"+trCnt).val();
			params.amt       	 = $("#amt"+trCnt).val();
			params.itemSeq       = $("#itemSeq"+trCnt).val();

			
			params.unitSeq       = $("#unitSeq"+trCnt).val();
			params.unitNm        = $("#unitNm"+trCnt).val();
			params.onoffNM       = $("#onoffNM"+trCnt).val();
			params.unitYn        = $("#unitYn"+trCnt).val();

			// unitYn =1 unit_sql1
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2ResultDetailSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert($("#year"+trCnt).val() + "년 " + $("#mm"+trCnt).val() + "월" +$("#dd"+trCnt).val() + "일"+ " 실적등록엑셀이 저장되었습니다.");
					fn_reload();
				} else {
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		// 실적등록 테이블에 입력 업데이트 / 실적L 테이블에 입력 업데이트
		function fnResultAppSave() {
			<c:if test = "${closeYn[0].closeYn == 'Y'}">
			alert("마감된 달의 수정요청은 승인할 수 없습니다.");
			return;
			</c:if>  
			//alert(storeSeq);
			var params = {};

			params.zemosIdx  	 = zemosIdx;
			params.wrkplcIdx 	 = wrkplcIdx;
			params.storeSeq  	 = storeSeq;
			params.storeNm  	 = storeNm;
			params.startDay      = startDay;
			params.endDay        = endDay;	
			params.unitSeq       = unitSeq;
			params.unitNm        = unitNm;
			params.onoffNM       = onoffNM;
			params.unitYn        = unitYn;
			

			// unitYn =1 unit_sql1
			$("#zemos_loading").show();
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2ResultDetailAppSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert(storeNm + " 실적등록이 승인 처리 되었습니다.");
					fn_back2();
				} else {
					alert(storeNm + " 실적에 수정요청이 있습니다./n 확인 후 다시 시도해 주세요 ");
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		//제모스 판매관리 메뉴이동  sales2Result
		function fn_back2() {
			if(ex == 'y') {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?userAdminGbn=A&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&startDay="+startDay+"&endDay="+endDay);
			}
			
			if(ex == 'y2') {
				
			}
			
			if(app == 'y') {
				
			}
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2Result.do?userAdminGbn=A&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&startDay="+startDay+"&endDay="+endDay);
		}
		
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">실적엑셀등록상세</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			 단위 : ${resultDetailList[0].unitNm}
			 <br><br>
			 온/오프라인 : ${resultDetailList[0].onoffNM}
			 <br><br>
			 ${storeUseName[0].storeUseNm}명 : ${resultDetailList[0].storeNm}
        </span>
    </div>
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table class="zemos_table1 table-container" style="margin-top: 0px;">
    		<colgroup>
		        <col width="20%" />
		        <col width="25%" />
				<col width="15%" />
				<col width="20%" />
				<col width="15%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding: 5px;" nowrap>실적일자</th>
	        		<th style="padding: 5px;" nowrap>${storeitemName[0].itemUseNm}</th>
	        		<th style="padding: 5px;" nowrap>수량</th>
	        		<th style="padding: 5px;" nowrap>금액</th>
	        		<th style="padding: 5px;" nowrap></th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<!-- goalDetailList -->
	        	<c:forEach items="${resultDetailList}" var="item" varStatus="status">
	        	<tr>
	        		<td class="first" style="padding: 2px; text-align: center;">
	        			${item.yearMmdd}
	        		</td>
	        		<td style="padding: 5px; text-align: center;">
	        			${item.itemNm}
	        		</td>
	        		<td style="padding: 2px; text-align: center;">
	        			<input type="text" id="qty${status.count}" name="qty" style="width:85%; background-color:white; text-align: right;" class="zemos_input1" value="${item.qty}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
	        		</td>
	        		<td style="padding:2px; text-align:right;">
		        		<input type="hidden" id="zemosIdx${status.count}" name="zemosIdx" value="${item.zemosIdx}"/>
						<input type="hidden" id="wrkplcIdx${status.count}" name="wrkplcIdx" value="${item.wrkplcIdx}"/>
						<input type="hidden" id="storeSeq${status.count}" name="storeSeq" value="${item.storeSeq}"/>
						<input type="hidden" id="resultexSeq${status.count}" name="resultexSeq" value="${item.resultexSeq}"/>
						<input type="hidden" id="itemSeq${status.count}" name="itemSeq" value="${item.itemSeq}"/>
						<input type="hidden" id="year${status.count}" name="year" value="${item.year}"/>
						<input type="hidden" id="mm${status.count}" name="mm" value="${item.mm}"/>
						<input type="hidden" id="dd${status.count}" name="dd" value="${item.dd}"/>
						<input type="hidden" id="yearMmdd${status.count}" name="yearMmdd" value="${item.yearMmdd}"/>
						
						<input type="hidden" id="unitSeq${status.count}" name="unitSeq" value="${item.unitSeq}"/>
						<input type="hidden" id="unitNm${status.count}" name="unitNm" value="${item.unitNm}"/>
						<input type="hidden" id="onoffNM${status.count}" name="onoffNM" value="${item.onoffNM}"/>
						<input type="hidden" id="unitYn${status.count}" name="unitYn" value="${item.unitYn}"/>
	        			<input type="text" id="amt${status.count}" name="amt" style="width:85%; background-color:white; text-align: right;" class="zemos_input1" value="${item.amt}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/>
	        		</td>
	        		<td class="saveBtn" style="padding:5px; text-align: center;">
	        			<a href="javascript:void(0);" onclick="javascript:fnResultSave('${status.count}'); return false;" class="zemos_form_span_btn_blue">
							<span style="font-size:12px;">저장</span>
						</a>
	        		</td>
	        	</tr>
	        	</c:forEach>
	        </tbody>
    	</table>
    </div>
	<div class="appBtn">
			<td style="padding:5px; text-align: center;">
     			<a href="javascript:void(0);" onclick="javascript:fnResultAppSave(); return false;" class="zemos_form_span_btn_blue">
				<span style="font-size:12px;">승인</span>
				</a>
     		</td>
     </div>		
<!-- 	<div class="zemos_label_search2"> -->
<!-- 			<td class="appBtn" style="padding:5px; text-align: center;"> -->
<!--      			<a href="javascript:void(0);" onclick="javascript:fnResultAppSave(); return false;" class="zemos_form_span_btn_blue"> -->
<!-- 				<span style="font-size:12px;">승인</span> -->
<!-- 				</a> -->
<!--      		</td> -->
<!--      </div>		 -->
    <!--조회된자료끝-->
    <form id="dataFileForm" method="post" enctype="multipart/form-data" action="" style="display:none;">
		<input type="file" id="dataFile" name="dataFile">
	</form>
</body>
</html>