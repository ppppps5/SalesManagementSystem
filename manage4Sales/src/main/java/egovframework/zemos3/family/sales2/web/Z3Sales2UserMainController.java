package egovframework.zemos3.family.sales2.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.file.service.FileService;
import egovframework.com.login.service.LoginService;
import egovframework.com.user.service.UserService;
import egovframework.com.utl.zemosPagingUtil;
import egovframework.com.utl.fcc.service.AES128Util;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.zemos.zemos.service.ZemosService;
import egovframework.zemos.zemossetup.service.ZemosSetupService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UserService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ResultService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UnitService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UserResultService;


/**
 * 판매실적관리 메인 Controller
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Controller
public class Z3Sales2UserMainController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2UserMainController.class);

	@Resource(name = "zemosSetupService")
	private ZemosSetupService zemosSetupService;
	
	@Resource(name = "zemosService")
	private ZemosService zemosService;
	
	//User Service
	@Resource(name = "userService")
	protected UserService userService;
	
	//Login Service
	@Resource(name = "loginService2")
	private LoginService loginService;
	
	//판매관리 사용자 Service
	@Resource(name = "z3Sales2UserService")
	protected Z3Sales2UserService z3Sales2UserService;
	
	//매장 Service
	@Resource(name = "z3Sales2StoreService")
	protected Z3Sales2StoreService z3Sales2StoreService;
	
	//유닛 Service
	@Resource(name = "z3Sales2UnitService")
	protected Z3Sales2UnitService z3Sales2UnitService;
	
	//품목 Service
	@Resource(name = "z3Sales2ItemService")
	protected Z3Sales2ItemService z3Sales2ItemService;
	
	//실적 Service
	@Resource(name = "z3Sales2ResultService")
	private Z3Sales2ResultService z3Sales2ResultService;
	
	//실적 Service
	@Resource(name = "z3Sales2UserResultService")
	private Z3Sales2UserResultService z3Sales2UserResultService;
	
	@Resource(name = "fileService")
	protected FileService fileService;
	
	private final static String FILE_OWNER_PREFIX = "ZEMOS_SALES_";
	
	/**
	 * 제모스 판매관리 관리자 메인 화면
	 */
	@RequestMapping("/zemos3/family/sales2/sales2AdminMain.do")
	public String sales2AdminMain(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2UserMain";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String salesabun = EgovStringUtil.isNullToString(params.get("salesabun"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String yyyyMm = EgovStringUtil.isNullToString(params.get("yyyyMm"));
		
		if (zemosIdx == null || zemosIdx.isEmpty()) {
			zemosIdx = loginVO.getZemosIdx();
			params.put("zemosIdx", zemosIdx);
		}
		
		if (!EgovStringUtil.isEmpty(zemosIdx) && "".equals(wrkplcIdx)) {
			//현장 List
			List<Map<String, Object>> selectWrkplcList = zemosSetupService.selectWrkplcList(params);
			model.put("wrkplcList", selectWrkplcList);
			if (selectWrkplcList.size() == 1) {
				wrkplcIdx = EgovStringUtil.isNullToString(selectWrkplcList.get(0).get("idx"));
				model.put("wrkplcIdx", wrkplcIdx);
			} else {
				
				// 현장 선택
				return "forward:/zemos3/zemos/menu/menuManagerWrkplcList.do?zemosIdx=" + zemosIdx + "&gubun=salesAdminMainList&zemosNm=" + zemosNm;
			}
		}
		
		model.put("wrkplcIdx", wrkplcIdx);
		
		//현재년도의 이전년도(20년)
		List<Map<String, Object>> yyyyList = z3Sales2UserService.selectYyyy(params);
		model.put("yyyyList", 	yyyyList);
		
		//셀렉박스 매장 List
		List<Map<String, Object>> storeList = null;
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		model.put("storeList", 	storeList);
		
		//매장명칭 List
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2ResultService.selectStoreNewUseNameList(params);
		model.put("storeUseName", storeUseName);
		
		params.put("userAdminGbn", "A");
		
		if ( EgovStringUtil.isEmptyMapList(storeList) ) {
			params.put("storeSeq", null);
		} else if ( params.get("storeSeq") == null ) {
			params.put("storeSeq", storeList.get(0).get("storeSeq"));
		}
		
		if ( params.get("yyyyMm") == null ) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());
	        params.put("yyyyMm", strToday);
	        model.put("yyyy", strToday.substring(0, 4));
	        if ( EgovStringUtil.isNullToString(params.get("mm")) == null || "".equals(EgovStringUtil.isNullToString(params.get("mm"))) ) {
	        	model.put("mm", strToday.substring(4, 6));
	        } else {
	        	model.put("mm", EgovStringUtil.isNullToString(params.get("mm")));
	        }
		} else {
			model.put("yyyy", yyyyMm.substring(0, 4));
			if ( EgovStringUtil.isNullToString(params.get("mm")) == null || "".equals(EgovStringUtil.isNullToString(params.get("mm"))) ) {
				model.put("mm", yyyyMm.substring(4, 6));
			} else {
				model.put("mm", EgovStringUtil.isNullToString(params.get("mm")));
			}
		}
		
		// 상단 기준별 목표, 실적, 달성률 출력
		List<Map<String, Object>> goalResultTot1 = z3Sales2UserService.selectGoalResultTot1(params);
		System.out.println("####### goalResultTot1 >>>>> " + goalResultTot1);
		
		if ( goalResultTot1 == null ) {
			List<Map<String, Object>> goalResultTot2 = z3Sales2UserService.selectGoalResultTot2(params);
			model.put("goalResultTot", goalResultTot2);
		} else {
			model.put("goalResultTot", goalResultTot1);
		}
		
