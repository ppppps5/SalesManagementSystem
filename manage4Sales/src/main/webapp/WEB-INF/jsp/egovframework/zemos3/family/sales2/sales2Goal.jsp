<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	
	<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp"%>
	<!-- selectbox 검색기능 css -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/zemos3/selectbox.css"/>
	
	<script type="text/javascript">
		//전역변수
		var zemosIdx  = "${params.zemosIdx[0]}";
		var zemosNm = "${params.zemosNm[0]}";
		var pageNo    = "${pageNo}";
		var numOfRows = "${numOfRows}";
		var wrkplcIdx = "${params.wrkplcIdx[0]}";
		var storeSeq = "${params.storeSeq[0]}";
		var row = "";
		var gubun = "";
		
		$(document).ready(function () {
			$("#storeSeq").select2();
			$(".select2-selection__arrow").hide();
			
			genRowspan("first");			
			genRowspan("first01");
			
			
			//alert(storeSeq02);
			$("#dataFile").change(function() {
				var formData = new FormData($("#dataFileForm")[0]);
		        var vFiles = $(this).prop("files");
		        
				if ( vFiles == null || vFiles <= 0 ) {
					alert("파일이 존재하지 않습니다.");
					$("#dataFile").val("");
					return;
				}
				
				if (vFiles.length > 0) {
					var file 	= vFiles[0];
					var fileExt = file.name.slice(file.name.indexOf(".") + 1).toLowerCase();
					if (fileExt != "xls" && fileExt != "xlsx") {
						alert("목표등록 양식 파일을 선택 바랍니다.");
						$("#dataFile").val("");
						return;
					}
				} else {
					$("#dataFile").val("");
					return;
				}
				
				var fileValue = $("#dataFile").val().split("\\");
				var fileName = fileValue[fileValue.length-1]; // 파일명
				formData.append('fileName', fileName);
				formData.append('zemosIdx', zemosIdx);
				formData.append('wrkplcIdx', wrkplcIdx);
				formData.append('gbn', gubun);
				formData.append('storeSeq', storeSeq);
				formData.append('itemSeq', $("#itemSeq"+row).val());
				formData.append('unitNm', $("#unitNm option:selected").val());
				formData.append('onoffNm', $("#onoffNm option:selected").val());

				//formData.append('year', year);
				
				$.ajax({
		            type	 	: "POST",
				    dataType 	: "json",
		            enctype		: "multipart/form-data",
		            url		 	: gvContextPath + "/zemos3/family/sales2/sales2GoalExcelUpload.do",
				    data	 	: formData,
				    processData	: false,
				    contentType	: false,
		            cache		: false,
		            timeout		: 600000,
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
				    },
		            success	 : function(result) {
		            	if (result.result) {
							alert("목표등록을 완료하였습니다.");
		            	} else {
		            		var now = new Date();
		    			    var year = now.getFullYear();
		    			    var month = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1) : '0' + (now.getMonth() + 1);
		    			    
		            		if ( result.resultError == '1' ) {
		            			alert("목표등록에 실패하였습니다.\n엑셀의 매장명이 상이합니다. 매장명을 확인해 주세요.");
		            		} else if ( result.resultError == '2' ) {
		            			alert(result.itemName + " 품목은 등록되지 않았습니다.\n"+result.itemName+" 품목명을 확인해 주세요.");
		            		} else if ( result.resultError == '3' ) {
		            			alert("목표등록에 실패하였습니다.\n엑셀의 값에 숫자가 아닌 데이터가 있습니다.");
		            		} else if ( result.resultError == '4' ) {
		            			alert("목표등록에 실패하였습니다.\n년월을 확인 해 주세요.(예:"+year+"년 "+month+"월)");
		            		} else if ( result.resultError == '5' ) {
		            			alert("목표등록에 실패하였습니다.\n월을 올바르게 작성해 주세요.(01월~12월)");
		            		} else if ( result.resultError == '6' ) {
		            			alert("목표등록에 실패하였습니다.\n매장의 품목갯수와 엑셀의 품목 갯수가 맞지않습니다.");
		            		}
		            	}
		            	fn_loading_hide();
		            	$("#dataFile").val("");
		            	fn_reload('select');
		            },
		            always : function(result) {
		            	fn_loading_hide();
		            	$("#dataFile").val("");
		            },
		            fail : function(result) {
		            	$("#dataFile").val("");
		            }
				});
			});
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
		
		//조회
		function fn_reload(type, value1, value2) {
			var startDate     = $("#startDate").val();
			var endDate       = $("#endDate").val();
			var selectText    = $("#selectText").val();
			var storeSeq      = $("#storeSeq option:selected").val();
			//var unitNm       = $("#unitNm option:selected").val();
			//var onoffNm       = $("#onoffNm option:selected").val();
			
			if ( type == "pageNo" ) {
				pageNo = value1;
			}
			
			if ( type == "select" ) {
				pageNo = 1;
			
			
			var url = "${pageContext.request.contextPath}${common.requestURI}";
			url += "?pageNo="	     + pageNo;
			url += "&numOfRows="	 + numOfRows;
			url += "&zemosIdx="	     + zemosIdx;
			url += "&wrkplcIdx="	 + wrkplcIdx;
			url += "&zemosNm="	     + encodeURIComponent(zemosNm);
			url += "&yyyy="			 + $("#yyyy option:selected").val();
			url += "&storeSeq="		 + storeSeq;
			//url += "&unitNm="		 + unitNm
			//url += "&onoffNm="	 + onoffNm
			
			fn_location_href(url);
			}
			//if ( type == "excel" ) {
			//	alert("먼저 " + storeNm + "${storeUseName[0].storeUseNm}의 전체목표를 등록해 주세요.");
			//}
		}
		
		//엑셀 다운로드
		function fnExcelDown(gbn, storeSeq, storeNm, unitNmd, onoffNMd,cnt) {
			var now = new Date();
			var year = now.getFullYear();
			
			
		    if (gbn == 'A'){
		    	var unitNm       = $("#unitNm option:selected").val();
				var onoffNm       = $("#onoffNm option:selected").val();
		    	//alert(unitNm);
		    	if (unitNm == null || unitNm ==''){
		    		alert("전체목표 다운 시 단위구분을 입력 해주세요.");
		    		return;
		    	}
		    	if(onoffNm == null || onoffNm ==''){
		    		alert("전체목표 다운 시 온/오프라인 구분을 입력 해주세요.");
		    		return;
		    	} 
			    	
	    		var vUrl = "${common.fullContext}/zemos3/family/sales2/sales2GoalExcelDownload.do"; //local
				//var vUrl = "https://m.zemos.co.kr/zemos3/family/sales2/sales2GoalExcelDownload.do"; //운영
				vUrl += "?zemosIdx=" + zemosIdx;
				vUrl += "&wrkplcIdx="	 + wrkplcIdx;
				vUrl += "&zemosNm=" + encodeURIComponent(zemosNm);
				vUrl += "&storeSeq=" + storeSeq;
				vUrl += "&storeNm=" + storeNm;
				vUrl += "&unitNm=" + unitNm;
				vUrl += "&onoffNm=" + onoffNm;
				vUrl += "&year=" + $("#yyyy option:selected").val();
				vUrl += "&gbn=" + gbn;
				
				fn_mobile_download(vUrl);
			
			    }
		    if (gbn == 'O'){
		    	var unitNm       = unitNmd;
				var onoffNm      = onoffNMd;
		    	//alert(unitNm);
		    	//alert(onoffNm);
			    	
	    		var vUrl = "${common.fullContext}/zemos3/family/sales2/sales2GoalExcelDownload.do"; //local
				//var vUrl = "https://m.zemos.co.kr/zemos3/family/sales2/sales2GoalExcelDownload.do"; //운영
				vUrl += "?zemosIdx=" + zemosIdx;
				vUrl += "&wrkplcIdx="	 + wrkplcIdx;
				vUrl += "&zemosNm=" + encodeURIComponent(zemosNm);
				vUrl += "&storeSeq=" + storeSeq;
				vUrl += "&storeNm=" + storeNm;
				vUrl += "&unitNm=" + unitNm;
				vUrl += "&onoffNm=" + onoffNm;
				vUrl += "&year=" + $("#yyyy option:selected").val();
				vUrl += "&gbn=" + gbn;
				
				fn_mobile_download(vUrl);
			
			    }
		    	
		}
		
		//엑셀 업로드
		function fnExcelUpload(gbn, storeSeq, cnt,gbn01) {
			if($("#dataFile").val() != "") {
				return;
			}
			var unitNm       = $("#unitNm option:selected").val();
			var onoffNm       = $("#onoffNm option:selected").val();
			var storeSeq02 = '';
			
			//alert(storeSeq);
			row = cnt;
			gubun = gbn;
			gubun01 = gbn01;
			storeSeq02 =  storeSeq;
			if (gubun == 'A'){
				if (gubun01 != 'B'){
					if (unitNm == null || unitNm ==''){
			    		alert("전체목표 업로드 시 단위구분을 입력 해주세요.");
			    		return;
			    	}
			    	if(onoffNm == null || onoffNm ==''){
			    		alert("전체목표 업로드 시 온/오프라인 구분을 입력 해주세요.");
			    		return;
					}
				}

		    	$("#dataFile").trigger('click');
		    	
			} 
			
		}

		//목표등록 상세
		function fnSalesGoalDetail(storeSeq, year, storeNm, unitYn, unitSeq, offYn, onYn, unitNm, onoffNM,totGoal) {
			if ( totGoal == null || totGoal == 0 ) {
				alert("먼저 " + storeNm +"${storeUseName[0].storeUseNm}의" + unitNm + "전체목표를 등록해 주세요.");
				return;
			}

			/*
				unitYn = 1 unit_seq1 unitYn = 2 unit_seq2 unitYn = 3 unit_seq3
				unitYn = 4 unit_seq4 unitYn = 5 unit_seq5 
			*/
			
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2GoalDetail.do";
			
			url += "?zemosIdx=" 	+ zemosIdx;
			url += "&wrkplcIdx=" 	+ wrkplcIdx;
			url += "&zemosNm=" 		+ encodeURIComponent(zemosNm);
			url += "&storeSeq=" 	+ storeSeq;
			url += "&unitYn=" 		+ unitYn;
			url += "&unitSeq=" 		+ unitSeq;
			url += "&offYn=" 		+ offYn;
			url += "&onYn=" 		+ onYn;
			url += "&unitNm=" 		+ unitNm;
			url += "&onoffNM=" 		+ onoffNM;
			url += "&year=" 		+ $("#yyyy option:selected").val();
			
			fn_location_href(url);
		}
		
		//제모스 판매관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx="+wrkplcIdx);
		}
	</script>
