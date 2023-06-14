<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

    <div id="itemPopup" class="zemos_modal">
    	<div class="zemos_modal_content" style="width: 90%;">
	    	<div class="zemos_title1">
				<span class="zemos_title1_middle"><c:out value = "${itemList[1].itemUseNm}"/> 선택</span> 
				<span class="zemos_title1_left"><a href="#" onclick="javascript:$('.zemos_modal').hide(); return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
			</div> 
			<div>
				<div style="text-align:center; font-size:15px; margin:5; font-weight:bold;" id="itemPopupStoreNm"></div>
				<div style="height:60%; padding-top: 0px; overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">
					<table id="itemPopupTable" class="zemos_table1" style="margin-top: 0px;border-bottom: 1px solid #e0e1e6;line-height: 20px;color: #000000;">
			    		<caption style="height: 10%; width: 100%; padding-top: 1%; background: #D7D7D7; padding-left: 15px; text-align: start;">
				    		<input type="checkbox" id="offChk" name="offChk" value="">
							<label for="offChk">오프라인&nbsp;&nbsp;&nbsp;&nbsp;</label>
							<input type="checkbox" id="onChk" name="onChk" value="">
							<label for="onChk">온라인</label>
						</caption>
			    		<colgroup>
					        <col width="10%" />
					        <col width="30%" />
					        <col width="30%" />
					        <col width="30%" />
				        </colgroup>
				        <thead>
					        <tr style="width : 100%;">
					        	<th style="padding-left : 15px; background : #F2F2F2;" onclick="javascript:fnAllCheckBox();">
					        		<input type="checkbox" id="allChk" name="allChk" value="">
					        		<label for="allChk" style="margin-top:17px;"></label>
					        	</th>
					        	<th style="padding : 0; background : #F2F2F2;">
					        		<c:out value = "${itemList[0].itemUseNm}"/>명
					        	</th>
					        	<th style="padding : 0; background : #F2F2F2;">
					        		코드
					        	</th>
					        	<th style="padding : 0; background : #F2F2F2;">
					        		온/오프
					        	</th>
					        </tr>
				        </thead>
				        <tbody>
				        	<c:choose>
					        	<c:when test="${fn:length(itemList) > 0}">
					        		<c:set var="i" value="0"/>
					        		<c:forEach items="${itemList}" var="item" varStatus="status">
					        			<c:if test="${item.useYn == 'Y'}">
					        			
					        			<c:set var="i" value="${i + 1}"/>
						       	 			<c:if test="${item.onoffYn == '0'}">
				        					<tr onClick="javascript:fnCheckBox('${i}');" class="itemListTr" id = "${item.itemSeq}Off">
				        						<td style="text-align: left;">
								        			<input type="hidden" id="itemSeq${i}" name="itemSeq" value="${item.itemSeq}"/>
								        			<input type="hidden" id="itemNm${i}" name="itemNm" value="${item.itemNm}"/>
								        			<input type="hidden" id="unitSeq1" name="unitSeq1" value="${item.unitSeq1}"/>
								        			<input type="hidden" id="unit1Yn" name="unit1Yn" value="${item.unit1Yn}"/>
								        			<input type="hidden" id="unit1Cost${i}" name="unit1Cost" value="${item.unit1Cost}"/>
								        			<input type="hidden" id="unitNm1" name="unitNm1" value="${item.unitNm1}"/>
								        			<input type="hidden" id="unitSeq2" name="unitSeq2" value="${item.unitSeq2}"/>
								        			<input type="hidden" id="unit2Yn" name="unit2Yn" value="${item.unit2Yn}"/>
								        			<input type="hidden" id="unit2Cost${i}" name="unit2Cost" value="${item.unit2Cost}"/>
								        			<input type="hidden" id="unitNm2" name="unitNm2" value="${item.unitNm2}"/>
								        			<input type="hidden" id="unitSeq3" name="unitSeq3" value="${item.unitSeq3}"/>
								        			<input type="hidden" id="unit3Yn" name="unit3Yn" value="${item.unit3Yn}"/>
								        			<input type="hidden" id="unit3Cost${i}" name="unit3Cost" value="${item.unit3Cost}"/>
								        			<input type="hidden" id="unitNm3" name="unitNm3" value="${item.unitNm3}"/>
								        			<input type="hidden" id="unitSeq4" name="unitSeq4" value="${item.unitSeq4}"/>
								        			<input type="hidden" id="unit4Yn" name="unit4Yn" value="${item.unit4Yn}"/>
								        			<input type="hidden" id="unit4Cost${i}" name="unit4Cost" value="${item.unit4Cost}"/>
								        			<input type="hidden" id="unitNm4" name="unitNm4" value="${item.unitNm4}"/>
								        			<input type="hidden" id="unitSeq5" name="unitSeq5" value="${item.unitSeq5}"/>
								        			<input type="hidden" id="unit5Yn" name="unit5Yn" value="${item.unit5Yn}"/>
								        			<input type="hidden" id="unit5Cost${i}" name="unit5Cost" value="${item.unit5Cost}"/>
								        			<input type="hidden" id="unitNm5" name="unitNm5" value="${item.unitNm5}"/>
								        			<input type="hidden" id="offLine${i}" name="offLine" value="오프라인"/>
								        			<input type="hidden" id="chkIdx${i}" name="chkIdx" value="${i}"/>
								        			<input type="checkbox" id="itemChk${i}" class="itemChk" name="itemChk" value="${item.itemSeq}">
								        			<label id="itemChkLabel${i}" for="itemChk${i}" style=" padding-left: 0; padding-top: 22px;"></label>
								        		</td>
								        		<td style="text-align: center; font-size: 12px; padding: 0;">${item.itemNm}</td>
								        		<td style="text-align: center; font-size: 12px; padding: 0;">${item.itemCode}</td>
								        		<td style="text-align: center; font-size: 12px; padding: 0;">오프라인</td>
								        	</tr>
							        		</c:if>
						       	 			<c:if test="${item.onoffYn == '1'}">
						       	 			<tr onClick="javascript:fnCheckBox('${i}');" class="itemListTr"  id = "${item.itemSeq}On">
				        						<td style="text-align: left;">
								        			<input type="hidden" id="itemSeq${i}" name="itemSeq" value="${item.itemSeq}"/>
								        			<input type="hidden" id="itemNm${i}" name="itemNm" value="${item.itemNm}"/>
								        			<input type="hidden" id="unitSeq1" name="unitSeq1" value="${item.unitSeq1}"/>
								        			<input type="hidden" id="unit1Yn" name="unit1Yn" value="${item.unit1Yn}"/>
								        			<input type="hidden" id="unit1Cost${i}" name="unit1Cost" value="${item.unit1Cost}"/>
								        			<input type="hidden" id="unitNm1" name="unitNm1" value="${item.unitNm1}"/>
								        			<input type="hidden" id="unitSeq2" name="unitSeq2" value="${item.unitSeq2}"/>
								        			<input type="hidden" id="unit2Yn" name="unit2Yn" value="${item.unit2Yn}"/>
								        			<input type="hidden" id="unit2Cost${i}" name="unit2Cost" value="${item.unit2Cost}"/>
								        			<input type="hidden" id="unitNm2" name="unitNm2" value="${item.unitNm2}"/>
								        			<input type="hidden" id="unitSeq3" name="unitSeq3" value="${item.unitSeq3}"/>
								        			<input type="hidden" id="unit3Yn" name="unit3Yn" value="${item.unit3Yn}"/>
								        			<input type="hidden" id="unit3Cost${i}" name="unit3Cost" value="${item.unit3Cost}"/>
								        			<input type="hidden" id="unitNm3" name="unitNm3" value="${item.unitNm3}"/>
								        			<input type="hidden" id="unitSeq4" name="unitSeq4" value="${item.unitSeq4}"/>
								        			<input type="hidden" id="unit4Yn" name="unit4Yn" value="${item.unit4Yn}"/>
								        			<input type="hidden" id="unit4Cost${i}" name="unit4Cost" value="${item.unit4Cost}"/>
								        			<input type="hidden" id="unitNm4" name="unitNm4" value="${item.unitNm4}"/>
								        			<input type="hidden" id="unitSeq5" name="unitSeq5" value="${item.unitSeq5}"/>
								        			<input type="hidden" id="unit5Yn" name="unit5Yn" value="${item.unit5Yn}"/>
								        			<input type="hidden" id="unit5Cost${i}" name="unit5Cost" value="${item.unit5Cost}"/>
								        			<input type="hidden" id="unitNm5" name="unitNm5" value="${item.unitNm5}"/>
								        			<input type="hidden" id="chkIdx${i}" name="chkIdx" value="${i}"/>
								        			<input type="hidden" id="onLine${i}" name="onLine" value="온라인"/>
								        			<input type="checkbox" id="itemChk${i}" class="itemChk" name="itemChk" value="${item.itemSeq}">
								        			<label id="itemChkLabel${i}" for="itemChk${i}" style=" padding-left: 0; padding-top: 22px;"></label>
								        		</td>
								        		<td style="text-align: center; font-size: 12px; padding: 0;">${item.itemNm}</td>
								        		<td style="text-align: center; font-size: 12px; padding: 0;">${item.itemCode}</td>
								        		<td style="text-align: center; font-size: 12px; padding: 0;">온라인</td>
								        	</tr>
							        		</c:if>
						        		</c:if>
				        			</c:forEach>
					        	</c:when>
						        <c:otherwise>
						    <tr>
				        		<td colspan="5" style="text-align: left; font-size: 15px;">등록되어 있는 품목이 없습니다.</td>
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