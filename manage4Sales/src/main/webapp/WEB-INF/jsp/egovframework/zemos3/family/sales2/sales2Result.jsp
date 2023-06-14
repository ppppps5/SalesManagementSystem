<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp" %>
        <!DOCTYPE html>
        <html>

        <head>
           <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
           <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
           <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp" %>
           
           <!-- 달력 -->
		   <%@include file="/WEB-INF/jsp/egovframework/zemos3/zemos/report/common/carendar.jsp"%>
		   
       	   <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/egovframework/zemos3/selectbox.css" />
           <script type="text/javascript">

             //전역변수
             var zemosIdx = "${params.zemosIdx[0]}";
             var zemosNm = "${params.zemosNm[0]}";
             var pageNo = "${pageNo}";
             var numOfRows = "${numOfRows}";
             var wrkplcIdx = "${params.wrkplcIdx[0]}";
             var storeSeq = "${params.storeSeq[0]}";
             var unitSeq = "${params.unitSeq[0]}";
             var userAdminGbn = "${params.userAdminGbn[0]}";
             var row = "";
             var gubun = "";
             var storeSeq1 = "";
             var unitYn1 = "";
             var unitSeq1 = "";
             var offYn1 = "";
             var onYn1 = "";
             var ex = "${params.ex[0]}";
             var ex2 = "${params.ex2[0]}";
             var app = "${params.app[0]}";
             

            $(document).ready(function () {
            	genRowspan("first");			
    			genRowspan("first01");
            	
                //달력
                setCarendarDay01('#carendarYmd1', '#carendarYmd2');
				
                var startDay = $("#carendarYmd1").val();
              	var endDay = $("#carendarYmd2").val();
                $("#storeSeq").select2();
                $(".select2-selection__arrow").hide();

                $("#dataFile").change(function () {
                    var formData = new FormData($("#dataFileForm")[0]);
                    var vFiles = $(this).prop("files");

                    if (vFiles == null || vFiles <= 0) {
                        alert("파일이 존재하지 않습니다.");
                        $("#dataFile").val("");
                        return;
                    }

                    if (vFiles.length > 0) {
                        var file = vFiles[0];
                        var fileExt = file.name.slice(file.name.indexOf(".") + 1).toLowerCase();
                        if (fileExt != "xls" && fileExt != "xlsx") {
                            alert("실적등록 양식 파일을 선택 바랍니다.");
                            $("#dataFile").val("");
                            return;
                        }
                    } else {
                        $("#dataFile").val("");
                        return;
                    }
                    //(gbn, storeSeq, unitYn, unitSeq, offYn, onYn, cnt)
                    
                  var fileValue = $("#dataFile").val().split("\\");
                  var fileName = fileValue[fileValue.length - 1]; // 파일명
                  formData.append('fileName', fileName);
                  formData.append('zemosIdx', zemosIdx);
                  formData.append('wrkplcIdx', wrkplcIdx);
                  formData.append('gbn', gubun);
                  formData.append('storeSeq', storeSeq1);
                  formData.append('unitYn',unitYn1);
                  formData.append('unitSeq',unitSeq1);
                  formData.append('offYn',offYn1);
                  formData.append('onYn',onYn1);
                  
                  //formData.append('year', year);

                  $.ajax({
                      type: "POST",
                      dataType: "json",
                      enctype: "multipart/form-data",
                      url: gvContextPath + "/zemos3/family/sales2/sales2ResultExcelUpload.do",
                      data: formData,
                      processData: false,
                      contentType: false,
                      cache: false,
                      timeout: 600000,
                      xhr: function () {
                          var xhr = $.ajaxSettings.xhr();
                          xhr.onprogress = function e() {
                              // For downloads
                              if (e.lengthComputable) {
                                  fn_loading_show("다운로드 " + (Math.round(100 * e.loaded / e.total)) + "%");
                              }
                          };
                          xhr.upload.onprogress = function (e) {
                              // For uploads
                              if (e.lengthComputable) {
                                  fn_loading_show("업로드 " + (Math.round(100 * e.loaded / e.total)) + "%");
                              }
                          };
                          return xhr;
                      },
                      success: function (result) {
                          if (result.result) {
                              alert("실적등록을 완료하였습니다.");
                          } else {
                              var now = new Date();
                              var year = now.getFullYear();
                              var month = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1) : '0' + (now.getMonth() + 1);

                              if (result.resultError == '1') {
                                  alert("실적등록에 실패하였습니다.\n엑셀의 ${storeUseName[0].storeUseNm}명이 상이합니다. ${storeUseName[0].storeUseNm}명을 확인해 주세요.");
                              } else if (result.resultError == '2') {
                                  alert(result.itemName + " 품목은 등록되지 않았습니다.\n" + result.itemName + " 품목명을 확인해 주세요.");
                              } else if (result.resultError == '3') {
                                  alert("실적등록에 실패하였습니다.\n엑셀의 값에 숫자가 아닌 데이터가 있습니다.");
                              } else if (result.resultError == '4') {
                                  alert("실적등록에 실패하였습니다.\n년월을 확인 해 주세요.(예:" + year + "년 " + month + "월)");
                              } else if (result.resultError == '5') {
                                  alert("실적등록에 실패하였습니다.\n월을 올바르게 작성해 주세요.(01월~12월)");
                              } else if (result.resultError == '6') {
                                  alert("실적등록에 실패하였습니다.\n${storeUseName[0].storeUseNm}의 품목갯수와 엑셀의 품목 갯수가 맞지않습니다.");
                              }
                          }
                          fn_loading_hide();
                          $("#dataFile").val("");
                          fn_reload('select');
                      },
                      always: function (result) {
                          fn_loading_hide();
                          $("#dataFile").val("");
                      },
                      fail: function (result) {
                          $("#dataFile").val("");
                      }
                  });
              });
				<c:if test = "${startDay != null}">
				$("#carendarYmd1").val("${startDay}");
				$("#carendarYmd2").val("${endDay}");
				</c:if>
            });

                  //조회
                  function fn_reload(type, value1, value2) {

                  	var startDay = $("#carendarYmd1").val();
                  	var endDay = $("#carendarYmd2").val();
					
                  	
                      var storeSeq = $("#storeSeq option:selected").val();
	
                      if (type == "pageNo") {
                          pageNo = value1;
                      }

                      if (type == "select") {
                          pageNo = 1;
                      }
                      
                      var url = "${pageContext.request.contextPath}${common.requestURI}";
                      if (ex == 'y' || ex == 'y2') {
                    	  url += "?ex=" + ex;
                      }
                      
                      if (app == 'y'){
                    	  url += "?app=" + app;
                      }
                      
                      url += "&pageNo=" + pageNo;
                      url += "&numOfRows=" + numOfRows;
                      url += "&zemosIdx=" + zemosIdx;
                      url += "&wrkplcIdx=" + wrkplcIdx;
                      url += "&zemosNm=" + encodeURIComponent(zemosNm);
                      url += "&startDay=" + startDay;
                      url += "&endDay=" + endDay;
                      url += "&storeSeq=" + storeSeq;
					  url += "&userAdminGbn=" + userAdminGbn;
					  
                      fn_location_href(url);
                  }
                  
                  //엑셀 다운로드
                  function fnExcelDown(gbn, storeSeq, storeNm, unitYn, unitSeq, unitNm, onoffNM, cnt) {
                      var now     = new Date();
                      var startDay = $("#carendarYmd1").val();
                      var endDay = $("#carendarYmd2").val();
                      
                      var vUrl = "${common.fullContext}/zemos3/family/sales2/sales2ResultExcelDownload.do"; //local
                      ////var vUrl = "https://m.zemos.co.kr/zemos3/family/sales2/sales2ResultExcelDownload.do"; //운영
                      
                      vUrl += "?zemosIdx=" + zemosIdx;
                      vUrl += "&wrkplcIdx=" + wrkplcIdx;
                      vUrl += "&storeSeq=" + storeSeq;
                      vUrl += "&storeNm=" + storeNm;
                      vUrl += "&unitYn=" + unitYn;
                      vUrl += "&unitSeq=" + unitSeq;
                      vUrl += "&unitNm=" + unitNm;
                      vUrl += "&onoffNM=" + onoffNM;
                      vUrl += "&startDay=" + startDay;
                      vUrl += "&endDay=" + endDay;
                      vUrl += "&gbn=" + gbn;
                     	
                      fn_mobile_download(vUrl);
                  }

                  //엑셀 업로드
                  //('O', '${item.storeSeq}', '${item.unitYn}', '${item.unitSeq}', '${item.offYn}', '${item.onYn}','${status.count}')
                  function fnExcelUpload(gbn, storeSeq, unitYn, unitSeq, offYn, onYn, cnt) {         
					  <c:if test="${closeYn[0].closeYn == 'Y'}">
                	  	alert("이미 마감된 달의 실적은 업로드 할 수 없습니다.");
                	  	return;
                	  </c:if>
                      if ($("#dataFile").val() != "") {
                          return;
                      }
                      row = cnt;
                      gubun = gbn;
                      storeSeq1 = storeSeq;
                      unitYn1 = unitYn;
                      unitSeq1 = unitSeq;
                      offYn1 = offYn;
                      onYn1 = onYn;
                      
                      $("#dataFile").trigger('click');
                  }

                  
                //실적등록 상세 ('${item.storeSeq}','${item.unitYn}','${item.unitSeq}','${item.onoffNM}','${item.unitNm}','${item.storeNm}','${item.totResult}')
          		function fnSalesResultDetail(storeSeq,unitYn, unitSeq, onoffNM, unitNm,storeNm,totResult) {
          			var startDay = $("#carendarYmd1").val();
                  	var endDay = $("#carendarYmd2").val();
          			if ( totResult == null ) {
          				alert("먼저 " + storeNm + "${storeUseName[0].storeUseNm}의 전체실적을 등록해 주세요.");
          				return;
          			}
          			
          			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2ResultDetail.do";
          			if(ex == 'y' || ex == 'y2'){
          				url += "?ex=" + ex;
          			}
          			
          			if(app == 'y'){
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
                  
                  //제모스 판매관리 메뉴이동
                  function fn_back2() {
                	  var userAdminGbn = "${params.userAdminGbn[0]}";
                	  
                	  if( ex == 'y' && userAdminGbn == 'A') {
                		  fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?zemosIdx=" + zemosIdx + "&zemosNm=" + encodeURIComponent(zemosNm) + "&wrkplcIdx=" + wrkplcIdx);
                	  } else if ( ex == 'y' && userAdminGbn == 'U'){
                		  fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx=" + zemosIdx + "&zemosNm=" + encodeURIComponent(zemosNm) + "&wrkplcIdx=" + wrkplcIdx);
                	  }
                	  
                	  if( app == 'y' && userAdminGbn == 'A') {
                		  fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2AdminMain.do?zemosIdx=" + zemosIdx + "&zemosNm=" + encodeURIComponent(zemosNm) + "&wrkplcIdx=" + wrkplcIdx);
                	  } else if ( app == 'y' && userAdminGbn == 'U') {
                		  fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2UserMain.do?zemosIdx=" + zemosIdx + "&zemosNm=" + encodeURIComponent(zemosNm) + "&wrkplcIdx=" + wrkplcIdx);
                	  }
                	  
                	  if (ex == 'y2') {
                		  fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx=" + zemosIdx + "&zemosNm=" + encodeURIComponent(zemosNm) + "&wrkplcIdx=" + wrkplcIdx);
                	  } 
                      
                  }

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
            
            </script>
  </head>
        <body>
    <!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp" %>
        <!--상단끝-->
        <!--타이틀시작-->
        <div class="zemos_title1">
            <span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">실적등록엑셀</span>
            <span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
       </div>
      <!--타이틀끝-->
      <!--조회조건시작-->
      <div class="zemos_label_search1">
      	<!--기간선택-->
      	<!-- 매장선택 -->
          <span class="fl mb5" style="width:100%; padding-right:10%;">
              <select id="storeSeq" name="storeSeq" class="zemos_select1"
                  style="width:100%; text-align:left;">
                  <option value="">${storeUseName[0].storeUseNm}전체</option>
                  <c:forEach items="${storeList}" var="item" varStatus="status">
                      <option value="${item.storeSeq}" <c:if test="${item.storeSeq eq params.storeSeq[0]}">
                          selected</c:if>>${item.storeNm}
                      </option>
                  </c:forEach>
              </select>
          </span>
          <span class="fr mb5" style="position:absolute; right:3%;">
              <a href="#" onclick="javascript:fn_reload('select'); return false;"
                  class="zemos_label_search1_search_image"></a>
          </span>
			<span style="border-left-width: 0px; font-size:15px; font-weight:600;">시작일</span>
			<input id="carendarYmd1" type="text" class="zemos_input1" style="width: 25%; margin-bottom: 2px;">
			
			<span style="border-left-width: 0px; font-size:15px; font-weight:600;">~</span>
			<span style="border-left-width: 0px; font-size:15px; font-weight:600;">종료일</span>
			<input id="carendarYmd2" type="text" class="zemos_input1" style="width: 27%; margin-bottom: 2px;">	
          
      </div>
      <!--조회된자료끝-->
      <!--조회된자료시작-->
      <div class="zemos_label_search2">
          <span class="fl" style="padding:10px 0px;">조회
              <span class="zemos_label_data_grey2">${resultCnt}</span>건
          </span>
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
                                <th>실적</th>
                                <th>업/다운</th>
                                
                </tr>
	        </thead>
	        <tbody>
                 <c:choose>
                     <c:when test="${fn:length(resultList) > 0}">
                        <c:forEach items="${resultList}" var="item" varStatus="status">
                           <tr id="resultTableTr${status.count}">
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
                             <td id="unitNm${status.count}" class="unitNm${status.count}" style="padding:5px; text-align: center;" onclick="javascript:fnSalesResultDetail('${item.storeSeq}','${item.unitYn}','${item.unitSeq}','${item.onoffNM}','${item.unitNm}','${item.storeNm}','${item.totResult}');">
                              ${item.unitNm}
							 </td>
                          
                               <!-- 온/오프 -->
                               <td id="onoffNM${status.count}" class="onoffNM${status.count}" style="padding:5px; text-align: center;" onclick="javascript:fnSalesResultDetail('${item.storeSeq}','${item.unitYn}','${item.unitSeq}','${item.onoffNM}','${item.unitNm}','${item.storeNm}','${item.totResult}');">
      							${item.onoffNM}
                               </td>
                               
                               <!-- 실적 -->
                               <td id="totResult${status.count}" class="totResult${status.count}" style="padding:5px; text-align:right;" onclick="javascript:fnSalesResultDetail('${item.storeSeq}','${item.unitYn}','${item.unitSeq}','${item.onoffNM}','${item.unitNm}','${item.storeNm}','${item.totResult}');">
                              	 <fmt:formatNumber value="${item.totResult}" pattern="#,###" />
                               </td>
                               
                               <!-- 업/다운 -->
                               <td style="padding:5px; text-align: center;">
                                <c:if test="${item.offYn == 'Y'}"> 
                                <c:if test="${item.itemCnt > '0'}">                                                 	
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelDown('O', '${item.storeSeq}','${item.storeNm}','${item.unitYn}','${item.unitSeq}','${item.unitNm}','${item.onoffNM}','${status.count}'); return false;">
                                       <img src="../../../images/egovframework/zemos3/icon_download.png" style="width: 25%;">
                                   </a>
                                   <span>
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelUpload('O', '${item.storeSeq}', '${item.unitYn}', '${item.unitSeq}', '${item.offYn}', '${item.onYn}','${status.count}'); return false;">
                                   	<img src="../../../images/egovframework/zemos3/icon_upload.png" style="width: 25%; margin-left: 2px;">
                                   </a>
                                   </span>                           
                                 </c:if>
                                 </c:if>
                                 <c:if test="${item.onYn == 'Y'}">  
                                 <c:if test="${item.itemCnt > '0'}">  
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelDown('O', '${item.storeSeq}','${item.storeNm}','${item.unitYn}','${item.unitSeq}','${item.unitNm}','${item.onoffNM}','${status.count}'); return false;">
                                       <img src="../../../images/egovframework/zemos3/icon_download.png" style="width: 25%;">
                                   </a>
                                   <span>
                                   <a href="javascript:void(0);" onclick="javascript:fnExcelUpload('O', '${item.storeSeq}', '${item.unitYn}', '${item.unitSeq}', '${item.offYn}', '${item.onYn}','${status.count}'); return false;">
                                   	<img src="../../../images/egovframework/zemos3/icon_upload.png" style="width: 25%; margin-left: 2px;">
                                   </a>
                                   </span>
                                 </c:if>
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
                     <c:when test="${fn:length(sumTotalList) > 0}">
                        <c:forEach items="${sumTotalList}" var="totSum" varStatus="status">
                <tr style="background-color:#CEE3F6; font-weight:bold;">
                    <td class="first" style="padding: 5px; text-align: center; font-size: 12px;">합계</td>            
                    <td class="first01" style="padding: 5px; text-align: center; font-size: 12px;">${totSum.unitNm}</td>
                    <td style="padding: 5px; text-align: center; font-size: 12px;">${totSum.onoffNM}</td>
                    <td style="padding: 5px; text-align: right; font-size: 12px;"><fmt:formatNumber value="${totSum.totSumResult}" pattern="#,###" /></td>
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