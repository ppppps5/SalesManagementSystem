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
		var salesabun = "${params.salesabun[0]}";
		var storeSeq = "${params.storeSeq[0]}";
		var unitSeq = "${params.unitSeq[0]}";
		var itemSeq = "${params.itemSeq[0]}";
		var onoffNm = "${params.onoffNm[0]}";
		var zemosNm 	= "${params.zemosNm[0]}";
		var wrkplcIdx   = "${params.wrkplcIdx[0]}";
		var pageNo 		= "${pageNo}";
		var numOfRows 	= "${numOfRows}";
		var type 	    = "${params.type[0]}";
		var startDate   = "${params.startDate[0]}";
		var endDate     = "${params.endDate[0]}";
		var pageReloadGbn = "${pageReloadGbn}";
		var userAdminGbn = "${userAdminGbn}";
		var yyyy = "${params.yyyy[0]}";
		var mm = "${params.mm[0]}";
		var salesabun = "${params.salesabun[0]}";
		
		$(document).ready(function () {
			
			//rowspan 적용
			mergeTable('#merge', 0);
			//mergeTable('#merge', 1);
			//mergeTable('#merge', 2);
			mergeTable('#merge2', 0);
			mergeTable('#merge2', 1);
			
			//selectbox 검색기능 css
			 $("#storeSeq").select2(); //storeSeq는 selectbox id
			 $(".select2-selection__arrow").hide();
			 
			console.log('storeSeq >>>>> ' + storeSeq);
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
		    	$('#startDate').val(year + '-' + mon + '-' + '01');
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
		    
		    if ( pageReloadGbn == "N" ) {
		    	fn_reload('select');
		    }
		});
		
		function fn_reload(type, value1, value2) {
			//alert(storeSeq);
			var startDateS = $("#startDate").val();
			var endDateS   = $("#endDate").val();
			//var onoffNm = $("#onoffNm").val();
			
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
			url += "&wrkplcIdx="	 + wrkplcIdx;
			url += "&salesabun=" 	 + salesabun;
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&type="	         + type;
			url += "&startDate="     + startDateS;
			url += "&endDate="       + endDateS;
			url += "&userAdminGbn="  + userAdminGbn;
			url += "&salesabun=" + salesabun;

			if ( $("#storeSeq").val() != '' ) {
				url += "&storeSeq=" + $("#storeSeq option:selected").val();	
			} else {
				if ( pageReloadGbn == "N" ) {
					url += "&storeSeq=" + storeSeq;
				} else {
					url += "&storeSeq=" + "";
				}
			}

			if ( $("#unitSeq").val() != '' ) {
				url += "&unitSeq=" + $("#unitSeq option:selected").val();	
			} else {
				if ( pageReloadGbn == "N" ) {
					url += "&unitSeq=" + unitSeq;
				} else {
					url += "&unitSeq=" + "";
				}
			}

			if ( $("#itemSeq").val() != '' ) {
				url += "&itemSeq=" + $("#itemSeq option:selected").val();	
			} else {
				if ( pageReloadGbn == "N" ) {
					url += "&itemSeq=" + itemSeq;
				} else {
					url += "&itemSeq=" + "";
				}
			}

			if ( $("#onoffNm").val() != '' ) {
				url += "&onoffNm=" + $("#onoffNm option:selected").val();	
			} else {
				if ( pageReloadGbn == "N" ) {
					url += "&onoffNm=" + onoffNm;
				} else {
					url += "&onoffNm=" + "";
				}
			}
			
			console.log('url > ' + url);
			fn_location_href(url);
		}
		
		function fnExcel(gbn) {
			var startDateP  = $("#startDate").val();
			var endDateP    = $("#endDate").val();
			var excelGubunP = gbn;
			
			var vUrl = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2PresentExcelDown.do";
			//var vUrl = "https://m.zemos.co.kr/zemos3/family/sales2/sales2PresentExcelDown.do";
			vUrl += "?pageNo="	      + pageNo;
			vUrl += "&numOfRows="	  + numOfRows;
			vUrl += "&zemosIdx="	  + zemosIdx;
			vUrl += "&wrkplcIdx="	  + wrkplcIdx;
			vUrl += "&salesabun=" 	 + salesabun;
			vUrl += "&zemosNm="	      + encodeURIComponent(zemosNm);
			vUrl += "&startDate="     + startDateP;
			vUrl += "&endDate="       + endDateP; 
			vUrl += "&excelGubun="	  + excelGubunP;
			vUrl += "&yyyy=" + yyyy;
			vUrl += "&mm=" + mm;
			vUrl += "&salesabun=" + salesabun;
			
			if ( $("#storeSeq").val() != 'A' ) {
				vUrl += "&storeSeq=" + $("#storeSeq option:selected").val();	
			} else {
				vUrl += "&storeSeq=" + "";
			}
			
			fn_mobile_download(vUrl);
		}
		
		function fnSalesPresentDetail(storeSeq, resultDate, unitSeq, onoffNm ) {
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2PresentDetail.do";
			
			url += "?zemosIdx="	     + zemosIdx;
			url += "&wrkplcIdx="	 + wrkplcIdx;
			url += "&storeSeq="      + storeSeq;
			url += "&resultDate="    + resultDate;
			url += "&onoffNm="        + onoffNm;
			url += "&unitSeq="       + unitSeq;
			url += "&userAdminGbn="  + userAdminGbn;
			url += "&salesabun="     + salesabun;
			url += "&startDate="     + startDate;
			url += "&endDate="       + endDate;
			
			if ( $("#storeSeq").val() != 'A' ) {
				url += "&storeSeq=" + $("#storeSeq option:selected").val();	
			} else {
				url += "&storeSeq=" + "";
			}
			
			
			fn_location_href(url);
		}

		function fn_back2() {
			var storeSeqVal = "";
			console.log($("#storeSeq").val());
			if ( $("#storeSeq").val() != 'A' ) {
				storeSeqVal = $("#storeSeq option:selected").val();	
			} else {
				storeSeqVal = "";
			}
			if ( userAdminGbn == "A" ) {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeqVal+"&yyyy="+yyyy+"&mm="+mm+"&salesabun=" + salesabun);
			} else {
				<c:if test="${loginVO.zemosAuth == '12000'}">
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeqVal+"&yyyy="+yyyy+"&mm="+mm+"&salesabun=" + salesabun);
				</c:if>
				<c:if test="${loginVO.zemosAuth == '11000'}">
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&salesabun="+salesabun+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeqVal+"&yyyy="+yyyy+"&mm="+mm);
				</c:if>
			}
		}
		
		function mergeTable(target, index) {
		    var loop = null;
		    var start_idx = 0;  //최초 td 인덱스를 담을 변수
		    var add_num = 1;    //마지막 td 인덱스를 담을 변수
		    $(target).find('tr').each(function (idx) {
		        var target_text = $(this).find('td').eq(index).text();
		        if (!loop) {  //최초 동작
		            loop = target_text;
		            start_idx = idx;
		        } else if (target_text == loop) {  //같은 열 발견
		            add_num++;
		            //같은열 + 마지막
		            if (idx == $(target).find('tr').length - 1) {
		                $(target).find('tr').eq(start_idx).find('td').eq(index).attr("rowSpan", add_num).css('vertical-align', 'middle');
		                for (var i = start_idx + 1; i < start_idx + add_num; i++) {
		                    $(target).find('tr').eq(i).find('td').eq(index).hide(); //hide로 변경
		                }
		            }
		        } else { //다른 텍스트 발견
		            if (add_num != 1) {    //머지가 필요한 경우
		                $(target).find('tr').eq(start_idx).find('td').eq(index).attr("rowSpan", add_num).css('vertical-align', 'middle');
		                for (var i = start_idx + 1; i < start_idx + add_num; i++) {
		                    $(target).find('tr').eq(i).find('td').eq(index).hide(); //hide로 변경
		                }
		            }
		            start_idx = idx;
		            loop = target_text;
		            add_num = 1;
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
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">판매관리 현황</span>
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
	
		<!-- {매장} 셀렉박스 -->
		<span class="fl mb5" style="width:60%; padding-right:5%;">
			<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%">
	   			<option value="" <c:if test="${ params.storeSeq[0] eq ''}">selected</c:if>>${storeUseName[0].storeUseNm}전체</option>
	   			<c:forEach items="${storeList}" var="store" varStatus="status">
	   				<option value="${store.storeSeq}" <c:if test="${store.storeSeq eq params.storeSeq[0]}">selected</c:if>>${store.storeNm}</option>
	   			</c:forEach>
			</select>
		</span>
		
		<!-- 기준단위 셀렉박스 -->
		<span class="fl mb5" style="width:30%;">
	    	<select id="unitSeq" class="zemos_select1" style="width:100%">
	    		<option value="" <c:if test="${ params.unitSeq[0] eq ''}">selected</c:if>>기준단위</option>
				<c:forEach items="${unitList}" var="unit" varStatus="status">
					<option value="${unit.unitSeq}" <c:if test="${unit.unitSeq eq params.unitSeq[0]}">selected</c:if>>${unit.unitNm}</option>
				</c:forEach>
			</select>
		</span>
		
		<!-- 검색 아이콘 -->
		<span class="fr mb5" style="position: absolute; margin-top: 1px; right: 20px;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
		
		<!-- 품목명 셀렉박스 -->
		<span class="fl mb5" style="width:60%; padding-right:5%;">
			<select id="itemSeq" name="itemSeq" class="zemos_select1" style="width:100%">
	   			<option value="" <c:if test="${ params.itemSeq[0] eq ''}">selected</c:if>>${itemUseName[0].itemUseNm} &nbsp;전체</option>
	   			<c:forEach items="${itemList}" var="item" varStatus="status">
	   			<option value="${item.itemSeq}" <c:if test="${item.itemSeq eq params.itemSeq[0]}">selected</c:if>>${item.itemNm}</option>
	   			</c:forEach>
			</select>
		</span>
		
		<!-- 온/오프 셀렉박스 -->
		<span class="fl mb5" style="width:30%;">
	    	<select id="onoffNm" class="zemos_select1" style="width:100%">
	    	<option value="" <c:if test="${ params.onoffNm[0] eq ''}">selected</c:if>>온/오프</option>
				<c:forEach items="${onoffList}" var="onoff" varStatus="status">
					<option value="${onoff.onoffNm}" <c:if test="${onoff.onoffNm eq params.onoffNm[0]}">selected</c:if>>${onoff.onoffNm}</option>
				</c:forEach>
			</select>
		</span>
	</div>
	
	<div class="zemos_label_search1">
	
		<!-- 캘린더 -->
		<div style="width:60%; float: left;">
			<input id="startDate" name="startDate" type="text" class="zemos_input1" style="width:45%; font-size:12px; float: left;" value="${params.startDate[0]}"/>
			<span style="width: 2%; float: left; padding: 8px;"> ~ </span>
			<input id="endDate" name="endDate" type="text" class="zemos_input1" style="width:45%; font-size:12px; float: left; "value="${params.endDate[0]}"/>
		</div>
		
		<!-- 엑셀 저장 버튼 -->
		<div style="width:40%; float: left; text-align: center;">
			<span class="fr mb5" style="position: absolute; margin-top: 1px; right:30%; width:10%;">
				<a href="javascript:void(0);" onclick="javascript:fnExcel('M1'); return false;" class="zemos_form_span_btn_blue">
					<span style="font-size:10px;">엑셀</span>
				</a>
			</span>
			<span class="fr mb5" style="position: absolute; margin-top: 1px; right:11%; width:16%;">
				<a href="javascript:void(0);" onclick="javascript:fnExcel('M2'); return false;" class="zemos_form_span_btn_blue">
					<span style="font-size:10px;">월대장엑셀</span>
				</a>
			</span>
		</div>
	</div>
    <!--조회조건끝-->
    
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <p class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${salesPresentCnt.cnt}</span>건
        </p>
    </div>
    <!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
	    <table class="zemos_table1" style="margin-top: 0px;">
	        <colgroup>
				<col width="25%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
				<col width="30%" />
				<col width="10%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th style="padding: 10px 5px;">${storeUseName[0].storeUseNm}</th>
	        		<th style="padding: 10px 5px;">일자</th>
	        		<th style="padding: 10px 5px;">기준</th>
	        		<th style="padding: 10px 5px;">온/오프</th>
	        		<th style="padding: 10px 5px;">실적</th>
	        		<th style="padding: 10px 5px;">수량</th>
	        	</tr>
	        </thead>
	        <tbody id="merge">
	        	<c:choose>
		        	<c:when test="${fn:length(selectSalesPresent) > 0}">
		        		<c:forEach items="${selectSalesPresent}" var="item" varStatus="status">
					        <tr>
					        
					        	<c:if test="${item.totResult ne 0}">
					        		
					        		<td class="storeNm" style="width: 25%; padding: 10px 5px; text-align: center;">
					        			${item.storeNm}
					        		</td>
					        		
					        		<td class="resultDate" style="width: 15%; padding: 10px 2px; text-align: center;">
					        			${item.resultDate}
					        		</td>
					        		
					        		<td class="unitNm" style="width: 10%; padding: 10px 5px; text-align: center;">
					        			${item.unitNm}
					        		</td>
					        		
					        		<td style="width: 10%; padding: 10px 5px; text-align: center;" 
					        		    onClick="javascript:fnSalesPresentDetail('${item.storeSeq}', '${item.resultDate}', '${item.unitSeq}', '${item.onoffNm}');">
					        			${item.onoffNm}
					        		</td>
					        		
					        		<td style="width: 30%; padding: 10px 5px; text-align: center;" 
					        		    onClick="javascript:fnSalesPresentDetail('${item.storeSeq}', '${item.resultDate}', '${item.unitSeq}', '${item.onoffNm}');">
					        			<fmt:formatNumber value="${item.totResult}" pattern="#,###" />
					        		</td>
					        		
					        		<td style="width: 10%; padding: 10px 5px; text-align: center;" 
					        		    onClick="javascript:fnSalesPresentDetail('${item.storeSeq}', '${item.resultDate}', '${item.unitSeq}', '${item.onoffNm}');">
					        			<fmt:formatNumber value="${item.totResultQty}" pattern="#,###" />
					        		</td>
				        		</c:if>
				        		
				        	</tr>
		        		</c:forEach>
		        	</c:when>
		        <c:otherwise>
		        <tr>
		        	<td colspan="7">
		        		등록된 판매관리 현황이 없습니다.
		        	</td>
		        </tr>
		        	</c:otherwise>
		        </c:choose>
	        </tbody>
	        <tfoot id="merge2">
		        <c:choose>
			    	<c:when test="${fn:length(selectSalesPresentSum) > 0}">
			        	<c:forEach items="${selectSalesPresentSum}" var="sum" varStatus="status">
			                <tr style="background-color:#CEE3F6; font-weight:bold;">
			                
			                	<td class="sum" colspan="2" style="padding: 5px; text-align: center; font-size: 12px;">
			                		합계
			                	</td>
			                	
			                    <td class="unitNm" style="padding: 5px; text-align: center; font-size: 12px;">
			                    	${sum.unitNm}
			                    </td>
			                    
			                    <td style="padding: 5px; text-align: center; font-size: 12px;">
			                    	${sum.onoffNm}
			                    </td>
			                    
			                    <td style="padding: 5px; text-align: center; font-size: 12px;">
			                    	<fmt:formatNumber value="${sum.resultSum}" pattern="#,###" />
			                    </td>
			                    
			                    <td style="padding: 5px; text-align: center; font-size: 12px;">
			                    	<fmt:formatNumber value="${sum.resultQtySum}" pattern="#,###" />
			                    </td>
			                    
			                </tr>
	                	</c:forEach>
	                </c:when>
	            </c:choose>
            </tfoot>
	    </table>
	    
	    <!-- 페이징 처리 -->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosPaging.jsp"%>
	    <!-- 페이징 처리 -->
	    
    </div>
   
    <!--조회된자료끝-->
    
</body>
</html>