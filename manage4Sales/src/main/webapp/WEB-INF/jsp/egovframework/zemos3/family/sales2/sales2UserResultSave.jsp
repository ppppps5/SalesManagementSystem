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
		var yyyy01 = "${params.yyyy01[0]}";
		var Mm01 = "${params.Mm01[0]}";
		var resultDt = ("${params.resultDt[0]}") ? "${params.resultDt[0]}" : "${salesDay.resultDt}";
		var storeSeq = "${params.storeSeq[0]}";
		var gbn = "${params.gbn[0]}";
		var moveDate;
		var imageIdx = "${resultMngList.imageIdx}";
		var resultDetailList = "${resultDetailList}";
		//관리자 권한추가
		var userAdminGbn = "${userAdminGbn}";
		
		var pyyyy = "${params.yyyy[0]}";
		var pmm = "${params.mm[0]}";
		
		
		var yyyy = "${salesDay.yyyy}";
		var mm = "${salesDay.mm}";
		var dd = "${salesDay.dd}";
		
		$(document).ready(function () {
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
		        console.log("idx = " + idx);
		        rowCnt = idx + 1;
		        if ( tymd == rtymd ) {
					$("#delBtn"+rowCnt).show();
				} else {
					$("#delBtn"+rowCnt).hide();
				}
			});
			
			
			
			if ( imageIdx != null || imageIdx != '' ) {
				$("#imageIdx").val(imageIdx);
			}
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
			
			// 파일 업로드 PC
			$("#dataFile").change(function() {
				
				var vFiles = $(this).prop("files");
				if (vFiles == null) {
					
					fn_alert("파일이 존재하지 않습니다.");
					$("#dataFile").val("");
					
					return;
				}
				
				// form
				var vFileFrom = new FormData();
				vFileFrom.append('fileOwner', '${loginVO.sabun}');
				vFileFrom.append('fileSe', 'img');
				vFileFrom.append('fileKind', 'sales');
				
				// 파일 리스트 생성 및 업로드 사이즈 체크 
				var vFiles = $(this).prop("files");
				var vSizes = 0;
				
				// 첨부파일 최대 업로드 사이즈
				var vMaxUploadSize = Number("${common.maxUploadSize}");
				// 첨부파일 최대 업로드 메세지
				var vMaxUploadMsg = "${common.maxUploadMsg}";
				
				// 첨부파일 업로드 사이즈
				var vUploadSize = Number("${common.uploadSize}");
				// 첨부파일 업로드 메세지
				var vUploadMsg = "${common.uploadMsg}";
				

				// IRP 계좌 이미지 업로드 허용 포맷
				var vUploadFormat 		= "${common.uploadIrpFormat}";
				// 첨부파일 업로드 허용 포맷 메세지
				var vUploadFormatMsg 	= "${common.uploadFormatMsg}";
				
				if (vFiles != null && vFiles.length > 0) {
					
					for (var i = 0; i < vFiles.length; i++) {
						
						var file = vFiles[i];
						
						// 첨부파일 파일 1개당 크기가 3M 이상인 경우
						if (file.size > vUploadSize) {
							
							// 파일당 최대 3MB(관리자:100MB)까지만 첨부 가능합니다.
							fn_alert(vUploadMsg);
							$("#dataFile").val("");
							
							return;
						}
						
						var fileExt 	= file.name.slice(file.name.indexOf(".") + 1).toLowerCase();
						// 첨부파일 업로드 허용 포맷 ( png|jpg|bmp|gif )
						var strSplit 	= vUploadFormat.split('|');
						if ($.inArray(fileExt, strSplit) < 0) {
							
							// 첨부할 수 없는 파일 형식입니다.
							fn_alert(vUploadFormatMsg);
							$("#dataFile").val("");
							
							return;
						}	
						
						vFileFrom.append('upload', vFiles[i]);
						vSizes += vFiles[i].size;
					}
				}
				
				// 첨부파일 전체 크기가 파일 최대크기 보다 큰 경우
				if (vSizes > vMaxUploadSize) {
					
					// 한번에 최대 100MB(관리자:500MB)까지만 업로드 가능합니다.
					fn_alert(vMaxUploadMsg);
					$("#dataFile").val("");
					
					return;
				}
				
				if (vFiles != null && vFiles.length > 0) {
					
					// ajax 시작
					$.ajax({
						
					    url: "${pageContext.request.contextPath}/com/file/uploadTemp.do",
					    type: 'post',
					    dataType : 'json', 
					    data: vFileFrom,
					    processData: false, // 파일 업로드시 필수
					    contentType: false, // 파일 업로드시 필수
					    xhr: function () {
					    	
					        var xhr = $.ajaxSettings.xhr();
					        xhr.onprogress = function e() {
					        	
					            // For downloads
					            if (e.lengthComputable) {
					                fn_loading_show("다운로드 "+(Math.round(100 * e.loaded / e.total))+"%");
					            }
					        };
					        xhr.upload.onprogress = function (e) {
					        	
					            // For uploads
					            if (e.lengthComputable) {
					                fn_loading_show("업로드 "+(Math.round(100 * e.loaded / e.total))+"%");
					            }
					        };
					        return xhr;
					    }
					}).always(function(data) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
					
						fn_loading_hide();
						$("#dataFile").val("");
					}).done(function (data) { // 완료
						
						var result = Number(data.result);
						var resultMsg = data.resultMsg;
						
						// 성공
						if (result > 0) {
							
							var list = data.resultList;
							if (list != null && list.length > 0) {
								
								if ($('#dataFileTable tr').length > 1) {
									$('#dataFileTable tr').eq(1).remove();
								}
								
								$("#checkIrp").hide();
								$("#dataFileTable tbody").append('');
								$("#dataFileList").append('');
								
								for (var i = 0; i < list.length; i++) {
									
									imageIdx = list[i].idx;
									
									var vHtml  = "<tr id=\"dataFile_" + list[i].idx + "_tr\">";
										vHtml += "<td style=\"border-left-width: 0px; cursor: pointer;\" onclick=\"javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=" + list[i].idxVal + "');\">";
									
									if(list[i].fileSe == "img") {
										vHtml += "<img src=\"${pageContext.request.contextPath}/com/file/download.do?idxVal=" + list[i].idxVal + "\" style=\"max-width: 100%;\">";
									} else {
										vHtml += list[i].fileNm;
									}
									
									vHtml += "<td style=\"padding: 5px 1px; border-left-width: 0px;\">";
									vHtml += "	<a href=\"#\" onclick=\"javascript:fn_file_delete('" + list[i].idx + "'); return false;\" class=\"zemos_btn_small1_grey\" style=\"width: 50px; float: right;\">삭제</a>";
									vHtml += "</td>";
									
									//vHtml += "<td colspan=\"2\" style=\"border-left-width: 0px;\">";
									//vHtml += "<div class=\"fl\"  style=\"width: 100%;\">";
									//vHtml += "</div>";
									//vHtml += "</tr>";
									
									$("#dataFileTable tbody").append(vHtml);
									
									var vHtml2 = "<input type=\"hidden\" name=\"dataFileList\" id=\"dataFile_" + list[i].idx + "\" value=\"" + list[i].idx + "\">";
									
									$("#dataFileList").append(vHtml2);
								}
								
								$("#fileDiv").hide();
								
							}
						// 실패
						} else {
							fn_alert(resultMsg);
						}
					}).fail(function (data) { // 실패
						fn_location_href("${pageContext.request.contextPath}/");
					}).always(function(data) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
						
					});
					// ajax 끝
				}
			});
		});
		
		// 파일 삭제
		function fn_file_delete(pIdx) {
			
			if (!fn_confirm("해당 파일을 삭제하시겠습니까?")) {
				return;
			}
			
			$("#dataFile_" + pIdx).remove();
			$("#dataFile_" + pIdx+"_tr").remove();
			
			$("#fileDiv").show();
		}
		
		function fnResultAdd() {
			
			
			
			$("#itemPopupStoreNm").text($("#storeSeq option:checked").text());
			
			var rowLength = $("#resultTable > tbody > tr").length;
			var itemLength = $("#itemPopupTable > tbody > tr").length;
			var row = 0;
			var item = 0;
			
			$('#allChk').prop("checked",false);
			$('.itemChk').prop("checked",false);
			
			for ( var i = 0; i < (itemLength-1); i++ ) {
				row = i + 1;
				for ( var j = 0; j < (itemLength-1); j++ ) {					
					item = j + 1;
					if ( $("#dItemSeq"+row).val() == $("#itemSeq"+item).val()) {
						$("#itemChk"+item).prop("checked", true);
						//fn_alert("등록 된 실적을 삭제 후 재 등록 해 주세요.");
						//return;
					}
				}
			}
			
			////////////////////////////////////////////////////////////////////////////
			$("#itemPopup").show();
		}
		
		function fnItemSave() {
			var innerHtml = "";
			var itemSeqLength = $('input:checkbox[name="itemChk"]').length;
			var itemUseYnLength = $('input:checkbox[name="itemUseYn"]').length;
			
			var rowLength = $("#resultTable > tbody > tr").length;
			
			
			for ( var i = 1; i <= itemSeqLength; i++ ) {
				
				if ( $("#itemChk"+i).is(":checked") == true ) {
					
					
					
					var iii = 0;
					//itemUseYnLength = itemUseYnLength + 1;
					for ( j = 0; j < rowLength; j++ ) {
						var kkk = $('.dItemSeqeq').eq(j).val();
						if($('#itemSeq'+i).val() == kkk ){
							iii++;
						}
					}
					
						//alert(i+"번째 $('#itemSeq'+i).val() : "+ $("#itemSeq"+i).val() + " ------ "+j+"번째 difference[j] : " + difference[j])
						if (iii == 0 ) {
							rowLength++;
							itemUseYnLength = rowLength;
							
							innerHtml += "<tr id=\"resultTableTr"+itemUseYnLength+"\"  class=\"resultTableTr\">";
							innerHtml += "	<td style=\"text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;\">";
							innerHtml += "		<input type=\"hidden\" id=\"pItemNm"+itemUseYnLength+"\" name=\"pItemNm\" value=\""+$("#itemNm"+i).val()+"\">";
							innerHtml += "		<input type=\"hidden\" id=\"dItemSeq"+itemUseYnLength+"\" name=\"dItemSeq\" class=\"dItemSeqeq\" value=\""+$("#itemChk"+i).val()+"\">";
							innerHtml += "		<input type=\"hidden\" id=\"requestYn"+itemUseYnLength+"\" name=\"requestYn\" value=\"W\"/>"; //여기추가
							innerHtml += "		<input type=\"hidden\" id=\"historySeq"+itemUseYnLength+"\" name=\"historySeq\"/>"; //여기추가
							innerHtml += "		<input type=\"hidden\" id=\"detailHistorySeq"+itemUseYnLength+"\" name=\"detailHistorySeq\"/>"; //여기추가
							//innerHtml += "		<span style=\"width:100%; height: 29px; display: table-cell; vertical-align: middle; padding:5; float:left; font-size:15px; margin-left:10%;\">";
							innerHtml += $("#itemNm"+i).val();
							//innerHtml += "		</span>";
							innerHtml += "	</td>";
							innerHtml += "	<td style=\"padding: 7px 10px;\">";
							innerHtml += "		<input type=\"text\" id=\"qty"+itemUseYnLength+"\" name=\"qty\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totQty_class\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"수량입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');sumtot('totQty');\"/>";
							innerHtml += "	</td>";
							innerHtml += "	<td style=\"padding: 7px 10px;\">";
							innerHtml += "		<input type=\"text\" id=\"amt"+itemUseYnLength+"\" name=\"amt\" style=\"width:100%; text-align:right;\" class=\"zemos_input1 totAmt_class\" pattern=\"[0-9]*\" inputmode=\"numeric\" placeholder=\"금액입력\" onKeyup=\"this.value=this.value.replace(/[^0-9]/g,'');sumtot('totAmt');\"/>";
							innerHtml += "	</td>";
							innerHtml += "	<td style=\"padding: 7px 10px;\">";
							//innerHtml += "		<span class=\"fr mb5\">";
							innerHtml += "		<span class=\"mb5\">";
							innerHtml += "			<a href=\"javascript:void(0);\" onclick=\"javascript:fnResultDel('"+itemUseYnLength+"');sumtot('totQty');sumtot('totAmt'); return false;\" class=\"zemos_form_span_btn_red\">";
							innerHtml += "				<span style=\"font-size:13px;\">삭제</span>";
							innerHtml += "			</a>";
							innerHtml += "		</span>";
							innerHtml += "	</td>";
							innerHtml += "</tr>";
							
						}
					
					}
				
			}
			$("#resultTable > tbody:last").append(innerHtml);
			$('.zemos_modal').hide();
			
			//저장 버튼을 추가한다
			/////////////////////////////////////////////////////////////////////////////////////////////////
			var resultDetailListLength = $("#resultDetailListLength").val();
			var resultTableTrLength = $(".resultTableTr").length;
			
			if(resultDetailListLength < resultTableTrLength) {$('#saveBtnDiv').show();}
			/////////////////////////////////////////////////////////////////////////////////////////////////
		}
		
		function checkNumber(event) {
			console.log('event.key > ' + event.key);
			  if(event.key === '.' 
			     || event.key === '-'
			     || event.key >= 0 && event.key <= 9) {
			    return true;
			  }
			  
			  return false;
			}
		
		function fnResultDel(trCnt) {
			var tr = $("#resultTableTr"+trCnt);
			tr.remove();
			
			//저장 버튼을 추가한다
			/////////////////////////////////////////////////////////////////////////////////////////////////
			var resultDetailListLength = $("#resultDetailListLength").val();
			var resultTableTrLength = $(".resultTableTr").length;
			
			if(resultDetailListLength >= resultTableTrLength) {$('#saveBtnDiv').hide();}
			/////////////////////////////////////////////////////////////////////////////////////////////////
		}
		
		function fnUserResultSave(fileYn) {
			
			
			
			if ( fileYn == "Y" ) {
				var vFileList = [];
				$("#dataFileList input[name='dataFileList']").each(function() {
					var vFileData = {};
					vFileData.idx = $(this).val();
					vFileList.push(vFileData);
				});
				$("#fileListLength").val(vFileList.length);
				$("#fileList").val(vFileList);
				$("#imageIdx").val(imageIdx);
			}
			console.log('##### '+$("#imageIdx").val());
			
			
			var imageIdxEnc = '${resultMngList.imageIdxEnc}';
			
			if ( fileYn == "Y" ) {
				if ( (imageIdxEnc == null || imageIdxEnc == '') && ($("#fileListLength").val() == null || $("#fileListLength").val() == "" || $("#fileListLength").val() == "0" ) ) {
					alert("첨부파일을 등록해 주십시요.");
					return;	
				}
			}
			
			//return;
			
			console.log($("#resultTable > tbody > tr").length);
			if ( $("#resultTable > tbody > tr").length <= 0 ) {
				alert("품목을 추가해 주십시요.");
				return;
			}
			
			if ( $("#resultSeqM").val() == null || $("#resultSeqM").val() == "" ) {
				$("#saveGbn").val("insert");
			} else {
				if ( $('input[name="resultDetailSeq"]').length > 0 ) {
					$("#saveGbn").val("update");
				} else {
					$("#saveGbn").val("insert");	
				}
			}
			
			/*
			var row;
			console.log('resultTable length > '+$("#resultTable > tbody > tr").length);
			for ( var i = 0; i < $("#resultTable > tbody > tr").length; i++ ) {
				row = i + 1;
				console.log('row > ' + row);
				if ( $("#qty"+row).val() == null || $("#qty"+row).val() ==  "" ) {
					alert($("#pItemNm"+row).val() + " 품목의 수량을 입력하세요.");
					$("#qty"+row).focus();
					return;
				} else if ( $("#amt"+row).val() == null || $("#amt"+row).val() ==  "" ) {
					alert($("#pItemNm"+row).val() + " 품목의 금액을 입력하세요.");
					$("#amt"+row).focus();
					return;
				}
			}
			*/
			var i = 0;
			var iItemNameValue;
			$("input[name=qty]").each(function(idx){   
		        // 해당 input의 Value 가져오기
		        var value = $(this).val();
		        var qtyValue = $("input[name=qty]:eq(" + idx + ")").val();
		        iItemNameValue = $("input[name=pItemNm]:eq(" + idx + ")").val();
		        //console.log('itemNameValue > ' + itemNameValue) ;
		        
		        if ( qtyValue == null || qtyValue ==  "" ) {
		        	i++;
					$("input[name=qty]:eq(" + idx + ")").focus();
					if ( i > 0 ) {
						return false;
					}
				}
		        
			});
			if ( i > 0 ) {
				alert(iItemNameValue + " 품목의 수량을 입력하세요.");
				return;
			}
			
			var k = 0;
			var kItemNameValue;
			$("input[name=amt]").each(function(idx){   
		        // 해당 input의 Value 가져오기
		        var value = $(this).val();
		        var amtValue = $("input[name=amt]:eq(" + idx + ")").val() ;
		        kItemNameValue = $("input[name=pItemNm]:eq(" + idx + ")").val();
		        
		        if ( amtValue == null || amtValue ==  "" ) {
		        	k++;
					$("input[name=amt]:eq(" + idx + ")").focus();
					if ( k > 0 ) {
						return false;
					}
				}
			});
			if ( k > 0 ) {
				alert(kItemNameValue + " 품목의 금액을 입력하세요.");
				return;
			}

			fn_loading_show();
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2UserResultSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: $("#zemosForm").serialize()
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
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserResult.do";
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
			url += "&yyyy=" + pyyyy;
			url += "&mm=" + pmm;
			
			
			fn_location_href(url);
		}
		
		// 파일 업로드
		function fn_file_upload(pGubun) {
			
			//var trCntLength = $("#resultTable tr").length;
			//var trCnt;
			
			//for ( var i = 0; i < trCntLength; i++ ) {
			//	trCnt = i + 1;
			//	if ( $("#historySeq"+trCnt).val() != null || $("#historySeq"+trCnt).val() != "" ) {
			//		alert("수정요청등록 사항이 있습니다.파일추가 불가 합니다.");
			//		return;
			//	}
			//}
			
			var url 		= "${common.fullContext}/com/file/uploadAppTemp.do";
			var id 			= "dataFile";
			var gubun 		= "dataFile";
			var userIdx 	= "${loginVO.idx}";
			var fileOwner 	= "${FILE_OWNER_PREFIX}${resultMap.IDX}";
			var fileSe 		= "img";
			
			if (fn_image_upload_call_image(url, id, gubun, userIdx, fileOwner, fileSe)) return;
			
			//진행 중 처리 방지
			if ($("#dataFile").val() != "") return;
			
			// 실행
			$("#dataFile").trigger('click');
		}
		
		// 모바일 이미지 업로드 CALLBACK
		function fn_image_upload(pId, pGubun, pData) {
			
			try {
				
				fn_loading_hide();
				
				var list = pData.resultList;
				if (list != null && list.length > 0) {
					
					if ($('#dataFileTable tr').length > 1) {
						$('#dataFileTable tr').eq(1).remove();
					}
					
					$("#checkIrp").hide();
					$("#" + pId + "Table tbody").append('');
					$("#" + pId + "List").append('');
					
					for (var i = 0 ; i < list.length; i++) {
						
						imageIdx = list[i].idx;
						
						var vHtml = "<tr id=\"" + pId + "_" + list[i].idx + "_tr\">";
						vHtml += "<td style=\"border-left-width: 0px; cursor: pointer;\" onclick=\"javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=" + list[i].idxVal + "');\">";
						if (list[i].fileSe == "img") {
							vHtml += "<img src=\"${pageContext.request.contextPath}/com/file/download.do?idxVal=" + list[i].idxVal + "\" style=\"max-width: 100%;\">";
						} else {
							vHtml += list[i].fileNm;
						}
						
						$("#" + pId + "Table tbody").append(vHtml);
						
						var vHtml2 = "<input type=\"hidden\" name=\"" + pId + "List\" id=\"" + pId + "_" + list[i].idx + "\" value=\"" + list[i].idx + "\">";
						$("#" + pId + "List").append(vHtml2);
					}
				}
			} catch(e) { }
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
		
		function sumtot(val){
			
			var sum = 0;
			
			for(var i=0;i < $('.'+val+'_class').length;i++){
				
				var val_class = ($('.'+val+'_class').eq(i).val() != "") ? parseInt($('.'+val+'_class').eq(i).val().replace(/,/g, "")) : 0;
				sum += val_class;
			}
			
			$('#'+val).empty().text(sum.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
			
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
    <input type="hidden" id="resultSeqM" name="resultSeqM" value="${resultMngList.resultSeq}" />
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
		        <col width="35%" />
		        <col width="20%" />
		        <col width="25%" />
		        <col width="20%" />
	        </colgroup>
	        <thead>
	        	<tr>
	        		<th>품목명</th>
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
		        		<c:forEach items="${resultDetailList}" var="itemList" varStatus="statusList">
		        	<tr id="resultTableTr${statusList.count}" class="resultTableTr">
						<td style="text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
							${itemList.itemNm}
							<input type="hidden" id="pItemNm${statusList.count}" name="pItemNm" value="${itemList.itemNm}"/>
							<input type="hidden" id="dItemSeq${statusList.count}" name="dItemSeq" class="dItemSeqeq" value="${itemList.itemSeq}"/>
							<input type="hidden" id="resultSeq${statusList.count}" name="resultSeq" value="${itemList.resultSeq}"/>
							<input type="hidden" id="resultDetailSeq${statusList.count}" name="resultDetailSeq" value="${itemList.resultDetailSeq}"/>
							<input type="hidden" id="requestYn${statusList.count}" name="requestYn" value="${itemList.requestYn}"/>
							<input type="hidden" id="historySeq${statusList.count}" name="historySeq" value="${itemList.historySeq}"/>
							<input type="hidden" id="detailHistorySeq${statusList.count}" name="detailHistorySeq" value="${itemList.detailHistorySeq}"/>
						</td>
						<td style="padding: 7px 10px;">
							<c:set var="totQty" value="${totQty + fn:replace(itemList.qty,',','') }" />
							<c:if test="${itemList.requestYn eq 'Y' || itemList.requestYn eq 'N' || itemList.requestYn eq 'D'}">
							${itemList.qty}
							<input type="hidden" id="qty${statusList.count}" name="qty" value="${itemList.qty}"/>
							</c:if>
							<c:if test="${itemList.requestYn == null || itemList.requestYn eq '' || itemList.requestYn eq 'W'}">
							<input type="text" id="qty${statusList.count}" name="qty" style="width:100%; text-align:right;" pattern="[0-9]*" inputmode="numeric" style="width:95%" class="zemos_input1 totQty_class" value="${itemList.qty}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');sumtot('totQty');" readOnly="readOnly" />
							</c:if>
						</td>
						<td style="padding: 7px 10px;">
							<c:set var="totAmt" value="${totAmt + fn:replace(itemList.amt,',','') }" />
							<c:if test="${itemList.requestYn eq 'Y' || itemList.requestYn eq 'N' || itemList.requestYn eq 'D'}">
							${itemList.amt}
							<input type="hidden" id="amt${statusList.count}" name="amt" value="${itemList.amt}"/>
							</c:if>
							<c:if test="${itemList.requestYn == null || itemList.requestYn eq '' || itemList.requestYn eq 'W'}">
							<input type="text" id="amt${statusList.count}" name="amt" style="width:100%; text-align:right;" pattern="[0-9]*" inputmode="numeric" style="width:95%" class="zemos_input1 totAmt_class" value="${itemList.amt}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');sumtot('totAmt');" readOnly="readOnly" />
							</c:if>
							<%-- <input type="text" id="amt${statusList.count}" name="amt" style="width:95%" class="zemos_input1" value="${itemList.amt}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/> --%>
						</td>
						<td style="padding: 7px 10px;">
							<c:if test="${itemList.requestYn == null || itemList.requestYn eq '' || itemList.requestYn eq 'W'}">
							<span class="mb5" id="delBtn${statusList.count}"> 
							
								<!--
								<a href="javascript:void(0);" onclick="javascript:fnResultDel('${statusList.count}'); return false;" class="zemos_form_span_btn_red">
									<span style="font-size:13px;">삭제</span>
								</a>
								  -->
							</span>
							</c:if>
						</td>
					</tr>
		        		</c:forEach>
		        	</c:when>
		        	<c:otherwise>
		        	</c:otherwise>
				</c:choose>
				<tfoot>
					<tr>
						<th>합계</th>
						<th id="totQty"><fmt:formatNumber value="${totQty }" pattern="#,###" /></th>
						<th id="totAmt"><fmt:formatNumber value="${totAmt }" pattern="#,###" /></th>
						<th></th>
					</tr>
				</tfoot>
	        </tbody>
    	</table>
    </div>
    
    
    <%-- <div>
    	<table id="resultTable" style="margin-top: 0px; width: 100%;">
    		<colgroup>
		        <col width="35%" />
		        <col width="25%" />
		        <col width="25%" />
		        <col width="15%" />
	        </colgroup>
	        <tbody>
	        	<c:choose>
	        	<c:when test="${fn:length(resultDetailList) > 0}">
	        		<c:forEach items="${resultDetailList}" var="itemList" varStatus="statusList">
	        	<tr id="resultTableTr${statusList.count}">
					<td style="text-align: left; font-size: 15px; font-weight: bold; border-bottom: 1px solid #e0e1e6; line-height: 20px; color: #000000; padding: 7px 10px;">
						${itemList.itemNm}
						<input type="hidden" id="dItemSeq${statusList.count}" name="dItemSeq" value="${itemList.itemSeq}"/>
						<input type="hidden" id="resultSeq${statusList.count}" name="resultSeq" value="${itemList.resultSeq}"/>
						<input type="hidden" id="resultDetailSeq${statusList.count}" name="resultDetailSeq" value="${itemList.resultDetailSeq}"/>
					</td>
					<td>
						<input type="text" id="qty${statusList.count}" name="qty" style="width:95%" class="zemos_input1" value="${itemList.qty}"/>
					</td>
					<td>
						<input type="text" id="amt${statusList.count}" name="amt" style="width:95%" class="zemos_input1" value="${itemList.amt}"/>
					</td>
					<td>
						<span class="fr mb5" style="margin-right:18px;">
							<a href="javascript:void(0);" onclick="javascript:fnResultDel('${statusList.count}'); return false;" class="zemos_form_span_btn_red">
								<span style="font-size:13px;">삭제</span>
							</a>
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
    </div> --%>
    <!-- 품목 -->
    
    <!-- 달러 -->
    <div class="zemos_form1" style="padding-top:10px; text-align:right;">
    
    	<span style="width:100%;">
			<c:if test="${selectStoreDetail.unitYn eq 'Y'}">
			<input type="text" id="dollarAmt" name="dollarAmt" class="zemos_input1"  style="width:50%;" pattern="[0-9]*" inputmode="numeric" value="${resultMngList.dollarAmt}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /> $
			</c:if>
			<c:if test="${selectStoreDetail.unitYn eq 'N'}">
			<input type="hidden" id="dollarAmt" name="dollarAmt" class="zemos_input1" value="${resultMngList.dollarAmt}" disabled="disabled"/>
			</c:if>
		</span>
		
		<c:choose>
    		<c:when test="${(today eq salesDay.resultDt || yesterday eq salesDay.resultDt) && fn:length(resultDetailList) > 0}">
    			<a href="javascript:void(0);" onclick="javascript:fnResultDallerChange(); return false;" class="zemos_form_span_btn_blue" style="width: 80px; float: right; margin-left: 20px;">
					<span style="font-size:13px;">달러수정</span>
				</a>
    		</c:when>
    	</c:choose>
		
    </div>
    <!-- 달러 -->
    
    <!--팝업시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/family/sales2/popup/itemPopup_01.jsp"%>
    <!--팝업끝-->
    
    </form>
    
    <input type="hidden" id="resultDetailListLength" name="resultDetailListLength" value="${fn:length(resultDetailList)}">
  	<!-- 오늘날짜 비교 했을 때 당일/하루전 아니면 아예 저장 버튼 안 보이게 처리 -->
    <c:if test="${today eq salesDay.resultDt || yesterday eq salesDay.resultDt }">
    
	    <!-- 한 번 저장한 상태에서는 저장할 수 없음.(수정요청으로 처리, 단 새로운 품목 추가 시 저장가능) -->
	  	<c:if test="${fn:length(resultDetailList) == 0}">
	  	
	   			
	    	<!-- 매장설정에서 첨부파일 등록 여부를 사용으로 했을경우. -->
	    	<c:if test="${selectStoreDetail.fileYn eq 'Y'}">
	    		<c:if test="${not empty resultMngList.imageIdxEnc}">
				    <div id="imgDiv" class="zemos_form2" onclick="javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=${resultMngList.imageIdxEnc}'); return false;">
						<img style="max-width: 100%;" src="${pageContext.request.contextPath}/com/file/download.do?idxVal=${resultMngList.imageIdxEnc}">
					</div>
				</c:if>
				
	    	
	    <div style="width:100%;">
	    	<form id="dataFileForm" method="post" enctype="multipart/form-data" action="" style="display:none;">
				<input type="file" id="dataFile" multiple="multiple">
				<input type="hidden" id="pageGubun" value="sales">
			</form>
			<div id="dataFileList">
				<c:forEach items="${fileList}" var="item" varStatus="status">
					<input type="hidden" name="dataFileList" id="dataFile_${item.IDX}" value="${item.IDX}">
				</c:forEach>
			</div>
			<div class="zemos_form">
				<!-- <table class="zemos_table2" id="dataFileTable"> -->
		        <table id="dataFileTable" style="width:100%; margin-bottom:5%;">
		            <colgroup>
			            <col width="50%" />
			            <col width="*" />
		            </colgroup>
		            <tbody>
		            	<c:forEach items="${fileList}" var="item" varStatus="status">
						    <tr id="dataFile_${item.IDX}_tr">
							    <td style="border-left-width: 0px; cursor: pointer;" onclick="javascript:fn_mobile_download('${common.fullContext}/com/file/download.do?idxVal=${item.IDX_VAL}');">
									<img src="${pageContext.request.contextPath}/com/file/download.do?idxVal=${item.IDX_VAL}" style="max-width: 100%;">
								</td>
								<td style="padding: 5px 1px; border-left-width: 0px;">
									<a href="#" onclick="javascript:fn_file_delete('${item.IDX}'); return false;" class="zemos_btn_small1_grey" style="width: 50px; float: right;">삭제</a>
				                </td>
							</tr>
						</c:forEach>
		            </tbody>
		        </table>
		        <!-- <div class="fl" style="width:100%;" id="fileDiv"> -->
		        <div style="width:100%;" id="fileDiv">
		        	<!-- <span class="fl mb5" style="width: 83%; height: 29px; text-align: left; position: absolute; right: 35px;"> -->
		        	<span class="mb5" style="height:29px; text-align:left; position:absolute; left:5%; width:100%;">
	            		<a href="#" onclick="javascript:fn_file_upload('image'); return false;" class="zemos_btn_small1_grey" style="width:90%;">파일선택</a>
	            	</span>
	            </div>
		    </div>
	    </div>
	    	</c:if>
	    	
	    <%-- </c:if> --%>
	    
	    
    	
    	</c:if><!-- 저장된 자료 비교 -->
    </c:if><!-- 날짜 비교 -->
    
    <div style="width:100%; padding-top:35px; display:none;" id="saveBtnDiv">
    	<span class="mb5" style="width:100%; height:29px; text-align:left; position:absolute; left:5%; width:100%;">
			<a href="javascript:void(0);" onclick="javascript:fnUserResultSave('${selectStoreDetail.fileYn}'); return false;" class="zemos_form_span_btn_blue" style="width:90%;">
				<span style="font-size:15px;">저 장</span>
			</a>
		</span>
	</div>
    
</body>
</html>