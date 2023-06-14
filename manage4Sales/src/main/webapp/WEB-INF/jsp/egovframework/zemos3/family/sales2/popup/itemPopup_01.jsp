<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

    <div id="itemPopup" class="zemos_modal">
    	<div class="zemos_modal_content">
	    	<div class="zemos_title1">
				<span class="zemos_title1_middle">품목정보</span> 
				<span class="zemos_title1_left"><a href="#" onclick="javascript:$('.zemos_modal').hide(); return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
			</div> 
			<div>
				<div style="text-align:center; font-size:15px; margin:5; font-weight:bold;" id="itemPopupStoreNm"></div>
				<div style="height:60%; padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
					<table id="itemPopupTable" class="zemos_table1" style="margin-top: 0px;border-bottom: 1px solid #e0e1e6;line-height: 20px;color: #000000;padding: 10px 10px;">
			    		<colgroup>
					        <col width="10%" />
					        <col width="90%" />
				        </colgroup>
				        <tbody>
				        	<tr onClick="javascript:fnAllCheckBox();">
				        		<td style="text-align: left;background:#d3ffd3;">
				        			<input type="checkbox" id="allChk" name="allChk" value="${item.itemSeq}">
				        			<label for="allChk" style="zoom:1.5; margin-top:17px;"></label>
				        		</td>
				        		<td style="text-align: left; font-size: 15px;background:#d3ffd3;">전체선택</td>
				        	</tr>
				        	<c:choose>
					        	<c:when test="${fn:length(itemList) > 0}">
					        		<c:set var="i" value="0"/>
					        		<c:forEach items="${itemList}" var="item" varStatus="status">
					        	<c:if test="${item.useYn == 'Y'}">
					        		<c:set var="i" value="${i + 1}"/>
				        	<tr onClick="javascript:fnCheckBox('${i}');">
				        		<td style="text-align: left;">
				        			<input type="hidden" id="itemSeq${i}" name="itemSeq" value="${item.itemSeq}"/>
				        			<input type="hidden" id="itemNm${i}" name="itemNm" value="${item.itemNm}"/>
				        			<input type="checkbox" id="itemChk${i}" class="itemChk" name="itemChk" value="${item.itemSeq}">
				        			<label id="itemChkLabel${i}" for="itemChk${status.count}" style="zoom:1.5; margin-top:17px;"></label>
				        		</td>
				        		<td style="text-align: left; font-size: 15px;">${item.itemNm}</td>
				        	</tr>
				        		</c:if>
				        			</c:forEach>
					        	</c:when>
						        <c:otherwise>
						    <tr>
				        		<td colspan="2" style="text-align: left; font-size: 15px;">등록되어 있는 품목이 없습니다.</td>
				        	</tr>   					    
						        </c:otherwise>
					        </c:choose>
				        </tbody>
			    	</table>
				</div>
		    </div>
			
			<div class="zemos_label_search1" style="width:100%; bottom:0;">
				<span class="fl mb5" style="width:100%; height:29px; text-align:left;">
					<a href="javascript:void(0);" onclick="javascript:fnItemSave(); return false;" class="zemos_form_span_btn_blue">
						<span style="font-size:15px;">확인</span>
					</a>
				</span>
			</div>
		</div>
	</div>