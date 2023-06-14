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
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;


/**
 * 판매실적관리 품목 Controller
 * 
 * @author 이엠룩
 * @since 2021.08.13
 * @version 1.0
 * @see 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2021.08.13  이엠룩          최초 생성 
 *  </pre>
 */
@Controller
public class Z3Sales2ItemController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2Class1Controller.class);

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

	//품목 Service
	@Resource(name = "z3Sales2ItemService")
	private Z3Sales2ItemService z3Sales2ItemService;
	
	//매장 Service
	@Resource(name = "z3Sales2StoreService")
	private Z3Sales2StoreService z3Sales2StoreService;
	
	/**
	 * 품목 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2Item.do")
	public String sales2Item(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Item";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String itemNm = EgovStringUtil.isNullToString(params.get("itemNm"));
		String unitSeq = EgovStringUtil.isNullToString(params.get("unitSeq"));
		String itemSeq = EgovStringUtil.isNullToString(params.get("itemSeq"));
		String itemUseNm = EgovStringUtil.isNullToString(params.get("itemUseNm"));
		String selectUseYn = EgovStringUtil.isNullToString(params.get("selectUseYn"));
		
		params.put("regUserSeq", loginVO.getIdx());
		
		int resultListCnt = 0;
		int unitcnt = 0;
		
		unitcnt = z3Sales2ItemService.selectUnitListCnt(params);
		
		List<Map<String, Object>> unitList = null;
		unitList = z3Sales2ItemService.selectUnitList(params);
		
		List<Map<String, Object>> itemList = null;
		itemList = z3Sales2ItemService.selectItemList(params);
		
		List<Map<String, Object>> itemDetailList = null;
		itemDetailList = z3Sales2ItemService.selectItemDetailList(params);
		
		List<Map<String, Object>> itemUseName = null;
		itemUseName = z3Sales2ItemService.selectItemUseNameList(params);
		
		model.put("unitcnt", unitcnt);
		model.put("unitSeq", unitSeq);
		model.put("unitList", unitList);
		model.put("itemSeq", itemSeq);
		model.put("itemList", itemList);
		model.put("itemDetailList", itemDetailList);
		model.put("itemNm", itemNm);
		model.put("selectUseYn", selectUseYn);
		model.put("itemUseName", itemUseName);
		model.put("itemUseNm", itemUseNm);
		
		return rtnurl;
	}
	
	//품목등록
		@RequestMapping("/zemos3/family/sales2/sales2ItemSave.do")
		public ModelAndView sales2ItemSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

			ModelAndView modelAndView = new ModelAndView("jsonView");
			
			modelAndView.addObject("result", false);
			
			// 로그인 정보
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			int saveResult = 0;
			int saveResult01 = 0;
			int saveItemResult = 0;
			
			params.put("regUserSeq", loginVO.getIdx());
			params.put("modUserSeq", loginVO.getIdx());
			
			int unitcnt = 0;
			System.out.println("여기");
			System.out.println(params);
			unitcnt = z3Sales2ItemService.selectUnitListCnt(params);
			
			String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
			String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
			String itemNm = EgovStringUtil.isNullToString(params.get("itemNm"));
			String itemCode = EgovStringUtil.isNullToString(params.get("itemCode"));
			String unitCost = EgovStringUtil.isNullToString(params.get("unitCost"));
			String unitSeq = EgovStringUtil.isNullToString(params.get("unitSeq"));
			
			String unitSeq0 = EgovStringUtil.isNullToString(params.get("unitSeq0"));
			String unitSeq1 = EgovStringUtil.isNullToString(params.get("unitSeq1"));
			String unitSeq2 = EgovStringUtil.isNullToString(params.get("unitSeq2"));
			String unitSeq3 = EgovStringUtil.isNullToString(params.get("unitSeq3"));
			String unitSeq4 = EgovStringUtil.isNullToString(params.get("unitSeq4"));
			
			String unitCost0 = EgovStringUtil.isNullToString(params.get("unitCost0"));			
			String unitCost1 = EgovStringUtil.isNullToString(params.get("unitCost1"));			
			String unitCost2 = EgovStringUtil.isNullToString(params.get("unitCost2"));			
			String unitCost3 = EgovStringUtil.isNullToString(params.get("unitCost3"));			
			String unitCost4 = EgovStringUtil.isNullToString(params.get("unitCost4"));
			
			
			String itemDetailSeq = EgovStringUtil.isNullToString(params.get("itemDetailSeq"));
			String useYn = EgovStringUtil.isNullToString(params.get("useYn"));
			String itemSeq = EgovStringUtil.isNullToString(params.get("itemSeq"));
			String saveGbn = EgovStringUtil.isNullToString(params.get("saveGbn"));
			String saveGbn01 = EgovStringUtil.isNullToString(params.get("saveGbn01"));
			String saveGbn0 = EgovStringUtil.isNullToString(params.get("saveGbn0"));
			
			Map<String, Object> insertMap = new HashMap<String, Object>();
			insertMap.put("zemosIdx", zemosIdx);
			insertMap.put("wrkplcIdx", wrkplcIdx);
			insertMap.put("itemNm", itemNm);
			insertMap.put("itemCode", itemCode);
			insertMap.put("unitCost", unitCost);
			insertMap.put("unitSeq", unitSeq);
			
			insertMap.put("unitSeq0", unitSeq0);
			insertMap.put("unitSeq1", unitSeq1);
			insertMap.put("unitSeq2", unitSeq2);
			insertMap.put("unitSeq3", unitSeq3);
			insertMap.put("unitSeq4", unitSeq4);
			
			insertMap.put("unitCost0", unitCost0);			
			insertMap.put("unitCost1", unitCost1);			
			insertMap.put("unitCost2", unitCost2);			
			insertMap.put("unitCost3", unitCost3);			
			insertMap.put("unitCost4", unitCost4);
			
			insertMap.put("itemDetailSeq", itemDetailSeq);
			insertMap.put("useYn", useYn);
			insertMap.put("itemSeq", itemSeq);
			insertMap.put("regUserSeq", loginVO.getIdx());
			insertMap.put("modUserSeq", loginVO.getIdx());
			
			int cnt = 0;
			cnt = z3Sales2ItemService.selectItem(insertMap);
			
			int cnt1 = 0;
			cnt1 = z3Sales2StoreService.selectStore(insertMap);
			
			if(saveGbn.equals("insert")){
				if ( cnt > 0 ) {
					//throw new Exception();
					cnt = z3Sales2ItemService.selectItem(insertMap);
					modelAndView.addObject("result", false);
					model.put("resultError", "1");
					return modelAndView;
				}
			}
			
			
			// 매장등록 여부 체크
			//if ( cnt1 > 0 ) {
				//modelAndView.addObject("result", false);
				//model.put("resultError", "2");
				//return modelAndView;
			//}
			
			if ( "insert".equals(saveGbn) ) {
				if ( "noitem".equals(saveGbn01) ) {
					saveResult = z3Sales2ItemService.itemInsert(insertMap);
				}
				if ( "item".equals(saveGbn01) ) {
					saveResult = z3Sales2ItemService.itemInsert(insertMap);
						saveResult01 = z3Sales2ItemService.itemDetailInsertD(insertMap);
						saveResult01 = z3Sales2ItemService.itemDetailInsert(insertMap);
						saveResult01 = z3Sales2ItemService.itemDetailDeleteD(insertMap);
				}
				
				if ( cnt1 > 0 ) {
					saveItemResult = z3Sales2ItemService.StoreitemInsert(insertMap);
				}
			} else if ( "update".equals(saveGbn) ) {
				
				
				if ("detail".equals(saveGbn01) ){					
					saveResult01 = z3Sales2ItemService.itemDetailUpdate(insertMap);
					//saveResult = z3Sales2ItemService.itemUpdate(insertMap);
					if ( cnt1 > 0 ) {
						saveItemResult = z3Sales2ItemService.StoreitemUpdate(insertMap); 
					}
				}else {
					saveResult = z3Sales2ItemService.itemUpdate(insertMap);
					if ( cnt1 > 0 ) {
						saveItemResult = z3Sales2ItemService.StoreitemUpdate(insertMap); 
					}
				}
				
			}
			
			// 리턴
			modelAndView.addObject("result", true);
			model.put("resultResponse", saveResult);
			
			return modelAndView;
		}
	
}