//
//		List<Map<String, Object>> resultTot1 = z3Sales2UserService.selectResultTot1(params);
//		System.out.println("####### resultTot1 >>>>> " + resultTot1);
//		
//		if ( resultTot1 == null ) {
//			List<Map<String, Object>> resultTot2 = z3Sales2UserService.selectResultTot2(params);
//			model.put("resultTot", resultTot2);
//		} else {
//			model.put("resultTot", resultTot1);
//		}
		
		//이거 수정해야함..
		// 하단 기준별 목표, 실적, 달성률 출력
		List<Map<String, Object>> selectUserMain = null;
		
		System.out.println("@@@@@@ goalResultTot1 >>>> " + goalResultTot1);
		
		if ( goalResultTot1 == null ) {
			params.put("goal", "N");
		} else {
			params.put("goal", "Y");
		}
		
//		System.out.println("@@@@@@ resultTot1 >>>> " + resultTot1);
//		
//		if ( resultTot1 == null ) {
//			System.out.println("resultTot1 null ############### ");
//			params.put("result", "N");
//		} else {
//			System.out.println("resultTot1 not null ############### ");
//			params.put("result", "Y");
//		}
		
		selectUserMain = z3Sales2UserService.selectUserMain(params);
		
		model.put("selectUserMain", selectUserMain);
		model.put("storeSeq", params.get("storeSeq"));
		model.put("userAdminGbn", "A");
		
		return rtnurl;
	}
	
	/**
	 * 제모스 판매관리 사용자 메인 화면
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2UserMain.do")
	public String sales2UserMain(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2UserMain";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		String yyyyMm = EgovStringUtil.isNullToString(params.get("yyyyMm"));
		String storeSeq = EgovStringUtil.isNullToString(params.get("storeSeq"));
		
		if ( wrkplcIdx == null || "".equals(wrkplcIdx) ) {
			params.put("wrkplcIdx", loginVO.getZemosWrkplcIdx());
			model.put("wrkplcIdx", loginVO.getZemosWrkplcIdx());
		}
		
		//현재년도의 이전년도(20년)
		List<Map<String, Object>> yyyyList = z3Sales2UserService.selectYyyy(params);
		model.put("yyyyList", 	yyyyList);
		
		List<Map<String, Object>> storeList = null;
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		model.put("storeList", 	storeList);
		
		//매장명칭 List
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2ResultService.selectStoreNewUseNameList(params);
		model.put("storeUseName", storeUseName);
		
		if ( params.get("yyyyMm") == null ) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());
	        params.put("yyyyMm", strToday);
	        model.put("yyyy", strToday.substring(0, 4));
	        if ( EgovStringUtil.isNullToString(params.get("mm")) == null || "".equals(EgovStringUtil.isNullToString(params.get("mm"))) ) {
	        	model.put("mm", strToday.substring(4, 6));
	        } else {
	        	model.put("mm", EgovStringUtil.isNullToString(params.get("mm")));
	        }
		} else {
			model.put("yyyy", yyyyMm.substring(0, 4));
			if ( EgovStringUtil.isNullToString(params.get("mm")) == null || "".equals(EgovStringUtil.isNullToString(params.get("mm"))) ) {
				model.put("mm", yyyyMm.substring(4, 6));
			} else {
				model.put("mm", EgovStringUtil.isNullToString(params.get("mm")));
			}
		}
		
//		Map<String, Object> goalResultTot1 = z3Sales2UserService.selectGoalResultTot1(params);
		List<Map<String, Object>> goalResultTot1 = z3Sales2UserService.selectGoalResultTot1(params);
		System.out.println("####### goalResultTot1 >>>>> " + goalResultTot1);
		
		if ( goalResultTot1 == null ) {
//			Map<String, Object> goalResultTot2 = z3Sales2UserService.selectGoalResultTot2(params);
			List<Map<String, Object>> goalResultTot2 = z3Sales2UserService.selectGoalResultTot2(params);
			model.put("goalResultTot", goalResultTot2);
		} else {
			model.put("goalResultTot", goalResultTot1);
		}
		
		List<Map<String, Object>> resultTot1 = z3Sales2UserService.selectResultTot1(params);
		System.out.println("####### resultTot1 >>>>> " + resultTot1);
		
		if ( resultTot1 == null ) {
			List<Map<String, Object>> resultTot2 = z3Sales2UserService.selectResultTot2(params);
			model.put("resultTot", resultTot2);
		} else {
			model.put("resultTot", resultTot1);
		}
		
		//셀렉박스 매장 List 권한
		List<Map<String, Object>> storeAppList = null;
		storeAppList = z3Sales2StoreService.selectAppStoreList(params);
		model.put("storeAppList", 	storeAppList);
		
		//이거 수정해야함..
		List<Map<String, Object>> selectUserMain = null;
		selectUserMain = z3Sales2UserService.selectUserMain(params);
		model.put("selectUserMain", 	selectUserMain);
		
		if ( goalResultTot1 == null ) {
			params.put("goal", "N");
		} else {
			params.put("goal", "Y");
		}
		System.out.println("@@@@@@ resultTot1 >>>> " + resultTot1);
		if ( resultTot1 == null ) {
			System.out.println("resultTot1 null ############### ");
			params.put("result", "N");
		} else {
			System.out.println("resultTot1 not null ############### ");
			params.put("result", "Y");
		}
		
		model.put("storeSeq", storeSeq);
		model.put("userAdminGbn", "U");
		
		return rtnurl;
	}
	
	/**
	 * 제모스 판매관리 사용자 실적등록 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2UserResult.do")
	public String sales2UserResult(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2UserResultSave";

		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		 
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String resultDt = EgovStringUtil.isNullToString(params.get("resultDt"));
		String gbn = EgovStringUtil.isNullToString(params.get("gbn"));
		//관리자 권한추가
		String userAdminGbn = EgovStringUtil.isNullToString(params.get("userAdminGbn"));
		model.put("userAdminGbn", userAdminGbn);
		//관리자 권한추가 
		String idx = "";
		
		Map<String, Object> salesDay = z3Sales2UserService.salesDay(params);
		model.put("salesDay", salesDay);
		params.put("resultDt", salesDay.get("resultDt"));
		System.out.println(">>>>>>>>>>> resultDt : " + salesDay.get("resultDt"));
		System.out.println(">>>>>>>>>>> resultDt : " + params.get("resultDt"));
		
		List<Map<String, Object>> storeList = null;
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		model.put("storeList", 	storeList);
		
		if ( params.get("storeSeq") == null ) {
			params.put("storeSeq", storeList.get(0).get("storeSeq"));
		}
		
		Map<String, Object> resultMngList = null;
		resultMngList = z3Sales2UserService.selectUserResultMngList(params);
		
		if ( resultMngList != null && resultMngList.size() > 0 ) {
			for ( int i = 0; i < resultMngList.size(); i++ ) {
				if ( EgovStringUtil.isNullToString(resultMngList.get("idx")) != null ) {
					idx = EgovStringUtil.isNullToString(resultMngList.get("idx"));
					resultMngList.put("imageIdxEnc", AES128Util.encrypt(EgovStringUtil.isNullToString(idx)));
					resultMngList.put("imageIdx", EgovStringUtil.isNullToString(idx));
				}
			}
		}
		model.put("resultMngList", resultMngList);
		
		List<Map<String, Object>> resultDetailList = null;
		resultDetailList = z3Sales2UserService.selectUserResultDetailList(params);
		model.put("resultDetailList", resultDetailList);
		
		//현재 수정 중인지 완료인지 여부 확인할 수 있음
		//		List<Map<String, Object>> selectUserResultWDetailList = null;
		//		selectUserResultWDetailList = z3Sales2UserService.selectUserResultWDetailList(params);
		//		model.put("selectUserResultWDetailList", selectUserResultWDetailList);
		
		Map<String, Object> selectStoreDetail = null;
		selectStoreDetail = z3Sales2StoreService.selectStoreDetail(params);
		model.put("selectStoreDetail", selectStoreDetail);
		
		List<Map<String, Object>> storeDetailItem = null;
		params.put("selectUseYn", "Y");
		storeDetailItem = z3Sales2StoreService.selectStoreDetailItem(params);
		model.put("itemList", storeDetailItem);
		
		return rtnurl;
	}
	
	
	/**
	    * 제모스 판매관리 사용자 실적등록 화면
	    * @param model
	    * @param params
	    * @param request
	    * @param response
	    * @return
	    * @throws Exception
	    */
	   @SuppressWarnings("unchecked")
	   @RequestMapping("/zemos3/family/sales2/sales2UserResultNew.do")
	   public String sales2UserResultNew(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
	      
	      String rtnurl = "egovframework/zemos3/family/sales2/sales2UserResultSaveNew";
	      
	      /* 페이징(전처리) */
	      params = zemosPagingUtil.setPrePagingValue(params);
	      
	      // 로그인 정보
	      LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
	      
	      // 권한
	      List<String> resultAuth = zemosService.zemosAuth(params);
	      model.put("resultAuth", resultAuth);
	      
	      String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
	      String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
	      String resultDt = EgovStringUtil.isNullToString(params.get("resultDt"));
	      String gbn = EgovStringUtil.isNullToString(params.get("gbn"));
	      //관리자 권한추가
	      String userAdminGbn = EgovStringUtil.isNullToString(params.get("userAdminGbn"));
	      model.put("userAdminGbn", userAdminGbn);
	      //관리자 권한추가 
	      String idx = "";
	      
	      Map<String, Object> salesDay = z3Sales2UserService.salesDay(params);
	      model.put("salesDay", salesDay);
	      params.put("resultDt", salesDay.get("resultDt"));
	      System.out.println(">>>>>>>>>>> resultDt : " + salesDay.get("resultDt"));
	      System.out.println(">>>>>>>>>>> resultDt : " + params.get("resultDt"));
	      
	      List<Map<String, Object>> storeList = null;
	      storeList = z3Sales2StoreService.selectBoxStoreList(params);
	      model.put("storeList",    storeList);
	      
	      if ( params.get("storeSeq") == null ) {
	         params.put("storeSeq", storeList.get(0).get("storeSeq"));
	      }
	      
	      List<Map<String, Object>> resultMngList = null;
	      List<Map<String, Object>> resultDetailList = null;
	      resultMngList = z3Sales2UserResultService.selectResultMng(params);
	      model.put("resultMngList", resultMngList);
	      if(z3Sales2UserResultService.selectResultMngCnt(params) != 0){
	         params.put("resultSeq", resultMngList.get(0).get("resultSeq"));
	      model.put("resultCnt", z3Sales2UserResultService.selectResultMngCnt(params));
	      resultDetailList = z3Sales2UserResultService.selectResultDetail(params);
	      model.put("resultDetailList", resultDetailList);
	      }else{
	         
	      }
	      
	      for(Map<String, Object> store : storeList){
	         if(EgovStringUtil.isNullToString(params.get("storeSeq")).equals(EgovStringUtil.isNullToString(store.get("storeSeq")))){
	               params.put("unit1Yn", store.get("unit1Yn"));
	               params.put("unit2Yn", store.get("unit2Yn"));
	               params.put("unit3Yn", store.get("unit3Yn"));
	               params.put("unit4Yn", store.get("unit4Yn"));
	               params.put("unit5Yn", store.get("unit5Yn"));
	         }
	      }
	      
	      int onOffCnt = 0;
	      onOffCnt = z3Sales2StoreService.onOffCnt(params);
	      List<Map<String, Object>> storeDetailItem = null;
	      params.put("selectUseYn", "Y");
	      params.put("onOffCnt", onOffCnt);
	      storeDetailItem = z3Sales2StoreService.selectStoreDetailItem(params);
	      model.put("itemList", storeDetailItem);
	      
	      
	      
	      Map<String, Object> selectStoreDetail = null;
	      selectStoreDetail = z3Sales2StoreService.selectStoreDetail(params);
	      model.put("selectStoreDetail", selectStoreDetail);
	      
	      
	      
	      if(z3Sales2UserResultService.selectResultMngCnt(params) != 0){
	         for(Map<String, Object> resultDetail : resultDetailList){
	            for(Map<String, Object> storeDetail : storeDetailItem){
	               if(EgovStringUtil.isNullToString(resultDetail.get("itemSeq")).equals(EgovStringUtil.isNullToString(storeDetail.get("itemSeq")))){
	                  resultDetail.put("itemNm", storeDetail.get("itemNm"));
	                  if(EgovStringUtil.isNullToString(storeDetail.get("onoffYn")).equals("0")){
	                     resultDetail.put("offYn", "Y");
	                  }else{
	                     resultDetail.put("onYn", "Y");                  
	                  }
	                  if(EgovStringUtil.isNullToString(storeDetail.get("unit1Yn")).equals("Y")){
	                     resultDetail.put("unit1Yn", "Y");
	                     resultDetail.put("unit1Cost", storeDetail.get("unit1Cost"));
	                     resultDetail.put("unitNm1", storeDetail.get("unitNm1"));
	                  }else{
	                     resultDetail.put("unit1Yn", "N");
	                  }
	                  if(EgovStringUtil.isNullToString(storeDetail.get("unit2Yn")).equals("Y")){
	                     resultDetail.put("unit2Yn", "Y");
	                     resultDetail.put("unit2Cost", storeDetail.get("unit2Cost"));
	                     resultDetail.put("unitNm2", storeDetail.get("unitNm2"));
	                  }else{
	                     resultDetail.put("unit2Yn", "N");
	                  }
	                  if(EgovStringUtil.isNullToString(storeDetail.get("unit3Yn")).equals("Y")){
	                     resultDetail.put("unit3Yn", "Y");
	                     resultDetail.put("unit3Cost", storeDetail.get("unit3Cost"));
	                     resultDetail.put("unitNm3", storeDetail.get("unitNm3"));
	                  }else{
	                     resultDetail.put("unit3Yn", "N");
	                  }
	                  if(EgovStringUtil.isNullToString(storeDetail.get("unit4Yn")).equals("Y")){
	                     resultDetail.put("unit4Yn", "Y");
	                     resultDetail.put("unit4Cost", storeDetail.get("unit4Cost"));
	                     resultDetail.put("unitNm4", storeDetail.get("unitNm4"));
	                  }else{
	                     resultDetail.put("unit4Yn", "N");
	                  }
	                  if(EgovStringUtil.isNullToString(storeDetail.get("unit5Yn")).equals("Y")){
	                     resultDetail.put("unit5Yn", "Y");
	                     resultDetail.put("unit5Cost", storeDetail.get("unit5Cost"));
	                     resultDetail.put("unitNm5", storeDetail.get("unitNm5"));
	                  }else{
	                     resultDetail.put("unit5Yn", "N");
	                  }
	               }
	            }
	         }
	      }
	      List<Map<String, Object>> closeYn = null;
	      closeYn = z3Sales2UserResultService.selectCloseYn(params);
	      model.put("closeYn", closeYn);
	      
	      List<Map<String, Object>> unitList = null;
	      params.put("selectUseYn", "Y");
	      unitList = z3Sales2UnitService.selectSales2Unit(params);
	      model.put("userAdminGbn", EgovStringUtil.isNullToString(params.get("userAdminGbn")));
	      return rtnurl;
	   }
	
	/**
	 * 제모스 판매관리 사용자 실적등록처리
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2UserResultSave.do")
	public ModelAndView sales2UserResultSave(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {

ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		int saveResultMng = 0;
		int saveResultDetail = 0;
		
		params.put("regUserSeq", loginVO.getIdx());
		params.put("modUserSeq", loginVO.getIdx());
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		//String zemosNm  = EgovStringUtil.isNullToString(params.get("zemosNm"));
		//String trCnt = EgovStringUtil.isNullToString(params.get("trCnt"));
		//String saveGbn = EgovStringUtil.isNullToString(params.get("saveGbn"));
		
		//int trI = 0;
		
		String[] itemSeq = request.getParameterValues("dItemSeq");
		String[] qty = request.getParameterValues("qty");
		String[] amt = request.getParameterValues("amt");
		String[] resultSeq = request.getParameterValues("resultSeq");
		String[] resultDetailSeq = request.getParameterValues("resultDetailSeq");
		String[] storeSeq = request.getParameterValues("storeSeq");
		String[] historySeq = request.getParameterValues("historySeq");
		String[] detailHistorySeq = request.getParameterValues("detailHistorySeq");
		String[] requestYn = request.getParameterValues("requestYn");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("zemosIdx", zemosIdx);
		resultMap.put("wrkplcIdx", wrkplcIdx);
		resultMap.put("resultSeq", EgovStringUtil.isNullToString(params.get("resultSeqM")));
		resultMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
		resultMap.put("resultDt", EgovStringUtil.isNullToString(params.get("resultDt")));
		resultMap.put("dollarAmt", EgovStringUtil.isNullToString(params.get("dollarAmt")));
		resultMap.put("regUserSeq", loginVO.getIdx());
		resultMap.put("modUserSeq", loginVO.getIdx());
		
		//당일, 당일기준 어제 는 다시 작성할 수 있다
		int result_seq = 0;
		Map<String, Object> selectUserResultMngList = z3Sales2UserService.selectUserResultMngList(resultMap);
		if(selectUserResultMngList == null){
			//신규로 저장한다
			result_seq = z3Sales2UserService.insertResultMng(resultMap);
			selectUserResultMngList = z3Sales2UserService.selectUserResultMngList(resultMap);
		} 
		
		result_seq = (int) selectUserResultMngList.get("resultSeq");
		
		
		
		/*
		 * 
		 * 
		int flag = 0;
		for ( int i = 0; i < historySeq.length; i++ ) {
			if ( historySeq[i] != "" || historySeq[i] != null ) {
				flag = 1;
				break;
			}
		}
		
		if ( flag == 1 ) {
			Map<String, Object> updateMap = new HashMap<String, Object>();
			updateMap.put("historySeq", historySeq[0]);
			updateMap.put("resultSeqN", resultMap.get("result_seq"));
			//updateMap.put("resultSeqO", resultSeq[0]);
			updateMap.put("zemosIdx", zemosIdx);
			updateMap.put("wrkplcIdx", wrkplcIdx);
			updateMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
			
			z3Sales2UserService.updateMasterResult(updateMap);
		}
		*/
		
		Map<String, Object> resultDetailMap = new HashMap<String, Object>();
		for ( int i = 0; i < itemSeq.length; i++ ) {
			resultDetailMap.put("resultSeq", result_seq);
			resultDetailMap.put("resultDt", EgovStringUtil.isNullToString(params.get("resultDt")));
			resultDetailMap.put("zemosIdx", zemosIdx);
			resultDetailMap.put("wrkplcIdx", wrkplcIdx);
			resultDetailMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
			resultDetailMap.put("itemSeq", EgovStringUtil.isNullToString(itemSeq[i]));
			resultDetailMap.put("amt", EgovStringUtil.isNullToString(amt[i]));
			resultDetailMap.put("qty", EgovStringUtil.isNullToString(qty[i]));
			resultDetailMap.put("requestYn", EgovStringUtil.isNullToString(requestYn[i]));
			/*
			if ( historySeq != null ) {
				if ( historySeq[i] != null || historySeq[i] != "" ) {
					resultDetailMap.put("requestYn", EgovStringUtil.isNullToString(requestYn[i]));
				}
			}
			*/
			resultDetailMap.put("regUserSeq", loginVO.getIdx());
			resultDetailMap.put("modUserSeq", loginVO.getIdx());
			
			Map<String,Object> selectUserResultDetailContent = z3Sales2UserService.selectUserResultDetailContent(resultDetailMap);
			if(selectUserResultDetailContent == null){
				//신규로 저장한다
				z3Sales2UserService.insertResultDetail(resultDetailMap);
				//selectUserResultDetailContent = z3Sales2UserService.selectUserResultDetailContent(resultDetailMap);
			} 
		
		}
		/*
		for ( int i = 0; i < detailHistorySeq.length; i++ ) {
			if ( historySeq != null ) {
				if ( historySeq[i] != null || historySeq[i] != "" ) {
					if ( detailHistorySeq[i] != null || detailHistorySeq[i] != "" ) {
						resultDetailMap.put("detailHistorySeq", EgovStringUtil.isNullToString(detailHistorySeq[i]));
						resultDetailMap.put("historySeq", EgovStringUtil.isNullToString(historySeq[i]));
						resultDetailMap.put("resultAmt", EgovStringUtil.isNullToString(amt[i]));
						resultDetailMap.put("resultQty", EgovStringUtil.isNullToString(qty[i]));
						resultDetailMap.put("itemSeq", EgovStringUtil.isNullToString(itemSeq[i]));
						resultDetailMap.put("zemosIdx", zemosIdx);
						resultDetailMap.put("wrkplcIdx", wrkplcIdx);
						
						z3Sales2UserService.updateDetailResult(resultDetailMap);
					}
				}
			}
		}
		*/
		
		
		if ( !"".equals(EgovStringUtil.isNullToString(params.get("imageIdx"))) ) {
		//if ( params.get("imageIdx") != null || params.get("imageIdx") != "" ) {
			params.put("resultSeq", resultDetailMap.get("resultSeq"));
			resultMap.put("resultSeq", resultDetailMap.get("resultSeq"));
			resultMap.put("fileOwner", FILE_OWNER_PREFIX + "R_" + resultDetailMap.get("resultSeq"));
			z3Sales2UserService.updateResultMng(resultMap);
			
			Map<String, Object> temp = new HashMap<String, Object>();
			//file테이블(ZM_ATCHMNFL) FILE_OWNER 업데이트
			temp.put("idx", EgovStringUtil.isNullToString(params.get("imageIdx")));
			temp.put("fileOwner", FILE_OWNER_PREFIX + "R_" + params.get("resultSeq"));
			z3Sales2UserService.updateFileOwner(temp);
		}
		
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultMngResponse", saveResultMng);
		model.put("resultDetailResponse", saveResultDetail);
		
		return modelAndView;
	}
	
	/**
	    * 제모스 판매관리 사용자 실적등록처리New
	    * @param model
	    * @param params
	    * @param request
	    * @param response
	    * @return
	    * @throws Exception
	    */
	   @RequestMapping("/zemos3/family/sales2/sales2UserResultSaveNew.do")
	   public ModelAndView sales2UserResultSaveNew(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
	      ModelAndView modelAndView = new ModelAndView("jsonView");
	      
	      // 로그인 정보
	      LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
	      
	      int saveResultMng = 0;
	      int saveResultDetail = 0;
	      
	      modelAndView.addObject("result", false);
	      params.put("regUserSeq", loginVO.getIdx());
	      params.put("modUserSeq", loginVO.getIdx());
	      
	      String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
	      String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
	      String storeSeq = EgovStringUtil.isNullToString(params.get("storeSeq"));
	      String resultDt = EgovStringUtil.isNullToString(params.get("resultDt"));
	      String resultSeq;
	      
	      //실적 마스터 테이블 or 실적 마스터 L 테이블 인설트(실적 등록 날짜에 실적이 등록 돼 있으면 셀렉트)
	      Map<String, Object> resultInsertMap = new HashMap<String, Object>();
	      resultInsertMap.put("zemosIdx", zemosIdx);
	      resultInsertMap.put("wrkplcIdx", wrkplcIdx);
	      resultInsertMap.put("storeSeq", storeSeq);
	      resultInsertMap.put("resultDt", resultDt);
	      resultInsertMap.put("regUserSeq", loginVO.getIdx());
	      if(z3Sales2UserResultService.selectResultMngCnt(resultInsertMap) == 0){
	         z3Sales2UserResultService.insertResultMng(resultInsertMap);
	         resultInsertMap.put("resultSeq", resultInsertMap.get("result_seq"));
	         z3Sales2UserResultService.insertResultLMng(resultInsertMap);
	         resultSeq = EgovStringUtil.isNullToString(resultInsertMap.get("result_seq"));
	      }else{
	         List<Map<String, Object>> resultMng = z3Sales2UserResultService.selectResultMng(params);
	         resultSeq = EgovStringUtil.isNullToString(resultMng.get(0).get("resultSeq"));
	      }
	      
	      // 실적 디테일 테이블 실적 디테일L 테이블  인설트 (실적 디테일 테이블에 해당 품목 정보 있으면 업데이트)
	      int useUnitCnt = Integer.parseInt((String)params.get("useUnitCnt")); 
	      int insertItemCnt = Integer.parseInt((String)params.get("insertItemCnt"));
	      for(int i = 0; i < insertItemCnt; i++){
	         Map<String, Object> resultDetailInsertMap = new HashMap<String, Object>();
	         resultDetailInsertMap.put("resultSeq", resultSeq);
	         resultDetailInsertMap.put("zemosIdx", zemosIdx);
	         resultDetailInsertMap.put("wrkplcIdx", wrkplcIdx);
	         resultDetailInsertMap.put("storeSeq", storeSeq);
	         if(EgovStringUtil.isNullToString(params.get("unit1Yn")).equals("Y")){
	            resultDetailInsertMap.put("unitSeq1", params.get("unitSeq1"));            
	         }
	         if(EgovStringUtil.isNullToString(params.get("unit2Yn")).equals("Y")){
	            resultDetailInsertMap.put("unitSeq2", params.get("unitSeq2"));            
	         }
	         if(EgovStringUtil.isNullToString(params.get("unit3Yn")).equals("Y")){
	            resultDetailInsertMap.put("unitSeq3", params.get("unitSeq3"));            
	         }
	         if(EgovStringUtil.isNullToString(params.get("unit4Yn")).equals("Y")){
	            resultDetailInsertMap.put("unitSeq4", params.get("unitSeq4"));            
	         }
	         if(EgovStringUtil.isNullToString(params.get("unit5Yn")).equals("Y")){
	            resultDetailInsertMap.put("unitSeq5", params.get("unitSeq5"));            
	         }
	         
	         resultDetailInsertMap.put("itemSeq", params.get("item["+i+"][itemSeq]"));
	         for (int j = 0; j < useUnitCnt; j++) {
	            int idx = j+1;
	            String onOffChk = EgovStringUtil.isNullToString(params.get("item["+i+"][onOff]"));
	            if(onOffChk.equals("off")){
	               if(idx == 1){               
	                  resultDetailInsertMap.put("qty", params.get("item["+i+"][qty"+idx+"]"));
	                  resultDetailInsertMap.put("amt", params.get("item["+i+"][amt"+idx+"]"));
	               }else{
	                  resultDetailInsertMap.put("qty"+idx, params.get("item["+i+"][qty"+idx+"]"));
	                  resultDetailInsertMap.put("amt"+idx, params.get("item["+i+"][amt"+idx+"]"));
	               }
	            }else if(onOffChk.equals("on")){
	               if(idx == 1){               
	                  resultDetailInsertMap.put("qtyOn", params.get("item["+i+"][qty"+idx+"_on]"));
	                  resultDetailInsertMap.put("amtOn", params.get("item["+i+"][amt"+idx+"_on]"));
	               }else{
	                  resultDetailInsertMap.put("qty"+idx+"On", params.get("item["+i+"][qty"+idx+"_on]"));
	                  resultDetailInsertMap.put("amt"+idx+"On", params.get("item["+i+"][amt"+idx+"_on]"));
	               }
	            }         
	         }
	         resultDetailInsertMap.put("regUserSeq", loginVO.getIdx());
	         if(z3Sales2UserResultService.selectResultDetailCnt(resultDetailInsertMap) == 0){
	            z3Sales2UserResultService.insertResultDetail(resultDetailInsertMap);
	            resultDetailInsertMap.put("resultDetailSeq", resultDetailInsertMap.get("result_detail_seq"));
	            z3Sales2UserResultService.insertResultLDetail(resultDetailInsertMap);
	         }else{
	            resultDetailInsertMap.put("resultDetailSeq", z3Sales2UserResultService.selectResultDetail(resultDetailInsertMap).get(0).get("resultDetailSeq"));
	            z3Sales2UserResultService.updateResultDetail(resultDetailInsertMap);
	            z3Sales2UserResultService.updateResultLDetail(resultDetailInsertMap);
	         }
	      }
	      
	      
	      // 리턴
	      modelAndView.addObject("result", true);
	      return modelAndView;
	   }
	
	/**
	 * 제모스 판매관리 사용자 실적등록처리
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2UserResultDallerUpdate.do")
	public ModelAndView sales2UserResultDallerUpdate(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		int saveResultMng = 0;
		int saveResultDetail = 0;
		
		params.put("regUserSeq", loginVO.getIdx());
		params.put("modUserSeq", loginVO.getIdx());
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		//String zemosNm  = EgovStringUtil.isNullToString(params.get("zemosNm"));
		//String trCnt = EgovStringUtil.isNullToString(params.get("trCnt"));
		//String saveGbn = EgovStringUtil.isNullToString(params.get("saveGbn"));
		
		//int trI = 0;
		
		String[] itemSeq = request.getParameterValues("dItemSeq");
		String[] qty = request.getParameterValues("qty");
		String[] amt = request.getParameterValues("amt");
		String[] resultSeq = request.getParameterValues("resultSeq");
		String[] resultDetailSeq = request.getParameterValues("resultDetailSeq");
		String[] storeSeq = request.getParameterValues("storeSeq");
		String[] historySeq = request.getParameterValues("historySeq");
		String[] detailHistorySeq = request.getParameterValues("detailHistorySeq");
		String[] requestYn = request.getParameterValues("requestYn");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("zemosIdx", zemosIdx);
		resultMap.put("wrkplcIdx", wrkplcIdx);
		resultMap.put("resultSeq", EgovStringUtil.isNullToString(params.get("resultSeqM")));
		resultMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
		resultMap.put("resultDt", EgovStringUtil.isNullToString(params.get("resultDt")));
		resultMap.put("dollarAmt", EgovStringUtil.isNullToString(params.get("dollarAmt")));
		resultMap.put("regUserSeq", loginVO.getIdx());
		resultMap.put("modUserSeq", loginVO.getIdx());
		
		//달러만 업데이트 한다
		z3Sales2UserService.updateResultDaller(resultMap);
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultMngResponse", saveResultMng);
		model.put("resultDetailResponse", saveResultDetail);
		
		return modelAndView;
	}
	
}
