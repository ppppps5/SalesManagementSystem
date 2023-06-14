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
	
	<script type="text/javascript">
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		//var cnt1 = ${selectStoreDetailCnt.cnt}
		//alert(cnt1);
		$(document).ready(function () {
			//검색기능
			$("#storeSeq").select2();
			$(".select2-selection__arrow").hide();
			//시간
			$('#pushDttm').mobiscroll().time({
				theme: 'android-holo-light',
				display: 'modal',
		        mode: 'scroller',
		        timeOrder: 'HH:ii',
		        timeFormat: 'HH:ii',
				onSelect: function (valueText, inst) {
			    }
		    });
			
			var cnt1 = '${selectStoreDetailCnt.cnt}';
			//alert(cnt1);
			if ( cnt1 == '0') {
				fnStoreDetailSave();
				//alert(cnt1);
			}
				
			
			var pushDttm = '${storeDetail.pushDttm}';
			if ( pushDttm == '' || pushDttm == null ) {
				var Now = new Date();
				var hh = Now.getHours(); // 시
				var ii = Now.getMinutes(); // 분
				$('#pushDttm').val(hh + ':' + ii);
				$('#pushDttm').mobiscroll("setDate", new Date(hh + ':' + ii));	
			}
						
			var itemChkLength = $('input:checkbox[name="itemChk"]').length;
			var iRow = 0;
			for ( var i = 0; i < itemChkLength; i++ ) {
				iRow = i+1;
				$("#useYnChkLabel"+iRow).click(function() {
					var isChecked = $("#useYn" + iRow).is(":checked");
					//alert("isChecked > " + isChecked);
					if (isChecked) {
						$("#useYn" + iRow).prop("checked", false);
					} else {
						$("#useYn" + iRow).prop("checked", true);
					}
		    	});
			}
		});
		
		//조회
		//gbn이 D이면 매장명 select, I이면 품목 리스트 사용여부
		function fnSearch(gbn) {
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreDetail.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq=" + $("#storeSeq option:selected").val();
			
			if ( gbn == 'I' ) {
				url += "&itemUseYn=" + $("#selectItemUseYn option:selected").val();
			}
			
			
			fn_location_href(url);
			
		}
		
		function fnStoreDetailSave() {
			var saveGbn = "";
			var fileYn = "";
			var unitYn = "";
			var pushYn = "";
			
			//storeDetailItemSeq
			if ( $("#storeDetailSeq").val() == "" || $("#storeDetailSeq").val() == null ) {
				$("#saveGbn").val("insert");
			} else {
				if ( $("input[name*=itemSeq]").length > 0 ) {
					$("#saveGbn").val("update");
					var row = 0;
					for ( var i = 0; i < $("input[name*=itemSeq]").length; i++ ) {
						row = i + 1;
						if ( $("#storeDetailItemSeq"+row).val() == null || $("#storeDetailItemSeq"+row).val() == "" ) {
							//$("#saveGbnDetail"+row).val("insert");
							$("#saveGbnDetail"+row).val("update");
						} else {
							$("#saveGbnDetail"+row).val("update");
						}
					}
				} else {
					$("#saveGbn").val("update");
				}
			}
			
			if ( $("#fileYn").is(":checked") == true ) {
				$("#iFileYn").val("Y");
			} else {
				$("#iFileYn").val("N");
			}
			
			if ( $("#unitYn").is(":checked") == true ) {
				$("#iUnitYn").val("Y");
			} else {
				$("#iUnitYn").val("N");
			}
			
			if ( $("#pushYn").is(":checked") == true ) {
				$("#iPushYn").val("Y");
			} else {
				$("#iPushYn").val("N");
			}
			
			//$("#itemSeqLength").val($('input:checkbox[name*="itemUseYn"]:checked').length);
			$("#itemSeqLength").val($('input:checkbox[name*="itemUseYn"]').length);
			
			for ( var i = 1; i <= $('input:checkbox[name*="itemUseYn"]').length; i++ ) {
				if ( $("#itemUseYn"+i).is(":checked") == true ) {
					$("#itemUseYn"+i).val("Y");					
				} else {
					$("#itemUseYn"+i).val("N");
				}
			}
			
			fn_loading_show();
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2StoreDetailSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: $("#zemosForm").serialize()
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					//fn_loading_hide();

					if ( response.result01 === true ) {
						fnSearch('D');
					}else{
						alert("매장상세정보가 저장되었습니다.");
						fnSearch('D');
					}						
					
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		function fnItemAdd() {
			$("#itemPopupStoreNm").text($("#storeSeq option:checked").text());
			var rowLength = $("#itemUl > li").length;
			var itemLength = $("#itemPopupTable > tbody > tr").length;
			var row = 0;
			var item = 0;
			for ( var i = 0; i < rowLength; i++ ) {
				row = i + 1;
				for ( var j = 0; j < itemLength; j++ ) {
					item = j + 1;
					if ( $("#dItemSeq2"+row).val() == $("#itemSeq"+item).val() ) {
						$("#itemChk"+item).prop("checked", true);
					}
				}
			}
			$("#itemPopup").show();
		}
		
		function fnItemSave() {
			var innerHtml = "";
			var itemSeqLength = $('input:checkbox[name="itemChk"]').length;
			var itemUseYnLength = $('input:checkbox[name="itemUseYn"]').length;
			 
			var row = 0;
			var itemValues = new Array();
			for ( var j = 0; j < itemSeqLength; j++ ) {
				row = j + 1;
				itemValues.push($("#itemSeq"+row).val());
			}
			
			//storeDetailSeq가 null이거나 ""이면 품목테이블을 비운다.(첫 저장시)	
			if ( $("#storeDetailSeq").val() == null || $("#storeDetailSeq").val() == "" ) {
				$("#itemTable > tbody > tr").empty();
			}
			
			var rowLength = $("#itemTable > tbody > tr").length;
			var dRow = 0;
			var dItemValues = new Array();
			for ( var j = 0; j < rowLength; j++ ) {
				dRow = j + 1;
				dItemValues.push($("#dItemSeq"+dRow).val());
			}
			
			var sum = itemValues.concat(dItemValues);
			//합집합
			var union = sum.filter((item, index) >= sum.indexOf(item) === index);
		    //교집합
		    var intersec = sum.filter((item, index) >= sum.indexOf(item) !== index);
		    //베타적 논리합
		    var difference = union.filter(x >= !intersec.includes(x));
		    
		    //console.log("합집합 > ",union);
		    //console.log("교집합 > ",intersec);
		    //console.log("차집합 > ",difference);
		    var r = dItemValues.length + 1;
			for ( var i = 1; i <= itemSeqLength; i++ ) {
				if ( $("#itemChk"+i).is(":checked") == true ) {
					//itemUseYnLength = itemUseYnLength + 1;
					for ( var j = 0; j < difference.length; j++ ) {
						//itemUseYnLength = i + 1;
						if ( $("#itemSeq"+i).val() == difference[j] ) {
							itemUseYnLength = r++;
							console.log('itemUseYnLength > '+itemUseYnLength);
							innerHtml += "<tr>";
							innerHtml += "	<td style=\"text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;\">";
							innerHtml += "		<span style=\"width:10%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left;\">";
							innerHtml += "			<input type=\"hidden\" id=\"dItemSeq"+itemUseYnLength+"\" name=\"dItemSeq"+itemUseYnLength+"\" value=\""+$("#itemChk"+i).val()+"\">";
							innerHtml += "			<input type=\"checkbox\" class=\"checkbox-style\" id=\"itemUseYn"+itemUseYnLength+"\" name=\"itemUseYn"+itemUseYnLength+"\" style=\"display:block; zoom:1.5;\" checked=\"checked\">";
							innerHtml += "		</span>";
							innerHtml += "		<span style=\"width:80%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:15px; margin-left:10%;\">";
							innerHtml += $("#itemNm"+i).val();
							innerHtml += "		</span>";
							innerHtml += "	</td>";
							innerHtml += "</tr>";
						}						
					}
				}
			}
			
			$("#itemTable > tbody:last").append(innerHtml);
			$('.zemos_modal').hide()
		}
		
		function fnCheckBox(row) {
			if ( $("#itemChk"+row).is(":checked") == true ) {
				$("#itemChk"+row).prop("checked", false);
			} else {
				$("#itemChk"+row).prop("checked", true);
			}
		}
		
		
		//제모스 판매관리 매장정보설정 이동 
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2Store.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx=" + wrkplcIdx);
		}
		
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">매장상세설정</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <form id="zemosForm" name="zemosForm" method="post" onsubmit="return false;" class="form-horizontal">
    <input type="hidden" id="iFileYn" name="iFileYn"/>
	<input type="hidden" id="iUnitYn" name="iUnitYn"/>
	<input type="hidden" id="iPushYn" name="iPushYn"/>
	<input type="hidden" id="itemSeqLength" name="itemSeqLength"/>
	<input type="hidden" id="zemosIdx" name="zemosIdx" value="${params.zemosIdx[0]}"/>
	<input type="hidden" id="wrkplcIdx" name="wrkplcIdx" value="${params.wrkplcIdx[0]}"/>
	<input type="hidden" id="storeDetailSeq" name="storeDetailSeq" value="${storeDetail.storeDetailSeq}"/>
	<input type="hidden" id="saveGbn" name="saveGbn"/>
	<input type="hidden" id="selectStoreDetailCnt" name="selectStoreDetailCnt" value="${selectStoreDetailCnt.cnt}"/>
	
    <div>
    	<table style="margin-top: 0px; width: 100%; margin-top: 5px; border-top: 2px solid #777777;">
    		<colgroup>
		        <col width="25%" />
		        <col width="50%" />
		        <col width="25%" />
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td style="text-align: left; font-size: 13px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">매장명</td>
	        		<td style="text-align: left; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;" colspan="2">
	        			<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%" onchange="javascript:fnSearch('D');">
	        				<c:forEach items="${selectBoxStoreList}" var="item" varStatus="status">
	        				<option value="${item.storeSeq}" <c:if test="${item.storeSeq == storeSeq}">selected="selected"</c:if>>${item.storeNm}</option>
	        				</c:forEach>
						</select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<td style="text-align: left; font-size: 13px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">첨부파일</td>
	        		<td style="text-align: right; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;" colspan="2">
	        			<label class="zemos_switch">
			              	<input type="checkbox" name="fileYn" id="fileYn" idx="1" <c:if test="${storeDetail.fileYn == 'Y'}">checked="checked"</c:if>>
			              	<span class="zemos_slider zemos_round"></span>
						</label>
	        		</td>
	        	</tr>
	        	<tr>
	        		<td style="text-align: left; font-size: 13px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">단위추가<br/>($/수량)</td>
	        		<td style="text-align: right; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;" colspan="2">
	        			<label class="zemos_switch">
			              	<input type="checkbox" name="unitYn" id="unitYn" idx="1" <c:if test="${storeDetail.unitYn == 'Y'}">checked="checked"</c:if>>
			              	<span class="zemos_slider zemos_round"></span>
						</label>
	        		</td>
	        	</tr>
	        	<tr>
	        		<td style="text-align: left; font-size: 13px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">등록알림</td>
	        		<td style="text-align: left; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
	        			<input id="pushDttm" name="pushDttm" type="text" class="zemos_input1" style="width:50%; font-size:15px;" value="${storeDetail.pushDttm}"/>
	        		</td>
	        		<td style="text-align: right; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
						<label class="zemos_switch">
			              	<input type="checkbox" name="pushYn" id="pushYn" idx="1" <c:if test="${storeDetail.pushYn == 'Y'}">checked="checked"</c:if>>
			              	<span class="zemos_slider zemos_round"></span>
						</label>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
    <!--조회된자료끝-->
    <div class="zemos_label_search1">
    	<span class="fl mb5" style="width:20%; text-align: left; margin-top: 8px; font-size: 15; font-weight: bold;">
    		품목설정
    	</span>
    	<span class="fl mb5" style="width:58%; text-align:right; margin-top:1px; float:right;">
    		<select id="selectItemUseYn" name="selectItemUseYn" class="zemos_select1" style="width:70%;" onchange="javascript:fnSearch('I');">
      			<option value=""  <c:if test="${params.itemUseYn[0] == ''}">selected="selected"</c:if>>전 체</option>
				<option value="Y" <c:if test="${params.itemUseYn[0] == 'Y'}">selected="selected"</c:if>>사 용</option>
				<option value="N" <c:if test="${params.itemUseYn[0] == 'N'}">selected="selected"</c:if>>미사용</option>
			</select>
    	</span>
		<!--
		<span class="fr mb5" style="margin-top:1%; width:20%;">
			<a href="javascript:void(0);" onclick="javascript:fnItemAdd('popup'); return false;" class="zemos_form_span_btn_blue">
				<span style="font-size:13px;">추가</span>
			</a>
		</span>
		-->
    </div>
    <!--
    <div>
    	<table style="margin-top: 0px; width: 100%;">
    		<colgroup>
		        <col width="100%" />
	        </colgroup>
	        <tbody>
	        	<tr>
	        		<td style="text-align: left; font-size: 13px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
	        			<select id="selectItemUseYn" name="selectItemUseYn" class="zemos_select1" style="width:50%;" onchange="javascript:fnSearch('I');">
	        				<option value=""  <c:if test="${params.itemUseYn[0] == ''}">selected="selected"</c:if>>전 체</option>
							<option value="Y" <c:if test="${params.itemUseYn[0] == 'Y'}">selected="selected"</c:if>>사 용</option>
							<option value="N" <c:if test="${params.itemUseYn[0] == 'N'}">selected="selected"</c:if>>미사용</option>
						</select>
	        		</td>
	        	</tr>
	        </tbody>
    	</table>
    </div>
    -->
    <!-- 품목 리스트시작 -->
    <div>
    	<ul id="itemUl" style="display:none;">
    		<c:choose>
		        	<c:when test="${fn:length(storeDetailAllItem) > 0}">
		        		<c:forEach items="${storeDetailAllItem}" var="item" varStatus="status">
		        <li>
							<input type="hidden" id="dItemSeq2${status.count}" name="dItemSeq${status.count}" value="${item.itemSeq}" >
				</li>
		        		</c:forEach>
		        	</c:when>
			        <c:otherwise>
			        </c:otherwise>
		        </c:choose>
		        	
    	</ul>
    	<table id="itemTable" style="margin-top: 0px; width: 100%;">
    		<colgroup>
		        <col width="100%" />
		        <!-- <col width="50%" /> -->
	        </colgroup>
	        <tbody>
	        	<c:choose>
		        	<c:when test="${fn:length(storeDetailItem) > 0}">
		        		<c:forEach items="${storeDetailItem}" var="item" varStatus="status">
		        <tr>
					<td style="text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
						<span style="width:10%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left;">
							<input type="hidden" id="dItemSeq${status.count}" name="dItemSeq${status.count}" value="${item.itemSeq}" >
							<input type="hidden" id="storeDetailItemSeq${status.count}" name="storeDetailItemSeq${status.count}" value="${item.storeDetailItemSeq}" >
							<input type="hidden" id="saveGbnDetail${status.count}" name="saveGbnDetail${status.count}" value="update" />
							<input type="checkbox" class="checkbox-style" id="itemUseYn${status.count}" name="itemUseYn${status.count}" style="display:block; zoom:1.5;" <c:if test="${item.useYn eq 'Y'}">checked="checked"</c:if>>
						</span>
						<span style="width:80%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:15px; margin-left:10%;">
							<label for="itemUseYn${status.count}">${item.itemNm}</label>
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
    <!-- 품목 리스트끝 -->
    
    <div class="zemos_label_search1">
		<span class="fl mb5" style="width:100%; height: 29px; text-align: left;">
			<a href="javascript:void(0);" onclick="javascript:fnStoreDetailSave(); return false;" class="zemos_form_span_btn_blue">
				<span style="font-size:15px;">저 장</span>
			</a>
		</span>
	</div>
	</form>
	<!--팝업시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/popup/item2Popup.jsp"%>
    <!--팝업끝-->
</body>
</html>