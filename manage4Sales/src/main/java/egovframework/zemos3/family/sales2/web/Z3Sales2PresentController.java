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

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.util.MakeExcel;
import egovframework.com.login.service.LoginService;
import egovframework.com.user.service.UserService;
import egovframework.com.utl.zemosPagingUtil;
import egovframework.com.utl.fcc.service.AES128Util;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.zemos.zemos.service.ZemosService;
import egovframework.zemos.zemossetup.service.ZemosSetupService;
import egovframework.zemos3.family.sales2.service.Z3Sales2PresentService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import egovframework.zemos3.family.sales2.service.Z3Sales2GaolService;
import egovframework.zemos3.family.sales2.service.Z3Sales2HistoryService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;


/**
 * 판매실적관리 판매관리 현황 Controller
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
public class Z3Sales2PresentController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2PresentController.class);

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

	//판매관리현황 Service
	@Resource(name = "z3Sales2PresentService")
	private Z3Sales2PresentService z3Sales2PresentService;
	
	//목표 Service
	@Resource(name = "z3Sales2GaolService")
	private Z3Sales2GaolService z3Sales2GaolService;
	
	//품목 Service
	@Resource(name = "z3Sales2ItemService")
	private Z3Sales2ItemService z3Sales2ItemService;
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreService")
	private Z3Sales2StoreService z3Sales2StoreService;
	
	//실적변경이력 Service
	@Resource(name = "z3Sales2HistoryService")
	protected Z3Sales2HistoryService z3Sales2HistoryService;
	
	/**
	 * 판매관리 판매관리현황
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2Present.do")
	public String sales2Present(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Present";

		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String yyyy = EgovStringUtil.isNullToString(params.get("yyyy"));
		String mm = EgovStringUtil.isNullToString(params.get("mm"));
		String userAdminGbn = EgovStringUtil.isNullToString(params.get("userAdminGbn"));
		
		model.put("userAdminGbn", userAdminGbn);
		
		
		//현재년도의 이전년도(20년)
		List<Map<String, Object>> yyyyList = z3Sales2GaolService.selectYyyy(params);
		model.put("yyyyList", yyyyList);
		
		if ( params.get("type") == null || params.get("type") == "" ) {
			model.put("pageReloadGbn", "N");
		}
		
		List<Map<String, Object>> storeList = null;
		List<Map<String, Object>> unitList = null;
		List<Map<String, Object>> itemList = null;
		List<Map<String, Object>> onoffList = null;
		List<Map<String, Object>> selectSalesPresent = null;
		List<Map<String, Object>> selectSalesPresentSum = null;
		Map<String, Object> salesPresentCnt = null;
		List<Map<String, Object>> storeUseName = null;
		List<Map<String, Object>> itemUseName = null;
		
		int cnt = 0;
		if ( "select".equals(params.get("type")) || "pageNo".equals(params.get("type")) ) {
			storeList = z3Sales2StoreService.selectBoxStoreList(params);
			unitList = z3Sales2GaolService.selectUnit(params);
			itemUseName = z3Sales2ItemService.selectItemUseNameList(params);
			itemList = z3Sales2PresentService.selectItemsList(params);
			onoffList = z3Sales2PresentService.selectBoxOnoffList(params);
			storeUseName = z3Sales2GaolService.selectStoreNewUseNameList(params);
			
			model.put("storeList", 	storeList);
			model.put("unitList", 	unitList);
			model.put("itemList", 	itemList);
			model.put("onoffList", 	onoffList);
			model.put("itemUseName", itemUseName);
			model.put("storeUseName", storeUseName);
			
			salesPresentCnt = z3Sales2PresentService.selectSales2PresentCnt(params);
			model.put("salesPresentCnt", salesPresentCnt);
			cnt = Integer.parseInt(salesPresentCnt.get("cnt").toString());
			
			selectSalesPresent = z3Sales2PresentService.selectSales2Present(params);
			model.put("selectSalesPresent", selectSalesPresent);
			
			selectSalesPresentSum = z3Sales2PresentService.selectSalesPresentSum(params);
			model.put("selectSalesPresentSum", selectSalesPresentSum);

			
			String idx = "";
			if ( selectSalesPresent != null && selectSalesPresent.size() > 0 ) {
				for ( int i = 0; i < selectSalesPresent.size(); i++ ) {
					if ( EgovStringUtil.isNullToString(selectSalesPresent.get(i).get("idx")) != null ) {
						idx = EgovStringUtil.isNullToString(selectSalesPresent.get(i).get("idx"));
						selectSalesPresent.get(i).put("imageIdxEnc", AES128Util.encrypt(EgovStringUtil.isNullToString(idx)));
					}
				}
			}
		}
		
		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, cnt, model);

		
		return rtnurl;
	}	
	
	/**
	 * 판매관리현황 엑셀다운로드
	 * @param params
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping("/zemos3/family/sales2/sales2PresentExcelDown.do")
	public void sales2PresentExcelDown(@RequestParam Map<String, Object> params, final HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
	
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String excelGubun = EgovStringUtil.isNullToString(params.get("excelGubun"));
		String excelFileName = "";
		String excelTempFileName = "";
		
		List<Map<String, Object>> salesExcelList = null;
		
		if ( "D".equals(excelGubun) ) { //D : 현황상세 엑셀
			salesExcelList = z3Sales2PresentService.selectSalesPresentDetail(params);
			excelFileName = "판매관리현황상세";
			excelTempFileName = "sales_template01";
		} else if ( "M1".equals(excelGubun) ) { //M1 : 현황 엑셀
			salesExcelList = z3Sales2PresentService.selectSales2Present(params);
			excelFileName = "판매관리현황";
			excelTempFileName = "sales_template02";
		} else if ( "M2".equals(excelGubun) ) { //M2 : 현황 월대장 엑셀
			salesExcelList = z3Sales2PresentService.selectSalesPresentMonth(params);
			excelFileName = "판매관리현황 월대장";
			excelTempFileName = "sales_template03";
		} 
		else if (  "H".equals(excelGubun)  ) {
			salesExcelList = z3Sales2HistoryService.salesHistory(params);
			excelFileName = "수정이력현황";
			excelTempFileName = "sales_template04";
		}
		

		MakeExcel me = new MakeExcel();
		map.put("list", salesExcelList);
    	me.download(request, response, map, excelFileName, excelTempFileName + ".xlsx");
	}
	
	/**
	 * 판매관리 판매관리현황 Detail
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2PresentDetail.do")
	public String sales2PresentDetail(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2PresentDetail";

		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String userAdminGbn = EgovStringUtil.isNullToString(params.get("userAdminGbn"));
		
		model.put("userAdminGbn", userAdminGbn);
		
		List<Map<String, Object>> selectSalesPresentDetail = null;
		Map<String, Object> selectSalesPresentDetailCnt = null;
		List<Map<String, Object>> itemUseName = null;
		
		itemUseName = z3Sales2ItemService.selectItemUseNameList(params);
		model.put("itemUseName", itemUseName);
		
		selectSalesPresentDetail = z3Sales2PresentService.selectSalesPresentDetail(params);
		model.put("selectSalesPresentDetail", selectSalesPresentDetail);
		
		selectSalesPresentDetailCnt = z3Sales2PresentService.selectSalesPresentDetailCnt(params);
		model.put("selectSalesPresentDetailCnt", selectSalesPresentDetailCnt);
		
		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, Integer.parseInt(selectSalesPresentDetailCnt.get("cnt").toString()), model);
		
		return rtnurl;
	}
}