</head>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">목표등록</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <!--조회조건시작-->
    <div class="zemos_label_search1">
    	<span class="fl mb5" style="width:30%; padding-right:2%;">
	    	<select id="yyyy" class="zemos_select1" style="width:100%" onchange="javascript:fn_reload('select');">
				<c:forEach items="${yyyyList}" var="item" varStatus="status">
					<option value="${item.yyyy}" <c:if test="${item.yyyy eq yyyy}">selected</c:if>>${item.yyyy}</option>
				</c:forEach>
			</select>
		</span>
    	<span class="fl mb5" style="width:70%; padding-right:10%;">
    		<%-- <input id="selectText" name="selectText" type="text" class="zemos_input1" style="float: left; width:100%;" value="${params.selectText[0]}" placeholder="검색어 입력" onKeyPress="javascript:if(event.keyCode == 13) fn_reload('select');" onfocus="$(this).select();"> --%>
    		<select id="storeSeq" name="storeSeq" class="zemos_select1" style="width:100%; text-align:left;">
				<option value="">${storeUseName[0].storeUseNm}전체</option>
     			<c:forEach items="${storeList}" var="item" varStatus="status">
     			<option value="${item.storeSeq}" <c:if test="${item.storeSeq eq params.storeSeq[0]}">selected</c:if>>${item.storeNm}</option>
     			</c:forEach>
			</select>
    	</span>
    	<span class="fr mb5" style="position:absolute; right:3%;">
			<a href="#" onclick="javascript:fn_reload('select'); return false;" class="zemos_label_search1_search_image"></a>
		</span>
		<span class="fl mb5" style="width:30%; padding-right:2%;">
	    	<select id="unitNm" class="zemos_select1" style="width:100%">
	    	<option value="">단위</option>
				<c:forEach items="${unitList}" var="unit" varStatus="status">
					<option value="${unit.unitNm}" <c:if test="${unit.unitNm eq params.unitNm[0]}">selected</c:if>>${unit.unitNm}</option>
				</c:forEach>
			</select>
		</span>
		<span class="fl mb5" style="width:30%; padding-right:2%;">
	    	<select id="onoffNm" class="zemos_select1" style="width:100%">
	    	<option value="">온/오프</option>
				<c:forEach items="${onoffList}" var="onoff" varStatus="status">
					<option value="${onoff.onoffNm}" <c:if test="${onoff.onoffNm eq params.onoffNm[0]}">selected</c:if>>${onoff.onoffNm}</option>
				</c:forEach>
			</select>
		</span>
    </div>
    <!--조회된자료끝-->
    <!--조회된자료시작-->
    <div class="zemos_label_search2">
        <span class="fl" style="padding:10px 0px;">
			조회<span class="zemos_label_data_grey2">${goalCnt}</span>건
        </span>
