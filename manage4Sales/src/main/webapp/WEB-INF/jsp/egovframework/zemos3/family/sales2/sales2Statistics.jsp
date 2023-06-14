<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>

	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/zemos3/selectbox.css"/> 
	<!-- 차트 -->
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/chart1.jsp"%>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/chart11.jsp"%>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/chart2.jsp"%>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/chart3.jsp"%>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/chart4.jsp"%>
	<!-- 달력 -->
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/zemos/report/common/carendar.jsp"%>
	
	<style>

		#chart1 {
			width: 100%;
			height: 500px;
		}
		
		#chart11 {
			width: 100%;
			height: 500px;
		}
		
		#chart2 {
			width: 100%;
			height: 500px;
		}
		
		#chart3 {
			width: 100%;
			height: 500px;
		}
		
		#chart4 {
			width: 100%;
			height: 500px;
		}
		
		.amcharts-pie-slice {
		
			transform: scale(1);
			transform-origin: 50% 50%;
			transition-duration: 0.3s;
			transition: all .3s ease-out;
			-webkit-transition: all .3s ease-out;
			-moz-transition: all .3s ease-out;
			-o-transition: all .3s ease-out;
			cursor: pointer;
			box-shadow: 0 0 30px 0 #000;
		}
		
		.amcharts-pie-slice:hover {
		
			transform: scale(1.1);
			filter: url(#shadow);
		}	
		
		.amcharts-export-menu-top-right {
			top: 10px;
			right: 0;
		}
		
		.amcharts-chart-div a {
			display:none !important;
		}
	
	</style>
	
	<!-- 차트 리소스 -->
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/zemos/report/common/chartResource.jsp"%>
	<script src="https://www.amcharts.com/lib/3/pie.js"></script>
	
	<script type="text/javascript">
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		var userAdminGbn = "${userAdminGbn}";
		var storeSeq = "${params.storeSeq[0]}";
		var yyyy = "${params.yyyy[0]}";
		var mm = "${params.mm[0]}";
	
		$(document).ready(function () {
			 $("#storeSeq").select2(); //storeSeq는 selectbox id
			  $(".select2-selection__arrow").hide();
			
			fn_chart_close('chart1', 1);
			fn_chart_close('chart11', 11);
			fn_chart_close('chart2', 2);
			fn_chart_close('chart3', 3);
			fn_chart_close('chart4', 4);
			fn_chart_close('chart5', 5);
			
			setCarendarMonth('#carendarYm1', '#carendarYm2');
			setCarendarMonth('#carendarYm11', '#carendarYm21');
			setCarendarMonth('#carendarYm12', '#carendarYm22');
			setCarendarMonthBasic('#carendarYm3');
			setCarendarMonth('#carendarYm4', '#carendarYm5');
			setCarendarMonth('#carendarYm6', '#carendarYm7');
			setCarendarMonth('#carendarYm8', '#carendarYm9');
			
			  
			//// 분류1~5 활성화 비 활성 화
			//if ( storeSeq == null || storeSeq == "" ) {
				//$("#class1").attr("disabled", false); //활성화
				//$("#class2").attr("disabled", false); //활성화
				//$("#class3").attr("disabled", false); //활성화
				//$("#class4").attr("disabled", false); //활성화
				//$("#class5").attr("disabled", false); //활성화
			//}
			
			//$("#class1").attr("disabled", true); //비활성화
			//$("#class2").attr("disabled", true); //비활성화
			//$("#class3").attr("disabled", true); //비활성화
			//$("#class4").attr("disabled", true); //비활성화
			//$("#class5").attr("disabled", true); //비활성화
			
			
		});
		
		// 차트 표시
		function fn_display_chart(chartName, index) {
			var detailDiv = "#" + chartName;
			if ($(detailDiv).css("display") == "none") {
				// 차트가 표시된 경우
				if ($(detailDiv).children('.amcharts-main-div').length > 0) {
					var vNextImg;
					if ( chartName == "chart1" ) {
						vNextImg = $('#img1');	
					} 
					else if(chartName == "chart11") {
						vNextImg = $('#img11');
					}
					else if(chartName == "chart2") {
						vNextImg = $('#img2');
					}
					else if(chartName == "chart3") {
						vNextImg = $('#img3');
					}
					else {
						vNextImg = $('#img4');
					}
						
					vNextImg.attr("src", "${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-u2.png");
					
					$(detailDiv).show();
				} else {
					
					var vNextImg = $('.chartDiv img').eq(index - 1);
					vNextImg.attr("src", "${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png");
					
					$(detailDiv).hide();
					fn_alert("검색 조건의 통계 결과가 존재하지 않습니다.\n통계확인 버튼을 선택해 주세요.");
				}
				
			} else {
				
				var vNextImg = $('.chartDiv img').eq(index - 1);
				vNextImg.attr("src", "${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png");
				
				$(detailDiv).hide();
			}
		}
		
		// 차트 열기
		function fn_chart_open(chartName, index) {
			var detailDiv = "#" + chartName;
			if ($(detailDiv).css("display") == "none") {
				$(detailDiv).show();
			}
		}
		
		// 차트 닫기
		function fn_chart_close(chartName, index) {
			var detailDiv = "#" + chartName;
			if ($(detailDiv).css("display") != "none") {
				$(detailDiv).hide();
			}
		}
		
		function fnSelectBox(obj){
			var val = $(obj).val();
			if ( val == null || val == "" ) {
				$("#class1").val("");
				$("#class2").val("");
				$("#class3").val("");
				$("#class4").val("");
				$("#class5").val("");
				$("#class1").attr("disabled", false); //활성화
				$("#class2").attr("disabled", false); //활성화
				$("#class3").attr("disabled", false); //활성화
				$("#class4").attr("disabled", false); //활성화
				$("#class5").attr("disabled", false); //활성화
			} else {
				$("#class1").val("");
				$("#class2").val("");
				$("#class3").val("");
				$("#class4").val("");
				$("#class5").val("");
				$("#class1").attr("disabled", true); //비활성화
				$("#class2").attr("disabled", true); //비활성화
				$("#class3").attr("disabled", true); //비활성화
				$("#class4").attr("disabled", true); //비활성화
				$("#class5").attr("disabled", true); //비활성화
			}
		}
		
		// 차트 그리기
		function fn_draw_chart(chartName, index) {

			var params = {};
			params.chartName = chartName;
			if ( chartName == "chart1" ) {
				params.startMonth = $("#carendarYm1").val();
				params.endMonth = $("#carendarYm2").val();
			}
			else if(chartName == "chart11" ){
				params.startMonth = $("#carendarYm11").val();
				params.endMonth = $("#carendarYm21").val();
				params.unit = $("#unitList option:selected").val(); 
			}
			else if(chartName == "chart2" ){
				params.yyyyMm = $("#carendarYm3").val();
			} 
			else if(chartName == "chart3" ){
				params.startMonth = $("#carendarYm4").val();
				params.endMonth = $("#carendarYm5").val();
			} 
			else {
				params.startMonth = $("#carendarYm6").val();
				params.endMonth = $("#carendarYm7").val();
			}
			
			params.zemosIdx = zemosIdx;
			params.storeSeq = $("#storeSeq option:selected").val();
			params.ItemSeq = $("#ItemSeq option:selected").val();
			params.goalYn = $("#goalYn option:selected").val();
			params.taxtYn = $("#taxtYn option:selected").val();
			params.onoffNM = $("#onoffNM option:selected").val();
			params.class1Seq = $("#class1 option:selected").val();
			params.class2Seq = $("#class2 option:selected").val();
			params.class3Seq = $("#class3 option:selected").val();
			params.class4Seq = $("#class4 option:selected").val();
			params.class5Seq = $("#class5 option:selected").val();
			params.Unit = $("#unitList option:selected").val(); 
			params.TOP1 = $("#TOP1").val();
			params.TOP2 = $("#TOP2").val();

			params.wrkplcIdx = wrkplcIdx;
			
			//fn_alert(params.TOP1);
			fn_loading_show();
			
			// ajax 시작
			$.ajax({
			    url: "${pageContext.request.contextPath}/zemos3/family/sales2/sales2ChartDataList.do",
			    type: 'post',
			    dataType : 'json',
			    data: params
			}).always(function(data) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			
				fn_loading_hide();
			}).done(function (data) { // 완료
				
				var vHtml = "";
				var result = Number(data.result);
				if(result > 0) {
					
					var list = data.resultList;
					if (list != null && list.length > 0) {
						if ( chartName == "chart1" ) {
							sales2Chart1(list);
						} 
						else if (chartName == "chart11" ){
							sales2Chart11(list);
						}						
						else if (chartName == "chart2" ){
							sales2Chart2(list);
						} 
						else if (chartName == "chart3" ){
							sales2Chart3(list);
						} 
						else{
							sales2Chart4(list);
						}
						
						var vNextImg = $('.chartDiv img').eq(index - 1);
						vNextImg.attr("src", "${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-u2.png");
						
						var detailDiv = "#" + chartName;
						$(detailDiv).show();
					}
				} else {
					var resultMsg = data.resultMsg;
					if (!fn_check_null(resultMsg)) {
						fn_alert(resultMsg);
					}
				}
			}).fail(function (data) { // 실패
				fn_location_href("${pageContext.request.contextPath}${common.requestURI}");
			}).always(function(data) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
				
			});
			// ajax 끝
		}
		
		function fn_back2() {
			var storeSeqVal = "";
			console.log($("#storeSeq").val());
			storeSeqVal = $("#storeSeq option:selected").val();	
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeqVal+"&yyyy="+yyyy+"&mm="+mm+"&yyyyMm="+yyyy+mm);
		}
		
		//슬라이드 처리
		$( document ).ready( function() {
			  $( '.toggle' ).slideUp();
	          $( 'button.zemos_form_header1_right' ).click( function() {
	            $( '.toggle' ).slideToggle();
	          } );
	          
	          $( '.monthReport' ).slideUp();
	          $( 'button.monthReportButton' ).click( function() {
	            $( '.monthReport' ).slideToggle();
	          } );
	          
	          $( '.monthReport1' ).slideUp();
	          $( 'button.monthReportButton1' ).click( function() {
	            $( '.monthReport1' ).slideToggle();
	          } );
	          
	          $( '.monthReport2' ).slideUp();
	          $( 'button.monthReportButton2' ).click( function() {
	            $( '.monthReport2' ).slideToggle();
	          } );
	          
	          $( '.dailyReport' ).slideUp();
	          $( 'button.dailyReportButton' ).click( function() {
	            $( '.dailyReport' ).slideToggle();
	          } );
	          
	          $( '.storeReport' ).slideUp();
	          $( 'button.storeReportButton' ).click( function() {
	            $( '.storeReport' ).slideToggle();
	          } );
	          
	          $( '.itemReport' ).slideUp();
	          $( 'button.itemReportButton' ).click( function() {
	            $( '.itemReport' ).slideToggle();
	          } );
	          
	          $( '.storeMonthReport' ).slideUp();
	          $( 'button.storeMonthReportButton' ).click( function() {
	            $( '.storeMonthReport' ).slideToggle();
	          } );
	        } );

		//체크박스 한개만
		$(document).ready(function() {
			 
			 $('input[type="checkbox"][name="checkbox"]').click(function(){
			 
			  if($(this).prop('checked')){
			 
			     $('input[type="checkbox"][name="checkbox"]').prop('checked',false);
			 
			     $(this).prop('checked',true);
			 
			    }
			  
			   });
			  
			 });
		
	</script>
