package egovframework.zemos3.family.sales2.web;

import java.io.File;
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

import egovframework.com.ZemosCommonConstant;
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
import egovframework.zemos3.family.sales2.service.Z3Sales2HistoryService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import egovframework.zemos3.family.sales2.service.Z3Sales2GaolService;


/**
 * 판매실적관리 이력 Controller
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
public class Z3Sales2HistoryController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2HistoryController.class);

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

	//이력 Service
	@Resource(name = "z3Sales2HistoryService")
	private Z3Sales2HistoryService z3Sales2HistoryService;
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreService")
	private Z3Sales2StoreService z3Sales2StoreService;	
	
	@Resource(name = "fileService")
	protected FileService fileService;
	
	/**
	 * 이력 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/**
	 * 제모스 판매관리 실적변경이력 화면
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2History.do")
	public String sales2History(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2History";

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
		
		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		List<Map<String, Object>> storeList = null;
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		model.put("storeList", 	storeList);
		
		List<Map<String, Object>> salesHistory = null;
		if ( params.get("storeSeq") == null ) {
			//if ( storeList.get(0).get("storeSeq") == null ) {
			if ( storeList == null ) {
				params.put("storeSeq", null);
			} else {
				params.put("storeSeq", storeList.get(0).get("storeSeq"));
			}
		}
		
		//int salesHistoryCnt = z3SalesHistoryService.salesHistoryCnt(params);
		Map<String, Object> salesHistoryCnt = z3Sales2HistoryService.salesHistoryCnt(params);
		model.put("salesHistoryCnt", salesHistoryCnt);
		
		salesHistory = z3Sales2HistoryService.salesHistory(params);
		model.put("storeSeq", params.get("storeSeq"));
		
		String idx = "";
		if ( salesHistory != null && salesHistory.size() > 0 ) {
			for ( int i = 0; i < salesHistory.size(); i++ ) {
				if ( EgovStringUtil.isNullToString(salesHistory.get(i).get("idx")) != null ) {
					idx = EgovStringUtil.isNullToString(salesHistory.get(i).get("idx"));
					salesHistory.get(i).put("imageIdxEnc", AES128Util.encrypt(EgovStringUtil.isNullToString(idx)));
				}
			}
		}
		
		if ( params.get("type") == null || params.get("type") == "" ) {
			model.put("pageReloadGbn", "N");
		}
		
		model.put("salesHistory", salesHistory);
		
		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, Integer.parseInt(salesHistoryCnt.get("cnt").toString()), model);
		
		return rtnurl;
	}
	/**
	 * file여부 체크
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping("/zemos3/family/sales2/sales2FileCheck.do")
	public ModelAndView sales2FileCheck(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		String idx 		= "";
		String idxVal 	= EgovStringUtil.isNullToStringNoTrim(params.get("idxVal"));
		if (!EgovStringUtil.isEmpty(idxVal)) {
			idx = AES128Util.decrypt(idxVal.replaceAll(" ", "+"));
		}
		
		params.put("idx", idx);
		
		List<Map<String, Object>> resultList = fileService.selectFile(params);
		
		if (!EgovStringUtil.isEmptyMapList(resultList)) {
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			resultMap 		= resultList.get(0);
			String filePath = EgovStringUtil.isNullToString(resultMap.get(ZemosCommonConstant.filePath.toString()));
			String fileNm 	= EgovStringUtil.isNullToString(resultMap.get(ZemosCommonConstant.fileNm.toString()));
			System.out.println("##### filePath + fileNm > " + filePath + fileNm);
			File file = new File(filePath);

			// 파일 다운로드
			if (file.exists()) {
				modelAndView.addObject("idxVal", idxVal);
				modelAndView.addObject("result", true);
			} else {
				modelAndView.addObject("result", false);
			}
		} else {
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}
}