<!--         <span class="mb5" style="margin-top:5px; width:27%;position:absolute; right:34%;"> -->
<!-- 			<a href="javascript:void(0);" onclick="javascript:fnExcelDown('A', '', '', ''); return false;" class="zemos_form_span_btn_blue"> -->
<%-- 				<span style="font-size:13px;">${storeUseName[0].storeUseNm}전체 다운</span> --%>
<!-- 			</a> -->
<!-- 		</span> -->
<!-- 		<span class="mb5" style="margin-top:5px; width:30%; position:absolute; right:3%;"> -->
<!-- 			<a href="javascript:void(0);" onclick="javascript:fnExcelUpload('A', '', ''); return false;" class="zemos_form_span_btn_blue"> -->
<%-- 				<span style="font-size:13px;">${storeUseName[0].storeUseNm}전체 업로드</span> --%>
<!-- 			</a> -->
<!-- 		</span> -->
    </div>
    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
    	<table class="zemos_table1 table-container" style="margin-top: 0px;">
    		<colgroup>
		         <col width="25%">
                 <col width="15%">
                 <col width="20%">
                 <col width="20%">
                 <col width="20%">
	        </colgroup>
	        <thead>
	        	<tr style="width:100%; height:29px;">
                                <th>${storeUseName[0].storeUseNm}명</th>
                                <th>기준</th>
                                <th>온/오프</th>
                                <th>목표</th>
                                <th>업/다운</th>
                                
                </tr>
	        </thead>
	        <tbody>
                 <c:choose>
                     <c:when test="${fn:length(goalList) > 0}">
                        <c:forEach items="${goalList}" var="item" varStatus="status">
                           <tr id="goalTableTr${status.count}">
                             <!-- 매장명 -->
                             <td class="first" id="storeNm${status.count}" class="storeNm${status.count}" style="padding: 5px; text-align: center;">
                                 <input type="hidden" id="storeSeq${status.count}" name="storeSeq${status.count}" value="${item.storeSeq}">
                                 <input type="hidden" id="storeNm${status.count}" name="storeNm${status.count}" value="${item.storeNm}">
                                 <input type="hidden" id="unitYn${status.count}" name="unitYn${status.count}" value="${item.unitYn}">
                                 <input type="hidden" id="unitSeq${status.count}" name="unitSeq${status.count}" value="${item.unitSeq}">
                                 <input type="hidden" id="offYn${status.count}" name="offYn${status.count}" value="${item.offYn}">
                                 <input type="hidden" id="onYn${status.count}" name="onYn${status.count}" value="${item.onYn}">
                                 ${item.storeNm}
                             </td>

                             <!-- 기준 -->
                             <td id="unitNm${status.count}" class="unitNm${status.count}" style="padding:5px; text-align: center;" onclick="javascript:fnSalesGoalDetail('${item.storeSeq}', '${item.year}', '${item.storeNm}','${item.unitYn}','${item.unitSeq}','${item.offYn}','${item.onYn}','${item.unitNm}','${item.onoffNM}','${item.totGoal}');">
                              ${item.unitNm}
							 </td>
                          
                               <!-- 온/오프 -->
                               <td id="onoffNM${status.count}" class="onoffNM${status.count}" style="padding:5px; text-align: center;" onclick="javascript:fnSalesGoalDetail('${item.storeSeq}', '${item.year}', '${item.storeNm}','${item.unitYn}','${item.unitSeq}','${item.offYn}','${item.onYn}','${item.unitNm}','${item.onoffNM}','${item.totGoal}');">
      							${item.onoffNM}
                               </td>
                               
                               <!-- 목표 -->
                               <td id="totGoal${status.count}" class="totGoal${status.count}" style="padding:5px; text-align:right;" onclick="javascript:fnSalesGoalDetail('${item.storeSeq}', '${item.year}', '${item.storeNm}','${item.unitYn}','${item.unitSeq}','${item.offYn}','${item.onYn}','${item.unitNm}','${item.onoffNM}','${item.totGoal}');">
                              	 <fmt:formatNumber value="${item.totGoal}" pattern="#,###" />
                               </td>
                               
                               <!-- 업/다운 -->
                               <td style="padding:5px; text-align: center;">
                                <c:if test="${item.offYn == 'Y'}">                                                 	
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelDown('O', '${item.storeSeq}','${item.storeNm}','${item.unitNm}','${item.onoffNM}','${status.count}'); return false;">
                                       <img src="../../../images/egovframework/zemos3/icon_download.png" style="width: 25%;">
                                   </a>
                                   <span>
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelUpload('A', '${item.storeSeq}','${status.count}','B'); return false;">
                                   	<img src="../../../images/egovframework/zemos3/icon_upload.png" style="width: 25%; margin-left: 2px;">
                                   </a>
                                   </span>                           
                                 </c:if>
                                 <c:if test="${item.onYn == 'Y'}">  
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelDown('O', '${item.storeSeq}','${item.storeNm}','${item.unitNm}','${item.onoffNM}','${status.count}'); return false;">
                                       <img src="../../../images/egovframework/zemos3/icon_download.png" style="width: 25%;">
                                   </a>
                                   <span>
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelUpload('A', '${item.storeSeq}','${status.count}','B'); return false;">
                                   	<img src="../../../images/egovframework/zemos3/icon_upload.png" style="width: 25%; margin-left: 2px;">
                                   </a>
                                   </span>
                                 </c:if>
                               </td>
                              
                             </tr>
                            </c:forEach>
                     </c:when>
                     <c:otherwise>
                         <tr>
                             <td colspan="4" style="text-align:center;">
                               		  등록되어있는 실적이 없습니다.
                             </td>
                         </tr>
                     </c:otherwise>
                 </c:choose>
             </tbody>
	       	  <tfoot>
	       	  	<c:choose>
                     <c:when test="${fn:length(totSumGoal) > 0}">
                        <c:forEach items="${totSumGoal}" var="totSum" varStatus="status">
                <tr style="background-color:#CEE3F6; font-weight:bold;">
                    <td class="first" style="padding: 5px; text-align: center; font-size: 12px;">합계</td>            
                    <td class="first01" style="padding: 5px; text-align: center; font-size: 12px;">${totSum.unitNm}</td>
                    <td style="padding: 5px; text-align: center; font-size: 12px;">${totSum.onoffNM}</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${totSum.totSumGoal}" pattern="#,###" /></td>
                    <td></td>
                    
                </tr>
                </c:forEach>
                     </c:when>
                </c:choose>
            </tfoot>
    	</table>
    </div>
    <!--조회된자료끝-->
    <form id="dataFileForm" method="post" enctype="multipart/form-data" action="" style="display:none;">
		<input type="file" id="dataFile" name="dataFile">
	</form>
</body>
</html>