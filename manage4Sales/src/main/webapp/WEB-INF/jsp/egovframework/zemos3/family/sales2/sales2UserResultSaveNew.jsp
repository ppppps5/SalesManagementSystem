<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!-- 오늘날짜 비교 했을 때 당일/하루전 아니면 아예 저장 버튼 안 보이게 처리 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="today"><fmt:formatDate value="${today}" pattern="yyyyMMdd" /></c:set> 
<c:set var="yesterday" value="<%=new java.util.Date(new java.util.Date().getTime() - 60*60*24*1000)%>"/>
<c:set var="yesterday"><fmt:formatDate value="${yesterday}" pattern="yyyyMMdd" /></c:set> 

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
			max-width: 100%;
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
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var resultDt = ("${params.resultDt[0]}") ? "${params.resultDt[0]}" : "${salesDay.resultDt}";
		var storeSeq = "${params.storeSeq[0]}";
		var gbn = "${params.gbn[0]}";
		//관리자 권한추가
		var userAdminGbn = "${userAdminGbn}";
		
		var pyyyy = "${params.yyyy[0]}";
		var pmm = "${params.mm[0]}";
		
		
		var yyyy = "${salesDay.yyyy}";
		var mm = "${salesDay.mm}";
		var dd = "${salesDay.dd}";
		var itemOnOff =[]
		$(document).ready(function () {
			<c:set var="onCnt" value="0"/>
			<c:set var="offCnt" value="0"/>
			<c:forEach items="${itemList}" var="item" varStatus="status">
			<c:choose>
        	<c:when test="${item.onoffYn == '0'}">
        		<c:set var="offCnt" value="${offCnt + 1}"/>
        	</c:when>
        	<c:otherwise>
        		<c:set var="onCnt" value="${onCnt+1}"/>
        	</c:otherwise>
        	</c:choose>
			</c:forEach>
			
			$(".itemOnOff").each(function(idx){
				$(".itemListTr").each(function(j){
					if($(".itemOnOff").eq(idx).val() == $(this).attr("id")){
						$(this).remove();
					}
				})
			})
			
			<c:if test="${itemList[0].unit1Yn == 'Y'}">
			sumtot('on_unit1_totAmt');
			sumtot('off_unit1_totAmt');
			sumtot('on_unit1_totQty');
			sumtot('off_unit1_totQty');
			sumtot('unit1_all_totQty');
			sumtot('unit1_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit2Yn == 'Y'}">
			sumtot('on_unit2_totAmt');
			sumtot('off_unit2_totAmt');
			sumtot('on_unit2_totQty');
			sumtot('off_unit2_totQty');
			sumtot('unit2_all_totQty');
			sumtot('unit2_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit3Yn == 'Y'}">
			sumtot('on_unit3_totAmt');
			sumtot('off_unit3_totAmt');
			sumtot('on_unit3_totQty');
			sumtot('off_unit3_totQty');
			sumtot('unit3_all_totQty');
			sumtot('unit3_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit4Yn == 'Y'}">
			sumtot('on_unit4_totAmt');
			sumtot('off_unit4_totAmt');
			sumtot('on_unit4_totQty');
			sumtot('off_unit4_totQty');
			sumtot('unit4_all_totQty');
			sumtot('unit4_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit5Yn == 'Y'}">
			sumtot('on_unit5_totAmt');
			sumtot('off_unit5_totAmt');
			sumtot('on_unit5_totQty');
			sumtot('off_unit5_totQty');
			sumtot('unit5_all_totQty');
			sumtot('unit5_all_totAmt');
			</c:if>
			sumtot('totQty');
			sumtot('totAmt');
			var now = new Date();
		    var year = now.getFullYear();
		    var month = now.getMonth() + 1;    //1월이 0으로 되기때문에 +1을 함.
		    var date = now.getDate();

		    month = month >=10 ? month : "0" + month;
		    date  = date  >= 10 ? date : "0" + date;
		     // ""을 빼면 year + month (숫자+숫자) 됨.. ex) 2018 + 12 = 2030이 리턴됨.
			var tymd = ""+year + month + date;
			var rtymd = yyyy+ mm+ dd;
			
			$("#storeSeq").select2(); //storeSeq는 selectbox id
			$(".select2-selection__arrow").hide();
			
			
			var rowCnt = 0;
			$("input[name=qty]").each(function(idx){   
		        // 해당 input의 Value 가져오기
		        //var value = $(this).val();
		        //var qtyValue = $("input[name=qty]:eq(" + idx + ")").val();
		        //var itemNameValue = $("input[name=pItemNm]:eq(" + idx + ")").val();
		        //console.log('itemNameValue > ' + itemNameValue) ;
		        rowCnt = idx + 1;
		        if ( tymd == rtymd ) {
					$("#delBtn"+rowCnt).show();
				} else {
					$("#delBtn"+rowCnt).hide();
				}
			});
			
			
			
			
			//시간
			$('#today').mobiscroll().time({
				theme: 'android-holo-light',
		        display: 'modal',
		        mode: 'scroller',
		        dateOrder: 'yy mm dd',
		        dateFormat : "yy-mm-dd",
		        maxDate: new Date(2099, 11, 31), // 2099-12-31 까지
				onSelect: function (valueText, inst) {
			    }
		    });
		});
		
		function fnResultAdd() {
			<c:if test = "${closeYn[0].closeYn == 'Y'}">
				alert("월 마감이 끝난 달의 실적은 추가할 수 없습니다.");
				return;
			</c:if>
			
			$("#itemPopupStoreNm").text($("#storeSeq option:checked").text());
			
			
			////////////////////////////////////////////////////////////////////////////
			$("#itemPopup").show();
		}
		var innerCnt = 0;
		function fnItemSave() {
			var innerHtml = "";
			var itemSeqLength = ${fn:length(itemList)};
			var itemUseYnLength = $('input:checkbox[name="useYn"]').length;
			var rowLength = $("#resultTable > tbody > tr").length;
			
			for ( var i = 1; i <= itemSeqLength; i++ ) {
				
				if ( $("#itemChk"+i).is(":checked") == true ) {
					
					
					var iii = 0;
					//itemUseYnLength = itemUseYnLength + 1;
					for ( j = 0; j < rowLength; j++ ) {
						var kkk = $('.dItemSeqeq').eq(j).val();
						var KKK = $('.dchkIdxdx').eq(j).val();
						if($('#itemSeq'+i).val() == kkk && $('#chkIdx'+i).val() == KKK){
							iii++;
						}
						
					}
					
						
						if (iii == 0 ) {
							rowLength++;
							innerCnt++;
							//itemCostLength = itemUseYnLength;
							itemUseYnLength = rowLength;
							
							if(innerCnt > itemUseYnLength){
								itemUseYnLength = innerCnt;
							}
							var unitCnt = 1;
							
							if($("#unit1Yn"+i).val() == "Y"){
								unitCnt++;
							}
							if($("#unit2Yn"+i).val() == "Y"){
								unitCnt++;
							}
							if($("#unit3Yn"+i).val() == "Y"){
								unitCnt++;
							}
							if($("#unit4Yn"+i).val() == "Y"){
								unitCnt++;
							}
							if($("#unit5Yn"+i).val() == "Y"){
								unitCnt++;
							}
							// 입력 단가 별 금액 자동 계산 식2022.12.16
							var cost1 = $("#unit1Cost"+i).val();
							var cost2 = $("#unit2Cost"+i).val();
							var cost3 = $("#unit3Cost"+i).val();
							var cost4 = $("#unit4Cost"+i).val();
							var cost5 = $("#unit5Cost"+i).val();
							
							//alert(cost1);
							
							innerHtml += "<tr id=\"resultTableTr"+itemUseYnLength+"\"  class=\"resultTableTr\">";
							innerHtml += "	<td style=\"text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;\">";
							innerHtml += "		<input type=\"hidden\" id=\"pItemNm"+itemUseYnLength+"\" name=\"pItemNm\" value=\""+$("#itemNm"+i).val()+"\">";
							innerHtml += "		<input type=\"hidden\" id=\"dItemSeq"+itemUseYnLength+"\" name=\"dItemSeq\" class=\"dItemSeqeq\" value=\""+$("#itemChk"+i).val()+"\">";
							innerHtml += "		<input type=\"hidden\" id=\"dchkIdx"+itemUseYnLength+"\" name=\"dchkIdx\" class=\"dchkIdxdx\" value=\""+$("#chkIdx"+i).val()+"\"/>"; //여기추가
							innerHtml += "		<input type=\"hidden\" id=\"requestYn"+itemUseYnLength+"\" name=\"requestYn\" value=\"W\"/>"; //여기추가
							innerHtml += "		<input type=\"hidden\" id=\"historySeq"+itemUseYnLength+"\" name=\"historySeq\"/>"; //여기추가
							innerHtml += "		<input type=\"hidden\" id=\"detailHistorySeq"+itemUseYnLength+"\" name=\"detailHistorySeq\"/>"; //여기추가
							//innerHtml += "		<span style=\"width:100%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:15px; margin-left:10%;\">";
							innerHtml += $("#itemNm"+i).val();
							//innerHtml += "		</span>";
							innerHtml += "	</td>";
							innerHtml += "	<td colspan='3' style=\"padding: 7px 10px;\">";
							innerHtml += "	<table id=\"unitTable"+itemUseYnLength+"\"  class=\"unitTable\" colspan='3' style=\"width: 100%;\">";		
							if($("#onLine"+i).val() == "온라인"){
								innerHtml += "	<caption style = 'width:100%; height:100%;'><span style = 'font-size : 13px; font-weight: bold;'>온라인</span></caption>";							
							}
							if($("#offLine"+i).val() == "오프라인"){
								innerHtml += "	<caption style = 'width:100%; height:100%;'><span style = 'font-size : 13px; font-weight: bold;'>오프라인</span></caption>";							
							}
							if($("#unit1Yn").val() == "Y"){
								innerHtml += "<tr>";
								innerHtml += "	<td style=\"padding: 7px 10px;\">";
								innerHtml += $("#unitNm1").val();
								innerHtml += "	</td>";
								if($("#onLine"+i).val() == "온라인"){
								innerHtml += "	<td id=\"unit1Qty\"  class=\"unit1Qty\" style=\"padding: 7px 10px;\">";
								innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit1_all_totQty_class on_unit1_totQty_class qty1 on_unit1"+itemUseYnLength+" unit1"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit1_all_totQty'); sumtot('on_unit1_totQty', 'on_unit1"+itemUseYnLength+"'); sumtot('totQty', 'unit1"+itemUseYnLength+"');changeUnitCnt('"+cost1+"', 'unit1"+itemUseYnLength+"');\"/>";
								innerHtml += "	</td>";
								innerHtml += "	<td id=\"unit1Amt\"  class=\"unit1Amt\" style=\"padding: 7px 10px;\">";
								innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit1_all_totAmt_class on_unit1_totAmt_class amt1 on_unit1"+itemUseYnLength+"Cost unit1"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit1_all_totAmt'); sumtot('on_unit1_totAmt', 'on_unit1"+itemUseYnLength+"Cost');sumtot('totAmt', 'unit1"+itemUseYnLength+"Cost');\"/>";
								innerHtml += "	</td>";
								}else if($("#offLine"+i).val() == "오프라인"){
								innerHtml += "	<td id=\"unit1Qty\"  class=\"unit1Qty\" style=\"padding: 7px 10px;\">";
								innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit1_all_totQty_class off_unit1_totQty_class qty1 off_unit1"+itemUseYnLength+" unit1"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit1_all_totQty'); sumtot('off_unit1_totQty', 'off_unit1"+itemUseYnLength+"'); sumtot('totQty', 'unit1"+itemUseYnLength+"');changeUnitCnt('"+cost1+"', 'unit1"+itemUseYnLength+"');\"/>";
								innerHtml += "	</td>";
								innerHtml += "	<td id=\"unit1Amt\"  class=\"unit1Amt\" style=\"padding: 7px 10px;\">";
								innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit1_all_totAmt_class off_unit1_totAmt_class amt1 off_unit1"+itemUseYnLength+"Cost unit1"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit1_all_totAmt'); sumtot('off_unit1_totAmt', 'off_unit1"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit1"+itemUseYnLength+"Cost');\"/>";
								innerHtml += "	</td>";
								}
								
								innerHtml += "</tr>";
							}
								
							if($("#unit2Yn").val() == "Y"){
								innerHtml += "<tr>";
								innerHtml += "	<td style=\"padding: 7px 10px;\">";
								innerHtml += $("#unitNm2").val();
								innerHtml += "	</td>";
								if($("#onLine"+i).val() == "온라인"){
									innerHtml += "	<td id=\"unit2Qty\"  class=\"unit2Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit2_all_totQty_class on_unit2_totQty_class qty2 on_unit2"+itemUseYnLength+" unit2"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit2_all_totQty'); sumtot('on_unit2_totQty', 'on_unit2"+itemUseYnLength+"'); sumtot('totQty', 'unit2"+itemUseYnLength+"');changeUnitCnt('"+cost2+"', 'unit2"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit2Amt\"  class=\"unit2Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit2_all_totAmt_class on_unit2_totAmt_class amt2 on_unit2"+itemUseYnLength+"Cost unit2"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit2_all_totAmt'); sumtot('on_unit2_totAmt', 'on_unit2"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit2"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}else if($("#offLine"+i).val() == "오프라인"){
									innerHtml += "	<td id=\"unit2Qty\"  class=\"unit2Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit2_all_totQty_class off_unit2_totQty_class qty2 off_unit2"+itemUseYnLength+" unit2"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit2_all_totQty'); sumtot('off_unit2_totQty', 'off_unit2"+itemUseYnLength+"'); sumtot('totQty', 'unit2"+itemUseYnLength+"');changeUnitCnt('"+cost2+"', 'unit2"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit2Amt\"  class=\"unit2Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit2_all_totAmt_class off_unit2_totAmt_class amt2 off_unit2"+itemUseYnLength+"Cost unit2"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit2_all_totAmt'); sumtot('off_unit2_totAmt', 'off_unit2"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit2"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}
								innerHtml += "</tr>";
							}
							if($("#unit3Yn").val() == "Y"){
								innerHtml += "<tr>";
								innerHtml += "	<td style=\"padding: 7px 10px;\">";
								innerHtml += $("#unitNm3").val();
								innerHtml += "	</td>";
								if($("#onLine"+i).val() == "온라인"){
									innerHtml += "	<td id=\"unit3Qty\"  class=\"unit3Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit3_all_totQty_class on_unit3_totQty_class qty3 on_unit3"+itemUseYnLength+" unit3"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit3_all_totQty'); sumtot('on_unit3_totQty', 'on_unit3"+itemUseYnLength+"'); sumtot('totQty', 'unit3"+itemUseYnLength+"');changeUnitCnt('"+cost3+"', 'unit3"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit3Amt\"  class=\"unit3Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit3_all_totAmt_class on_unit3_totAmt_class amt3 on_unit3"+itemUseYnLength+"Cost unit3"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit3_all_totAmt'); sumtot('on_unit3_totAmt', 'on_unit3"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit3"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}else if($("#offLine"+i).val() == "오프라인"){
									innerHtml += "	<td id=\"unit3Qty\"  class=\"unit3Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit3_all_totQty_class off_unit3_totQty_class qty3 off_unit3"+itemUseYnLength+" unit3"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit3_all_totQty'); sumtot('off_unit3_totQty', 'off_unit3"+itemUseYnLength+"'); sumtot('totQty', 'unit3"+itemUseYnLength+"');changeUnitCnt('"+cost3+"', 'unit3"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit3Amt\"  class=\"unit3Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit3_all_totAmt_class off_unit3_totAmt_class amt3 off_unit3"+itemUseYnLength+"Cost unit3"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit3_all_totAmt'); sumtot('off_unit3_totAmt', 'off_unit3"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit3"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}
								innerHtml += "</tr>";
							}
							if($("#unit4Yn").val() == "Y"){
								innerHtml += "<tr>";
								innerHtml += "	<td style=\"padding: 7px 10px;\">";
								innerHtml += $("#unitNm4").val();
								innerHtml += "	</td>";
								if($("#onLine"+i).val() == "온라인"){
									innerHtml += "	<td id=\"unit4Qty\"  class=\"unit4Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit4_all_totQty_class on_unit4_totQty_class qty4 on_unit4"+itemUseYnLength+" unit4"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit4_all_totQty'); sumtot('on_unit4_totQty', 'on_unit4"+itemUseYnLength+"'); sumtot('totQty', 'unit4"+itemUseYnLength+"');changeUnitCnt('"+cost4+"', 'unit4"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit4Amt\"  class=\"unit4Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit4_all_totAmt_class on_unit4_totAmt_class amt4 on_unit4"+itemUseYnLength+"Cost unit4"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit4_all_totAmt'); sumtot('on_unit4_totAmt', 'on_unit4"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit4"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}else if($("#offLine"+i).val() == "오프라인"){
									innerHtml += "	<td id=\"unit4Qty\"  class=\"unit4Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit4_all_totQty_class off_unit4_totQty_class qty4 off_unit4"+itemUseYnLength+" unit4"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit4_all_totQty'); sumtot('off_unit4_totQty', 'off_unit4"+itemUseYnLength+"'); sumtot('totQty', 'unit4"+itemUseYnLength+"');changeUnitCnt('"+cost4+"', 'unit4"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit4Amt\"  class=\"unit4Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit4_all_totAmt_class off_unit4_totAmt_class amt4 off_unit4"+itemUseYnLength+"Cost unit4"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit4_all_totAmt'); sumtot('off_unit4_totAmt', 'off_unit4"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit4"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}
								innerHtml += "</tr>";
							}
							if($("#unit5Yn").val() == "Y"){
								innerHtml += "<tr>";
								innerHtml += "	<td style=\"padding: 7px 10px;\">";
								innerHtml += $("#unitNm5").val();
								innerHtml += "	</td>";
								if($("#onLine"+i).val() == "온라인"){
									innerHtml += "	<td id=\"unit5Qty\"  class=\"unit5Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit5_all_totQty_class on_unit5_totQty_class qty5 on_unit5"+itemUseYnLength+" unit5"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit5_all_totQty'); sumtot('on_unit5_totQty', 'on_unit5"+itemUseYnLength+"'); sumtot('totQty', 'unit5"+itemUseYnLength+"');changeUnitCnt('"+cost5+"', 'unit5"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit5Amt\"  class=\"unit5Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit5_all_totAmt_class on_unit5_totAmt_class amt5 on_unit5"+itemUseYnLength+"Cost unit5"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit5_all_totAmt'); sumtot('on_unit5_totAmt', 'on_unit5"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit5"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}else if($("#offLine"+i).val() == "오프라인"){
									innerHtml += "	<td id=\"unit4Qty\"  class=\"unit4Qty\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class unit5_all_totQty_class off_unit5_totQty_class qty5 off_unit5"+itemUseYnLength+" unit5"+itemUseYnLength+"\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit5_all_totQty'); sumtot('off_unit5_totQty', 'off_unit5"+itemUseYnLength+"'); sumtot('totQty', 'unit5"+itemUseYnLength+"');changeUnitCnt('"+cost5+"', 'unit5"+itemUseYnLength+"');\"/>";
									innerHtml += "	</td>";
									innerHtml += "	<td id=\"unit4Amt\"  class=\"unit4Amt\" style=\"padding: 7px 10px;\">";
									innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class unit5_all_totAmt_class off_unit5_totAmt_class amt5 off_unit5"+itemUseYnLength+"Cost unit5"+itemUseYnLength+"Cost\" pattern=\"[^-0-9]\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^-0-9]/g,''); sumtot('unit5_all_totAmt'); sumtot('off_unit5_totAmt', 'off_unit5"+itemUseYnLength+"Cost'); sumtot('totAmt', 'unit5"+itemUseYnLength+"Cost');\"/>";
									innerHtml += "	</td>";
									}
								innerHtml += "</tr>";
							}
							innerHtml += "	</table>";
							innerHtml += "	</td>";
							innerHtml += "	<td style=\"padding: 7px 10px;\">";
							//innerHtml += "		<span class=\"fr mb5\">";
							innerHtml += "		<span class=\"mb5\">";
							if($("#onLine"+i).val() == "온라인"){
							innerHtml += "			<a href=\"javascript:void(0);\" onclick=\"javascript:fnResultDel('"+itemUseYnLength+"'); fnOnAll(); sumtot('totQty');sumtot('totAmt'); return false;\" class=\"zemos_form_span_btn_red\">";
							}
							if($("#offLine"+i).val() == "오프라인"){
							innerHtml += "			<a href=\"javascript:void(0);\" onclick=\"javascript:fnResultDel('"+itemUseYnLength+"'); fnOffAll(); sumtot('totQty');sumtot('totAmt'); return false;\" class=\"zemos_form_span_btn_red\">";
							}
							innerHtml += "				<span style=\"font-size:13px;\">삭제</span>";
							innerHtml += "			</a>";
							innerHtml += "		</span>";
							innerHtml += "	</td>";
							innerHtml += "</tr>";
						}
					
					}else{
						for ( var q = 1; q <= itemSeqLength; q++ ) {
							if($("#chkIdx"+i).val()==$("#dchkIdx"+q).val()){
								var itemLength = $("#itemPopupTable > tbody > tr").length;
								$("#itemChk"+$("#dchkIdx"+q).val()).prop("checked", true);
								if(itemLength == $('.dchkIdxdx').length){
									$("#allChk").prop("checked", true);
								}
							}
							
						}
					}
					
			}
			$("#resultTable > tbody:last").append(innerHtml);
			$('.zemos_modal').hide();
			
			//저장 버튼을 추가한다
			/////////////////////////////////////////////////////////////////////////////////////////////////
			var resultTableTrLength = $(".resultTableTr").length;
			
			if(0 < resultTableTrLength) {$('#saveBtnDiv').show();}
			/////////////////////////////////////////////////////////////////////////////////////////////////
		}
		
		function fnOnAll(){
			<c:if test="${itemList[0].unit1Yn == 'Y'}">
			sumtot('on_unit1_totAmt');
			sumtot('on_unit1_totQty');
			sumtot('unit1_all_totQty');
			sumtot('unit1_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit2Yn == 'Y'}">
			sumtot('on_unit2_totAmt');
			sumtot('on_unit2_totQty');
			sumtot('unit2_all_totQty');
			sumtot('unit2_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit3Yn == 'Y'}">
			sumtot('on_unit3_totAmt');
			sumtot('on_unit3_totQty');
			sumtot('unit3_all_totQty');
			sumtot('unit3_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit4Yn == 'Y'}">
			sumtot('on_unit4_totAmt');
			sumtot('on_unit4_totQty');
			sumtot('unit4_all_totQty');
			sumtot('unit4_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit5Yn == 'Y'}">
			sumtot('on_unit5_totAmt');
			sumtot('on_unit5_totQty');
			sumtot('unit5_all_totQty');
			sumtot('unit5_all_totAmt');
			</c:if>
		}
		function fnOffAll(){
			<c:if test="${itemList[0].unit1Yn == 'Y'}">
			sumtot('off_unit1_totAmt');
			sumtot('off_unit1_totQty');
			sumtot('unit1_all_totQty');
			sumtot('unit1_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit2Yn == 'Y'}">
			sumtot('off_unit2_totAmt');
			sumtot('off_unit2_totQty');
			sumtot('unit2_all_totQty');
			sumtot('unit2_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit3Yn == 'Y'}">
			sumtot('off_unit3_totAmt');
			sumtot('off_unit3_totQty');
			sumtot('unit3_all_totQty');
			sumtot('unit3_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit4Yn == 'Y'}">
			sumtot('off_unit4_totAmt');
			sumtot('off_unit4_totQty');
			sumtot('unit4_all_totQty');
			sumtot('unit4_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit5Yn == 'Y'}">
			sumtot('off_unit5_totAmt');
			sumtot('off_unit5_totQty');
			sumtot('unit5_all_totQty');
			sumtot('unit5_all_totAmt');
			</c:if>
		}
		
		
		function fnResultDel(trCnt) {
			var tr = $("#resultTableTr"+trCnt);
			$("#itemChk"+$("#dchkIdx"+trCnt).val()).prop("checked", false);
			$("#allChk").prop("checked", false);
			tr.remove();
			//저장 버튼을 추가한다
			/////////////////////////////////////////////////////////////////////////////////////////////////
			var resultTableTrLength = $(".resultTableTr").length;
			
			if(0 >= resultTableTrLength) {$('#saveBtnDiv').hide();}
			/////////////////////////////////////////////////////////////////////////////////////////////////
		}
		
		function fnUserResultSave() {
			var params = {};
			
			var i = 0;
			var iItemNameValue;
			$("input[name=qty]").each(function(idx){   
		        // 해당 input의 Value 가져오기
		        var value = $(this).val();
		        var qtyValue = $("input[name=qty]:eq(" + idx + ")").val();
		        iItemNameValue = $(this).parents("tr.resultTableTr").children().eq(0).text().trim();
		        
		        //console.log('itemNameValue > ' + itemNameValue) ;
		        $(this).parents("tr.resultTableTr").children().eq(0).text()
		        
		        if ( qtyValue == null || qtyValue ==  "" ) {
		        	i++;
					$("input[name=qty]:eq(" + idx + ")").focus();
					if ( i > 0 ) {
						return false;
					}
				}
		        
			});
			if ( i > 0 ) {
				alert(iItemNameValue +"${itemList[1].itemUseNm}"+" 의 수량을 입력하세요.");
				return;
			}
			
			var k = 0;
			var kItemNameValue;
			$("input[name=amt]").each(function(idx){   
		        // 해당 input의 Value 가져오기
		        var value = $(this).val();
		        var amtValue = $("input[name=amt]:eq(" + idx + ")").val() ;
		        kItemNameValue = $(this).parents("tr.resultTableTr").children().eq(0).text().trim();
		        
		        if ( amtValue == null || amtValue ==  "" ) {
		        	k++;
					$("input[name=amt]:eq(" + idx + ")").focus();
					if ( k > 0 ) {
						return false;
					}
				}
			});
			if ( k > 0 ) {
				alert(kItemNameValue +"${itemList[1].itemUseNm}"+" 의 금액을 입력하세요.");
				return;
			}

			fn_loading_show();
			var items = [];
			params.resultDt = $("#resultDt").val();
			params.zemosIdx = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			params.storeSeq = storeSeq;
			<c:if test="${itemList[0].unit1Yn == 'Y'}">			
				params.unitSeq1 = ${itemList[0].unitSeq1};
				params.unit1Yn = "${itemList[0].unit1Yn}";
			</c:if>
			<c:if test="${itemList[0].unit2Yn == 'Y'}">			
				params.unitSeq2 = ${itemList[0].unitSeq2};
				params.unit2Yn = "${itemList[0].unit2Yn}";
			</c:if>
			<c:if test="${itemList[0].unit3Yn == 'Y'}">			
				params.unitSeq3 = ${itemList[0].unitSeq3};
				params.unit3Yn = "${itemList[0].unit3Yn}";
			</c:if>
			<c:if test="${itemList[0].unit4Yn == 'Y'}">			
				params.unitSeq4 = ${itemList[0].unitSeq4};
				params.unit4Yn = "${itemList[0].unit4Yn}";
			</c:if>
			<c:if test="${itemList[0].unit5Yn == 'Y'}">			
				params.unitSeq5 = ${itemList[0].unitSeq5};
				params.unit5Yn = "${itemList[0].unit5Yn}";
			</c:if>
			
			var insertItemCnt = 0;
			$("input[name=dItemSeq]").each(function(idx){
				insertItemCnt = idx+1;
				var item = {};
				var useUnitCnt = 0;
				item.itemSeq = $(this).val();
					<c:if test="${itemList[0].unit1Yn == 'Y'}">
						useUnitCnt++
						if($(this).parents("tr.resultTableTr").children().eq(1).children("table").children("caption").text().trim()=="오프라인"){
							item.qty1 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit1Qty").children().val();
							item.amt1 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit1Amt").children().val();
							item.onOff = "off"; 
						}else{
							item.qty1_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit1Qty").children().val();
							item.amt1_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit1Amt").children().val();
							item.onOff = "on";
						}
					</c:if>
					<c:if test="${itemList[0].unit2Yn == 'Y'}">
						useUnitCnt++
						if($(this).parents("tr.resultTableTr").children().eq(1).children("table").children("caption").text().trim()=="오프라인"){
							item.qty2 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit2Qty").children().val();
							item.amt2 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit2Amt").children().val();
							item.onOff = "off";
						}else{
							item.qty2_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit2Qty").children().val();
							item.amt2_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit2Amt").children().val();
							item.onOff = "on";
						}
					</c:if>
					<c:if test="${itemList[0].unit3Yn == 'Y'}">
						useUnitCnt++
						if($(this).parents("tr.resultTableTr").children().eq(1).children("table").children("caption").text().trim()=="오프라인"){
							item.qty3 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit3Qty").children().val();
							item.amt3 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit3Amt").children().val();
							item.onOff = "off";
						}else{
							item.qty3_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit3Qty").children().val();
							item.amt3_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit3Amt").children().val();
							item.onOff = "on";
						}
					</c:if>
					<c:if test="${itemList[0].unit4Yn == 'Y'}">
						useUnitCnt++
						if($(this).parents("tr.resultTableTr").children().eq(1).children("table").children("caption").text().trim()=="오프라인"){
							item.qty4 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit4Qty").children().val();
							item.amt4 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit4Amt").children().val();
							item.onOff = "off";
						}else{
							item.qty4_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit4Qty").children().val();
							item.amt4_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit4Amt").children().val();
							item.onOff = "on";
						}
					</c:if>
					<c:if test="${itemList[0].unit5Yn == 'Y'}">
						useUnitCnt++
						if($(this).parents("tr.resultTableTr").children().eq(1).children("table").children("caption").text().trim()=="오프라인"){
							item.qty5 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit5Qty").children().val();
							item.amt5 = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit5Amt").children().val();
							item.onOff = "off";
						}else{
							item.qty5_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit5Qty").children().val();
							item.amt5_on = $(this).parents("tr.resultTableTr").children().eq(1).children("table").children("tbody").children("tr").children("td.unit5Amt").children().val();
							item.onOff = "on";
						}
					</c:if>
					items.push(item);
					params.useUnitCnt = useUnitCnt;
			})
			params.item = items;			
			params.insertItemCnt = insertItemCnt;
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2UserResultSaveNew.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					fn_loading_hide();
					alert($("#storeSeq option:selected").text() + "의 실적을 저장하였습니다.");
					fnSearch('D');
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		//조회
		//gbn이 D이면 매장명 select, P이면 이전날짜, N이면 이후날짜
		function fnSearch(gbn) {
			
			var resultDt = $("#resultDt").val();
			var yyyyMmDd;
			var y = resultDt.substr(0, 4);
		    var m = resultDt.substr(4, 2);
		    var d = resultDt.substr(6, 2);
			if ( gbn == 'P' ) {
				yyyyMmDd = new Date(y,m-1,d);
				yyyyMmDd.setDate(yyyyMmDd.getDate() - 1);
			} else if ( gbn == 'N' ) {
				yyyyMmDd = new Date(y,m-1,d);
				yyyyMmDd.setDate(yyyyMmDd.getDate() + 1);
			} else {
				yyyyMmDd = new Date(y, m-1, d);
				yyyyMmDd.setDate(yyyyMmDd.getDate());
			}
			var year  = yyyyMmDd.getFullYear();
			var month = (yyyyMmDd.getMonth() + 1) > 9 ? '' + (yyyyMmDd.getMonth() + 1) : '0' + (yyyyMmDd.getMonth() + 1);
			var day   = yyyyMmDd.getDate() > 9 ? '' + yyyyMmDd.getDate() : '0' + yyyyMmDd.getDate();
			
			if ( gbn != 'D' && (new Date() < yyyyMmDd) ) {
				alert("오늘이후 날짜의 실적을 입력할 수 없습니다.");
				yyyyMmDd.setDate(yyyyMmDd.getDate() - 1);
				return;
			}
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserResultNew.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&salesabun=" + salesabun;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq=" + $("#storeSeq option:selected").val();
			url += "&resultDt=" + year + month + day;
			url += "&gbn=" + gbn;
			//관리자 권한추가
			url += "&userAdminGbn="  + userAdminGbn;
			//관리자 권한추가
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&yyyy=" + year;
			url += "&mm=" + month;
			
			
			fn_location_href(url);
		}
		
		//제모스 판매관리 매장정보설정 이동
		function fn_back2() {
			//관리자 권한추가
			if ( userAdminGbn == "A" ) {
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm+"&salesabun=" + salesabun);
			} else {
				<c:if test="${loginVO.zemosAuth == '12000'}">
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm+"&salesabun=" + salesabun);
				</c:if>
				<c:if test="${loginVO.zemosAuth == '11000'}">
				fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?userAdminGbn="+userAdminGbn+"&zemosIdx="+zemosIdx+"&salesabun="+salesabun+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx+"&storeSeq="+storeSeq+"&yyyy="+yyyy+"&mm="+mm);
				</c:if>
			}
		}
		
		function fnCheckBox(row) {
			if ( $("#itemChk"+row).is(":checked") == true ) {
				$("#allChk").prop("checked", false);
				$("#itemChk"+row).prop("checked", false);
			} else {
				$("#itemChk"+row).prop("checked", true);
				
				var tot = 0;
				for(i=0;i<$(".itemChk").length;i++){
					if($(".itemChk").eq(i).is(":checked") == true){
						tot++;
					}
				}
				if(tot == $(".itemChk").length){
					$("#allChk").prop("checked", true);
				}
			}
		}
		
		function fnAllCheckBox() {
			if ( $("#allChk").is(":checked") == true ) {
				$("#allChk").prop("checked", false);
				$(".itemChk").prop("checked", false);
			} else {
				$("#allChk").prop("checked", true);
				$(".itemChk").prop("checked", true);
			}
		}
		
		function sumtot(val, unit){
				if(val=="totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit1_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit1_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit2_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit2_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit3_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit3_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit4_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit4_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit5_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit5_totQty" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit1_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit1_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit2_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit2_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit3_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit3_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit4_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit4_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="on_unit5_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				if(val=="off_unit5_totAmt" && $("."+unit).val() == "-"){
					return;
				}
				
			var sum = 0;
			
			for(var i=0;i < $('.'+val+'_class').length;i++){
				
				var val_class = ($('.'+val+'_class').eq(i).val() != "") ? parseInt($('.'+val+'_class').eq(i).val().replace(/,/g, "")) : 0;
				sum += val_class;
			}
			
			$('#'+val).empty().text(sum.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			
		}
		function changeUnitCnt(unitCost, unit){
			if(unitCost == null || unitCost == ""){
				return;
			}
			if($("."+unit).val()=="-"){
				return;
			}
			$("."+unit+"Cost").val(unitCost*$("."+unit).val());
			sumtot("totAmt");
			<c:if test="${itemList[0].unit1Yn == 'Y'}">
			sumtot('on_unit1_totAmt');
			sumtot('off_unit1_totAmt');
			sumtot('unit1_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit2Yn == 'Y'}">
			sumtot('on_unit2_totAmt');
			sumtot('off_unit2_totAmt');
			sumtot('unit2_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit3Yn == 'Y'}">
			sumtot('on_unit3_totAmt');
			sumtot('off_unit3_totAmt');
			sumtot('unit3_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit4Yn == 'Y'}">
			sumtot('on_unit4_totAmt');
			sumtot('off_unit4_totAmt');
			sumtot('unit4_all_totAmt');
			</c:if>
			<c:if test="${itemList[0].unit5Yn == 'Y'}">
			sumtot('on_unit5_totAmt');
			sumtot('off_unit5_totAmt');
			sumtot('unit5_all_totAmt');
			</c:if>
		}
		
		function fnResultDallerChange(){
			
			var dollarAmt = $('#dollarAmt').val();
			
			dollarAmt = dollarAmt.replace(/,/g, "");
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2UserResultDallerUpdate.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: $("#zemosForm").serialize()
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					fn_loading_hide();
					alert("달러 금액을 수정하였습니다.");
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
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
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">실적등록</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <form id="zemosForm" name="zemosForm" method="post" onsubmit="return false;" class="form-horizontal">
    <input type="hidden" id="resultDt" name="resultDt" value="${salesDay.resultDt}"/>
    <input type="hidden" id="saveGbn" name="saveGbn" />
    <input type="hidden" id="zemosIdx" name="zemosIdx" value="${params.zemosIdx[0]}" />
    <input type="hidden" id="wrkplcIdx" name="wrkplcIdx" value="${params.wrkplcIdx[0]}" />
    <input type="hidden" id="resultSeqM" name="resultSeqM" value="${resultMngList[0].resultSeq}" />
    <input type="hidden" id="fileListLength" name="fileListLength" />
	<input type="hidden" id="fileList" name="fileList" />
	<input type="hidden" id="imageIdx" name="imageIdx" />
				
    <div>
    	<table style="margin-top: 0px; width: 100%; margin-top: 5px;">
    		<colgroup>
		        <col width="20%" />
		        <col width="60%" />
		        <col width="20%" />
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td style="text-align:right; height:40px;">
	        			<a href="#" onClick="javascript:fnSearch('P');">
	        				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre.png" width="30px" alt="이전">
	        			</a>
	        		</td>
	        		<td style="text-align:center; height:40px;">
	        			<span id="spanToday" name="spanToday" style="padding:7px 10px; text-align:center; font-size:17px; font-weight:800;">
	        				${salesDay.yyyy}년 ${salesDay.mm}월 ${salesDay.dd}일 ${salesDay.dayOfWeek}
	        			</span>
	        		</td>
	        		<td style="text-align:left; height:40px;">
	        			<a href="#" onClick="javascript:fnSearch('N');">
	        				<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_next.png" width="30px" alt="다음">
	        			</a>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
    <!--조회된자료끝-->
    <div class="zemos_label_search1">
    	<c:choose>
    		<c:when test="${(today eq salesDay.resultDt || yesterday eq salesDay.resultDt)}">
    			<c:set var="widthValue" value="79" />
    		</c:when>
    		<c:otherwise>
    			<!--<c:set var="widthValue" value="100" /> -->
    			<c:set var="widthValue" value="79" />
    		</c:otherwise>
    	</c:choose>
    	<span class="fl mb5" style="width:${widthValue}%; text-align: center; margin-top: 8px; font-size: 15; font-weight: bold;">
    		<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%" onchange="javascript:fnSearch('D');">
      			<c:forEach items="${storeList}" var="item" varStatus="status">
      			<option value="${item.storeSeq}" <c:if test="${item.storeSeq eq params.storeSeq[0] || item.storeSeq eq storeSeq}">selected="selected"</c:if>>${item.storeNm}</option>
      			</c:forEach>
			</select>
    	</span>
    	<!--c:if test="${(today eq salesDay.resultDt || yesterday eq salesDay.resultDt)}"> -->
		<span class="fr mb5" style="width:20%; text-align: center; margin-top: 8px; font-size: 15; font-weight: bold;">
			<a href="javascript:void(0);" onclick="javascript:fnResultAdd(); return false;" class="zemos_form_span_btn_blue">
				<span style="font-size:13px;">추 가</span>
			</a>
		</span>
		<!--/c:if> -->
    </div>
    <!-- 품목 -->
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch; width:100%;">
    	<table id="resultTable" class="zemos_table1" style="margin-top:0px; width:100%;">
    		<colgroup>
		        <col width="20%" />
		        <col width="20%" />
		        <col width="20%" />
		        <col width="20%" />
		        <col width="20%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th><c:out value = "${itemList[1].itemUseNm}"/>명</th>
	        		<th>기준단위</th>
	        		<th>수량</th>
	        		<th>금액</th>
	        		<th></th>
	        	</tr>
	        </thead>
	        <tbody>
	        	<c:set var="totQty" value="0" />
	        	<c:set var="totAmt" value="0" />
	        	<c:choose>
		        	<c:when test="${fn:length(resultDetailList) > 0}">
		        		<c:set var="idx" value="${1}"/>
		        		<c:forEach items="${resultDetailList}" var="itemList" varStatus="statusList">
		        			<c:set var="idx" value="${idx + 1}"/>
			        			<c:if test="${itemList.onYn == 'Y'}">
			        			<c:if test="${itemList.qtyOn != undefined || itemList.qtyOn != null || 
			        							itemList.qty2On != undefined || itemList.qty2On != null || 
			        							itemList.qty3On != undefined || itemList.qty3On != null || 
			        							itemList.qty4On != undefined || itemList.qty4On != null || 
			        							itemList.qty5On != undefined || itemList.qty5On != null }">
			        			<tr>
									<td style= "text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
										<input type="hidden" id="pItemNm${statusList.count}" name="pItemNm" value="${itemList.itemNm}"/>
										<input type="hidden" id="dItemSeq${statusList.count}" name="dItemSeq" class="dItemSeqeq" value="${itemList.itemSeq}"/>
										<input type="hidden" id="dchkIdx${statusList.count}" name="dchkIdx" class="dchkIdxdx" value=""/><!-- 데이터 넣기 -->
										<input type="hidden" class="itemOnOff" value="${itemList.itemSeq}On"/>
										<span style="width:100%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:15px; margin-left:10%;">
											<c:out value = "${itemList.itemNm}"/>
										</span>
									</td>
									<td colspan='3' style="padding: 7px 10px;">
										<table id="unitTable${statusList.count}"  class="unitTable" colspan='3' style="width: 100%;">
										<caption style = 'width:100%; height:100%;'><span style = 'font-size : 13px; font-weight: bold;'>온라인</span></caption>						
								<c:if test="${itemList.unit1Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													 ${itemList.unitNm1}
												</td>
												<td id="unit1Qty"  class="unit1Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit1_all_totQty_class on_unit1_totQty_class totQty_class qty1 unit1${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력"  value="${itemList.qtyOn}" readonly="readonly"/>
												</td>
												<td id="unit1Amt"  class="unit1Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit1_all_totAmt_class on_unit1_totAmt_class totAmt_class amt1 unit1${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력"  value="${itemList.amtOn}" readonly="readonly"/>
												</td>
									
											</tr>
								</c:if>
								<c:if test="${itemList.unit2Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm2}
												</td>
												<td id="unit2Qty"  class="unit2Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit2_all_totQty_class on_unit2_totQty_class totQty_class qty2 unit2${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력"  value="${itemList.qty2On}" readonly="readonly"/>
												</td>
												<td id="unit2Amt"  class="unit2Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit2_all_totAmt_class on_unit2_totAmt_class totAmt_class amt2 unit2${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력"  value="${itemList.amt2On}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
								<c:if test="${itemList.unit3Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm3}
												</td>
												<td id="unit3Qty"  class="unit3Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit3_all_totQty_class on_unit3_totQty_class totQty_class qty3 unit3${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty3On}" readonly="readonly"/>
												</td>
												<td id="unit3Amt"  class="unit3Amt" style="padding: 7px 10px;">
													<input type="text" id="amt"${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit3_all_totAmt_class on_unit3_totAmt_class totAmt_class amt3 unit3${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt3On}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
								<c:if test="${itemList.unit4Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm4}
												</td>
												<td id="unit4Qty"  class="unit4Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit4_all_totQty_class on_unit4_totQty_class totQty_class qty4 unit4${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty4On}" readonly="readonly"/>
												</td>
												<td id="unit4Amt"  class="unit4Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit4_all_totAmt_class on_unit4_totAmt_class totAmt_class amt4  unit4${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt4On}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
								<c:if test="${itemList.unit5Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm5}
												</td>
												<td id="unit5Qty"  class="unit5Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit5_all_totQty_class on_unit5_totQty_class totQty_class qty5 unit5${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty5On}" readonly="readonly"/>
												</td>
												<td id="unit5Amt"  class="unit5Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit5_all_totAmt_class on_unit5_totAmt_class totAmt_class amt5 unit5${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt5On}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
									</table>
									</td>
									<td style="padding: 7px 10px;">
									</td>
								</tr>
								</c:if>
								</c:if>
			        			<c:if test="${itemList.offYn == 'Y'}">
			        			<c:if test="${itemList.qty != undefined || itemList.qty != null || 
			        							itemList.qty2 != undefined || itemList.qty2 != null || 
			        							itemList.qty3 != undefined || itemList.qty3 != null || 
			        							itemList.qty4 != undefined || itemList.qty4 != null || 
			        							itemList.qty5 != undefined || itemList.qty5 != null }">
			        			<c:set var="itemSeq" value="${itemList.itemSeq}${statusList.count}"/>
			        			<c:set var="onoff" value="off"/>
			        			<tr>
									<td style= "text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
										<input type="hidden" id="pItemNm${statusList.count}" name="pItemNm" value="${itemList.itemNm}"/>
										<input type="hidden" id="dItemSeq${statusList.count}" name="dItemSeq" class="dItemSeqeq" value="${itemList.itemSeq}"/>
										<input type="hidden" id="dchkIdx${statusList.count}" name="dchkIdx" class="dchkIdxdx" value=""/><!-- 데이터 넣기 -->
										<input type="hidden" class="itemOnOff" value="${itemList.itemSeq}Off"/>
										<span style="width:100%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:15px; margin-left:10%;">
											<c:out value = "${itemList.itemNm}"/>
										</span>
									</td>
									<td colspan='3' style="padding: 7px 10px;">
										<table id="unitTable${statusList.count}"  class="unitTable" colspan='3' style="width: 100%;">
										<caption style = 'width:100%; height:100%;'><span style = 'font-size : 13px; font-weight: bold;'>오프라인</span></caption>						
								<c:if test="${itemList.unit1Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													 ${itemList.unitNm1}
												</td>
												<td id="unit1Qty"  class="unit1Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit1_all_totQty_class totQty_class off_unit1_totQty_class qty1 unit1${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty}" readonly="readonly"/>
												 </td>
												<td id="unit1Amt"  class="unit1Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit1_all_totAmt_class totAmt_class off_unit1_totAmt_class amt1 unit1${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt}" readonly="readonly"/>
												</td>
									
											</tr>
								</c:if>
								<c:if test="${itemList.unit2Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm2}
												</td>
												<td id="unit2Qty"  class="unit2Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit2_all_totQty_class totQty_class off_unit2_totQty_class qty2 unit2${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty2}" readonly="readonly"/>
												</td>
												<td id="unit2Amt"  class="unit2Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit2_all_totAmt_class totAmt_class off_unit2_totAmt_class amt2 unit2${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt2}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
								<c:if test="${itemList.unit3Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm3}
												</td>
												<td id="unit3Qty"  class="unit3Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit3_all_totQty_class totQty_class off_unit3_totQty_class qty3 unit3${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty3}" readonly="readonly"/>
												</td>
												<td id="unit3Amt"  class="unit3Amt" style="padding: 7px 10px;">
													<input type="text" id="amt"${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit3_all_totAmt_class totAmt_class off_unit3_totAmt_class amt3 unit3${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt3}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
								<c:if test="${itemList.unit4Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm4}
												</td>
												<td id="unit4Qty"  class="unit4Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit4_all_totQty_class totQty_class off_unit4_totQty_class qty4 unit4${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty4}" readonly="readonly"/>
												 </td>
												<td id="unit4Amt"  class="unit4Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit4_all_totAmt_class totAmt_class off_unit4_totAmt_class amt4  unit4${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt4}" readonly="readonly"/>
												 </td>
											</tr>
								</c:if>
								<c:if test="${itemList.unit5Yn == 'Y'}">
											<tr>
												<td style="padding: 7px 10px;">
													${itemList.unitNm5}
												</td>
												<td id="unit5Qty"  class="unit5Qty" style="padding: 7px 10px;">
													<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" class="zemos_input1 unit5_all_totQty_class totQty_class off_unit5_totQty_class qty5 unit5${statusList.count}" pattern="[^-0-9]" inputmode="numeric" placeholder="수량입력" value="${itemList.qty5}" readonly="readonly"/>
												</td>
												<td id="unit5Amt"  class="unit5Amt" style="padding: 7px 10px;">
													<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" class="zemos_input1 unit5_all_totAmt_class totAmt_class off_unit5_totAmt_class amt5 unit5${statusList.count}Cost" pattern="[^-0-9]" inputmode="numeric" placeholder="금액입력" value="${itemList.amt5}" readonly="readonly"/>
												</td>
											</tr>
								</c:if>
									</table>
									</td>
									<td style="padding: 7px 10px;">
									</td>
								</tr>
								</c:if>
								</c:if>
								
		        		</c:forEach>
		        	</c:when>
		        	<c:otherwise>
		        	</c:otherwise>
				</c:choose>
				<tfoot>
				<c:if test="${onCnt != '0'}">
					<tr>
						<th>온라인</th>
						<th colspan="3">
							<table style="width: 100%">
							<c:if test="${itemList[0].unit1Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm1}</td>
									<td id="on_unit1_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="on_unit1_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit2Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm2}</td>
									<td id="on_unit2_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="on_unit2_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit3Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm3}</td>
									<td id="on_unit3_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="on_unit3_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit4Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm4}</td>
									<td id="on_unit4_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="on_unit4_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit5Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm5}</td>
									<td id="on_unit5_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="on_unit5_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							</table>
						</th>
						<th></th>
					</tr>
					</c:if>
					<c:if test="${offCnt != '0'}">
					<tr>
						<th>오프라인</th>
						<th colspan="3">
							<table style="width: 100%">
							<c:if test="${itemList[0].unit1Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm1}</td>
									<td id="off_unit1_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="off_unit1_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit2Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm2}</td>
									<td id="off_unit2_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="off_unit2_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit3Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm3}</td>
									<td id="off_unit3_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="off_unit3_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit4Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm4}</td>
									<td id="off_unit4_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="off_unit4_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit5Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm5}</td>
									<td id="off_unit5_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="off_unit5_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							</table>
						</th>
						<th></th>
					</tr>
					</c:if>
					<tr>
						<th>합계</th>
						<th colspan="3">
							<table style="width: 100%">
							<c:if test="${itemList[0].unit1Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm1}</td>
									<td id="unit1_all_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="unit1_all_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit2Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm2}</td>
									<td id="unit2_all_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="unit2_all_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit3Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm3}</td>
									<td id="unit3_all_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="unit3_all_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit4Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm4}</td>
									<td id="unit4_all_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="unit4_all_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
							<c:if test="${itemList[0].unit5Yn == 'Y'}">
								<tr>
									<td style="padding: 7px 10px;">${itemList[0].unitNm5}</td>
									<td id="unit5_all_totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="unit5_all_totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</c:if>
								<tr>
									<td style="padding: 7px 10px;">전체</td>
									<td id="totQty" style="padding: 7px 10px;"><fmt:formatNumber value="${totQty }" pattern="#,###" /></td>
									<td id="totAmt" style="padding: 7px 10px;"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></td>
								</tr>
							</table>
						</th>
						<th></th>
					</tr>
				</tfoot>
	        </tbody>
    	</table>
    </div>
    </form>
    <!--팝업시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/popup/itemPopup_01New.jsp"%>
    <!--팝업끝-->
    
    
    
    <div style="width:100%; padding-top:35px; display:none;" id="saveBtnDiv">
    	<span class="mb5" style="width:100%; height:29px; text-align:left; position:absolute; left:5%; width:100%;">
			<a href="javascript:void(0);" onclick="javascript:fnUserResultSave(); return false;" class="zemos_form_span_btn_blue" style="width:90%;">
				<span style="font-size:15px;">저 장</span>
			</a>
		</span>
	</div>
    
</body>
</html>