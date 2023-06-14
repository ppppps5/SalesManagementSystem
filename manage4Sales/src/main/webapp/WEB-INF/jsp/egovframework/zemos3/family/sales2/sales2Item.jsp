<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html> 
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	<style>
	.disabledbutton {
	    pointer-events: none;
	    opacity: 0.4;
	}
	
	.zemos_form_span_btn_blue{
		border-radius: 10px;
	}
	
	.zemos_form_span_btn_red{
		border-radius: 10px;
	}
	</style>
	<script type="text/javascript">
	var zemosIdx  = "${params.zemosIdx[0]}";
	var zemosNm = "${params.zemosNm[0]}";
	var pageNo    = "${pageNo}";
	var numOfRows = "${numOfRows}";
	var wrkplcIdx = "${params.wrkplcIdx[0]}";
		
		$(document).ready(function () {
			//기준 숨기기
			//$("#standard1").html("기준");
			$(".standard2").css("visibility","hidden");
			$(".standard3").css("visibility","hidden");
			
			console.log('wrkplcIdx > ' + wrkplcIdx);
			$("input[type=checkbox]").css("display", "block");
			
			var trCntLength = $("#itemTable > tbody tr").length;
			var trSeq = 0;
			for ( var i = 0; i < trCntLength; i++ ) {
				trSeq = i + 1;

				fnRowCheck(trSeq);
				fnCheckBox(trSeq);
			
			}
			
			//btnA
			//btnSpan
			//품목명 keyup이벤트
			$('input[name=itemNm]').on('keyup',function(){	
				//var index = $(this).parent().parent().index();
				var index = $(this).parent().parent().parent().index();
				console.log("index : "+ index);
				var rowIndex = index + 1;
				var itemNm = $("#itemNm"+rowIndex).val();
				var hitemNm = $("#hitemNm"+rowIndex).val(); 
				var useYn = $("#useYn"+rowIndex).val();
				var huseYn = $("#huseYn"+rowIndex).val();
				
				if ( $("#useYn"+rowIndex).is(":checked") == true ) {
					useYn = "Y";
				} else {
					useYn = "N";
				}	
				console.log(itemNm)
				console.log(hitemNm)
				if ( itemNm == hitemNm ) {
					if ( useYn != huseYn ) {
						$("#btnA"+rowIndex).removeClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("수정");
					} else {
						$("#btnA"+rowIndex).addClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("저장");	
					}
				} else {
					
					$("#btnA"+rowIndex).removeClass("disabledbutton");
					$("#btnSpan"+rowIndex).text("수정");
				}
			});
			
			//코드 keyup이벤트
			$('input[name=itemCode]').on('keyup',function(){	
				//var index = $(this).parent().parent().index();
				var index = $(this).parent().parent().parent().index();
				var rowIndex = index + 1;
				var itemCode = $("#itemCode"+rowIndex).val();
				var hitemCode = $("#hitemCode"+rowIndex).val(); 
				var useYn = $("#useYn"+rowIndex).val();
				var huseYn = $("#huseYn"+rowIndex).val();
				
				if ( $("#useYn"+rowIndex).is(":checked") == true ) {
					useYn = "Y";
				} else {
					useYn = "N";
				}	
				
				if ( itemCode == hitemCode ) {
					if ( useYn != huseYn ) {
						$("#btnA"+rowIndex).removeClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("수정");
					} else {
						$("#btnA"+rowIndex).addClass("disabledbutton");
						$("#btnSpan"+rowIndex).text("저장");	
					}
				} else {
					
					$("#btnA"+rowIndex).removeClass("disabledbutton");
					$("#btnSpan"+rowIndex).text("수정");
				}
			});
			
			
			
			
			//사용여부 change이벤트
			
		});
		
		//조회
		function fn_reload(type, value1, value2) {
			var itemNm = $("#itemNm").val();
			var useYn = $("#selectUseYn").val();
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			if ( itemNm != '' || itemNm != null ) {
				url += "&itemNm=" + itemNm;	
			}
			if ( useYn != '' || useYn != null ) {
				url += "&selectUseYn=" + useYn;	
			}
			
			fn_location_href(url);
		}
		
		//채널추가
		function fnItemAdd() {
			var innerHtml = "";
			var trCnt = $("#itemTable > tbody tr").length + 1;
			var trSeq = 0;
			var unitcnt = ${unitcnt};

			innerHtml += "<tr id=\"itemTableTr"+trCnt+"\">";
			innerHtml += "	<td>";
			innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
			innerHtml += "			${itemUseName[0].itemUseNm}명";
			innerHtml += "		</span>";
			innerHtml += "		<span style=\"width:80%; height: 29px; float: left; text-align: left;\">";
			innerHtml += "			<input id=\"itemNm"+trCnt+"\" name=\"itemNm\" type=\"text\" class=\"zemos_input1\" style=\"float: left; width:100%;\" placeholder=\"${itemUseName[0].itemUseNm}명\" maxlength=\"99\">";
			innerHtml += "		</span>";
			innerHtml += "		<br><br>";	
			innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
			innerHtml += "			코드";
			innerHtml += "		</span>";
			innerHtml += "		<span style=\"width:80%; height: 29px; float: left; text-align: left;\">";
			innerHtml += "			<input id=\"itemCode"+trCnt+"\" name=\"itemCode\" type=\"text\" class=\"zemos_input1\" style=\"float: left; width:100%;\" placeholder=\"코드\" maxlength=\"99\">";
			innerHtml += "		</span>";
			innerHtml += "		<br><br>";
			
			//for ( var i = 0; i < unitcnt; i++ ) {
			//// 단위 /단가 추가 
			    //innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				//innerHtml += "			";
				//innerHtml += "		</span>";
				//innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				//innerHtml += "			${unitList[trSeq].unitNm}";
				//innerHtml += "		</span>";
				//innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    //innerHtml += "			단가&nbsp&nbsp";
			    //innerHtml += "		</span>";
			    //innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    //innerHtml += "			<input id=\"unitSeq"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[trSeq].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    //innerHtml += "			<input id=\"unitCost"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";			    																															
			    //innerHtml += "		</span>";
			    //innerHtml += "		<br><br>";
			//// 단위 /단가 추가 
		    //trSeq = i + 1;
			//}
		
			if (unitcnt == 1) {
				// 단위 /단가 추가 
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[0].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq0"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[0].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost0"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";			    																															
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			 // 단위 /단가 추가 
			}
			if (unitcnt == 2) {
				// 단위 /단가 추가 
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[0].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq0"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[0].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost0"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[1].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq1"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[1].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost1"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			 // 단위 /단가 추가 
			}
			if (unitcnt == 3) {
				// 단위 /단가 추가 
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[0].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq0"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[0].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost0"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[1].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq1"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[1].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost1"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[2].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq2"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[2].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost2"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			 // 단위 /단가 추가 
			}
			if (unitcnt == 4) {
				// 단위 /단가 추가 
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[0].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq0"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[0].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost0"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[1].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq1"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[1].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost1"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[2].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq2"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[2].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost2"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[3].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq3"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[3].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost3"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			 // 단위 /단가 추가 
			}
			
			if (unitcnt == 5) {
				// 단위 /단가 추가 
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[0].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq0"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[0].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost0"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[1].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq1"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[1].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost1"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"단가입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[2].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq2"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[2].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost2"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" placeholder=\"단가입력\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[3].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq3"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[3].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost3"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" placeholder=\"단가입력\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			    
			    innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
				innerHtml += "			${unitList[4].unitNm}";
				innerHtml += "		</span>";
				innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;\">";
			    innerHtml += "			단가&nbsp&nbsp";
			    innerHtml += "		</span>";
			    innerHtml += "		<span style=\"width:40%; height: 29px; float: left; text-align: left;\">";
			    innerHtml += "			<input id=\"unitSeq4"+trCnt+"\" name=\"unitSeq\" value=\"${unitList[4].unitSeq}\" type=\"hidden\" class=\"zemos_input1\" style=\"float: right; width:90%;\">";
			    innerHtml += "			<input id=\"unitCost4"+trCnt+"\" name=\"unitCost\" type=\"text\" class=\"zemos_input1\" style=\"float: right; width:90%;\" placeholder=\"단가입력\" maxlength=\"99\">";
			    innerHtml += "		</span>";
			    innerHtml += "		<br><br>";
			 // 단위 /단가 추가 
			}
			
			
			innerHtml += "		<span style=\"width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;\">";
			innerHtml += "			사용여부";
			innerHtml += "		</span>";
			innerHtml += "		<span style=\"width:40%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left;\">";
			innerHtml += "			<input id=\"useYn"+trCnt+"\" name=\"useYn\" type=\"checkbox\" class=\"checkbox-style\" style=\"display:block; zoom:1.5;\" checked=\"checked\" onChange=\"javascript:fnCheckBox('"+trCnt+"');\">";
			innerHtml += "		</span>";
			innerHtml += "		<span class=\"fr mb5\" style=\"width:20%;position: absolute; margin-top: 1px; right: 14px;\">";
			innerHtml += "			<a href=\"javascript:void(0);\" onclick=\"javascript:fnItemSave('"+trCnt+"'); return false;\" class=\"zemos_form_span_btn_blue\">";
			innerHtml += "				<span style=\"font-size:13px;\">저장</span>";
			innerHtml += "			</a>";
			innerHtml += "		</span>";
			innerHtml += "	</td>";
			innerHtml += "</tr>";
			
	    	$("input[type=checkbox]").css("display", "block");
	        $("#itemTable > tbody:last").append(innerHtml);
	        $("#itemNm"+trCnt).focus();
		}
		//단가 keyup이벤트
		function fn_changeBtn(unitCnt, rowCnt){
			if ( $("#useYn"+rowCnt).is(":checked") == true ) {
				useYn = "Y";
			} else {
				useYn = "N";
			}
			var unitCost = $("#unitCost"+rowCnt+unitCnt).val();
			var hunitCost = $("#hunitCost"+rowCnt+unitCnt).val();
			
			if ( unitCost != hunitCost ) {
					$("#btnA"+rowCnt).removeClass("disabledbutton");
					$("#btnSpan"+rowCnt).text("수정");
				}else{
					$("#btnA"+rowCnt).addClass("disabledbutton");
					$("#btnSpan"+rowCnt).text("저장");
				}
		}
		
		//품목저장
		function fnItemSave(trCnt) {
			var useYn = "";
			var saveGbn = "";
			var saveGbn01 = "";
			var itemSeq = $("#itemSeq"+trCnt).val();
			var itemNm = $("#itemNm"+trCnt).val();
			var itemCode = $("#itemCode"+trCnt).val();
			var useYn = $("#useYn"+trCnt).val();
			var unitcnt = ${unitcnt};
			
						
			if ( itemNm == '' || itemNm == null ) {
				alert("${itemUseName[0].itemUseNm}명을 입력해 주세요.");
				$("#itemNm"+trCnt).focus();
				return;
			}
			
			//코드 필수 체크 제외 -- 실적등록 시 코드가 있으면 보여주고 없으면 제외 처리 2022.10.11 시현 요청사항 
			//if ( itemCode == '' || itemCode == null ) {
				//alert("코드를 입력해 주세요.");
				//$("#itemCode"+trCnt).focus();
				//return;
			//}
			
			if ( Number(byteCheck($("#itemNm"+trCnt))) > 100 ) {
				alert("${itemUseName[0].itemUseNm}명의 글자수를 초과하였습니다.\n${itemUseName[0].itemUseNm}명은 한글 50글자, 영문 100글자까지 입니다.");
				$("#itemNm"+trCnt).focus();
				return;
			}
			
			if ( Number(byteCheck($("#itemCode"+trCnt))) > 100 ) {
				alert("코드의 글자수를 초과하였습니다.\n코드는 한글 50글자, 영문 100글자까지 입니다.");
				$("#itemNm"+trCnt).focus();
				return;
			}
			
			if ( $("#useYn"+trCnt).is(":checked") == true ) {
				useYn = "Y";
			} else {
				useYn = "N";
			}			
			
			if ( itemSeq == '' || itemSeq == null ) {
				saveGbn = "insert";
			} else {
				saveGbn = "update";
			}
			if (saveGbn == "update") {
				
			// 단위 //단가 체크 
			var trCntLength1 = $("#itemDetailTable > tbody tr").length;
			var trSeq1 = trCnt;
			for ( var i = 0; i < trCntLength1; i++ ) {
				trSeq1 = i + 1;
				var unitCost = $("#unitCost"+trCnt+trSeq1).val();
				if (unitCost != undefined ) {
				var unitCost01 = $("#unitCost"+trCnt+trSeq1).val();
				var hunitCost01 = $("#hunitCost"+trCnt+trSeq1).val();
				var unitSeq01 = $("#unitSeq"+trCnt+trSeq1).val();
				var itemDetailSeq = $("#itemDetailSeq"+trCnt+trSeq1).val();
				
				saveGbn01 = "detail";
				//단가 단위 체크 
				if (unitCost01 != hunitCost01) {
					
					var params = {};
					params.itemNm = itemNm;
					params.itemCode = itemCode;
					params.unitCost = unitCost01;
					params.unitSeq = unitSeq01;
					params.itemDetailSeq = itemDetailSeq;
					params.useYn = useYn;
					params.itemSeq = itemSeq;
					params.saveGbn = saveGbn;
					params.saveGbn01 = saveGbn01;
					params.zemosIdx = zemosIdx;
					params.wrkplcIdx = wrkplcIdx;
					
					fn_loading_show();
					
					 $.ajax({
						url 		: gvContextPath + "/zemos3/family/sales2/sales2ItemSave.do",
						type		: 'POST',
					    dataType 	: 'json',
					    data		: params
					}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
					}).done(function (response) { // 완료
						if ( response.result === true ) {
							fn_loading_hide();
							//alert("${itemUseName[0].itemUseNm}이 저장되었습니다.");
							fn_reload();
						} else {
							if ( response.resultError == '1' ) {
								//alert("중복되는 ${itemUseName[0].itemUseNm}이 있습니다.");
							}
							fn_reload();
						}
					}).fail(function (response) { // 실패
					}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
					}); 
					
					}
				}
				
			}
		}	
			saveGbn01 = "item";
			var saveGbn0 = "";
			// 단위/단가 변경 없음/insert
			if (unitcnt  > 0 ){
				if ($("#unitSeq0"+trCnt).val() != undefined){
					var unitCost0 = $("#unitCost0"+trCnt).val();
					if(unitCost0 == undefined) {
						unitCost0 = 0;
						
					}
					var unitSeq0 = $("#unitSeq0"+trCnt).val();
					unitSeq1 = 0;
					unitSeq2 = 0;
					unitSeq3 = 0;
					unitSeq4 = 0;
					
					unitCost1 = 0;
					unitCost2 = 0;
					unitCost3 = 0;
					unitCost4 = 0;
					saveGbn0 = "0";
				}
				
				if ($("#unitSeq1"+trCnt).val() != undefined){
					var unitCost1 = $("#unitCost1"+trCnt).val();
					if(unitCost1 == undefined) {
						unitCost1 = 0;
						
					}
					var unitSeq1 = $("#unitSeq1"+trCnt).val();
					unitSeq2 = 0;
					unitSeq3 = 0;
					unitSeq4 = 0;
					
					unitCost2 = 0;
					unitCost3 = 0;
					unitCost4 = 0;
					saveGbn0 = "1";
				}
				if ($("#unitSeq2"+trCnt).val() != undefined){
					var unitCost2 = $("#unitCost2"+trCnt).val();
					if(unitCost2 == undefined) {
						unitCost2 = 0;
						
					}
					var unitSeq2 = $("#unitSeq2"+trCnt).val();
					unitSeq3 = 0;
					unitSeq4 = 0;
					
					unitCost3 = 0;
					unitCost4 = 0;
					saveGbn0 = "2";
				}
				if ($("#unitSeq3"+trCnt).val() != undefined){
					var unitCost3 = $("#unitCost3"+trCnt).val();
					if(unitCost3 == undefined) {
						unitCost3 = 0;
						
					}
					var unitSeq3 = $("#unitSeq3"+trCnt).val();
					unitSeq4 = 0;
					
					unitCost4 = 0;
					saveGbn0 = "3";
				}
				if ($("#unitSeq4"+trCnt).val() != undefined){
					var unitCost4 = $("#unitCost4"+trCnt).val();
					if(unitCost4 == undefined) {
						unitCost4 = 0;
					}
					var unitSeq4 = $("#unitSeq4"+trCnt).val();
					saveGbn0 = "4";
				}
				
			}else{
				saveGbn01 ="noitem";
			}
			
			//alert(unitCost0);
			//alert(unitCost1);
			//alert(saveGbn0);
			var params = {};
			params.itemNm = itemNm;
			params.itemCode = itemCode;
			params.unitCost0 = unitCost0;
			params.unitSeq0 = unitSeq0;
			params.unitCost1 = unitCost1;
			params.unitSeq1 = unitSeq1;
			params.unitCost2 = unitCost2;
			params.unitSeq2 = unitSeq2;
			params.unitCost3 = unitCost3;
			params.unitSeq3 = unitSeq3;
			params.unitCost4 = unitCost4;
			params.unitSeq4 = unitSeq4;
			params.itemDetailSeq = itemDetailSeq;
			params.useYn = useYn;
			params.itemSeq = itemSeq;
			params.saveGbn = saveGbn;
			params.zemosIdx = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			params.saveGbn01 = saveGbn01;
			params.saveGbn0 = saveGbn0;
			
			fn_loading_show();
			console.log(saveGbn);
			console.log(saveGbn01);
			 $.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2ItemSave.do",
				type		: 'POST',
			   dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					fn_loading_hide();
					alert("${itemUseName[0].itemUseNm}이 저장되었습니다.");
					fn_reload();
				} else {
					if ( response.resultError == '1' ) {
						alert("중복되는 ${itemUseName[0].itemUseNm}이 있습니다.");
					}
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			}); 
		}
		
		//바이트수 반환  
		function byteCheck(el){
		    var codeByte = 0;
		    for (var idx = 0; idx < el.val().length; idx++) {
		        var oneChar = escape(el.val().charAt(idx));
		        if ( oneChar.length == 1 ) {
		            codeByte ++;
		        } else if (oneChar.indexOf("%u") != -1) {
		            codeByte += 2;
		        } else if (oneChar.indexOf("%") != -1) {
		            codeByte ++;
		        }
		    }
		    return codeByte;
		}
		
		function fnRowCheck(trCnt) {
			
			var useYn = "";
			if ( $("#useYn"+trCnt).is(":checked") == true ) {
				useYn = "Y";
			} else {
				useYn = "N";
			}	
			
			// 단위 //단가 체크 
			var trCntLength1 = $("#itemDetailTable > tbody tr").length;
			var trSeq1 = trCnt;
			for ( var i = 0; i < trCntLength1; i++ ) {
				trSeq1 = i + 1;
				var unitCost = $("#unitCost"+trCnt+trSeq1).val();
				if (unitCost != undefined ) {
				var unitCost01 = $("#unitCost"+trCnt+trSeq1).val();
				var hunitCost01 = $("#hunitCost"+trCnt+trSeq1).val();
				if ( $("#unitCost"+trCnt+trSeq1).val() == $("#hunitCost"+trCnt+trSeq1).val() && useYn == $("#huseYn"+trCnt).val()) {
					$("#btnA"+trCnt).addClass("disabledbutton");
					$("#btnSpan"+trCnt).text("저장");
				} else {
					$("#btnA"+trCnt).removeClass("disabledbutton");
					$("#btnSpan"+trCnt).text("수정");
				}
				}
				
			}
			
			if ( $("#itemNm"+trCnt).val() == $("#hitemNm"+trCnt).val() && useYn == $("#huseYn"+trCnt).val()) {
				$("#btnA"+trCnt).addClass("disabledbutton");
				$("#btnSpan"+trCnt).text("저장");
			} else {
				$("#btnA"+trCnt).removeClass("disabledbutton");
				$("#btnSpan"+trCnt).text("수정");
			}
			
			if ( $("#itemCode"+trCnt).val() == $("#hitemCode"+trCnt).val() && useYn == $("#huseYn"+trCnt).val()) {
				$("#btnA"+trCnt).addClass("disabledbutton");
				$("#btnSpan"+trCnt).text("저장");
			} else {
				$("#btnA"+trCnt).removeClass("disabledbutton");
				$("#btnSpan"+trCnt).text("수정");
			}
		}
		
		function fnCheckBox(trCnt,trCnt1) {
			
			// 단위 //단가 체크 
			var trCntLength1 = $("#itemDetailTable > tbody tr").length;
			var trSeq1 = trCnt1;
			
			if ( $("#useYn"+trCnt).is(":checked") == true ){
				$(".cost"+trCnt).attr("disabled", false);	
			}else {
				$(".cost"+trCnt).attr("disabled", true); 
			}
			var itemNm = $("#itemNm"+trCnt).val();
			var unitCost = $("#unitCost"+trCnt+1).val();
			var unitNm = $("#unitNm"+trCnt).val();
			
			if ( $("#useYn"+trCnt).is(":checked") == true ) {
				$("#itemNm"+trCnt).attr("disabled", false); 
				$("#itemCode"+trCnt).attr("disabled", false); 
			} else {
				$("#itemNm"+trCnt).attr("disabled", true); 
				$("#itemCode"+trCnt).attr("disabled", true); 
			}
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx=" + wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">${itemUseName[0].itemUseNm}등록</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <!--조회조건시작-->
    <div class="zemos_label_search1">
    	<span class="fl mb5" style="width:100%; padding-right:1%;">
    		<select id="selectUseYn" class="zemos_select1" style="float: left; width: 25%;">
    			<option value=""  <c:if test="${params.selectUseYn[0] == ''}" >selected</c:if>>전체</option> 
				<option value="Y" <c:if test="${params.selectUseYn[0] == 'Y'}">selected</c:if>>사용</option>
				<option value="N" <c:if test="${params.selectUseYn[0] == 'N'}">selected</c:if>>미사용</option>
			</select>
    		<input id="itemNm" name="itemNm" type="text" class="zemos_input1" style="float: left; width:65%; margin-left: 4px;" value="${params.itemNm[0]}" placeholder="검색어(${itemUseName[0].itemUseNm}) 입력" onKeyPress="javascript:if(event.keyCode == 13) fn_reload('select');" onfocus="$(this).select();" maxlength="99">
    	</span>
    	<span class="fr mb5" style="position: absolute; margin-top: 1px; right:3%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
    </div>
    <!--조회된자료끝-->
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(itemList)}</span>건
        </span>
        <span class="fr mb5" style="position:absolute; margin-top:1%; right:4%;">
			<a href="javascript:void(0);" onclick="javascript:fnItemAdd(); return false;" class="zemos_form_span_btn_red" style="width: 60;">
				<span style="font-size:13px;">추 가</span>
			</a>
		</span>
    </div>
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table class="zemos_table1 table-container" id="itemTable" style="margin-top: 0px;">
    		<colgroup>
		        <col width="100%" />
	        </colgroup>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(itemList) > 0}">
		        		<c:forEach items="${itemList}" var="item" varStatus="status">
		        <tr id="itemTableTr${status.count}">
			    	<td>
			    		<span style="width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;">
			    			${itemUseName[0].itemUseNm}명
			    		</span>
			    		<span style="width:80%; height: 29px; float: left; text-align: left;">
			    			<input id="itemSeq${status.count}" name="itemSeq" type="hidden" value="${item.itemSeq}">
			    			<input id="itemNm${status.count}" name="itemNm" value="${item.itemNm}" type="text" class="zemos_input1" style="float: left; width:100%;" placeholder="품목명" maxlength="99">
			    		</span>
			    		<br><br>	
			    		<span style="width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;">
			    			코드
			    		</span>	
			    		<span style="width:80%; height: 29px; float: left; text-align: left;">			    			
			    			<input id="itemCode${status.count}" name="itemCode" value="${item.itemCode}" type="text" class="zemos_input1" style="float: left; width:100%;" placeholder="코드" maxlength="99">
			    		</span>
			    		<br><br>
			    		<!-- 기준 추가 -->
			    		<c:choose>
			    		<c:when test="${fn:length(itemDetailList) > 0}">
			    			<c:forEach items="${itemDetailList}" var="unit" varStatus="status1">
			    			<c:if test="${item.itemSeq == unit.itemSeq}"> 
			    			<table id="itemDetailTable">
			    				<tr id="itemDetailTableTr${status.count}${status1.count}">
								<span class="standard${status.count}${status1.count}" style="width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;">
					    			
					    		</span>
					    		<span style="width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;">
					    			${unit.unitNm}
					    		</span>
					    		<span style="width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px; text-align: right;">
					    			단가&nbsp;&nbsp;
					    		</span>
					    		<span style="width:40%; height: 29px; float: left; text-align: left;">		
					    			<input id="unitSeq${status.count}${status1.count}" name="unitSeq" value="${unit.unitSeq}" class="zemos_input1" style="float: right; width:90%;" type="hidden">					    			
					    			<input id="itemDetailSeq${status.count}${status1.count}" name="itemDetailSeq" value="${unit.itemDetailSeq}" class="zemos_input1" style="float: right; width:90%;" type="hidden">
					    			<input id="unitCost${status.count}${status1.count}" name="unitCost" value="${unit.unitCost}" type="text" class="zemos_input1 cost${status.count}" style="float: right; width:90%;" pattern="[0-9]*" inputmode="numeric" placeholder="" onKeyup="this.value=this.value.replace(/[^0-9]/g,''); fn_changeBtn('${status1.count}','${status.count}')" maxlength="99">
					    			<input type="hidden" id="hunitCost${status.count}${status1.count}" name="hunitCost" value="${unit.unitCost}"/>	
					    		</span>
					    		<br><br>
					    		</tr>
					    	</table>
					    	</c:if>
			    			</c:forEach>
			    		</c:when>
			    		</c:choose>
			    		<!-- 기준 추가 종료-->    	 	
			    		<span style="width:20%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:14px;">
			    			사용여부
			    		</span>
			    		<span style="width:60%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; margin-left: 7%;">
			    			<input type="checkbox" class="checkbox-style" id="useYn${status.count}" name="useYn" style="display:block; zoom:1.5;" onChange="javascript:fnCheckBox('${status.count}','${status1.count}');" <c:if test="${item.useYn eq 'Y'}">checked="checked"</c:if>>
						</span>
						<span class="fr mb5" style="width:20%;position: absolute; margin-top: 1px; right: 14px;">
			    			<a href="javascript:void(0);" onclick="javascript:fnItemSave('${status.count}'); return false;" class="zemos_form_span_btn_blue" id="btnA${status.count}">
								<span id="btnSpan${status.count}" style="font-size:13px;">저장</span>
							</a>
							<input type="hidden" id="hrow${status.count}" name="hrow" value="${status.count}"/>
							<input type="hidden" id="hitemNm${status.count}" name="hitemNm" value="${item.itemNm}"/>
							<input type="hidden" id="hitemCode${status.count}" name="hitemCode" value="${item.itemCode}"/>
							<input type="hidden" id="huseYn${status.count}" name="huseYn" value="${item.useYn}"/>
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
    <!--조회된자료끝-->
</body>
</html>