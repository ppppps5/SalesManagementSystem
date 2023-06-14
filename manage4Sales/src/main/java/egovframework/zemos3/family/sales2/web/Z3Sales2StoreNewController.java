package egovframework.zemos3.family.sales2.web;

import java.util.ArrayList;
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
import egovframework.com.login.service.LoginService;
import egovframework.com.user.service.UserService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.zemos.zemos.service.ZemosService;
import egovframework.zemos.zemossetup.service.ZemosSetupService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class1Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class2Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class3Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class4Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class5Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreNewService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UnitService;


/**
 * 판매실적관리 매장관리 Controller
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 *  
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Controller
public class Z3Sales2StoreNewController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2StoreNewController.class);

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
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreNewService")
	private Z3Sales2StoreNewService z3Sales2StoreNewService;
	
	//품목 Service
	@Resource(name = "z3Sales2ItemService")
	private Z3Sales2ItemService z3Sales2ItemService;
	
	//분류1 Service
	@Resource(name = "z3Sales2Class1Service")
	private Z3Sales2Class1Service z3Sales2Class1Service;
	
	//분류2 Service
	@Resource(name = "z3Sales2Class2Service")
	private Z3Sales2Class2Service z3Sales2Class2Service;
	
	//분류3 Service
	@Resource(name = "z3Sales2Class3Service")
	private Z3Sales2Class3Service z3Sales2Class3Service;
	
	//분류4 Service
	@Resource(name = "z3Sales2Class4Service")
	private Z3Sales2Class4Service z3Sales2Class4Service;
	
	//분류5 Service
	@Resource(name = "z3Sales2Class5Service")
	private Z3Sales2Class5Service z3Sales2Class5Service;

	//단위 Service
	@Resource(name = "z3Sales2UnitService")
	private Z3Sales2UnitService z3Sales2UnitService;
	
	/**
	 * 매장조회
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2StoreNew.do")
	public String sales2Store(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2StoreNew";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
		String storeUseNm = EgovStringUtil.isNullToString(params.get("storeUseNm"));
		String selectUseYn = EgovStringUtil.isNullToString(params.get("selectUseYn"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		
		params.put("regUserSeq", loginVO.getIdx());
		
		List<Map<String, Object>> storeList = null;

		storeList = z3Sales2StoreNewService.selectStoreNewList(params);

		
		model.put("storeList", storeList);
		model.put("storeNm", storeNm);
		model.put("selectUseYn", selectUseYn);
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2StoreNewService.selectStoreNewUseNameList(params);
		
		model.put("storeUseName", storeUseName);
		model.put("storeUseNm", storeUseNm);
		
		return rtnurl;
	}
	@RequestMapping("/zemos3/family/sales2/sales2StoreNewDetail.do")
	public String sales2StoreNewDetail(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2StoreNewDetail";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String storeSeq = EgovStringUtil.isNullToString(params.get("storeSeq"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		
		
		//분류
		List<Map<String, Object>> itemNm = null;
		itemNm = z3Sales2ItemService.selectItemUseNameList(params);
		
		List<Map<String, Object>> item = null;
		params.put("selectUseYn", "Y");
		item = z3Sales2StoreNewService.selectItemListNoDetail(params);
		
		//분류 리스트
		List<Map<String, Object>> class1 = null;
		if (z3Sales2Class1Service.selectSales2Class1Cnt(params) != 0) {			
			class1 = z3Sales2Class1Service.selectSales2Class1(params);
		}
		
		List<Map<String, Object>> class2 = null;
		if (z3Sales2Class2Service.selectSales2Class2Cnt(params) != 0) {
		class2 = z3Sales2Class2Service.selectSales2Class2(params);	
		}
		
		List<Map<String, Object>> class3 = null;
		if (z3Sales2Class3Service.selectSales2Class3Cnt(params) != 0) {
		class3 = z3Sales2Class3Service.selectSales2Class3(params);
		}
		
		List<Map<String, Object>> class4 = null;
		if (z3Sales2Class4Service.selectSales2Class4Cnt(params) != 0) {
		class4 = z3Sales2Class4Service.selectSales2Class4(params);
		}
		
		List<Map<String, Object>> class5 = null;
		if (z3Sales2Class5Service.selectSales2Class5Cnt(params) != 0) {
		class5 = z3Sales2Class5Service.selectSales2Class5(params);
		}
		
		//분류사용명 
		List<Map<String, Object>> class1Nm = null;
		
		class1Nm = z3Sales2Class1Service.selectClass1NameList(params);
		
		List<Map<String, Object>> class2Nm = null;
		
		class2Nm = z3Sales2Class2Service.selectClass2NameList(params);
		
		List<Map<String, Object>> class3Nm = null;
		
		class3Nm = z3Sales2Class3Service.selectClass3NameList(params);
		
		List<Map<String, Object>> class4Nm = null;
		
		class4Nm = z3Sales2Class4Service.selectClass4NameList(params);
		
		List<Map<String, Object>> class5Nm = null;
		
		class5Nm = z3Sales2Class5Service.selectClass5NameList(params);
		
		List<Map<String, Object>> userList = null;
		
		userList = zemosSetupService.zemosSetupEmpList(params);
		
		
		
		//단위
		List<Map<String, Object>> unit = null;
		unit = z3Sales2UnitService.selectSales2Unit(params);

		List<Map<String, Object>> selectStore = null;
		selectStore = z3Sales2StoreNewService.selectStoreNewList(params);
		
		List<Map<String, Object>> selectStoreDetail = null;
		selectStoreDetail = z3Sales2StoreNewService.selectStoreNewDetailList(params);
		
		
		List<Map<String, Object>> selectStoreNewDetailItemList = null;
		selectStoreNewDetailItemList = z3Sales2StoreNewService.selectStoreNewDetailItemList(params);
		
		
		List<Map<String, Object>> selectStoreNewSmList = null;
		selectStoreNewSmList = z3Sales2StoreNewService.selectStoreNewSmList(params);
		
		List<Map<String, Object>> storeList = null;
		params.remove("storeSeq");
		storeList = z3Sales2StoreNewService.selectStoreNewList(params);
		
		model.put("storeList", storeList);
		model.put("selectStoreNewSmList", selectStoreNewSmList);
		model.put("selectStoreNewDetailItemList", selectStoreNewDetailItemList);
		model.put("selectStoreDetail", selectStoreDetail);
		model.put("selectStore", selectStore);
		model.put("itemNm", itemNm);
		model.put("item", item);
		model.put("class1Nm", class1Nm);
		model.put("class2Nm", class2Nm);
		model.put("class3Nm", class3Nm);
		model.put("class4Nm", class4Nm);
		model.put("class5Nm", class5Nm);
		model.put("class1", class1);
		model.put("class2", class2);
		model.put("class3", class3);
		model.put("class4", class4);
		model.put("class5", class5);
		model.put("unit", unit);
		model.put("userList", userList);
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2StoreNewService.selectStoreNewUseNameList(params);
		
		model.put("storeUseName", storeUseName);
		
		return rtnurl;
	}
	@RequestMapping("/zemos3/family/sales2/sales2StoreNewAdd.do")
	public String sales2StoreAdd(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		String rtnurl = "egovframework/zemos3/family/sales2/sales2StoreNewAdd";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
		String storeUseNm = EgovStringUtil.isNullToString(params.get("storeUseNm"));
		String selectUseYn = EgovStringUtil.isNullToString(params.get("selectUseYn"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx")); 
		
		params.put("regUserSeq", loginVO.getIdx());
		
		List<Map<String, Object>> storeList = null;
		
		storeList = z3Sales2StoreNewService.selectStoreNewList(params);

		//분류
		List<Map<String, Object>> itemNm = null;
		itemNm = z3Sales2ItemService.selectItemUseNameList(params);

		List<Map<String, Object>> item = null;
		params.put("selectUseYn", "Y");
		item = z3Sales2StoreNewService.selectItemListNoDetail(params);
		
		//분류 리스트
		List<Map<String, Object>> class1 = null;
		if (z3Sales2Class1Service.selectSales2Class1Cnt(params) != 0) {			
			class1 = z3Sales2Class1Service.selectSales2Class1(params);
		}
		
		List<Map<String, Object>> class2 = null;
		if (z3Sales2Class2Service.selectSales2Class2Cnt(params) != 0) {
		class2 = z3Sales2Class2Service.selectSales2Class2(params);	
		}
		
		List<Map<String, Object>> class3 = null;
		if (z3Sales2Class3Service.selectSales2Class3Cnt(params) != 0) {
		class3 = z3Sales2Class3Service.selectSales2Class3(params);
		}
		
		List<Map<String, Object>> class4 = null;
		if (z3Sales2Class4Service.selectSales2Class4Cnt(params) != 0) {
		class4 = z3Sales2Class4Service.selectSales2Class4(params);
		}
		
		List<Map<String, Object>> class5 = null;
		if (z3Sales2Class5Service.selectSales2Class5Cnt(params) != 0) {
		class5 = z3Sales2Class5Service.selectSales2Class5(params);
		}
		
		//분류사용명 
		List<Map<String, Object>> class1Nm = null;
		
		class1Nm = z3Sales2Class1Service.selectClass1NameList(params);
		
		List<Map<String, Object>> class2Nm = null;
		
		class2Nm = z3Sales2Class2Service.selectClass2NameList(params);
		
		List<Map<String, Object>> class3Nm = null;
		
		class3Nm = z3Sales2Class3Service.selectClass3NameList(params);
		
		List<Map<String, Object>> class4Nm = null;
		
		class4Nm = z3Sales2Class4Service.selectClass4NameList(params);
		
		List<Map<String, Object>> class5Nm = null;
		
		class5Nm = z3Sales2Class5Service.selectClass5NameList(params);
		
		
		List<Map<String, Object>> userList = null;
		
		userList = zemosSetupService.zemosSetupEmpList(params);
		
		//단위
		List<Map<String, Object>> unit = null;
		unit = z3Sales2UnitService.selectSales2Unit(params);
		
		model.put("storeList", storeList);
		model.put("storeNm", storeNm);
		model.put("selectUseYn", selectUseYn);
		model.put("itemNm", itemNm);
		model.put("item", item);
		model.put("class1Nm", class1Nm);
		model.put("class2Nm", class2Nm);
		model.put("class3Nm", class3Nm);
		model.put("class4Nm", class4Nm);
		model.put("class5Nm", class5Nm);
		model.put("class1", class1);
		model.put("class2", class2);
		model.put("class3", class3);
		model.put("class4", class4);
		model.put("class5", class5);
		model.put("unit", unit);
		model.put("userList", userList);
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2StoreNewService.selectStoreNewUseNameList(params);
		
		model.put("storeUseName", storeUseName);
		model.put("storeUseNm", storeUseNm);
		
		return rtnurl;
	}
	@RequestMapping("/zemos3/family/sales2/sales2StoreNewSave.do")
	public ModelAndView sales2StoreSave(ModelMap model,@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2StoreNewAdd";
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		int saveResult = 0;
		
		params.put("regUserSeq", loginVO.getIdx());
		params.put("modUserSeq", loginVO.getIdx());
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
		String offYn = EgovStringUtil.isNullToString(params.get("offYn"));
		String onYn = EgovStringUtil.isNullToString(params.get("onYn"));
		String taxYn = EgovStringUtil.isNullToString(params.get("taxYn"));
		String classYn = EgovStringUtil.isNullToString(params.get("classYn"));
		String useYn = EgovStringUtil.isNullToString(params.get("useYn"));
		String class1 = EgovStringUtil.isNullToString(params.get("class1"));
		String class2 = EgovStringUtil.isNullToString(params.get("class2"));
		String class3 = EgovStringUtil.isNullToString(params.get("class3"));
		String class4 = EgovStringUtil.isNullToString(params.get("class4"));
		String class5 = EgovStringUtil.isNullToString(params.get("class5"));
		String regUserSeq = EgovStringUtil.isNullToString(params.get("regUserSeq"));
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx", zemosIdx);
		insertMap.put("wrkplcIdx", wrkplcIdx);
		insertMap.put("storeNm", storeNm);
		insertMap.put("offYn", offYn);
		insertMap.put("onYn", onYn);
		insertMap.put("taxYn", taxYn);
		insertMap.put("classYn", classYn);
		insertMap.put("useYn", useYn);
		insertMap.put("class1", class1);
		insertMap.put("class2", class2);
		insertMap.put("class3", class3);
		insertMap.put("class4", class4);
		insertMap.put("class5", class5);
		insertMap.put("regUserSeq", regUserSeq);
		
		saveResult = z3Sales2StoreNewService.storeInsert(insertMap);
		
		Map<String, Object> insertDetailMap = new HashMap<String, Object>();
		String unitSeq1 = EgovStringUtil.isNullToString(params.get("unitSeq1"));
		String unitSeq2 = EgovStringUtil.isNullToString(params.get("unitSeq2"));
		String unitSeq3 = EgovStringUtil.isNullToString(params.get("unitSeq3"));
		String unitSeq4 = EgovStringUtil.isNullToString(params.get("unitSeq4"));
		String unitSeq5 = EgovStringUtil.isNullToString(params.get("unitSeq5"));
		String unit1Yn = EgovStringUtil.isNullToString(params.get("unit1Yn"));
		String unit2Yn = EgovStringUtil.isNullToString(params.get("unit2Yn"));
		String unit3Yn = EgovStringUtil.isNullToString(params.get("unit3Yn"));
		String unit4Yn = EgovStringUtil.isNullToString(params.get("unit4Yn"));
		String unit5Yn = EgovStringUtil.isNullToString(params.get("unit5Yn"));
		
		insertDetailMap.put("storeSeq", insertMap.get("store_seq"));
		insertDetailMap.put("zemosIdx", zemosIdx);
		insertDetailMap.put("wrkplcIdx", wrkplcIdx);
		insertDetailMap.put("unitSeq1", unitSeq1);
		insertDetailMap.put("unitSeq2", unitSeq2);
		insertDetailMap.put("unitSeq3", unitSeq3);
		insertDetailMap.put("unitSeq4", unitSeq4);
		insertDetailMap.put("unitSeq5", unitSeq5);
		insertDetailMap.put("unit1Yn", unit1Yn);
		insertDetailMap.put("unit2Yn", unit2Yn);
		insertDetailMap.put("unit3Yn", unit3Yn);
		insertDetailMap.put("unit4Yn", unit4Yn);
		insertDetailMap.put("unit5Yn", unit5Yn);
		insertDetailMap.put("regUserSeq", regUserSeq);
		
		z3Sales2StoreNewService.storeDetailInsert(insertDetailMap);
		insertDetailMap.get("store_detail_seq");
		
		
		for(String key : params.keySet()){
			if(key.indexOf("item")==0){
				Map<String, Object> itemInsertMap = new HashMap<String, Object>();
				
				itemInsertMap.put("itemSeq", params.get(key).toString().split(",")[0]);
				itemInsertMap.put("itemCode", params.get(key).toString().split(",")[1]);
				itemInsertMap.put("itemUseYn", params.get(key).toString().split(",")[2]);
				System.out.println(params.get(key).toString());
				itemInsertMap.put("storeSeq", insertMap.get("store_seq"));
				itemInsertMap.put("storeDetailSeq", insertDetailMap.get("store_detail_seq"));
				itemInsertMap.put("zemosIdx", zemosIdx);
				itemInsertMap.put("wrkplcIdx", wrkplcIdx);
				itemInsertMap.put("regUserSeq", regUserSeq);
				z3Sales2StoreNewService.storeItemInsert(itemInsertMap);
			}
			if(key.indexOf("sm")==0){
				Map<String, Object> smInsertMap = new HashMap<String, Object>();
				smInsertMap.put("sabun", params.get(key).toString().split(",")[0]);
				smInsertMap.put("uploadYn", params.get(key).toString().split(",")[1]);
				smInsertMap.put("approvalYn", params.get(key).toString().split(",")[2]);
				
				smInsertMap.put("storeSeq", insertMap.get("store_seq"));
				smInsertMap.put("zemosIdx", zemosIdx);
				smInsertMap.put("wrkplcIdx", wrkplcIdx);
				smInsertMap.put("regUserSeq", regUserSeq);
				z3Sales2StoreNewService.storeSmInsert(smInsertMap);
			}
		}
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
	@RequestMapping("/zemos3/family/sales2/sales2StoreNewUpdate.do")
	public ModelAndView sales2StoreNewUpdate(ModelMap model,@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		int saveResult = 0;
		
		params.put("regUserSeq", loginVO.getIdx());
		params.put("modUserSeq", loginVO.getIdx());
				
		String storeDetailSeq = EgovStringUtil.isNullToString(params.get("storeDetailSeq"));
		String storeSeq = EgovStringUtil.isNullToString(params.get("storeSeq"));
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
		String offYn = EgovStringUtil.isNullToString(params.get("offYn"));
		String onYn = EgovStringUtil.isNullToString(params.get("onYn"));
		String taxYn = EgovStringUtil.isNullToString(params.get("taxYn"));
		String classYn = EgovStringUtil.isNullToString(params.get("classYn"));
		String useYn = EgovStringUtil.isNullToString(params.get("useYn"));
		String class1 = EgovStringUtil.isNullToString(params.get("class1"));
		String class2 = EgovStringUtil.isNullToString(params.get("class2"));
		String class3 = EgovStringUtil.isNullToString(params.get("class3"));
		String class4 = EgovStringUtil.isNullToString(params.get("class4"));
		String class5 = EgovStringUtil.isNullToString(params.get("class5"));
		String regUserSeq = EgovStringUtil.isNullToString(params.get("regUserSeq"));
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("storeSeq", storeSeq);
		insertMap.put("zemosIdx", zemosIdx);
		insertMap.put("wrkplcIdx", wrkplcIdx);
		insertMap.put("storeNm", storeNm);
		insertMap.put("offYn", offYn);
		insertMap.put("onYn", onYn);
		insertMap.put("taxYn", taxYn);
		insertMap.put("classYn", classYn);
		insertMap.put("useYn", useYn);
		insertMap.put("class1", class1);
		insertMap.put("class2", class2);
		insertMap.put("class3", class3);
		insertMap.put("class4", class4);
		insertMap.put("class5", class5);
		insertMap.put("regUserSeq", regUserSeq);
		
		saveResult = z3Sales2StoreNewService.storeUpdate(insertMap);
		
		Map<String, Object> insertDetailMap = new HashMap<String, Object>();
		String unitSeq1 = EgovStringUtil.isNullToString(params.get("unitSeq1"));
		String unitSeq2 = EgovStringUtil.isNullToString(params.get("unitSeq2"));
		String unitSeq3 = EgovStringUtil.isNullToString(params.get("unitSeq3"));
		String unitSeq4 = EgovStringUtil.isNullToString(params.get("unitSeq4"));
		String unitSeq5 = EgovStringUtil.isNullToString(params.get("unitSeq5"));
		String unit1Yn = EgovStringUtil.isNullToString(params.get("unit1Yn"));
		String unit2Yn = EgovStringUtil.isNullToString(params.get("unit2Yn"));
		String unit3Yn = EgovStringUtil.isNullToString(params.get("unit3Yn"));
		String unit4Yn = EgovStringUtil.isNullToString(params.get("unit4Yn"));
		String unit5Yn = EgovStringUtil.isNullToString(params.get("unit5Yn"));
		
		insertDetailMap.put("storeDetailSeq", storeDetailSeq);
		insertDetailMap.put("storeSeq", storeSeq);
		insertDetailMap.put("zemosIdx", zemosIdx);
		insertDetailMap.put("wrkplcIdx", wrkplcIdx);
		insertDetailMap.put("unitSeq1", unitSeq1);
		insertDetailMap.put("unitSeq2", unitSeq2);
		insertDetailMap.put("unitSeq3", unitSeq3);
		insertDetailMap.put("unitSeq4", unitSeq4);
		insertDetailMap.put("unitSeq5", unitSeq5);
		insertDetailMap.put("unit1Yn", unit1Yn);
		insertDetailMap.put("unit2Yn", unit2Yn);
		insertDetailMap.put("unit3Yn", unit3Yn);
		insertDetailMap.put("unit4Yn", unit4Yn);
		insertDetailMap.put("unit5Yn", unit5Yn);
		insertDetailMap.put("regUserSeq", regUserSeq);
		
		z3Sales2StoreNewService.storeDetailUpdate(insertDetailMap);
		List<Map<String, Object>> userList = null;
		Map<String, Object> userDeleteYn = new HashMap<String, Object>();
		
		userList = z3Sales2StoreNewService.selectStoreNewSmList(params);
		
		
		for(Map<String, Object> user : userList){
				userDeleteYn.put(user.get("sabun").toString(), user.get("deleteYn"));
		}
		List<Map<String, Object>> itemList = null;
		itemList = z3Sales2StoreNewService.selectItemListNoDetail(params);
		Map<String, Object> items = new HashMap<String, Object>();
		for(Map<String, Object> item : itemList){
			items.put(EgovStringUtil.isNullToString(item.get("itemSeq")), EgovStringUtil.isNullToString(item.get("itemSeq")));
		}
		for(String key : params.keySet()){
			if(key.indexOf("item")==0){
				Map<String, Object> itemInsertMap = new HashMap<String, Object>();
				
				itemInsertMap.put("itemSeq", params.get(key).toString().split(",")[0]);
				itemInsertMap.put("itemCode", params.get(key).toString().split(",")[1]);
				itemInsertMap.put("itemUseYn", params.get(key).toString().split(",")[2]);
				
				itemInsertMap.put("storeSeq", storeSeq);
				itemInsertMap.put("storeDetailSeq", storeDetailSeq);
				itemInsertMap.put("zemosIdx", zemosIdx);
				itemInsertMap.put("wrkplcIdx", wrkplcIdx);
				itemInsertMap.put("regUserSeq", regUserSeq);
				if(EgovStringUtil.isNullToString(items.get(itemInsertMap.get("itemSeq").toString())).equals(itemInsertMap.get("itemSeq").toString())){					
					z3Sales2StoreNewService.storeDetailItemUpdate(itemInsertMap);
				}else{
					z3Sales2StoreNewService.storeItemInsert(itemInsertMap);
				}
			}
			if(key.indexOf("sm")==0){
				Map<String, Object> smInsertMap = new HashMap<String, Object>();
				smInsertMap.put("sabun", params.get(key).toString().split(",")[0]);
				smInsertMap.put("uploadYn", params.get(key).toString().split(",")[1]);
				smInsertMap.put("approvalYn", params.get(key).toString().split(",")[2]);
				System.out.println();
				smInsertMap.put("storeSeq", storeSeq);
				smInsertMap.put("zemosIdx", zemosIdx);
				smInsertMap.put("wrkplcIdx", wrkplcIdx);
				smInsertMap.put("regUserSeq", regUserSeq);
				if(EgovStringUtil.isNullToString(userDeleteYn.get(smInsertMap.get("sabun"))).equals("")){
					smInsertMap.put("deleteYn", "N");
					z3Sales2StoreNewService.storeSmInsert(smInsertMap);
				}else{
					smInsertMap.put("deleteYn", "N");
					z3Sales2StoreNewService.storeSmUpdate(smInsertMap);
					userDeleteYn.remove(smInsertMap.get("sabun"));
				}
			}
		}
		if(userDeleteYn.size() != 0){			
			for(String key : userDeleteYn.keySet()){
				Map<String, Object> smInsertMap = new HashMap<String, Object>();
				smInsertMap.put("sabun", key);
				smInsertMap.put("deleteYn", "Y");
				smInsertMap.put("storeSeq", storeSeq);
				smInsertMap.put("zemosIdx", zemosIdx);
				smInsertMap.put("wrkplcIdx", wrkplcIdx);
				smInsertMap.put("regUserSeq", regUserSeq);
				z3Sales2StoreNewService.storeSmDeleteYnUpdate(smInsertMap);
			}
		}
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
}
