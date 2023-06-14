<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp"%>

    <div id="shopAddPopup" class="zemos_modal">
    	<div class="zemos_modal_content">
	    	<div class="zemos_title1">
				<span class="zemos_title1_middle" id="storePopName"></span>
				<span class="zemos_title1_left"><a href="#" onclick="javascript:$('.zemos_modal').hide(); return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
			</div>
			<div>
		    	<table class="zemos_table1" style="margin-top: 0px;border-bottom: 1px solid #e0e1e6;line-height: 20px;color: #000000;padding: 10px 10px;">
		    		<colgroup>
				        <col width="28%" />
				        <col width="72%" />
			        </colgroup>
			        <tbody>
			        	<tr> 
			        		<td style="text-align: left; font-size: 12px;">매장명</td>
			        		<td style="text-align: left;">
			        			<input id="storeName" name="storeName" type="text" class="zemos_input1" style="float: left; width:100%;" placeholder="매장명 입력" maxlength="100">
			        			<input id="storeNameU" name="storeNameU" type="text" class="zemos_input1" style="float: left; width:100%;" placeholder="매장명 입력" maxlength="100">
			        			<input id="storeSeq" name="storeSeq" type="hidden">
			        			<input id="saveGbn" name="saveGbn" type="hidden">
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">분류1</td>
			        		<td style="text-align: left;">
			        			<select id="class1" name="class1" class="zemos_select1" style="width:100%;">
			        				<option value="">선택</option>
			        				<c:forEach items="${storeClass1List}" var="item" varStatus="status">
									<option value="${item.class1Seq}">${item.class1Nm}</option>
									</c:forEach>
								</select>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">분류2</td>
			        		<td style="text-align: left;">
			        			<select id="class2" name="class2" class="zemos_select1" style="width:100%;">
			        				<option value="">선택</option>
									<c:forEach items="${storeClass2List}" var="item" varStatus="status">
									<option value="${item.class2Seq}">${item.class2Nm}</option>
									</c:forEach>
								</select>
			        		</td> 
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">분류3</td>
			        		<td style="text-align: left;">
			        			<select id="class3" name="class3" class="zemos_select1" style="width:100%;">
			        				<option value="">선택</option>
									<c:forEach items="${storeClass3List}" var="item" varStatus="status">
									<option value="${item.class3Seq}">${item.class3Nm}</option>
									</c:forEach>
								</select>
			        		</td> 
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">판매관리자1</td>
			        		<td style="text-align: left;">
			        			<select id="sabun" name="sabun" class="zemos_select1" style="width:100%;" onchange="javascript:fbSabunChange(this);">
			        				<option value="">선택</option>
									<c:forEach items="${storeuserList}" var="item" varStatus="status">
									<option value="${item.usersabun}">${item.username}</option>
									</c:forEach>
								</select>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">판매관리자2</td>
			        		<td style="text-align: left;">
			        			<select id="sabun2" name="sabun2" class="zemos_select1" style="width:100%;" onchange="javascript:fbSabun2Change(this);">
			        				<option value="">선택</option>
									<c:forEach items="${storeuserList}" var="item" varStatus="status">
									<option value="${item.usersabun}">${item.username}</option>
									</c:forEach>
								</select>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">분류사용여부</td>
			        		<td style="text-align: left;">
		        				<input type="checkbox" id="classyn" name="classyn">
		        				<label id="classynChkLabel" for="classyn" style="zoom:1.5; margin-top:17px;"></label>
			        		</td>
			        	</tr>
			        	<tr> 
			        		<td style="text-align: left; font-size: 12px;">사용여부</td>
			        		<td style="text-align: left;">
		        				<input type="checkbox" id="useYn" name="useYn">
		        				<label id="useYnChkLabel" for="useYn" style="zoom:1.5; margin-top:17px;"></label>
			        		</td>
			        	</tr>
			        </tbody>
		    	</table>
		    </div>
			
			<div class="zemos_label_search1">
				<span class="fl mb5" style="width:100%; height: 29px; text-align: left;">
					<a href="javascript:void(0);" onclick="javascript:fnStoreSave(); return false;" class="zemos_form_span_btn_blue">
						<span style="font-size:15px;">저 장</span>
					</a>
				</span>
			</div>
		</div>
	</div>