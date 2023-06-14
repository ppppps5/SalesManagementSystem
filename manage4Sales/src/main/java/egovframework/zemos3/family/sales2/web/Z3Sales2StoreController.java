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
import egovframework.zemos3.family.sales.service.Z3SalesChannelService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class1Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class2Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class3Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;


/**
 * 판매실적관리 매장관리 Controller
 * 
 * @author 이엠룩
 * @since 2021.08.13
 * @version 2.0
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
public class Z3Sales2StoreController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2StoreController.class);

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
	protected Z3Sales2ItemService z3Sales2ItemService;
	
	//Class1 Service
	@Resource(name = "z3Sales2Class1Service")
	protected Z3Sales2Class1Service z3Sales2Class1Service;
	
	//Class2 Service
	@Resource(name = "z3Sales2Class2Service")
	protected Z3Sales2Class2Service z3Sales2Class2Service;
		
	//Class3 Service
	@Resource(name = "z3Sales2Class3Service")
	protected Z3Sales2Class3Service z3Sales2Class3Service;	
	
	//채널설정 Service
	@Resource(name = "z3SalesChannelService")
	protected Z3SalesChannelService z3SalesChannelService;
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreService")
	private Z3Sales2StoreService z3Sales2StoreService;	
	
	/**
	 * 매장조회
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Store.do")
	public String sales2Store(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Store";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
		String selectUseYn = EgovStringUtil.isNullToString(params.get("selectUseYn"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		
		params.put("regUserSeq", loginVO.getIdx());
		
		List<Map<String, Object>> storeList = null;
		List<Map<String, Object>> storeClass1List = null;
		List<Map<String, Object>> storeClass2List = null;
		List<Map<String, Object>> storeClass3List = null;
		List<Map<String, Object>> storeuserList = null;
		
		storeList = z3Sales2StoreService.selectStoreList(params);
		
		//params.put("selectUseYn", "Y");
		
		storeClass1List = z3Sales2Class1Service.selectSales2Class01(params);
		
		storeClass2List = z3Sales2Class2Service.selectSales2Class02(params);
		
		storeClass3List = z3Sales2Class3Service.selectSales2Class03(params);
		
		storeuserList = z3Sales2StoreService.storeuserList(params);
		
		model.put("storeList", storeList);
		model.put("storeClass1List", storeClass1List);
		model.put("storeClass2List", storeClass2List);
		model.put("storeClass3List", storeClass3List);
		model.put("storeuserList", storeuserList);
		model.put("storeNm", storeNm);
		model.put("selectUseYn", selectUseYn);
		
		return rtnurl;
	}
	//매장등록
		@RequestMapping("/zemos3/family/sales2/sales2StoreSave.do")
		public ModelAndView sales2StoreSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

			ModelAndView modelAndView = new ModelAndView("jsonView");
			
			modelAndView.addObject("result", false);
			
			// 로그인 정보
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			int saveResult = 0;
			
			params.put("regUserSeq", loginVO.getIdx());
			params.put("modUserSeq", loginVO.getIdx());
			
			String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
			String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
			String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
			String class1 = EgovStringUtil.isNullToString(params.get("class1"));
			String class2 = EgovStringUtil.isNullToString(params.get("class2"));
			String class3 = EgovStringUtil.isNullToString(params.get("class3"));
			String sabun = EgovStringUtil.isNullToString(params.get("sabun"));
			String sabun2 = EgovStringUtil.isNullToString(params.get("sabun2"));
			String classyn = EgovStringUtil.isNullToString(params.get("classyn"));
			String useYn = EgovStringUtil.isNullToString(params.get("useYn"));
			String saveGbn = EgovStringUtil.isNullToString(params.get("saveGbn"));
			
			Map<String, Object> insertMap = new HashMap<String, Object>();
			insertMap.put("zemosIdx", zemosIdx);
			insertMap.put("wrkplcIdx", wrkplcIdx);
			insertMap.put("storeNm", storeNm);
			insertMap.put("class1", class1);
			insertMap.put("class2", class2);
			insertMap.put("class3", class3);
			insertMap.put("sabun", sabun);
			insertMap.put("sabun2", sabun2);
			insertMap.put("classyn", classyn);
			insertMap.put("useYn", useYn);
			insertMap.put("regUserSeq", loginVO.getIdx());
			insertMap.put("modUserSeq", loginVO.getIdx());
			
			int cnt = 0;
			cnt = z3Sales2StoreService.selectStore(insertMap);
			
			int cnt1 = 0;
			cnt1 = z3Sales2ItemService.selectItem(insertMap);
			
			if ( "insert".equals(saveGbn) ) {
				//동일한 내용이 있으면 리턴
				insertMap.put("storeNm", storeNm);
				cnt = z3Sales2StoreService.selectStore(insertMap);
				if ( cnt > 0 ) {
					System.out.println("############### insert ###############");
					//throw new Exception();
					modelAndView.addObject("result", false);
					model.put("resultError", "1");
					return modelAndView;
				}
				//품목이 내용이 없으면 리턴
				if ( cnt1 == 0 ) {
					System.out.println("############### insert ###############");
					//throw new Exception();
					modelAndView.addObject("result", false);
					model.put("resultError", "2");
					return modelAndView;
				}
				
				saveResult = z3Sales2StoreService.storeInsert(insertMap);
			} else if ( "update".equals(saveGbn) ) {
				insertMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
				saveResult = z3Sales2StoreService.storeUpdate(insertMap);
			}
			
			// 리턴
			modelAndView.addObject("result", true);
			model.put("resultResponse", saveResult);
			
			return modelAndView;
		}
		
		@RequestMapping("/zemos3/family/sales2/sales2StoreDetail.do")
		public String sales2StoreDetail(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			String rtnurl = "egovframework/zemos3/family/sales2/sales2StoreDetail";

			// 로그인 정보
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			// 권한
			List<String> resultAuth = zemosService.zemosAuth(params);
			model.put("resultAuth", resultAuth);
			
			String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
			String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
			String storeSeq = EgovStringUtil.isNullToString(params.get("storeSeq"));
			String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
			
			List<Map<String, Object>> storeList = null;
			storeList = z3Sales2StoreService.selectStoreList(params);
			
			List<Map<String, Object>> selectBoxStoreList = null;
			selectBoxStoreList = z3Sales2StoreService.selectBoxStoreList(params);
			
			Map<String, Object> storeDetail = null;
			storeDetail = z3Sales2StoreService.selectStoreDetail(params);			
			
			List<Map<String, Object>> storeDetailAllItem = null;
			String itemUseYn = EgovStringUtil.isNullToString(params.get("itemUseYn"));
			params.put("itemUseYn", "K");
			storeDetailAllItem = z3Sales2StoreService.selectStoreDetailItem(params);
			
			Map<String, Object> selectStoreDetailCnt = null;
			//selectStoreDetailCnt = z3Sales2StoreService.selectStoreDetailCnt(params);
			
			int cnt = 0;
			cnt = z3Sales2StoreService.storeDetailItemCnt(params);
			
			List<Map<String, Object>> storeDetailItem = null;
			
			if ( cnt > 0 ) {			
			params.put("itemUseYn", itemUseYn);
			storeDetailItem = z3Sales2StoreService.selectStoreDetailItem(params);
			}else{
				storeDetailItem	= z3Sales2ItemService.selectItemList(params);
				selectStoreDetailCnt = z3Sales2StoreService.selectStoreDetailCnt(params);
			}
			List<Map<String, Object>> itemList = null;
			params.put("selectUseYn", "Y");
			itemList = z3Sales2ItemService.selectItemList(params);
			
			model.put("storeList", storeList);
			model.put("selectBoxStoreList", selectBoxStoreList);
			model.put("storeDetail", storeDetail);
			model.put("storeDetailAllItem", storeDetailAllItem);
			model.put("storeDetailItem", storeDetailItem);
			model.put("itemList", itemList);
			model.put("storeSeq", storeSeq);
			model.put("selectStoreDetailCnt", selectStoreDetailCnt);
			
			return rtnurl;
		}
		
		//매장상세등록
		@RequestMapping("/zemos3/family/sales2/sales2StoreDetailSave.do")
		public ModelAndView sales2StoreDetailSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

			ModelAndView modelAndView = new ModelAndView("jsonView");
			
			modelAndView.addObject("result", false);
			modelAndView.addObject("result01", false);
			
			// 로그인 정보
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			
			int saveDetailResult = 0;
			int saveDetailItemResult = 0;
			
			params.put("regUserSeq", loginVO.getIdx());
			params.put("modUserSeq", loginVO.getIdx());
			
			String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
			String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
			String storeNm = EgovStringUtil.isNullToString(params.get("storeNm"));
			String itemSeqLength = EgovStringUtil.isNullToString(params.get("itemSeqLength"));
					
			Map<String, Object> detailMap = new HashMap<String, Object>();
			detailMap.put("storeSeq", params.get("storeSeq"));
			detailMap.put("zemosIdx", zemosIdx);
			detailMap.put("wrkplcIdx", wrkplcIdx);
			detailMap.put("fileYn", params.get("iFileYn"));
			detailMap.put("unitYn", params.get("iUnitYn"));
			detailMap.put("pushDttm", params.get("pushDttm")+":00");
			detailMap.put("pushYn", params.get("iPushYn"));
			detailMap.put("regUserSeq", loginVO.getIdx());
			detailMap.put("modUserSeq", loginVO.getIdx());

			String useYn = "";
			int trCnt = 0;
			if ( "insert".equals(params.get("saveGbn")) ) {
				modelAndView.addObject("result01", true);
				if ( params.get("storeDetailSeq") == null || params.get("storeDetailSeq") == "" ) {
					saveDetailResult = z3Sales2StoreService.storeDetailInsert(detailMap);
				}
				
				for ( int i = 0; i < Integer.parseInt(itemSeqLength); i++ ) {
					trCnt = i + 1;
					
					Map<String, Object> detailItemMap = new HashMap<String, Object>();
					
					if ( params.get("storeDetailSeq") == null || params.get("storeDetailSeq") == "" ) {
						detailItemMap.put("storeDetailSeq", detailMap.get("store_detail_seq"));
					} else {
						detailItemMap.put("storeDetailSeq", params.get("storeDetailSeq"));
					}
					
					detailItemMap.put("zemosIdx", zemosIdx);
					detailItemMap.put("wrkplcIdx", wrkplcIdx);
					detailItemMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
					detailItemMap.put("itemSeq", EgovStringUtil.isNullToString(params.get("dItemSeq"+trCnt)));
					detailItemMap.put("useYn", EgovStringUtil.isNullToString(params.get("itemUseYn"+trCnt)));
					detailItemMap.put("regUserSeq", loginVO.getIdx());
					detailItemMap.put("modUserSeq", loginVO.getIdx());
					
					saveDetailItemResult = z3Sales2StoreService.storeDetailItemInsert(detailItemMap);
				}
			} else if ( "update".equals(params.get("saveGbn")) ) {
				detailMap.put("storeDetailSeq", params.get("storeDetailSeq"));
				saveDetailResult = z3Sales2StoreService.storeDetailUpdate(detailMap);
				
				for ( int i = 0; i < Integer.parseInt(itemSeqLength); i++ ) {
					trCnt = i + 1;
					
					if ( "update".equals(EgovStringUtil.isNullToString(params.get("saveGbnDetail"+trCnt))) ) {
						Map<String, Object> detailItemMap = new HashMap<String, Object>();
						
						detailItemMap.put("storeDetailItemSeq", EgovStringUtil.isNullToString(params.get("storeDetailItemSeq"+trCnt)));
						detailItemMap.put("storeDetailSeq", EgovStringUtil.isNullToString(params.get("storeDetailSeq")));
						detailItemMap.put("zemosIdx", zemosIdx);
						detailItemMap.put("wrkplcIdx", wrkplcIdx);
						detailItemMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
						detailItemMap.put("itemSeq", EgovStringUtil.isNullToString(params.get("dItemSeq"+trCnt)));
						detailItemMap.put("useYn", EgovStringUtil.isNullToString(params.get("itemUseYn"+trCnt)));
						detailItemMap.put("regUserSeq", loginVO.getIdx());
						detailItemMap.put("modUserSeq", loginVO.getIdx());
						
						saveDetailItemResult = z3Sales2StoreService.storeDetailItemUpdate(detailItemMap);
					} else {
						Map<String, Object> detailItemMap = new HashMap<String, Object>();
						
						if ( params.get("storeDetailSeq") == null || params.get("storeDetailSeq") == "" ) {
							detailItemMap.put("storeDetailSeq", detailMap.get("store_detail_seq"));
						} else {
							detailItemMap.put("storeDetailSeq", params.get("storeDetailSeq"));
						}
						
						detailItemMap.put("zemosIdx", zemosIdx);
						detailItemMap.put("wrkplcIdx", wrkplcIdx);
						detailItemMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
						detailItemMap.put("itemSeq", EgovStringUtil.isNullToString(params.get("dItemSeq"+trCnt)));
						detailItemMap.put("useYn", EgovStringUtil.isNullToString(params.get("itemUseYn"+trCnt)));
						detailItemMap.put("regUserSeq", loginVO.getIdx());
						detailItemMap.put("modUserSeq", loginVO.getIdx());
						
						saveDetailItemResult = z3Sales2StoreService.storeDetailItemInsert(detailItemMap);
						
					}
				}
			}
			
			// 리턴
			modelAndView.addObject("result", true);
			model.put("resultResponse", saveDetailResult);
			
			return modelAndView;
		}
}