</head>
<body>

	<!--상단시작-->
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
	<!--상단끝-->

	<!--타이틀시작-->
	<div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">판매실적 통계관리</span>
		<span class="zemos_title1_left">
			<a href="javascript:void(0);" onclick="javascript:fn_back2();return false;">
				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/>
			</a>
		</span>
	</div>
	<!--타이틀끝-->
	
		<div class="zemos_form_header1" style="background-color: #f3f4f4;">
			<p class="zemos_form_header1_left" style="font-size:14px; color: black;">조건설정</p>
			<button class="zemos_form_header1_right"><img src="../../../images/egovframework/com/conditionSetting.png"></button>
		</div>
	
	<!-- 검색영역 -->
	
		<div class="toggle" style="background-color: #f3f4f4;">
			<div class="zemos_form_header1" style="background-color: #f3f4f4;">
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${storeUseName[0].storeUseNm}명
					</span>
				</div>
				
				<div style="width:80%; padding: 5px; float: left;">
					<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%" onChange="javascript:fnSelectBox(this);">
						<option value="">${storeUseName[0].storeUseNm}전체</option>
		     			<c:forEach items="${storeList}" var="item" varStatus="status">
		     			<option value="${item.storeSeq}" <c:if test="${item.storeSeq eq params.storeSeq[0]}">selected</c:if>>${item.storeNm}</option>
		     			</c:forEach>
					</select>
				</div>			
				
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${itemNmList[0].itemNm}명
					</span>
				</div>
				<div style="width:80%; padding: 5px; float: left;">
					<select id="ItemSeq" name="ItemSeq" class="zemos_select1" style="width:100%">
						<option value="">${itemNmList[0].itemNm}전체</option>
		     			<c:forEach items="${salesItem}" var="item" varStatus="status">
		     			<option value="${item.itemSeq}" <c:if test="${item.itemSeq eq params.itemSeq[0]}">selected</c:if>>${item.itemNm}</option>
		     			</c:forEach>
					</select>				
				</div>
				
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						목표표현
					</span>
				</div>				
				<div style="width:80%; padding: 5px; float: left;">
					<select id="goalYn" name="goalYn" class="zemos_select1" style="width:100%">				
		     			<option value="1">포함</option>
						<option value="2">제외</option>					
					</select>				
				</div>																		
				
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						일반/면세
					</span>
				</div>				
				<div style="width:80%; padding: 5px; float: left;">
					<select id="taxtYn" name="taxtYn" class="zemos_select1" style="width:100%">	
					    <option value="0">전체</option>				
		     			<option value="1">일반</option>
						<option value="2">면세</option>					
					</select>				
				</div>
				
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						온/오프
					</span>
				</div>
				
				<div style="width:80%; padding: 5px; float: left;">
					<select id="onoffNM" name="onoffNM" class="zemos_select1" style="width:100%">	
						<option value="0">전체</option>				
		     			<option value="1">오프라인</option>
						<option value="2">온라인</option>					
					</select>				
				</div>
				
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${class1NmList[0].class1Nm}
					</span>
				</div>
				<div style="width:80%; padding: 5px; float: left;">
					<select id="class1" name="class1" class="zemos_select1" style="width:100%">
						<option value="">${class1NmList[0].class1Nm}전체</option>
		     			<c:forEach items="${salesClass1}" var="item" varStatus="status">
		     			<option value="${item.class1Seq}" <c:if test="${item.class1Seq eq params.class1[0]}">selected</c:if>>${item.class1Nm}</option>
		     			</c:forEach>
					</select>				
				</div>
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${class2NmList[0].class2Nm}
					</span>
				</div>
				<div style="width:80%; padding: 5px; float: left;">
					<select id="class2" name="class2" class="zemos_select1" style="width:100%">
						<option value="">${class2NmList[0].class2Nm}전체</option>
		     			<c:forEach items="${salesClass2}" var="item" varStatus="status">
		     			<option value="${item.class2Seq}" <c:if test="${item.class2Seq eq params.class2[0]}">selected</c:if>>${item.class2Nm}</option>
		     			</c:forEach>
					</select>				
				</div>
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${class3NmList[0].class3Nm}
					</span>
				</div>
				<div style="width:80%; padding: 5px; float: left;">
					<select id="class3" name="class3" class="zemos_select1" style="width:100%">
						<option value="">${class3NmList[0].class3Nm}전체</option>
		     			<c:forEach items="${salesClass3}" var="item" varStatus="status">
		     			<option value="${item.class3Seq}" <c:if test="${item.class3Seq eq params.class3[0]}">selected</c:if>>${item.class3Nm}</option>
		     			</c:forEach>
					</select>				
				</div>
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${class4NmList[0].class4Nm}
					</span>
				</div>
				<div style="width:80%; padding: 5px; float: left;">
					<select id="class4" name="class4" class="zemos_select1" style="width:100%">
						<option value="">${class4NmList[0].class4Nm}전체</option>
		     			<c:forEach items="${salesClass4}" var="item" varStatus="status">
		     			<option value="${item.class4Seq}" <c:if test="${item.class4Seq eq params.class4[0]}">selected</c:if>>${item.class4Nm}</option>
		     			</c:forEach>
					</select>				
				</div>
				<div style="width:20%; padding: 5px;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						${class5NmList[0].class5Nm}
					</span>
				</div>
				<div style="width:80%; padding: 5px; float: left;">
					<select id="class5" name="class5" class="zemos_select1" style="width:100%">
						<option value="">${class5NmList[0].class5Nm}전체</option>
		     			<c:forEach items="${salesClass5}" var="item" varStatus="status">
		     			<option value="${item.class5Seq}" <c:if test="${item.class5Seq eq params.class5[0]}">selected</c:if>>${item.class5Nm}</option>
		     			</c:forEach>
					</select>				
				</div>
			</div>
			</div>	
				
		
	
		<div class="chartDiv">
		
		<!-- 월별 판매실적 (전체집계)현황 시작 -->
		<div class="zemos_title1" style="text-align: center; border-radius: 10px;">
			<button class="monthReportButton" style="color:white; font-size:14px; font-weight:600;">월별 판매실적 현황(전체집계)</button>
		</div>
		<div class="monthReport">
		<div class="zemos_form_header1">
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					조회기간
				</span>
			</div>
			
			<div style="width:25%; float: left;">
				<input id="carendarYm1" type="text" class="zemos_input1" style="width:100%; font-size:12;">
			</div>
			
			<div style="width:5%; float: left;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; margin-left:40%;">
					<strong>~</strong>
				</span>
			</div>
			
			<div style="width:25%; float: left;">
				<input id="carendarYm2" type="text" class="zemos_input1" style="width: 100%; font-size:12;">
			</div>
			<div style="width:20%; float: right;">
				<span class="fr">
					<a href="#" onclick="javascript:fn_draw_chart('chart1', 1); return false;" class="zemos_form_span_btn_red" style="height:30px; width:60px; border-radius:10px;">조회</a>
				</span>
			</div>

			<div style="width:100%; float: left;">
				<p class="zemos_form_header1_left">
					<span class="zemos_naming2_image_span" onclick="javascript:fn_display_chart('chart1', 1);" style="float: right; margin-top: 5px; font-size:15px; font-weight:bold; letter-spacing:-0.5px; line-height: 24px;">
						<img id="img1" class="zemos_naming2_image_20p" style="margin-top: 1px; float: right;" src="${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png" >
					    월별 판매실적 현황
					</span>
				</p>
			</div>
			
		</div>
		
		<div id="chart1" style="display: none;"></div>
		<div style="border-bottom:1px dotted #cccccc; width:100%;"></div>
		</div>
		<!-- 월별 판매실적 현황 종료 -->
		<!-- 월별 판매실적 (단위별)현황 시작 -->
		<div class="zemos_title1" style="text-align: center; border-radius: 10px;">
			<button class="monthReportButton1" style="color:white; font-size:14px; font-weight:600;">월별 판매실적 현황(단위별집계)</button>
		</div>
		<div class="monthReport1">
		<div class="zemos_form_header1">
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					조회기간
				</span>
			</div>
			
			<div style="width:25%; float: left;">
				<input id="carendarYm11" type="text" class="zemos_input1" style="width:100%; font-size:12;">
			</div>
			
			<div style="width:5%; float: left;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; margin-left:40%;">
					<strong>~</strong>
				</span>
			</div>
			
			<div style="width:25%; float: left;">
				<input id="carendarYm21" type="text" class="zemos_input1" style="width: 100%; font-size:12;">
			</div>
			<div style="width:20%; float: right;">
				<span class="fr">
					<a href="#" onclick="javascript:fn_draw_chart('chart11', 11); return false;" class="zemos_form_span_btn_red" style="height:30px; width:60px; border-radius:10px;">조회</a>
				</span>
			</div>
			<div style="width:25%;">
					<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
						단위기준
					</span>
			</div> 
			<div style="width:75%; float: left; padding-top: 5px;">
				<select id="unitList" name="unitList" class="zemos_select1" style="width:100%">
					<option value="">단위전체</option>
	     			<c:forEach items="${unitList}" var="item" varStatus="status">
	     			<option value="${item.unitSeq}" <c:if test="${item.unitSeq eq params.unitList[0]}">selected</c:if>>${item.unitNm}</option>
	     			</c:forEach>
				</select>			
			</div>
			<div style="width:100%; float: left;">
				<p class="zemos_form_header1_left">
					<span class="zemos_naming2_image_span" onclick="javascript:fn_display_chart('chart11', 11);" style="float: right; margin-top: 5px; font-size:15px; font-weight:bold; letter-spacing:-0.5px; line-height: 24px;">
						<img id="img11" class="zemos_naming2_image_20p" style="margin-top: 1px; float: right;" src="${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png" >
					    월별 판매실적 현황
					</span>
				</p>
			</div>
			
		</div>
		
		<div id="chart11" style="display: none;"></div>
		<div style="border-bottom:1px dotted #cccccc; width:100%;"></div>
		</div>
		<!-- 월별 판매실적 현황 종료 -->
		
		<!-- 일별 판매실적 현황 시작 -->
		<div class="zemos_title1" style="text-align: center; border-radius: 10px;">
			<button class="dailyReportButton" style="color:white; font-size:14px; font-weight:600;">일별 판매실적 현황</button>
		</div>
		<div class="dailyReport">
		<div class="zemos_form_header1">
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:14px; font-weight:600; width:100%;">
					조회기간
				</span>
			</div>
			<div style="width:55%; float: left;">
				<input id="carendarYm3" type="text" class="zemos_input1" style="width:46%; font-size:12;">
			</div>
			<div style="width:20%; float: left;">
				<span class="fr">
					<a href="#" onclick="javascript:fn_draw_chart('chart2', 2); return false;" class="zemos_form_span_btn_red" style="height:30px; width:60px; border-radius:10px;">조회</a>
				</span>
			</div>
			<div style="width:100%; float: left;">
				<p class="zemos_form_header1_left">
					<span class="zemos_naming2_image_span" onclick="javascript:fn_display_chart('chart2', 2);" style="float: right; margin-top: 5px; font-size:15px; font-weight:bold; letter-spacing:-0.5px; line-height: 24px;">
						<img id="img2" class="zemos_naming2_image_20p" style="margin-top: 1px; float: right;" src="${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png" >
					    	일별 판매실적 현황
					 </span>
				</p>
			</div>
		</div>
		
		<div id="chart2" style="display: none;"></div>
		<div style="border-bottom:1px dotted #cccccc; width:100%;"></div>
		</div>
		<!-- 일별 판매실적 현황 종료 -->
		
		<!-- 매장별 판매실적 현황 시작 -->
		<div class="zemos_title1" style="text-align: center; border-radius: 10px;">
			<button class="storeReportButton" style="color:white; font-size:14px; font-weight:600;">매장별 판매실적 현황</button>
		</div>
		<div class="storeReport">
		<div class="zemos_form_header1">
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					조회기간
				</span>
			</div>
			<div style="width:25%; float: left;">
				<input id="carendarYm4" type="text" class="zemos_input1" style="width:100%; font-size:12;">
			</div>
			<div style="width:5%; float: left;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; margin-left:40%;">
					<strong>~</strong>
				</span>
			</div>
			<div style="width:25%; float: left;">
				<input id="carendarYm5" type="text" class="zemos_input1" style="width: 100%; font-size:12;">
			</div>			
			<div style="width:20%; float: left;">
				<span class="fr">
					<a href="#" onclick="javascript:fn_draw_chart('chart3', 3); return false;" class="zemos_form_span_btn_red" style="height:30px; width:60px; border-radius:10px;">조회</a>
				</span>
			</div>
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					TOP순위
				</span>
			</div>
			<div style="width:75%; float: left; padding-top: 5px;">
				<select id="TOP1" name="TOP1" class="zemos_select1" style="width:50%;">	
					<option value="0">전체매장</option>				
	     			<option value="1">상위10개</option>
					<option value="2">하위10개</option>					
				</select>				
			</div>
			<div style="width:100%; float: left;">
				<p class="zemos_form_header1_left">
					<span class="zemos_naming2_image_span" onclick="javascript:fn_display_chart('chart3', 3);" style="float: right; margin-top: 5px; font-size:15px; font-weight:bold; letter-spacing:-0.5px; line-height: 24px;">
						<img id="img3" class="zemos_naming2_image_20p" style="margin-top: 1px; float: right;" src="${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png" >
					    	매장별 판매실적 현황
					 </span>
				</p>
			</div>
		</div>
		<div id="chart3" style="display: none;"></div>
		<div style="border-bottom:1px dotted #cccccc; width:100%;"></div>
		</div>
		<!-- 매장별 판매실적 현황 종료 -->
		
		<!-- 품목별 판매실적 현황 시작 -->
		<div class="zemos_title1" style="text-align: center; border-radius: 10px;">
			<button class="itemReportButton" style="color:white; font-size:14px; font-weight:600;">품목별 판매실적 현황</button>
		</div>
		<div class="itemReport">
		<div class="zemos_form_header1">
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					조회기간
				</span>
			</div>
			<div style="width:25%; float: left;">
				<input id="carendarYm6" type="text" class="zemos_input1" style="width:100%; font-size:12;">
			</div>
			<div style="width:5%; float: left;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; margin-left:40%;">
					<strong>~</strong>
				</span>
			</div>		
			<div style="width:25%; float: left;">
				<input id="carendarYm7" type="text" class="zemos_input1" style="width: 100%; font-size:12;">
			</div>			
			<div style="width:20%; float: left;">
				<span class="fr">
					<a href="#" onclick="javascript:fn_draw_chart('chart4', 4); return false;" class="zemos_form_span_btn_red" style="height:30px; width:60px; border-radius:10px;">조회</a>
				</span>
			</div>
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					품목순위
				</span>
			</div>
			<div style="width:75%; float: left; padding-top: 5px;">
				<select id="TOP2" name="TOP2" class="zemos_select1" style="width:49%">	
					<option value="0">전체품목</option>				
	     			<option value="1">상위5개품목</option>
					<option value="2">하위5개품목</option>					
				</select>				
			</div>
			<div style="width:100%; float: left;">
				<p class="zemos_form_header1_left">
					<span class="zemos_naming2_image_span" onclick="javascript:fn_display_chart('chart4', 4);" style="float: right; margin-top: 5px; font-size:15px; font-weight:bold; letter-spacing:-0.5px; line-height: 24px;">
						<img id="img3" class="zemos_naming2_image_20p" style="margin-top: 1px; float: right;" src="${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png" >
					    	품목별 판매실적 현황
					 </span>
				</p>
			</div>
		</div>
		
		<div id="chart4" style="display: none;"></div>
		<div style="border-bottom:1px dotted #cccccc; width:100%;"></div>
		</div>
		<!-- 품목별 판매실적 현황 -->
	</div>
		
		<!-- 매장별 전당월 판매실적 비교현황 시작
		<div class="zemos_title1" style="text-align: center; border-radius: 10px;">
			<button class="storeMonthReportButton" style="color:white; font-size:14px; font-weight:600;">매장별 전당월 판매실적 비교현황</button>
		</div>
		<div class="storeMonthReport">
		<div class="zemos_form_header1">
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					조회기간
				</span>
			</div>
			<div style="width:25%; float: left;">
				<input id="carendarYm8" type="text" class="zemos_input1" style="width:100%; font-size:12;">
			</div>
			<div style="width:5%; float: left;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; margin-left:40%;">
					<strong>~</strong>
				</span>
			</div>		
			<div style="width:25%; float: left;">
				<input id="carendarYm9" type="text" class="zemos_input1" style="width: 100%; font-size:12;">
			</div>			
			<div style="width:20%; float: left;">
				<span class="fr">
					<a href="#" onclick="javascript:fn_draw_chart('chart4', 4); return false;" class="zemos_form_span_btn_red" style="height:30px; width:60px; border-radius:10px;">조회</a>
				</span>
			</div>
			<div style="width:25%;">
				<span class="fl mb5" style="padding-top:5px; font-size:15px; font-weight:600; width:100%;">
					품목순위
				</span>
			</div>
			<div style="width:75%; float: left; padding-top: 5px;">
				<select id="TOP2" name="TOP2" class="zemos_select1" style="width:49%">	
					<option value="0">매장전체</option>				
	     			<option value="1">실적상위10개</option>
	     			<option value="2">실적상위5개</option>
					<option value="3">실적하위10개</option>					
					<option value="4">실적하위5개</option>					
				</select>				
			</div>
			<div style="width:100%; float: left;">
				<p class="zemos_form_header1_left">
					<span class="zemos_naming2_image_span" onclick="javascript:fn_display_chart('chart4', 4);" style="float: right; margin-top: 5px; font-size:15px; font-weight:bold; letter-spacing:-0.5px; line-height: 24px;">
						<img id="img3" class="zemos_naming2_image_20p" style="margin-top: 1px; float: right;" src="${pageContext.request.contextPath}/images/egovframework/zemos3/ic-arrow-d2.png" >
					    	매장별 전당월 판매실적 비교현황
					 </span>
				</p>
			</div>
		</div>
		 -->
		
		<div id="chart5" style="display: none;"></div>
		<div style="border-bottom:1px dotted #cccccc; width:100%;"></div>
		</div>
		<!-- 매장별 전당월 판매실적 비교현황 종료 -->
	
</body>
</html>