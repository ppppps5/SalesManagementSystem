package egovframework.zemos3.family.sales2.web;

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
import egovframework.zemos3.family.sales2.service.Z3Sales2ClassService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;


/**
 * 판매실적관리 분류1 Controller
 * 
 * @author 이엠룩
 * @since 2022.09.02
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.09.02  이엠룩          최초 생성 
 *  </pre>
 */
@Controller
public class Z3Sales2ClassController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2ClassController.class);

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
	
	// 품목/분류명 관리 Service
	@Resource(name = "z3Sales2ClassService")
	private Z3Sales2ClassService z3Sales2ClassService;
	
	/**
	 * 품목/분류명 관리 메인 화면 조회
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2Class.do")
	public String sales2Class(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Class";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String UseYn1 = EgovStringUtil.isNullToString(params.get("UseYn1"));
		String UseYn2 = EgovStringUtil.isNullToString(params.get("UseYn2"));
		String UseYn3 = EgovStringUtil.isNullToString(params.get("UseYn3"));
		String UseYn4 = EgovStringUtil.isNullToString(params.get("UseYn4"));
		String UseYn5 = EgovStringUtil.isNullToString(params.get("UseYn5"));
		
		List<Map<String, Object>> storeNmList = null;
		List<Map<String, Object>> itemNmList = null;
		List<Map<String, Object>> class1NmList = null;
		List<Map<String, Object>> class2NmList = null;
		List<Map<String, Object>> class3NmList = null;
		List<Map<String, Object>> class4NmList = null;
		List<Map<String, Object>> class5NmList = null;
		
		storeNmList = z3Sales2ClassService.selectStoreNmList(params);
		itemNmList = z3Sales2ClassService.selectItemNmList(params);
		class1NmList = z3Sales2ClassService.selectSales2Class1Nm(params);
		class2NmList = z3Sales2ClassService.selectSales2Class2Nm(params);
		class3NmList = z3Sales2ClassService.selectSales2Class3Nm(params);
		class4NmList = z3Sales2ClassService.selectSales2Class4Nm(params);
		class5NmList = z3Sales2ClassService.selectSales2Class5Nm(params);
		
		model.put("storeNmList", storeNmList);
		model.put("itemNmList", itemNmList);
		model.put("class1NmList", class1NmList);
		model.put("class2NmList", class2NmList);
		model.put("class3NmList", class3NmList);
		model.put("class4NmList", class4NmList);
		model.put("class5NmList", class5NmList);
		
		model.put("UseYn1", UseYn1);
		model.put("UseYn2", UseYn2);
		model.put("UseYn3", UseYn3);
		model.put("UseYn4", UseYn4);
		model.put("UseYn5", UseYn5);
		
		return rtnurl;
	}
	
	/**
	 * 품목/분류명 관리 메인 화면 데이터 저장
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/zemos3/family/sales2/classSave.do")
	public ModelAndView classSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		
		String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
		String itemNm = EgovStringUtil.isNullToString(params.get("itemNm"));
		String class1Nm = EgovStringUtil.isNullToString(params.get("class1Nm"));
		String class2Nm = EgovStringUtil.isNullToString(params.get("class2Nm"));
		String class3Nm = EgovStringUtil.isNullToString(params.get("class3Nm"));
		String class4Nm = EgovStringUtil.isNullToString(params.get("class4Nm"));
		String class5Nm = EgovStringUtil.isNullToString(params.get("class5Nm"));
		
		String useYn1 = EgovStringUtil.isNullToString(params.get("useYn1"));
		String useYn2 = EgovStringUtil.isNullToString(params.get("useYn2"));
		String useYn3 = EgovStringUtil.isNullToString(params.get("useYn3"));
		String useYn4 = EgovStringUtil.isNullToString(params.get("useYn4"));
		String useYn5 = EgovStringUtil.isNullToString(params.get("useYn5"));
		
		
		String storeNmSaveGbn = EgovStringUtil.isNullToString(params.get("storeNmSaveGbn"));
		String itemNmSaveGbn = EgovStringUtil.isNullToString(params.get("itemNmSaveGbn"));
		String class1SaveGbn = EgovStringUtil.isNullToString(params.get("class1SaveGbn"));
		String class2SaveGbn = EgovStringUtil.isNullToString(params.get("class2SaveGbn"));
		String class3SaveGbn = EgovStringUtil.isNullToString(params.get("class3SaveGbn"));
		String class4SaveGbn = EgovStringUtil.isNullToString(params.get("class4SaveGbn"));
		String class5SaveGbn = EgovStringUtil.isNullToString(params.get("class5SaveGbn"));
		
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx"  , EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx" , EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("storeNm"  , EgovStringUtil.isNullToString(params.get("storeNm")));
		insertMap.put("itemNm"   , EgovStringUtil.isNullToString(params.get("itemNm")));
		insertMap.put("class1Nm"  , EgovStringUtil.isNullToString(params.get("class1Nm")));
		insertMap.put("class2Nm"  , EgovStringUtil.isNullToString(params.get("class2Nm")));
		insertMap.put("class3Nm"  , EgovStringUtil.isNullToString(params.get("class3Nm")));
		insertMap.put("class4Nm"  , EgovStringUtil.isNullToString(params.get("class4Nm")));
		insertMap.put("class5Nm"  , EgovStringUtil.isNullToString(params.get("class5Nm")));
		
		insertMap.put("useYn1"    , EgovStringUtil.isNullToString(params.get("useYn1")));
		insertMap.put("useYn2"    , EgovStringUtil.isNullToString(params.get("useYn2")));
		insertMap.put("useYn3"    , EgovStringUtil.isNullToString(params.get("useYn3")));
		insertMap.put("useYn4"    , EgovStringUtil.isNullToString(params.get("useYn4")));
		insertMap.put("useYn5"    , EgovStringUtil.isNullToString(params.get("useYn5")));
		
		insertMap.put("storeNmSaveGbn"    , EgovStringUtil.isNullToString(params.get("storeNmSaveGbn")));
		insertMap.put("itemNmSaveGbn"    , EgovStringUtil.isNullToString(params.get("itemNmSaveGbn")));
		insertMap.put("class1SaveGbn"    , EgovStringUtil.isNullToString(params.get("class1SaveGbn")));
		insertMap.put("class2SaveGbn"    , EgovStringUtil.isNullToString(params.get("class2SaveGbn")));
		insertMap.put("class3SaveGbn"    , EgovStringUtil.isNullToString(params.get("class3SaveGbn")));
		insertMap.put("class4SaveGbn"    , EgovStringUtil.isNullToString(params.get("class4SaveGbn")));
		insertMap.put("class5SaveGbn"    , EgovStringUtil.isNullToString(params.get("class5SaveGbn")));
		
		
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int storeNmSaveResult = 0;
		int itemNmSaveResult = 0;
		int class1NmSaveResult = 0;
		int class2NmSaveResult = 0;
		int class3NmSaveResult = 0;
		int class4NmSaveResult = 0;
		int class5NmSaveResult = 0;
		int cnt1 = 0;
		cnt1 = z3Sales2ClassService.selectSales2Class1NmCnt(params);
		int cnt2 = 0;
		cnt2 = z3Sales2ClassService.selectSales2Class2NmCnt(params);
		int cnt3 = 0;
		cnt3 = z3Sales2ClassService.selectSales2Class3NmCnt(params);
		int cnt4 = 0;
		cnt4 = z3Sales2ClassService.selectSales2Class4NmCnt(params);
		int cnt5 = 0;
		cnt5 = z3Sales2ClassService.selectSales2Class5NmCnt(params);
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("storeNmSaveGbn"))) ) {
			//insert
			storeNmSaveResult = z3Sales2ClassService.storeNmInsert(params);
			
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("storeNmSaveGbn"))) ) {
			//update
			storeNmSaveResult = z3Sales2ClassService.storeNmUpdate(insertMap);
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("itemNmSaveGbn"))) ) {
			//insert
			itemNmSaveResult = z3Sales2ClassService.itemNmInsert(params);
			
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("itemNmSaveGbn"))) ) {
			//update
			itemNmSaveResult = z3Sales2ClassService.itemNmUpdate(insertMap);
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("class1SaveGbn"))) ) {
			//insert			
			if(cnt1 == 0){
				class1NmSaveResult = z3Sales2ClassService.class1NmInsert(params);
			  }else{
				  class1NmSaveResult = z3Sales2ClassService.class1NmUpdate(insertMap);
			  }
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("class1SaveGbn"))) ) {
			//update
			if(cnt1 == 0){
				class1NmSaveResult = z3Sales2ClassService.class1NmInsert(params);
			}else{
				class1NmSaveResult = z3Sales2ClassService.class1NmUpdate(insertMap);
			}		
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("class2SaveGbn"))) ) {
			//insert
			if(cnt2 == 0){
				class2NmSaveResult = z3Sales2ClassService.class2NmInsert(params);
			}else{
				class2NmSaveResult = z3Sales2ClassService.class2NmUpdate(insertMap);
			}
			
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("class2SaveGbn"))) ) {
			//update
			if(cnt2 == 0){
				class2NmSaveResult = z3Sales2ClassService.class2NmInsert(params);
			}else{
				class2NmSaveResult = z3Sales2ClassService.class2NmUpdate(insertMap);
			}
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("class3SaveGbn"))) ) {
			//insert
			if(cnt3 == 0){
				class3NmSaveResult = z3Sales2ClassService.class3NmInsert(params);
			}else{
				class3NmSaveResult = z3Sales2ClassService.class3NmUpdate(insertMap);
			}			
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("class3SaveGbn"))) ) {
			//update
			if(cnt3 == 0){
				class3NmSaveResult = z3Sales2ClassService.class3NmInsert(params);
			}else{
				class3NmSaveResult = z3Sales2ClassService.class3NmUpdate(insertMap);
			}
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("class4SaveGbn"))) ) {
			//insert
			if(cnt4 == 0){
				class4NmSaveResult = z3Sales2ClassService.class4NmInsert(params);
			}else{
				class4NmSaveResult = z3Sales2ClassService.class4NmUpdate(insertMap);
			}
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("class4SaveGbn"))) ) {
			//update
			if(cnt4 == 0){
				class4NmSaveResult = z3Sales2ClassService.class4NmInsert(params);
			}else{
				class4NmSaveResult = z3Sales2ClassService.class4NmUpdate(insertMap);
			}
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("class5SaveGbn"))) ) {
			//insert
			if(cnt5 == 0){
				class5NmSaveResult = z3Sales2ClassService.class5NmInsert(params);
			}else{
				class5NmSaveResult = z3Sales2ClassService.class5NmUpdate(insertMap);
			}
			
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("class5SaveGbn"))) ) {
			//update
			if(cnt5 == 0){
				class5NmSaveResult = z3Sales2ClassService.class5NmInsert(params);
			}else{
				class5NmSaveResult = z3Sales2ClassService.class5NmUpdate(insertMap);
			}
		}
		
		// 리턴
		modelAndView.addObject("result", true);
		
		model.put("ssresultResponse", storeNmSaveResult);
		model.put("isresultResponse", itemNmSaveResult);
		model.put("c1resultResponse", class1NmSaveResult);
		model.put("c2resultResponse", class2NmSaveResult);
		model.put("c3resultResponse", class3NmSaveResult);
		model.put("c4resultResponse", class4NmSaveResult);
		model.put("c5resultResponse", class5NmSaveResult);
		
		return modelAndView;
	}
	
}
