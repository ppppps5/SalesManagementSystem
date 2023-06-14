<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	
	<script type="text/javascript">
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		
		$(document).ready(function () {
			$("#useYnChkLabel").click(function() {
				var isChecked = $("#useYn").is(":checked");
				//alert("isChecked > " + isChecked);
				if (isChecked) {
					$("#useYn").prop("checked", false);
				} else {
					$("#useYn").prop("checked", true);
				}
	    	});
			
			$("#classynChkLabel").click(function() {
				var isChecked = $("#classyn").is(":checked");
				//alert("isChecked > " + isChecked);
				if (isChecked) {
					$("#classyn").prop("checked", false);
				} else {
					$("#classyn").prop("checked", true);
				}
	    	});
		});
		
		//조회
		function fn_reload(type, value1, value2) {
			var storeNm = $("#storeNm").val();
			var useYn = $("#selectUseYn").val();
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeNm=" + storeNm;
			if ( useYn != '' || useYn != null ) {
				url += "&selectUseYn=" + useYn;	
			}
			
			fn_location_href(url);
		}
		
		//매장추가(팝업) 및 매장 등록
		function fnShopAdd(gbn) {
			if ( gbn == "popup" ) {
				$("#shopAddPopup").show();	
				$("#saveGbn").val("insert");
				$("#storeName").val("");
				$("#channel1").val("");
				$("#channel2").val("");
				$("#sabun").val("");
				$("#sabun2").val("");
				$("#storeName").show();
				$("#storeNameU").hide();
				$("#storePopName").text("매장등록");
				$("input:checkbox[id='classyn']").prop("checked", true);
				$("input:checkbox[id='useYn']").prop("checked", true);
			} else if ( gbn == "insert" ) {
				$('.zemos_modal').hide();
			}
		}
		
		function fnMyModifyStore(gbn, storeSeq, storeNm, class1, class2, class3, sabun, classyn, useYn, sabun2) {
			//alert(class1);			
			if ( gbn == "popup" ) {
				$("#shopAddPopup").show();
				$("#saveGbn").val("update");
				$("#storeSeq").val(storeSeq);
				$("#storeName").val(storeNm);
				$("#storeNameU").val(storeNm);
				$("#class1").val(class1);
				$("#class2").val(class2);
				$("#class3").val(class3);
				$("#sabun").val(sabun);
				$("#sabun2").val(sabun2);
				$("#storePopName").text("매장수정");
				$("#storeName").hide();
				$("#storeNameU").show();
				if ( classyn == "Y" ) {
					$("input:checkbox[id='classyn']").prop("checked", true);
				} else {
					$("input:checkbox[id='classyn']").prop("checked", false);
				}
				if ( useYn == "Y" ) {
					$("input:checkbox[id='useYn']").prop("checked", true);
				} else {
					$("input:checkbox[id='useYn']").prop("checked", false);
				}
				//$("#useYn").val(useYn);
			}
		}
		
		function storePopupCheckBox(obj) {
			if ( $(obj).is(":checked") ) {
				$("input:checkbox[id='useYn']").prop("checked", true);
			} else {
				$("input:checkbox[id='useYn']").prop("checked", false);
			}
			if ( $(obj).is(":checked") ) {
				$("input:checkbox[id='classyn']").prop("checked", true);
			} else {
				$("input:checkbox[id='classyn']").prop("checked", false);
			}
		}
		
		function fnStoreSave() {
			var useYn = "";
			var saveGbn = $("#saveGbn").val();
			
			var storeSeq = $("#storeSeq").val();
			//var storeNm = $("#storeName").val();
			var storeNm = $("#storeName").val();
			var storeNmU = $("#storeNameU").val();
			var class1 = $("#class1").val();
			var class2 = $("#class2").val();
			var class3 = $("#class3").val();
			var sabun = $("#sabun").val();
			var sabun2 = $("#sabun2").val();
			var classyn = $("#classyn").val();
			var useYn = $("#useYn").val();			
			
			if ( storeNm == '' || storeNm == null ) {
				alert("매장명을 입력해 주세요.");
				$("#storeNm").focus();
				return;
			}
			
			if ( Number(byteCheck($("#storeName"))) > 100 ) {
				alert("매장명의 글자수를 초과하였습니다.\n매장명은 한글 50글자, 영문 100글자까지 입니다.");
				$("#storeName").focus();
				return;
			}
			/*
			if ( Number(byteCheck($("#class1"))) < 1 ) {
				alert("분류1을 선택하세요.");
				$("#class1").focus();
				return;
			}
			*/
			/*
			if ( Number(byteCheck($("#class2"))) < 1 ) {
				alert("분류2을 선택하세요.");
				$("#class2").focus();
				return;
			}
			*/
			/*
			if ( Number(byteCheck($("#class3"))) < 1 ) {
				alert("분류3을 선택하세요.");
				$("#class3").focus();
				return;
			}
			*/
			
			if ( $("#sabun").val() == null || $("#sabun").val() == "" ) {
				alert("판매관리자1은 필수입니다.\n판매관리자1을 선택하세요.");
				$("#sabun").focus();
				return;
			}
			if ( Number(byteCheck($("#storeName"))) > 100 ) {
				alert("매장명의 글자수를 초과하였습니다.\n매장명은 한글 50글자, 영문 100글자까지 입니다.");
				$("#storeName").focus();
				return;
			}
			
			if ( $("#useYn").is(":checked") == true ) {
				useYn = "Y";
			} else {
				useYn = "N";
			}
			
			if ( $("#classyn").is(":checked") == true ) {
				classyn = "Y";
			} else {
				classyn = "N";
			}
			
			var k = 0;
			
			if ( saveGbn == "update" && storeNm != storeNmU ) {
				$("input[name=hStoreNm]").each(function(idx){   
			        // 해당 input의 Value 가져오기
			        var value = $(this).val();
			        var storeNmValue = $("input[name=hStoreNm]:eq(" + idx + ")").val();
			        
			        if ( value != storeNm ) {
			        	if ( storeNmU == storeNmValue ) {
			        		//alert("중복되는 매장명이 있습니다.");
			        		k++;
			        	}
			        }
				});
			}
			
			if ( k > 0 ) {
				alert("중복되는 매장명이 있습니다.");
				return;
			}
			
			//return;
			
			var params = {};
			if ( saveGbn == "insert" ) {
				params.storeNm = storeNm;	
			} else {
				params.storeNm = storeNmU;
			}
			
			if ( storeSeq != null || storeSeq != "" ) {
				params.storeSeq = storeSeq;	
			}
			params.class1 = class1;
			params.class2 = class2;
			params.class3 = class3;
			params.sabun = sabun;
			params.sabun2 = sabun2;
			params.classyn = classyn;
			params.useYn = useYn;
			params.zemosIdx = zemosIdx;
			params.saveGbn = saveGbn;
			params.wrkplcIdx = wrkplcIdx;
			
			fn_loading_show();
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2StoreSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("매장이 저장되었습니다.");
					$('.zemos_modal').hide();
					fn_reload();
				} else {
					if ( response.resultError == '1' ) {
						alert("중복되는 매장이 있습니다.");
					}
					if ( response.resultError == '2' ) {
						alert("품목등록이 없습니다.");
					}
					fn_reload();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		//매장상세설정 이동
		function fnShopInfoDetail(idx, storeSeq) {
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreDetail.do";
			url += "?zemosIdx=" + idx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq="+storeSeq;
			
			fn_location_href(url);
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
		
		function fbSabunChange(obj) {
			//alert("fbSabunChange val > " + obj.value);
		}
		
		function fbSabun2Change(obj) {
			//alert("fbSabun2Change val > " + obj.value);
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx=" + wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">매장정보설정</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
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
    		<input id="storeNm" name="storeNm" type="text" class="zemos_input1" style="float:left; width:67%; margin-left:10px;" value="${params.storeNm[0]}" placeholder="검색어(매장명) 입력" onKeyPress="javascript:if(event.keyCode == 13) fn_reload('select');" onfocus="$(this).select();" maxlength="100">
    	</span>
    	<span class="fr mb5" style="position:absolute; margin-top:1px; right:1%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
		<!-- <span class="fr mb5" style="position: absolute; margin-top: 1px; right: 20px;">
			<a href="javascript:void(0);" onclick="javascript:fnShopAdd('popup'); return false;" class="zemos_form_span_btn_blue">
				<span style="font-size:13px;">매장추가</span>
			</a>
		</span> -->
    </div>
    <!--조회된자료끝-->
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${fn:length(storeList)}</span>건
        </span>
        <span class="fr mb5" style="position:absolute; margin-top:4px; right:8px; width:18%;">
			<a href="javascript:void(0);" onclick="javascript:fnShopAdd('popup'); return false;" class="zemos_form_span_btn_blue">
				<span style="font-size:13px;">매장추가</span>
			</a>
		</span>
    </div>
    <!-- <div class="zemos_form1"  style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;"> -->
    <!-- <div class="zemos_form1" id="testContent"> -->
    <div id="testContent">
    	<!-- <table class="zemos_table1 table-container" style="margin-top: 0px;"> -->
    	<table class="zemos_table1" style="margin-top: 0px;">
    		<colgroup>
		        <col width="80%" />
		        <col width="19%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th colspan="2" style="padding: 10px;">매장명</th>
	        	</tr>
	        </thead>
	        <tbody>
	        <c:choose>
	        	<c:when test="${fn:length(storeList) > 0}">
	        		<c:forEach items="${storeList}" var="item" varStatus="status">
	        	<tr>
	        		<td style="padding:10px; text-align:left; font-weight:bold;" onClick="javascript:fnShopInfoDetail('${item.zemosIdx}','${item.storeSeq}');">
	        			${item.storeNm}
	        			<input type="hidden" id="hStoreNm${status.count}" name="hStoreNm" value="${item.storeNm}" />
	        		</td>
	        		<td style="padding: 10px; text-align: left;">
		        		<a href="javascript:void(0);" onclick="javascript:fnMyModifyStore('popup', '${item.storeSeq}', '${item.storeNm}', '${item.class1}', '${item.class2}', '${item.class3}', '${item.sabun}', '${item.classyn}', '${item.useYn}', '${item.sabun2}'); return false;" class="zemos_form_span_btn_red">
							<span style="font-size:12px;">변경</span>
						</a>
					</td>
	        	</tr>
	        		</c:forEach>
	        	</c:when>
		        <c:otherwise>
			    <tr>
			    	<td colspan="2">
			    		등록되어있는 매장이 없습니다.
			    	</td>
			    </tr>
			    </c:otherwise>
		    </c:choose>
	        </tbody>
    	</table>
	    <!--팝업시작-->
	    <%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/popup/store2AddPopup.jsp"%>
	    <!--팝업끝-->
    </div>
    <!--조회된자료끝-->
    
</body>
</html>