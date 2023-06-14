<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>
<style type="text/css">
	.result td {
    border-bottom: 1px solid #e0e1e6;
    font-size: 10px;
    line-height: 20px;
    color: #000000;
    text-align: center;
    padding: 10px 15px;
	}
	</style>
    <div id="salesResultRecordPopup" class="zemos_modal">
    	<div class="zemos_modal_content" style="width: 95% !important;">
	    	<div class="zemos_title1">
				<span class="zemos_title1_middle">수정관리</span>
				<span class="zemos_title1_left"><a href="#" onclick="javascript:$('.zemos_modal').hide(); return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
			</div>
			<div>
	    	<table class="zemos_table1 table-container result" style="margin-top:0px; width: 100%">
		    	<colgroup>
			    	<col width="25%" />
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
		    	</colgroup>
	    		<thead>
		        	<tr style="height:20px; background-color:#eff0f4;">
		        		<th style="padding:5px;">${storeUseName[0].storeUseNm}</th>
		        		<th style="padding:5px;">요청일자</th>
		        		<th style="padding:5px;">실적일자</th>
		        		<th style="padding:5px;">상태</th>
		        	</tr>
		        </thead>
		       	<tbody>
		       		<tr style="height:20px; padding:4px 4px;">
				     	<td style="text-align:center; padding:4px 4px;" id = "headStoreNm">
				     	 ${resultDetailList[0].storeNm}
				     	</td>
				     	<td style="text-align:center; padding:4px 4px;" id = "regDttmTd">
				     	</td>
				     	<td style="text-align:center; padding:4px 4px;" id = "modifyDtTd">
				     	</td>
				     	<td style="text-align:center; padding:4px 4px;" id = "requestYnTd">
				     	</td>
			    	</tr>
			    	<tr>
			    		<td id = "modUserTd" colspan="4" style="font-size: 13px;">
			    		</td>
			    	</tr>
		       	</tbody>
	    	</table>
	    </div>
	    
	    
	 
		
	    <!-- 품목 -->
	    <div style="padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
	    	<table id="resultTable" class="zemos_table1 table-container result" style="margin-top:0px;">
	    		<colgroup>
			        <col width="10%" />
			        <col width="20%" />
			        <col width="20%" />
			        <col width="10%" />
			        <col width="20%" />
			        <col width="20%" />
			        <!-- <col width="20%" /> -->
		        </colgroup>
		        <thead>
		        	<tr style="height:50px; background-color:#eff0f4;">
		        		<th style="padding:5px;">${itemNm[0].itemUseNm}</th>
		        		<th style="padding:5px;">온/오프</th>
		        		<th style="padding:5px;">기준</th>
		        		<th style="padding:5px;">구분</th>
		        		<th style="padding:5px;">기존</th>
		        		<th style="padding:5px;">변경</th>
		        		<!-- <th style="padding:5px;">승인/반려</th> -->
		        	</tr>
		        </thead>
		        <tbody id = "resultDetailListBody">
		        
		        </tbody>
	    	</table>
	    </div>

		<div style="width:100%;margin-top:10px;" id = "deleteButton">
			
		</div> 
		</div>
	</div>