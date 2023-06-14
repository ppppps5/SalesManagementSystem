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
		//관리자 확인용 
		var i = 1;
		var sm = [];
		
		$(document).ready(function () {
			
			$("#storeName").on("focusout", function() {
				var storeName = $("#storeName").val();
				<c:forEach items="${storeList}" var="item" varStatus="status">
				 	if(storeName == "${item.storeNm}"){
				 		alert("이미 사용중인 "+"${storeUseName[0].storeUseNm}"+"명 입니다. \n다른 "+"${storeUseName[0].storeUseNm}"+"명을 사용해 주세요.");
				 		$("#storeName").val("");
				 		$("#storeName").focus();
				 		return;
				 	}
				</c:forEach>
			});
			
			$("#itemCheckAll").click(function() {
				if($("#itemCheckAll").is(":checked")) $(".chk").prop("checked", true);
				else $(".chk").prop("checked", false);
			});
			
			$(".chk").click(function() {
				var total = $(".chk").length;
				var checked = $(".chk:checked").length;
				
				if(total != checked) $("#itemCheckAll").prop("checked", false);
				else $("#itemCheckAll").prop("checked", true); 
			});
			
			$('#classYn').click(function(){
				var checked = $('#classYn').is(':checked');
				
				if(checked){
					$('.classAll').show();
					$("#class1").attr("disabled", false);
					$("#class2").attr("disabled", false);
					$("#class3").attr("disabled", false);
					$("#class4").attr("disabled", false);
					$("#class5").attr("disabled", false);
				}else{
					$('.classAll').hide();
					$("#class1").attr("disabled", true);
					$("#class2").attr("disabled", true);
					$("#class3").attr("disabled", true);
					$("#class4").attr("disabled", true);
					$("#class5").attr("disabled", true);
				}
			});
			
			const tabList = document.querySelectorAll('.tab_menu .list li');
			  const contents = document.querySelectorAll('.tab_menu .cont_area .cont')
			  var activeCont = ''; // 현재 활성화 된 컨텐츠 (기본:#tab1 활성화)

			  for(var i = 0; i < tabList.length; i++){
			    tabList[i].querySelector('.btn').addEventListener('click', function(e){
			      e.preventDefault();
			      for(var j = 0; j < tabList.length; j++){
			        // 나머지 버튼 클래스 제거
			        tabList[j].classList.remove('is_on');

			        // 나머지 컨텐츠 display:none 처리
			        contents[j].style.display = 'none';
			      }

			      // 버튼 관련 이벤트
			      this.parentNode.classList.add('is_on');

			      // 버튼 클릭시 컨텐츠 전환
			      activeCont = this.getAttribute('href');
			      document.querySelector(activeCont).style.display = 'block';
			    });
			  }
			

			$("#storeUseYnChkLabel").click(function() {
				var isChecked = $("#storeUseYn").is(":checked");

				if (isChecked) {
					$("#storeUseYn").prop("checked", false);
				} else {
					$("#storeUseYn").prop("checked", true);
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
		
		
		//매장등록
		function fnStoreSave() {
			var params = {};
			
			var storeNm = $("#storeName").val();
			var offYn;
			var onYn;
			var taxYn = $("#taxYn").val();
			var classYn;
			var useYn;
			<c:if test="${class1Nm[0].useYn == 'Y'}">
				var class1 = $("#class1").val();
				params.class1 = class1;
			</c:if>
			<c:if test="${class2Nm[0].useYn == 'Y'}">
				var class2 = $("#class2").val();
				params.class2 = class2;
			</c:if>
			<c:if test="${class3Nm[0].useYn == 'Y'}">
				var class3 = $("#class3").val();
				params.class3 = class3;
			</c:if>
			<c:if test="${class4Nm[0].useYn == 'Y'}">
				var class4 = $("#class4").val();
				params.class4 = class4;
			</c:if>
			<c:if test="${class5Nm[0].useYn == 'Y'}">
				var class5 = $("#class5").val();
				params.class5 = class5;
			</c:if>		
			if($("#offYn").is(":checked")){
				offYn = "Y";
			}else{
				offYn = "N";				
			}
			if($("#onYn").is(":checked")){
				onYn = "Y";
			}else{
				onYn = "N";				
			}
			
			if($("#storeUseYn").is(":checked")){
				useYn = "Y";
			}else{
				useYn = "N";				
			}
			<c:forEach items="${unit}" var="item" varStatus="status">
				var id = $("#<c:out value="${item.unitNm}" />").val();
				<c:if test="${item.useYn=='Y'}">
	    		if($("#<c:out value="${item.unitNm}" />").is(":checked")){
	    			var unit<c:out value="${status.count}" /> = $("#<c:out value="${item.unitNm}" />").val();
	    			params.unitSeq<c:out value="${status.count}" /> = unit<c:out value="${status.count}" />;
	    			params.unit<c:out value="${status.count}" />Yn = "Y";
	    		}else{
	    			var unit<c:out value="${status.count}" /> = $("#<c:out value="${item.unitNm}" />").val();
	    			params.unitSeq<c:out value="${status.count}" /> = unit<c:out value="${status.count}" />;
	    			params.unit<c:out value="${status.count}" />Yn = "N";	    			
	    		}
	    		</c:if>
			</c:forEach>
			
			if($("#classYn").is(":checked")){
				classYn = "Y";
			}else{
				classYn = "N";
			}
			if(sm.length != 0){
				sm.forEach(function(i, index){
					<c:forEach items="${userList}" var="item" varStatus="status">
					var sabun = "<c:out value="${item.USER_SABUN}"/>";
					if(i == sabun){
						var uploadYn;
						var approvalYn;
						if($("#"+i+"uploadYn").is(":checked")){
							uploadYn = "Y";
						}else{
							uploadYn = "N";
						}
						if($("#"+i+"approvalYn").is(":checked")){
							approvalYn = "Y";
						}else{
							approvalYn = "N";
						}
						params.sm<c:out value="${status.count}"/> = i+","+uploadYn+","+approvalYn;
					}
					</c:forEach>
				});
			} 
			<c:forEach items="${item}" var="item" varStatus="status">
				if($("#useYn<c:out value="${status.count}"/>").is(":checked")){
					params.itemSeq<c:out value="${status.count}"/> = $("#useYn<c:out value="${status.count}"/>").val()+",${item.itemCode}"+",Y";
				}else{
					params.itemSeq<c:out value="${status.count}"/> = $("#useYn<c:out value="${status.count}"/>").val()+",${item.itemCode}"+",N";
				}
			</c:forEach>
			console.log(params);
			if ( storeNm == '' || storeNm == null ) {
				alert("<c:out value = '${storeUseName[0].storeUseNm}'/>명을 입력해 주세요.");
				const tab = document.querySelectorAll('.tab_menu .list li');
				const cont = document.querySelectorAll('.tab_menu .cont_area .cont');
				var active = "#tab1";
				      for(var j = 0; j < tab.length; j++){
				        // 나머지 버튼 클래스 제거
				        tab[j].classList.remove('is_on');
	
				        // 나머지 컨텐츠 display:none 처리
				        cont[j].style.display = 'none';
				      }
				      document.querySelector(active).parentNode.classList.add('is_on');
				      document.querySelector(active).style.display = 'block';
					$("#basic").addClass("is_on");
				
					$("#storeName").focus();
				return;
			}
			
			if ( Number(byteCheck($("#storeName"))) > 100 ) {
				alert("<c:out value = '${storeUseName[0].storeUseNm}'/>명의 글자수를 초과하였습니다.\n<c:out value = '${storeUseName[0].storeUseNm}'/>명은 한글 50글자, 영문 100글자까지 입니다.");
				const tab = document.querySelectorAll('.tab_menu .list li');
				const cont = document.querySelectorAll('.tab_menu .cont_area .cont');
				var active = "#tab1";
				      for(var j = 0; j < tab.length; j++){
				        // 나머지 버튼 클래스 제거
				        tab[j].classList.remove('is_on');
	
				        // 나머지 컨텐츠 display:none 처리
				        cont[j].style.display = 'none';
				      }
				      document.querySelector(active).parentNode.classList.add('is_on');
				      document.querySelector(active).style.display = 'block';
					$("#basic").addClass("is_on");
				$("#storeName").focus();
				return;
			}
			if(!$("#onYn").is(":checked") && !$("#offYn").is(":checked")){
				alert("온/오프 구분을 하나 이상 체크해 주세요.");
				const tab = document.querySelectorAll('.tab_menu .list li');
				const cont = document.querySelectorAll('.tab_menu .cont_area .cont');
				var active = "#tab1";
				      for(var j = 0; j < tab.length; j++){
				        // 나머지 버튼 클래스 제거
				        tab[j].classList.remove('is_on');
	
				        // 나머지 컨텐츠 display:none 처리
				        cont[j].style.display = 'none';
				      }
				      document.querySelector(active).parentNode.classList.add('is_on');
				      document.querySelector(active).style.display = 'block';
					$("#basic").addClass("is_on");
				return;
			}
			var unitChk = [];
			var unitUseChk = false;
			<c:forEach items="${unit}" var="item" varStatus="status">
    		if("<c:out value ='${item.useYn}'/>"=='Y'){
    			unitChk.push($("#<c:out value ='${item.unitNm}'/>").is(":checked"));
    		}
			</c:forEach>
			console.log(unitChk);
			var idx;
			for(idx = 0; idx < unitChk.length; idx++){
				if(unitChk[idx]){
					unitUseChk = true;
					break;
				}
			}
			if(!unitUseChk){
				alert("사용하실 단위를 하나이상 추가해 주세요.");
				const tab = document.querySelectorAll('.tab_menu .list li');
				const cont = document.querySelectorAll('.tab_menu .cont_area .cont');
				var active = "#tab1";
				      for(var j = 0; j < tab.length; j++){
				        // 나머지 버튼 클래스 제거
				        tab[j].classList.remove('is_on');
	
				        // 나머지 컨텐츠 display:none 처리
				        cont[j].style.display = 'none';
				      }
				      document.querySelector(active).parentNode.classList.add('is_on');
				      document.querySelector(active).style.display = 'block';
					$("#basic").addClass("is_on");
				return;
			}
				
			if (sm.length == 0) {
				alert("판매관리자를 추가해 주세요.");
				const tab = document.querySelectorAll('.tab_menu .list li');
				const cont = document.querySelectorAll('.tab_menu .cont_area .cont');
				var active = "#tab3";
				      for(var j = 0; j < tab.length; j++){
				        // 나머지 버튼 클래스 제거
				        tab[j].classList.remove('is_on');
	
				        // 나머지 컨텐츠 display:none 처리
				        cont[j].style.display = 'none';
				      }
				      document.querySelector(active).parentNode.classList.add('is_on');
				      document.querySelector(active).style.display = 'block';
					$("#liSm").addClass("is_on");	
				return;
			}
			
			
			
			params.storeNm = storeNm;
			params.offYn = offYn;
			params.onYn = onYn;
			params.taxYn = taxYn;
			params.classYn = classYn;
			params.useYn = useYn;
			params.zemosIdx = zemosIdx;
			params.wrkplcIdx = wrkplcIdx;
			fn_loading_show();
			
			$.ajax({
				url 		: gvContextPath + "/zemos3/family/sales2/sales2StoreNewSave.do",
				type		: 'POST',
			    dataType 	: 'json',
			    data		: params
			}).always(function(response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
			}).done(function (response) { // 완료
				if ( response.result === true ) {
					alert("매장이 저장되었습니다.");
					fn_reload();
					fn_back2();
				}
			}).fail(function (response) { // 실패
			}).always(function(response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
			});
		}
		
		//판매관리자 추가
		function fnUserAddShow(){
			$("#userListDiv").show();
		}
		
		function fnAddSM(){
			var sabun = $("#userList option:checked").val();
			var userName = $("#userList option:checked").text();
			var html = $("#sm").html();
			var arList = $('#sm').find('input');
			if(arList.length != 0){
				for(i in arList){
					if(arList[i].value==sabun){
						alert("이미 추가한 관리자 입니다.");
						$("#userListDiv").hide();
						$("#userList").val("");
						return;
					}
				}
			}
			html += "<tr id = '"+sabun+"'><td>"+userName+"</td>"
			html += "<td style = 'padding:0;'><input type='checkbox' id = '"+sabun+"uploadYn'><label id='uploadYnChkLabel' for='"+sabun+"uploadYn'>&nbsp;</label></td>"
			html += "<td style = 'padding:0;'><input type='checkbox' id = '"+sabun+"approvalYn'><label id='approvalYnChkLabel' for='"+sabun+"approvalYn'>&nbsp;</label></td>"
			html += "<td style = 'padding:0;'><a href = '#' onclick = 'javascript:fnDelete("+sabun+")'><img src = '${pageContext.request.contextPath}/images/egovframework/zemos3/delete.png'></a>"
			html += "<input type = 'hidden' value ='"+sabun+"'></td></tr>"
			$("#sm").html(html);
			$("#userListDiv").hide();
			$("#userList").val("");
			sm.push(sabun);
			i++;
		}
		
		function fnDelete(sabun){
			sabun.remove()
			i--;
			var idx = i-1;
			sm.splice(idx,1);
		}
		
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
		
		//매장상세설정 이동
		function fnShopInfoDetail(idx, storeSeq) {
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreNewDetail.do";
			url += "?zemosIdx=" + idx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			url += "&storeSeq="+storeSeq;
			
			fn_location_href(url);
		}
		
		//매장추가 이동
		function fnShopAdd() {
			var url = "${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreNewAdd.do";
			url += "?zemosIdx=" + zemosIdx;
			url += "&wrkplcIdx=" + wrkplcIdx;
			url += "&zemosNm=" + encodeURIComponent(zemosNm);
			
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
		
		//제모스 매장관리 메뉴이동
		function fn_back2() {
			fn_location_href("${pageContext.request.contextPath}/zemos3/family/sales2/sales2StoreNew.do?zemosIdx="+zemosIdx+"&zemosNm="+encodeURIComponent(zemosNm)+"&wrkplcIdx=" + wrkplcIdx);
		}
	</script>
</head>
<style>
  .tab_menu{position:relative;}
  .tab_menu .list{overflow:hidden;}
  .tab_menu .list li{float:left; width: 33.33%; text-align: center; background: #D7D7D7; padding: 10px;}
  .tab_menu .list li.is_on .btn{}
  .tab_menu .list li.is_on{background: #F2F2F2;}
  .tab_menu .list .btn{font-size:13px; display: block;font-weight:bold;}
  .tab_menu .cont_area .cont{position:absolute;background:#F2F2F2; width:100%;}
</style>
<body>
	<!--상단시작-->
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/main/mainTop2.jsp"%>
    <!--상단끝-->
    <!--타이틀시작-->
    <div class="zemos_title1">
		<span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;"> ${storeUseName[0].storeUseNm}등록</span>
		<span class="zemos_title1_left"><a href="#" onclick="javascript:fn_back2();return false;"><img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전"/></a></span>
	</div>
    <!--타이틀끝-->
    <div class="tab_menu">
	  <ul class="list">
	    <li class="is_on" id="basic">
	      <a href="#tab1" class="btn">기본정보</a>
	    </li>
	    <li>
	      <a href="#tab2" class="btn">${itemNm[0].itemUseNm}정보</a>
	    </li>
	    <li id="liSm">
	      <a href="#tab3" class="btn">판매관리자</a>
	    </li>
	  </ul>
	  
	  <div class="cont_area">
	    <div id="tab1" class="cont" style="display: block;">
	      <div>
		    	<table class="zemos_table1" style="margin-top: 0px;border-bottom: 1px solid #e0e1e6;line-height: 20px;color: #000000;padding: 10px 10px; border-top: 0;">
		    		<colgroup>
				        <col width="28%" />
				        <col width="72%" />
			        </colgroup>
			        <tbody>
			        	<tr> 
			        		<td style="text-align: left; font-size: 12px;">${storeUseName[0].storeUseNm}명</td>
			        		<td style="text-align: left;">
			        			<input id="storeName" name="storeName" type="text" class="zemos_input1" style="float: left; width:100%;" placeholder='<c:out value="${storeUseName[0].storeUseNm}"></c:out>명 입력' maxlength="100">
			        			<input id="storeSeq" name="storeSeq" type="hidden">
			        			<input id="saveGbn" name="saveGbn" type="hidden">
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">온/오프</td>
			        		<td style="text-align: left;">
		        				<input type="checkbox" id="offYn" name="offYn" value="offYn">
		        				<label id="offYnChkLabel" for="offYn">오프라인</label>
		        				&nbsp;
		        				<input type="checkbox" id="onYn" name="onYn" value="onYn">
		        				<label id="onYnChkLabel" for="onYn">온라인</label>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">과세구분</td>
			        		<td style="text-align: left;">
			        			<select id="taxYn" name="taxYn" class="zemos_select1" style="width:100%;">
			        				<option value="Y">과세</option>
									<option value="N">면세</option>
								</select>
			        		</td>
			        	</tr>
			        	<tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">사용단위</td>
			        		<td style="text-align: left;">
			        		<c:forEach items="${unit}" var="item" varStatus="status">
				        		<c:if test="${item.useYn=='Y'}">
				        			<input type="checkbox" id="${item.unitNm}" name="${item.unitNm}" value="${item.unitSeq}">
			        				<label id="${item.unitNm}ChkLabel" for="${item.unitNm}">${item.unitNm}</label>
			        				&nbsp;
				        		</c:if>
			        		</c:forEach>
			        		</td>
			        	</tr>
			        	<tr>
			        		<td style="text-align: left; font-size: 12px;">분류사용</td>
			        		<td style="text-align: left;">
		        				<input type="checkbox" id="classYn" name="classYn">
		        				<label id="classYnChkLabel" for="classYn">&nbsp;&nbsp;&nbsp;</label>
			        		</td>
			        	</tr>
			        	<c:if test="${class1Nm[0].useYn == 'Y'}">
				        	<tr class="classAll" style="display: none;">
				        		<td style="text-align: left; font-size: 12px;">${class1Nm[0].class1UseNm}</td>
				        		<td style="text-align: left;">
				        			<select id="class1" name="class1" class="zemos_select1" style="width:100%;" disabled="disabled">
				        				<option value="">선택</option>
				        				<c:forEach items="${class1}" var="item" varStatus="status">
				        				<c:if test="${item.useYn == 'Y'}">
											<option value="${item.class1Seq}">${item.class1Nm}</option>
				        				</c:if>
										</c:forEach>
									</select>
				        		</td>
				        	</tr>
			        	</c:if>
			        	<c:if test="${class2Nm[0].useYn == 'Y'}">
				        	<tr class="classAll" style="display: none;">
				        		<td style="text-align: left; font-size: 12px;">${class2Nm[0].class2UseNm}</td>
				        		<td style="text-align: left;">
				        			<select id="class2" name="class2" class="zemos_select1" style="width:100%;" disabled="disabled">
				        				<option value="">선택</option>
										<c:forEach items="${class2}" var="item" varStatus="status">
										<c:if test="${item.useYn == 'Y'}">
											<option value="${item.class2Seq}">${item.class2Nm}</option>
										</c:if>
										</c:forEach>
									</select>
				        		</td> 
				        	</tr>
			        	</c:if>
			        	<c:if test="${class3Nm[0].useYn == 'Y'}">
				        	<tr class="classAll" style="display: none;">
				        		<td style="text-align: left; font-size: 12px;">${class3Nm[0].class3UseNm}</td>
				        		<td style="text-align: left;">
				        			<select id="class3" name="class3" class="zemos_select1" style="width:100%;" disabled="disabled">
				        				<option value="">선택</option>
										<c:forEach items="${class3}" var="item" varStatus="status">
										<c:if test="${item.useYn == 'Y'}">
											<option value="${item.class3Seq}">${item.class3Nm}</option>
										</c:if>
										</c:forEach>
									</select>
				        		</td> 
				        	</tr>
				        </c:if>
				        <c:if test="${class4Nm[0].useYn == 'Y'}">	
				        	<tr class="classAll" style="display: none;">
				        		<td style="text-align: left; font-size: 12px;">${class4Nm[0].class4UseNm}</td>
					       		<td style="text-align: left;">
				        			<select id="class4" name="class4" class="zemos_select1" style="width:100%;" disabled="disabled">
				        				<option value="">선택</option>
										<c:forEach items="${class4}" var="item" varStatus="status">
										<c:if test="${item.useYn == 'Y'}">
											<option value="${item.class3Seq}">${item.class3Nm}</option>
										</c:if>
										</c:forEach>
									</select>
				        		</td> 
				        	</tr>
				        </c:if>
				        <c:if test="${class5Nm[0].useYn == 'Y'}">	
					       	<tr class="classAll" style="display: none;">
				        		<td style="text-align: left; font-size: 12px;">${class5Nm[0].class5UseNm}</td>
				        		<td style="text-align: left;">
				        			<select id="class5" name="class5" class="zemos_select1" style="width:100%;" disabled="disabled">
				        				<option value="">선택</option>
										<c:forEach items="${class5}" var="item" varStatus="status">
										<c:if test="${item.useYn == 'Y'}">
											<option value="${item.class3Seq}">${item.class3Nm}</option>
										</c:if>
										</c:forEach>
									</select>
				        		</td> 
					    	</tr>
					    </c:if>	
			        	<tr> 
			        		<td style="text-align: left; font-size: 12px;">사용여부</td>
			        		<td style="text-align: left;">
			        			<input type="checkbox" id="storeUseYn" name="storeUseYn" checked="checked">
		        				<label id="StoreUseYnChkLabel" for="storeUseYn">&nbsp;</label>
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
	    <div id="tab2" class="cont" style="display: none;">
	      <div>
	    	<table class="zemos_table1" id="unitTable" style="margin-top: 0px; border-top: 0;">
	    		<colgroup>
			        <col width="10%" />
			        <col width="45%" />
			        <col width="45%" />
		        </colgroup>
		        <thead>
		        	<tr>
		        		<th style="background-color: #777777 !important;"><input id="itemCheckAll" name="itemCheckAll" type="checkbox" class="checkbox-style" style="display:inline;"></th>
		        		<th style="padding: 10px; font-weight: bolder; background-color: #777777 !important;">${itemNm[0].itemUseNm}명</th>
		        		<th style="padding: 10px; font-weight: bolder; background-color: #777777 !important;">코드</th>
		        	</tr>
		        </thead>
			    <tbody>
			        	<c:choose>
				        	<c:when test="${fn:length(item) > 0}">
				        		<c:forEach items="${item}" var="item" varStatus="status">
						        	<tr id="unitTableTr${status.count}">
						        	<c:if test="${item.useYn == 'Y'}">
						        		<td>
						        		<input id="useYn${status.count}" name="useYn${status.count}" type="checkbox" class="checkbox-style chk" style="display:inline;" value="${item.itemSeq}">
						        		</td>
						        		<td style="text-align: center;">
						        			<span>${item.itemNm}</span>
						        		</td>
						        		<td style="text-align: center;">
						        			<span>${item.itemCode}</span>			        			
						        		</td>
						        	</c:if>
						        	</tr>
			        			</c:forEach>
				        	</c:when>
					        <c:otherwise>
					        </c:otherwise>
				        </c:choose>
			        </tbody>
	    		</table>
	    		<div class="zemos_label_search1">
					<span class="fl mb5" style="width:100%; height: 29px; text-align: left;">
						<a href="javascript:void(0);" onclick="javascript:fnStoreSave(); return false;" class="zemos_form_span_btn_blue">
							<span style="font-size:15px;">저 장</span>
						</a>
					</span>
				</div>
	    	</div>
	    </div>
	    <div id="tab3" class="cont" style="display: none;">
	    	<div class="zemos_label_search2">
				<span class="fr mb5" style="margin-top:4px; right:8px; width:18%;">
					<a href="javascript:void(0);" onclick="fnUserAddShow();" class="zemos_form_span_btn_blue">
					<span style="font-size:13px;">추가</span>
					</a>
				</span>
			</div>
			<div>
				<table class="zemos_table1" id="unitTable" style="margin-top: 0px; border-top: 0;">
		    		<colgroup>
				        <col width="25%" />
				        <col width="25%" />
				        <col width="25%" />
				        <col width="25%" />
			        </colgroup>
		        	<thead>
			        	<tr>
			        		<th style="padding: 10px; font-weight: bolder; background-color: #D7D7D7 !important;">이름</th>
			        		<th style="padding: 10px; font-weight: bolder; background-color: #D7D7D7 !important;">업로드</th>
			        		<th style="padding: 10px; font-weight: bolder; background-color: #D7D7D7 !important;">실적승인</th>
			        		<th style="padding: 10px; font-weight: bolder; background-color: #D7D7D7 !important;">삭제</th>
			        	</tr>
		        	</thead>
			    	<tbody id = "sm" name = "sm">
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
			<div id = "userListDiv" name = "userListDiv" style="display: none;">
				<select id="userList" name="userList" class="zemos_select1" style="width:100%;" onchange="fnAddSM()">
				    <option value="">선택</option>
					<c:forEach items="${userList}" var="item" varStatus="status">
						<c:if test="${item.USE_YN == 'Y'}">
							<option value="${item.USER_SABUN}">${item.USER_NAME}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>	
	    </div>
	  </div>
	</div>
    
</body>
</html>