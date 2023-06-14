<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
    <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosTop.jsp" %>

        <!DOCTYPE html>
        <html>
        <head>
            <%@include file="/WEB-INF/jsp/egovframework/zemos3/com/zemosHeader.jsp" %>
                <style>
                    .disabledbutton {
                        pointer-events: none;
                        opacity: 0.4;
                    }

                    .zemos_submenu99 {
                        border-bottom: 1px solid #cbcbcb;
                        padding: 16px 20px;
                        background-color: #f4f4f4;
                        overflow: hidden;
                        cursor: pointer;
                    }

                    .zemos_submenu99>a {
                        display: block;
                        width: 100%;
                    }

                    .zemos_submenu99>a>p {
                        display: block;
                        width: 100%;
                        float: left;
                        font-size: 14px;
                        font-weight: 600;
                        letter-spacing: -0.5px;
                    }
                </style>

                <script type="text/javascript">

                    // 전역변수
                    var pageNo = "${pageNo}";
                    var numOfRows = "${numOfRows}";
                    var zemosIdx = "${params.zemosIdx[0]}";
                    var zemosNm = "${params.zemosNm[0]}";
                    var wrkplcIdx = "${params.wrkplcIdx[0]}";
                    	
                    $(document).ready(function () {
            			console.log('wrkplcIdx > ' + wrkplcIdx);
            			$("input[type=checkbox]").css("display", "block");
            			
            			var trCntLength = 5;
            			var trSeq = 0;
            			for ( var i = 0; i < trCntLength; i++ ) {
            				trSeq = i + 1;
            				fnRowCheck(trSeq);
            				fnCheckBox(trSeq);
            			}
            			
            			//매장명 keyup이벤트
            			$('input[name=storeNm]').on('keyup',function(){	
            				var storeNm = $("#storeNm").val();
            				var hstoreNm = $("#hstoreNm").val();	
            				
            				if ( storeNm == hstoreNm ) {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//품목명 keyup이벤트
            			$('input[name=itemNm]').on('keyup',function(){	
            				var itemNm = $("#itemNm").val();
            				var hitemNm = $("#hitemNm").val();	
            				
            				if ( itemNm == hitemNm ) {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//분류1명 keyup이벤트
            			$('input[name=class1Nm]').on('keyup',function(){	
            				var class1Nm = $("#class1Nm").val();
            				var hclass1Nm = $("#hclass1Nm").val();
            				var useYn1 = $("#useYn1").val();
            				var huseYn1 = $("#huseYn1").val();
            				if ( $("#useYn1").is(":checked") == true ) {
            					useYn1 = "Y";
            				} else {
            					useYn1 = "N";
            				}	
            				
            				if ( class1Nm == hclass1Nm ) {
            					if ( useYn1 != huseYn1) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//분류2명 keyup이벤트
            			$('input[name=class2Nm]').on('keyup',function(){	
            				var class2Nm = $("#class2Nm").val();
            				var hclass2Nm = $("#hclass2Nm").val();
            				var useYn2 = $("#useYn2").val();
            				var huseYn2 = $("#huseYn2").val();
            				if ( $("#useYn2").is(":checked") == true ) {
            					useYn2 = "Y";
            				} else {
            					useYn2 = "N";
            				}	
            				
            				if ( class2Nm == hclass2Nm ) {
            					if ( useYn2 != huseYn2) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//분류3명 keyup이벤트
            			$('input[name=class3Nm]').on('keyup',function(){	
            				var class3Nm = $("#class3Nm").val();
            				var hclass3Nm = $("#hclass3Nm").val();
            				var useYn3 = $("#useYn3").val();
            				var huseYn3 = $("#huseYn3").val();
            				if ( $("#useYn3").is(":checked") == true ) {
            					useYn3 = "Y";
            				} else {
            					useYn3 = "N";
            				}	
            				
            				if ( class3Nm == hclass3Nm ) {
            					if ( useYn3 != huseYn3) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//분류4명 keyup이벤트
            			$('input[name=class4Nm]').on('keyup',function(){	
            				var class4Nm = $("#class4Nm").val();
            				var hclass4Nm = $("#hclass4Nm").val();
            				var useYn4 = $("#useYn4").val();
            				var huseYn4 = $("#huseYn4").val();
            				if ( $("#useYn4").is(":checked") == true ) {
            					useYn4 = "Y";
            				} else {
            					useYn4 = "N";
            				}	
            				
            				if ( class4Nm == hclass4Nm ) {
            					if ( useYn4 != huseYn4) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//분류5명 keyup이벤트
            			$('input[name=class5Nm]').on('keyup',function(){	
            				var class5Nm = $("#class5Nm").val();
            				var hclass5Nm = $("#hclass5Nm").val();
            				var useYn5 = $("#useYn5").val();
            				var huseYn5 = $("#huseYn5").val();
            				if ( $("#useYn5").is(":checked") == true ) {
            					useYn5 = "Y";
            				} else {
            					useYn5 = "N";
            				}	
            				
            				if ( class5Nm == hclass5Nm ) {
            					if ( useYn5 != huseYn5) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton"); 
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            				
            			});
            			
            			//사용여부분류1 change이벤트
            			$('input[name=useYn1]').on('change',function(){	
            				var class1Nm = $("#class1Nm").val();
            				var hclass1Nm = $("#hclass1Nm").val();
            				var useYn1 = $("#useYn1").val();
            				var huseYn1 = $("#huseYn1").val();
            				
            				if ( $("#useYn1").is(":checked") == true ) {
            					useYn1 = "Y";
            				} else {
            					useYn1 = "N";
            				}	
            				
            				if ( useYn1 == huseYn1 ) {
            					if ( class1Nm != hclass1Nm ) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton");
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            			});
            			
            			//사용여부분류2 change이벤트
            			$('input[name=useYn2]').on('change',function(){	
            				var class2Nm = $("#class2Nm").val();
            				var hclass2Nm = $("#hclass2Nm").val();
            				var useYn2 = $("#useYn2").val();
            				var huseYn2 = $("#huseYn2").val();
            				
            				if ( $("#useYn2").is(":checked") == true ) {
            					useYn2 = "Y";
            				} else {
            					useYn2 = "N";
            				}	
            				
            				if ( useYn2 == huseYn2 ) {
            					if ( class2Nm != hclass2Nm ) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton");
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            			});
            			
            			//사용여부분류3 change이벤트
            			$('input[name=useYn3]').on('change',function(){	
            				var class3Nm = $("#class3Nm").val();
            				var hclass3Nm = $("#hclass3Nm").val();
            				var useYn3 = $("#useYn3").val();
            				var huseYn3 = $("#huseYn3").val();
            				
            				if ( $("#useYn3").is(":checked") == true ) {
            					useYn3 = "Y";
            				} else {
            					useYn3 = "N";
            				}	
            				
            				if ( useYn3 == huseYn3 ) {
            					if ( class3Nm != hclass3Nm ) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton");
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            			});
            			
            			//사용여부분류4 change이벤트
            			$('input[name=useYn4]').on('change',function(){	
            				var class4Nm = $("#class4Nm").val();
            				var hclass4Nm = $("#hclass4Nm").val();
            				var useYn4 = $("#useYn4").val();
            				var huseYn4 = $("#huseYn4").val();
            				
            				if ( $("#useYn4").is(":checked") == true ) {
            					useYn4 = "Y";
            				} else {
            					useYn4 = "N";
            				}	
            				
            				if ( useYn4 == huseYn4 ) {
            					if ( class4Nm != hclass4Nm ) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton");
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            			});
            			
            			//사용여부분류5 change이벤트
            			$('input[name=useYn5]').on('change',function(){	
            				var class5Nm = $("#class5Nm").val();
            				var hclass5Nm = $("#hclass5Nm").val();
            				var useYn5 = $("#useYn5").val();
            				var huseYn5 = $("#huseYn5").val();
            				
            				if ( $("#useYn5").is(":checked") == true ) {
            					useYn5 = "Y";
            				} else {
            					useYn5 = "N";
            				}	
            				
            				if ( useYn5 == huseYn5 ) {
            					if ( class5Nm != hclass5Nm ) {
            						$("#btnA").removeClass("disabledbutton");
            						$("#btnSpan").text("수정");
            					} else {
            						$("#btnA").addClass("disabledbutton");
            						$("#btnSpan").text("저장");	
            					}
            				} else {
            					$("#btnA").removeClass("disabledbutton");
            					$("#btnSpan").text("수정");
            				}
            			});
            			
            		});
            		
            		//조회
            		function fn_reload(type, value1, value2) {
            			
            			
            			var url = "${pageContext.request.contextPath}${common.requestURI}";
            			url += "?zemosIdx=" + zemosIdx;
            			url += "&wrkplcIdx=" + wrkplcIdx;
            			url += "&zemosNm=" + encodeURIComponent(zemosNm);
            			
            			var useYn1 = $("#useYn1").val();
            			var useYn2 = $("#useYn2").val();
            			var useYn3 = $("#useYn3").val();
            			var useYn4 = $("#useYn4").val();
            			var useYn5 = $("#useYn5").val();
            			
            			//alert(useYn4);
            			
            			fn_location_href(url);
            		}
            		
                    //판매관리 메뉴 이동 체크
                    function fnSalesYnHref(gbn, url,gbn1) {
                    	var itemNm = $("#itemNm").val();
                    	var hitemNm = $("#hitemNm").val();
                    	var gbn1 = gbn1;
                    	
                    	if(gbn1 == 'C1'){
                    		var class1Nm = $("#class1Nm").val();
                    		var hclass1Nm = $("#hclass1Nm").val();
                    		if(hclass1Nm == null || hclass1Nm ==''){
                    			alert("분류1명 등록 후 사용가능합니다.");
                        		return;
                    		}
                    	}
                    	
                    	if(gbn1 == 'C2'){
                    		var class2Nm = $("#class2Nm").val();
                    		var hclass2Nm = $("#hclass2Nm").val();
                    		if(hclass2Nm == null || hclass2Nm ==''){
                    			alert("분류2명 등록 후 사용가능합니다.");
                        		return;
                    		}
                    	}
                    	
                    	if(gbn1 == 'C3'){
                    		var class3Nm = $("#class3Nm").val();
                    		var hclass3Nm = $("#hclass3Nm").val();
                    		if(hclass3Nm == null || hclass3Nm ==''){
                    			alert("분류3명 등록 후 사용가능합니다.");
                        		return;
                    		}
                    	}
                    	
                    	if(gbn1 == 'C4'){
                    		var class4Nm = $("#class4Nm").val();
                    		var hclass4Nm = $("#hclass4Nm").val();
                    		if(hclass4Nm == null || hclass4Nm ==''){
                    			alert("분류4명 등록 후 사용가능합니다.");
                        		return;
                    		}
                    	}
                    	
                    	if(gbn1 == 'C5'){
                    		var class5Nm = $("#class5Nm").val();
                    		var hclass5Nm = $("#hclass5Nm").val();
                    		if(hclass5Nm == null || hclass5Nm ==''){
                    			alert("분류5명 등록 후 사용가능합니다.");
                        		return;
                    		}
                    	}
                    	
                        if (url == "" || url == null) {
                            alert("메뉴 이동 경로가 없습니다.");
                            return;
                        }

                        if (gbn == 'O' || gbn == 'H') {
                            if (storeListCnt <= 0) {
                                alert("매장 등록 후 사용가능합니다.");
                                return;
                            }
                        }
                        
                        if (gbn == 'itemNm' && itemNm == '' || itemNm == null) {
                        	if (itemNm.length == 0){
                        		alert("품목명칭 등록 후 사용가능합니다.");
                        		return;
                        	}
                        	
                        }
                        if (gbn == 'itemNm' && hitemNm == '' || hitemNm == null) {
		                        if (hitemNm.length== 0){
	                        		alert("저장 후 사용가능합니다.");
	                        		return;
		                    	}
                        }
                        
                        url += "&wrkplcIdx=" + wrkplcIdx;
                        fn_location_href(url);
                    }

                    function fn_back2() {
                        fn_location_href("${pageContext.request.contextPath}/zemos3/zemos/zemossetup/zemosSalesAdmin.do?zemosIdx=" + zemosIdx + "&zemosNm=" + zemosNm);
                    }
                    
                    function fnRowCheck() {
            			var useYn1 = "";
            			var useYn2 = "";
            			var useYn3 = "";
            			var useYn4 = "";
            			var useYn5 = "";
            			
            			if ( $("#useYn1").is(":checked") == true ) {
            				useYn1 = "Y";
            			} else {
            				useYn1 = "N";
            			}	
            			if ( $("#useYn2").is(":checked") == true ) {
            				useYn2 = "Y";
            			} else {
            				useYn2 = "N";
            			}
            			if ( $("#useYn3").is(":checked") == true ) {
            				useYn3 = "Y";
            			} else {
            				useYn3 = "N";
            			}
            			if ( $("#useYn4").is(":checked") == true ) {
            				useYn4 = "Y";
            			} else {
            				useYn4 = "N";
            			}
            			if ( $("#useYn5").is(":checked") == true ) {
            				useYn5 = "Y";
            			} else {
            				useYn5 = "N";
            			}
            				
            			
           				if ( $("#class1Nm").val() == $("#hclass1Nm").val() && useYn1 == $("#huseYn1").val()) {
           				
           					$("#btnA").addClass("disabledbutton");
           					$("#btnSpan").text("저장");
           				} else {
           					
           					$("#btnA").removeClass("disabledbutton");
           					$("#btnSpan").text("수정");
           				}
           			
            			
            		}	
                    
                    function fnCheckBox(tcnt) {
                    	var useYn1 = "";
            			var useYn2 = "";
            			var useYn3 = "";
            			var useYn4 = "";
            			var useYn5 = "";
            			
                    	if (tcnt = 1){
                    		if ( $("#useYn1").is(":checked") == true ) {
                				useYn1 = "Y";
                				$("#class1Nm").attr("disabled", false);
                				$("#class1Next").attr("disabled", false);
                			} else {
                				useYn1 = "N";
                				$("#class1Nm").attr("disabled", true);
                				$("#class1Next").attr("disabled", true);
                			}	
                    	}
                    	if (tcnt = 2){
                    		if ( $("#useYn2").is(":checked") == true ) {
                				useYn2 = "Y";
                				$("#class2Nm").attr("disabled", false);
                				$("#class2Next").attr("disabled", false);
                			} else {
                				useYn2 = "N";
                				$("#class2Nm").attr("disabled", true);
                				$("#class2Next").attr("disabled", true);
                			}	
                    	}
                    	if (tcnt = 3){
                    		if ( $("#useYn3").is(":checked") == true ) {
                				useYn3 = "Y";
                				$("#class3Nm").attr("disabled", false);
                				$("#class3Next").attr("disabled", false);
                			} else {
                				useYn3 = "N";
                				$("#class3Nm").attr("disabled", true); 
                				$("#class3Next").attr("disabled", true);
                			}
                    	}
                    	if (tcnt = 4){
                    		if ( $("#useYn4").is(":checked") == true ) {
                				useYn4 = "Y";
                				$("#class4Nm").attr("disabled", false);
                				$("#class4Next").attr("disabled", false);
                			} else {
                				useYn4 = "N";
                				$("#class4Nm").attr("disabled", true); 
                				$("#class4Next").attr("disabled", true);
                			}
                    	}
                    	if (tcnt = 5){
                    		if ( $("#useYn5").is(":checked") == true ) {
                				useYn5 = "Y";
                				$("#class5Nm").attr("disabled", false);
                				$("#class5Next").attr("disabled", false);
                			} else {
                				useYn5 = "N";
                				$("#class5Nm").attr("disabled", true); 
                				$("#class5Next").attr("disabled", true);
                			}
                    	}
            		}
                    
                    function fnSaveAll() {
                    	 
                    	// 변수 선언
            			var storeSaveGbn  = "";
            			var itemSaveGbn   = "";
            			var class1SaveGbn = "";
            			var class2SaveGbn = "";
            			var class3SaveGbn = "";
            			var class4SaveGbn = "";
            			var class5SaveGbn = "";
            			
            			var storeSeq = $('#storeNmSeq').val();
            			var itemSeq = $('#itemNmSeq').val();
            			var class1NmSeq = $('#class1Seq').val();
            			var class2NmSeq = $('#class2Seq').val();
            			var class3NmSeq = $('#class3Seq').val();
            			var class4NmSeq = $('#class4Seq').val();
            			var class5NmSeq = $('#class5Seq').val();
            			
            			var storeNm       = $('#storeNm').val();
                        var itemNm        = $("#itemNm").val();
                        var class1Nm      = $("#class1Nm").val();
                        var class2Nm      = $("#class2Nm").val();
                        var class3Nm      = $("#class3Nm").val();
                        var class4Nm      = $("#class4Nm").val();
                        var class5Nm      = $("#class5Nm").val();
                        
                        var useYn1        = $("#useYn1").val();
                        var useYn2        = $("#useYn2").val();
                        var useYn3        = $("#useYn3").val();
                        var useYn4        = $("#useYn4").val();
                        var useYn5        = $("#useYn5").val();
                        
                        var hstoreNm      = $("#hstoreNm").val();
                        var hitemNm = $("#hitemNm").val();
                        
                        if (hstoreNm == '' || hstoreNm == null) {
		                        if (storeNm.length== 0){
	                        		alert("매장명 등록 후 사용가능합니다.");
	                        		return;
		                    	}
                        }
						
                        if (hitemNm == '' || hitemNm == null) {
		                        if (itemNm.length== 0){
	                        		alert("품목명 등록 후 사용가능합니다.");
	                        		return;
		                    	}
                        }
                        // 체크표시에 따른 사용여부 조절
                        if ($("#useYn1").is(":checked") == true) {
                            useYn1 = "Y";
                        } else {
                            useYn1 = "N";
                        }
						
                        if ($("#useYn2").is(":checked") == true) {
                            useYn2 = "Y";
                        } else {
                            useYn2 = "N";
                        }
						
                        if ($("#useYn3").is(":checked") == true) {
                            useYn3 = "Y";
                        } else {
                            useYn3 = "N";
                        }
						
                        if ($("#useYn4").is(":checked") == true) {
                            useYn4 = "Y";
                        } else {
                            useYn4 = "N";
                        }
						
                        if ($("#useYn5").is(":checked") == true) {
                            useYn5 = "Y";
                        } else {
                            useYn5 = "N";
                        }
						
                        // 인서트/업데이트 구분 작업
                        if (storeSeq == '' || storeSeq == null) {
                            storeNmSaveGbn = "insert";
                        } else {
                        	if(storeNm == '' || storeNm == null) {
                        		alert("매장명을 입력하세요");
                        		return false;
                        	}
                        	storeNmSaveGbn = "update";
                        }
						
                        if (itemSeq == '' || itemSeq == null) {
                        	itemNmSaveGbn = "insert";
                        } else {
                        	if(itemNm == '' || itemNm == null) {
                        		alert("품목명을 입력하세요");
                        		return false;
                        	}
                        	itemNmSaveGbn = "update";
                        }
                        
                        if( class1NmSeq = '' || class1NmSeq == null) {
                        	class1SaveGbn = "insert";
                        } else {
                        	class1SaveGbn = "update";
                        }
                        
                        if( class2NmSeq = '' || class2NmSeq == null) {
                        	class2SaveGbn = "insert";
                        } else {
                        	class2SaveGbn = "update";
                        }
                        
                        if( class3NmSeq = '' || class3NmSeq == null) {
                        	class3SaveGbn = "insert";
                        } else {
                        	class3SaveGbn = "update";
                        }
                        
                        if( class4NmSeq = '' || class4NmSeq == null) {
                        	class4SaveGbn = "insert";
                        } else {
                        	class4SaveGbn = "update";
                        }
                        
                        if( class5NmSeq = '' || class5NmSeq == null) {
                        	class5SaveGbn = "insert";
                        } else {
                        	class5SaveGbn = "update";
                        }

                        var params = {};
            			params.zemosIdx      = zemosIdx;
            			params.wrkplcIdx     = wrkplcIdx;
                        params.storeNmSaveGbn= storeNmSaveGbn;
                        params.itemNmSaveGbn = itemNmSaveGbn;
                        params.class1SaveGbn = class1SaveGbn;
                        params.class2SaveGbn = class2SaveGbn;
                        params.class3SaveGbn = class3SaveGbn;
                        params.class4SaveGbn = class4SaveGbn;
                        params.class5SaveGbn = class5SaveGbn;
                        params.useYn1        = useYn1;
                        params.useYn2        = useYn2;
                        params.useYn3        = useYn3;
                        params.useYn4        = useYn4;
                        params.useYn5        = useYn5;
                        params.storeNm       = storeNm;
                        params.itemNm        = itemNm;
                        params.class1Nm      = class1Nm;
                        params.class2Nm      = class2Nm;
                        params.class3Nm      = class3Nm;
                        params.class4Nm      = class4Nm;
                        params.class5Nm      = class5Nm;

                        $.ajax({
                            url: gvContextPath + "/zemos3/family/sales2/classSave.do",
                            type: 'POST',
                            dataType: 'json',
                            data: params
                        }).always(function (response) { // 전 처리 (완료 실패 모든 상황에서 실행됨)
                        }).done(function (response) { // 완료
                            if (response.result === true) {
                                alert("저장되었습니다.");
                                fn_reload();
                            } else {
                                if (response.resultError == '1') {
                                    alert("중복되는 항목이 있습니다.");
                                }
                                fn_reload();
                            }
                        }).fail(function (response) { // 실패
                        }).always(function (response) { // 후 처리 (완료 실패 모든 상황에서 실행됨)
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
                    <span class="zemos_title1_middle" onclick="javascript:fn_location_href();return false;">
                    	품목/분류명관리
                    </span>
                    <span class="zemos_title1_left">
                    	<a href="#" onclick="javascript:fn_back2();return false;">
                    		<img src="${pageContext.request.contextPath}/images/egovframework/zemos3/icon_pre_w.png" alt="이전" />
                    	</a>
                    </span>
                </div>
                <!--타이틀끝-->
                
                <!--조회된자료시작-->
                <div class="zemos_label_search2">
                    <span class="fl" style="padding:10px 0px;">
                    </span>
                    <span class="fr mb5" style="margin-top:5px; width:21%;">
                      	<a href="javascript:void(0);" onclick="javascript:fnSaveAll(); return false;" class="zemos_form_span_btn_blue" id="btnA">
							<span id="btnSpan" style="font-size:13px;">저장</span>
						</a>
                    </span>
                </div>
                <div style="overflow-x:scroll; z-index:9999; -webkit-overflow-scrolling: touch;">

                    <!-- 매장명칭 -->
		        	 			<div class="zemos_submenu99">
			                        <a>
			                            <p>매장명칭
			                            	<input type="hidden" id="storeNmSeq" name="storeNmSeq"  value="${storeNmList[0].storeSeq}">
			                                <input type="text" id="storeNm" name="storeNm" value="${storeNmList[0].storeNm}" placeholder="매장명칭으로 사용할 이름"
			                                	style="display: inline-block; width: 70%; height: 29px; margin-left:10px;">
			                                <input type="hidden" id="hstoreNm" name="hstoreNm" value="${storeNmList[0].storeNm}"/> 	
			                            </p>
			                        </a>
			                    </div>

                    <!-- 품목명칭 -->
			                    <div class="zemos_submenu99">
			                        <a href="#" onclick="javascript:return false;">
			                            <p>품목명칭
			                            	<input type="hidden" id="itemNmSeq" name="itemNmSeq" value="${itemNmList[0].itemSeq}">
			                                <input type="text" id="itemNm" name="itemNm" value="${itemNmList[0].itemNm}" placeholder="품목명칭으로 사용할 이름"
			                                    style="display: inline-block; width: 70%; height: 29px; margin-left:10px;">
			                                <input type="hidden" id="hitemNm" name="hitemNm" value="${itemNmList[0].itemNm}"/>     
			                                <img src="../../../images/egovframework/zemos3/icon_next.png"
			                                    style="width: 20px; height: 20px; display: inline-block; float:right;"
			                                    onclick="javascript:fnSalesYnHref('itemNm','${pageContext.request.contextPath}/zemos3/family/sales2/sales2Item.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}')); return false;">
			                            </p>
			                        </a>
			                    </div>
					
                    <!-- 분류명1 -->
                     			<div class="zemos_submenu99">
                                    
                                        <p>1
                                            <input id="class1Seq" name="class1Seq" type="hidden" value="${class1NmList[0].class1NmSeq}">
                                            <input id="class1Nm" name="class1Nm" value="${class1NmList[0].class1Nm}" type="text" style="display: inline-block; width: 70%; height: 29px; margin-left:10px;" placeholder="분류명1">
                                            <input type="hidden" id="hclass1Nm" name="hclass1Nm" value="${class1NmList[0].class1Nm}"/>  
                                            <input id="class1Next" type="image" src="../../../images/egovframework/zemos3/icon_next.png" style="width: 20px; height: 20px;  float:right;" 
                                             onclick="javascript:fnSalesYnHref('I','${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class1.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}'),'C1'); return false;">
                                            <input id="useYn1" name="useYn1" type="checkbox" class="checkbox-style"
                                                style="display:inline-block; padding: 10px; float: right; margin-right: 15px; zoom:1.5;" onChange="javascript:fnCheckBox(1);" 
                                                <c:if test="${class1NmList[0].useYn1 eq 'Y'}">checked="checked"</c:if>>
                                            <input type="hidden" id="hclass1Nm" name="hclass1Nm" value="${class1NmList[0].class1Nm}"/> 
                                            <input type="hidden" id="huseYn1" name="huseYn1" value="${class1NmList[0].useYn1}"/>    
                                        </p>
                                   
                                </div>
                    <!-- 분류명2 -->
                                <div class="zemos_submenu99">
                                    
                                        <p>2
                                            <input id="class2Seq" name="class2Seq" type="hidden" value="${class2NmList[0].class2NmSeq}">
                                            <input id="class2Nm" name="class2Nm" value="${class2NmList[0].class2Nm}" type="text" style="display: inline-block; width: 70%; height: 29px; margin-left:10px;" placeholder="분류명2">
                                            <input type="hidden" id="hclass2Nm" name="hclass2Nm" value="${class2NmList[0].class2Nm}"/>  
                                            <input id="class2Next" type="image" src="../../../images/egovframework/zemos3/icon_next.png" style="width: 20px; height: 20px;  float:right;" 
                                             onclick="javascript:fnSalesYnHref('I','${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class2.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}'),'C2'); return false;">
                                            <input id="useYn2" name="useYn2" type="checkbox" class="checkbox-style"
                                                style="display:inline-block; padding: 10px; float: right; margin-right: 15px; zoom:1.5;" onChange="javascript:fnCheckBox(2);" 
                                                <c:if test="${class2NmList[0].useYn2 eq 'Y'}">checked="checked"</c:if>>
                                            <input type="hidden" id="hclass2Nm" name="hclass2Nm" value="${class2NmList[0].class2Nm}"/>   
                                            <input type="hidden" id="huseYn2" name="huseYn2" value="${class2NmList[0].useYn2}"/>  
                                        </p>
                                    
                                </div>

                    <!-- 분류명3 -->
                                <div class="zemos_submenu99">
                                   
                                        <p>3
                                            <input id="class3Seq" name="class3Seq" type="hidden" value="${class3NmList[0].class3NmSeq}">
                                            <input id="class3Nm" name="class3Nm" value="${class3NmList[0].class3Nm}" type="text" style="display: inline-block; width: 70%; height: 29px; margin-left:10px;" placeholder="분류명3">
                                            <input type="hidden" id="hclass3Nm" name="hclass3Nm" value="${class3NmList[0].class3Nm}"/>
                                            <input id="class3Next" type="image" src="../../../images/egovframework/zemos3/icon_next.png" style="width: 20px; height: 20px;  float:right;" 
                                             onclick="javascript:fnSalesYnHref('I','${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class3.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}'),'C3'); return false;">
                                            <input id="useYn3" name="useYn3" type="checkbox" class="checkbox-style"
                                                style="display:inline-block; padding: 10px; float: right; margin-right: 15px; zoom:1.5;" onChange="javascript:fnCheckBox(3);" 
                                                <c:if test="${class3NmList[0].useYn3 eq 'Y'}">checked="checked"</c:if>>
                                            <input type="hidden" id="hclass3Nm" name="hclass3Nm" value="${class3NmList[0].class3Nm}"/> 
                                            <input type="hidden" id="huseYn3" name="huseYn3" value="${class3NmList[0].useYn3}"/>   
                                        </p>
                                    
                                </div>
					
                    <!-- 분류명4 -->
                                <div class="zemos_submenu99">
                                    
                                        <p>4
                                            <input id="class4Seq" name="class4Seq" type="hidden" value="${class4NmList[0].class4NmSeq}">
                                            <input id="class4Nm" name="class4Nm" value="${class4NmList[0].class4Nm}" type="text" style="display: inline-block; width: 70%; height: 29px; margin-left:10px;" placeholder="분류명4">
                                            <input type="hidden" id="hclass4Nm" name="hclass4Nm" value="${class4NmList[0].class4Nm}"/>
                                            <input id="class4Next" type="image" src="../../../images/egovframework/zemos3/icon_next.png" style="width: 20px; height: 20px;  float:right;" 
                                             onclick="javascript:fnSalesYnHref('I','${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class4.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}'),'C4'); return false;">
                                            <input id="useYn4" name="useYn4" type="checkbox" class="checkbox-style"
                                                style="display:inline-block; padding: 10px; float: right; margin-right: 15px; zoom:1.5;" onChange="javascript:fnCheckBox(4);" 
                                                <c:if test="${class4NmList[0].useYn4 eq 'Y'}">checked="checked"</c:if>>
                                            <input type="hidden" id="hclass4Nm" name="hclass4Nm" value="${class4NmList[0].class4Nm}"/>  
                                            <input type="hidden" id="huseYn4" name="huseYn4" value="${class4NmList[0].useYn4}"/>  
                                        </p>
                                    
                                </div>
					
                    <!-- 분류명5 -->
                                <div class="zemos_submenu99">
                                   
                                        <p>5
                                            <input id="class5Seq" name="class5Seq" type="hidden" value="${class5NmList[0].class5NmSeq}">
                                            <input id="class5Nm" name="class5Nm" value="${class5NmList[0].class5Nm}" type="text" style="display: inline-block; width: 70%; height: 29px; margin-left:10px;" placeholder="분류명5">
                                            <input type="hidden" id="hclass5Nm" name="hclass5Nm" value="${class5NmList[0].class5Nm}"/>
                                            <input id="class5Next" type="image" src="../../../images/egovframework/zemos3/icon_next.png" style="width: 20px; height: 20px;  float:right;" 
                                             onclick="javascript:fnSalesYnHref('I','${pageContext.request.contextPath}/zemos3/family/sales2/sales2Class5.do?zemosIdx=${params.zemosIdx[0]}&zemosNm='+encodeURIComponent('${params.zemosNm[0]}'),'C5'); return false;">
                                            <input id="useYn5" name="useYn5" type="checkbox" class="checkbox-style"
                                                style="display:inline-block; padding: 10px; float: right; margin-right: 15px; zoom:1.5;" onChange="javascript:fnCheckBox(5);" 
                                                <c:if test="${class5NmList[0].useYn5 eq 'Y'}">checked="checked"</c:if>>
                                            <input type="hidden" id="hclass5Nm" name="hclass5Nm" value="${class5NmList[0].class5Nm}"/>
                                            <input type="hidden" id="huseYn5" name="huseYn5" value="${class5NmList[0].useYn5}"/>  
                                        </p>
                                    
                                </div>
                    
                <!--조회된자료끝-->
                </div>

        </body>
        </html>