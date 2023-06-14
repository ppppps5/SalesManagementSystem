<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
  
    <div id="itemPopup" class="zemos_modal">
    	<div class="zemos_modal_content">
	    	<div class="zemos_title1">
				<span class="zemos_title1_middle">품목정보</span>
				<span class="zemos_title1_left"><a href="#" onclick="javascript:$('.zemos_modal').hide(); return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
			</div>
			<div>
				<div style="text-align:center; font-size:15px; margin:5; font-weight:bold;" id="itemPopupStoreNm"></div>
				<table id="itemPopupTable" class="zemos_table1" style="margin-top: 0px;border-bottom: 1px solid #e0e1e6;line-height: 20px;color: #000000;padding: 10px 10px;">
		    		<colgroup>
				        <col width="10%" /> 
				        <col width="90%" />
			        </colgroup>
			        <tbody>
			        	<%-- <tr>
			        		<td colspan="2" style="text-align: left; font-size: 16px;" id="itemPopupStoreNm">${storeDetail.storeNm}</td>
			        	</tr> --%>
			        	<c:choose>
				        	<c:when test="${fn:length(itemList) > 0}">
				        		<c:forEach items="${itemList}" var="item" varStatus="status">
			        	<tr onClick="javascript:fnCheckBox('${status.count}');">
			        		<td style="text-align: left;">
			        			<input type="hidden" id="itemSeq${status.count}" name="itemSeq" value="${item.itemSeq}"/>
			        			<input type="hidden" id="itemNm${status.count}" name="itemNm" value="${item.itemNm}"/>
			        			<%-- <input type="checkbox" id="itemChk${status.count}" name="itemChk" value="${item.itemSeq}" class="checkbox-style" style="display: block; zoom:1.5; z-index:1;" onClick="javascript:fnCheckBoxTest('${status.count}');"> --%>
			        			<input type="checkbox" id="itemChk${status.count}" name="itemChk" value="${item.itemSeq}">
			        			<label id="itemChkLabel${status.count}" for="itemChk${status.count}" style="zoom:1.5; margin-top:17px;"></label>
			        		</td>
			        		<td style="text-align: left; font-size: 15px;">${item.itemNm}</td>
			        	</tr>
			        			</c:forEach>
				        	</c:when>
					        <c:otherwise>
					    <tr>
					    	<td>
					    		등록되어있는 품목이 없습니다.
					    	</td>
					    </tr>
					        </c:otherwise>
				        </c:choose>
			        </tbody>
		    	</table>
		    </div>
			
			<div class="zemos_label_search1">
				<span class="fl mb5" style="width:100%; height:29px; text-align:left;">
					<a href="javascript:void(0);" onclick="javascript:fnItemSave(); return false;" class="zemos_form_span_btn_blue">
						<span style="font-size:15px;">확인</span>
					</a>
				</span>
			</div>
		</div>
	</div>