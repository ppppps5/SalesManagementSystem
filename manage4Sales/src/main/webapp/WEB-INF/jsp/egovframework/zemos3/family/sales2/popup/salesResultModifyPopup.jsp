<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

    <div id="salesResultModifyPopup" class="zemos_modal">
    	<div class="zemos_modal_content">
	    	<div class="zemos_title1">
				<span class="zemos_title1_middle">수정관리</span>
				<span class="zemos_title1_left"><a href="#" onclick="javascript:$('.zemos_modal').hide(); return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
			</div>
			<div>
		    	<table class="zemos_table1" style="margin-top: 0px;border-bottom: 1px solid #e0e1e6;line-height: 20px;color: #000000;padding: 10px 10px;">
		    		<colgroup>
				        <col width="25%" />
				        <col width="55%" />
				        <col width="20%" />
			        </colgroup> 
			        <tbody>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">매장명</td>
			        		<td style="text-align: left;" colspan="2">
			        			<input id="storeNm" name="storeNm" type="text" class="zemos_input1" style="float: left; width:100%;" readonly="readonly">
			        			<input type="hidden" id="storeSeq" name="storeSeq"/>
			        			<input type="hidden" id="resultSeq" name="resultSeq"/>
			        			<input type="hidden" id="resultDetailSeq" name="resultDetailSeq"/>
			        			<input type="hidden" id="resultDt" name="resultDt"/>
			        			<input type="hidden" id="requestYn" name="requestYn"/>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">품목</td>
			        		<td style="text-align: left;" colspan="2">
			        			<select id="itemSeq" name="itemSeq" class="zemos_select1" style="width:100%;" onchange="javascript:fnPopupSearch(this);">
			        				<c:forEach items="${selectSalesPresentDetail}" var="item" varStatus="status">
									<option value="${item.itemSeq}" <c:if test="${item.itemSeq eq params.itemSeq[0]}">selected</c:if>>${item.itemNm}</option>
									</c:forEach>
								</select>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;" rowspan="2">실적</td>
			        		<td style="text-align: left;">
			        			<span style="width:100%;">
			        				<input id="resultAmt" name="resultAmt" type="text" class="zemos_input1" style="float: left; width:100%;" readonly="readonly">
			        			</span>
			        		</td>
			        		<td>
			        			<span style="width:100%;">
			        				원
			        			</span>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left;">
			        			<span style="width:100%; margin-top: 10px;">
			        				<input id="resultQty" name="resultQty" type="text" class="zemos_input1" style="float: left; width:100%;" readonly="readonly">
			        			</span>
			        		</td>
			        		<td>
			        			<span style="width:100%;">
			        				수량
			        			</span>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;" rowspan="2">수정</td>
			        		<td style="text-align: left;">
			        			<span style="width:100%;">
			        				<input id="changeAmt" name="changeAmt" type="text" class="zemos_input1" style="float: left; width:100%;">
			        			</span>
			        		</td>
			        		<td>
			        			<span style="width:100%;">
			        				원
			        			</span>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left;">
			        			<span>
			        				<input id="changeQty" name="changeQty" type="text" class="zemos_input1" style="float: left; width:100%;">
			        			</span>
			        		</td>
			        		<td>
			        			<span style="width:100%;">
			        				수량
			        			</span>
			        		</td>
			        	</tr>
			        </tbody>
		    	</table>
		    </div>
			
			<div class="zemos_label_search1">
				<span class="fl mb5" style="width:100%; height: 29px; text-align: left;">
					<a href="javascript:void(0);" onclick="javascript:fnResultModifySave(); return false;" class="zemos_form_span_btn_blue">
						<span style="font-size:15px;">저 장</span>
					</a>
				</span>
			</div>
		</div>
	</div>