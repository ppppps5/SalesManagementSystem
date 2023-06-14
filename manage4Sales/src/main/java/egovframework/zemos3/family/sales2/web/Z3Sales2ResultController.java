package egovframework.zemos3.family.sales2.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.util.MakeExcel;
import egovframework.com.login.service.LoginService;
import egovframework.com.user.service.UserService;
import egovframework.com.utl.zemosPagingUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.zemos.zemos.service.ZemosService;
import egovframework.zemos.zemossetup.service.ZemosSetupService;
import egovframework.zemos3.family.sales2.service.Z3Sales2GaolService;
import egovframework.zemos3.family.sales2.service.Z3Sales2MyResultRequestService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ResultService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UnitService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UserResultService;

/**
 * 판매실적관리 실적등록 Controller
 * 
 * @author 이엠룩
 * @since 2022.09.21
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.09.21 이엠룩          최초 생성
 *      </pre>
 */
@Controller
public class Z3Sales2ResultController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2ResultController.class);

	@Resource(name = "zemosSetupService")
	private ZemosSetupService zemosSetupService;

	@Resource(name = "zemosService")
	private ZemosService zemosService;

	// User Service
	@Resource(name = "userService")
	protected UserService userService;

	// Login Service
	@Resource(name = "loginService2")
	private LoginService loginService;

	// 목표 Service
	@Resource(name = "z3Sales2GaolService")
	private Z3Sales2GaolService z3Sales2GaolService;
	
	// 목표 Service
	@Resource(name = "z3Sales2UserResultService")
	private Z3Sales2UserResultService z3Sales2UserResultService;

	// 실적등록 Service
	@Resource(name = "z3Sales2ResultService")
	private Z3Sales2ResultService z3Sales2ResultService;
	
	// 실적수정 Service
	@Resource(name = "z3Sales2MyResultRequestService")
	private Z3Sales2MyResultRequestService z3Sales2MyResultRequestService;
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreService")
	private Z3Sales2StoreService z3Sales2StoreService;

	// 단위기준 Service
	@Resource(name = "z3Sales2UnitService")
	private Z3Sales2UnitService z3Sales2UnitService;

	/**
	 * 실적등록 화면
	 * 
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Result.do")
	public String sales2Result(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String rtnurl = "egovframework/zemos3/family/sales2/sales2Result";

		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());

		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);

		List<Map<String, Object>> storeUseName = null;
		List<Map<String, Object>> storeList = null;
		List<Map<String, Object>> resultList = null;
		List<Map<String, Object>> sumTotalList = null;
		
		if(EgovStringUtil.isNullToString(params.get("startDay")).equals("")){
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
			Date now = new Date();
			String firstDt = format.format(now);
			firstDt = firstDt+"-01";
			SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
			String nowDt = format2.format(now);
			params.put("startDay", firstDt);
			params.put("endDay", nowDt);
			List<Map<String, Object>> closeYn = null;
			closeYn = z3Sales2UserResultService.selectCloseYn(params);
			model.put("closeYn", closeYn);
		}else{
			List<Map<String, Object>> closeYn = null;
			String[] startYyyy = EgovStringUtil.isNullToString(params.get("startDay")).split("-");
			String syyyy = startYyyy[0].toString();
			String smm = startYyyy[1].toString();
			Map<String, Object> closeYnSearch= new HashMap<String, Object>();
			closeYnSearch.put("zemosIdx", params.get("zemosIdx"));
			closeYnSearch.put("wrkplcIdx", params.get("wrkplcIdx"));
			closeYnSearch.put("yyyy", syyyy);
			closeYnSearch.put("mm", smm);
			closeYn = z3Sales2UserResultService.selectCloseYn(closeYnSearch);
			model.put("closeYn", closeYn);
		}
		
		int resultCnt = 0;
		int unitCnt = 0;
		int onoffCnt = 0;

		// 매장명칭 List
		storeUseName = z3Sales2ResultService.selectStoreNewUseNameList(params);
		
		// 매장 List
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		
		// 실적 List
		resultList = z3Sales2ResultService.selectResult(params);
		
		// 실적 합계 금액 List
		sumTotalList = z3Sales2ResultService.selectSumTotalList(params);
		
		// 실적  Count
		resultCnt = z3Sales2ResultService.selectResultCnt(params);

		if (EgovStringUtil.isNullToString(params.get("type")) == null
				|| "".equals(EgovStringUtil.isNullToString(params.get("type")))) {
			model.put("pageReloadGbn", "N");
		}
		model.put("startDay", params.get("startDay"));
		model.put("endDay", params.get("endDay"));
		// 매장별 권한 List
		List<Map<String, Object>> storeAppList = null;
		storeAppList = z3Sales2StoreService.selectAppStoreList(params);
		model.put("storeAppList", 	storeAppList);
		String userAdminGbn = EgovStringUtil.isNullToString(params.get("userAdminGbn"));
		model.put("userAdminGbn", userAdminGbn);
		model.put("storeList", storeList);
		model.put("storeUseName", storeUseName);
		model.put("resultList", resultList);
		model.put("sumTotalList", sumTotalList);
		model.put("resultCnt", resultCnt);
		params.put("startMonth", EgovStringUtil.isNullToString(params.get("startMonth")));

		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, resultCnt, model);

		return rtnurl;
	}
//	
//	/**
//	 * 실적등록 상세화면
//	 * @param model
//	 * @param params
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultDetail.do")
	public String sales2ResultDetail(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2ResultDetail";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2ResultService.selectStoreNewUseNameList(params);
		
		List<Map<String, Object>> storeitemName = null;
		storeitemName = z3Sales2ResultService.storeitemName(params);
		
		List<Map<String, Object>> resultDetailList = null;
		resultDetailList = z3Sales2ResultService.selectResultDetail(params);
		
		List<Map<String, Object>> closeYn = null;
		String[] startYyyy = EgovStringUtil.isNullToString(params.get("startDay")).split("-");
		String syyyy = startYyyy[0].toString();
		String smm = startYyyy[1].toString();
		Map<String, Object> closeYnSearch= new HashMap<String, Object>();
		closeYnSearch.put("zemosIdx", params.get("zemosIdx"));
		closeYnSearch.put("wrkplcIdx", params.get("wrkplcIdx"));
		closeYnSearch.put("yyyy", syyyy);
		closeYnSearch.put("mm", smm);
		closeYn = z3Sales2UserResultService.selectCloseYn(closeYnSearch);
		
		model.put("closeYn", closeYn);		
		model.put("userAdminGbn", EgovStringUtil.isNullToString(params.get("userAdminGbn")));
		model.put("resultDetailList", resultDetailList);
		model.put("storeUseName", storeUseName);
		model.put("storeitemName", storeitemName);
		
		return rtnurl;
	}
//	/**
//	 * 실적등록 상세저장화면
//	 * @param model
//	 * @param params
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultDetailSave.do")
	public ModelAndView sales2ResultDetailSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("storeSeq",  EgovStringUtil.isNullToString(params.get("storeSeq")));
		insertMap.put("resultexSeq",  EgovStringUtil.isNullToString(params.get("resultexSeq")));
		insertMap.put("qty",  EgovStringUtil.isNullToString(params.get("qty")));
		insertMap.put("amt",  EgovStringUtil.isNullToString(params.get("amt")));
		insertMap.put("year",  EgovStringUtil.isNullToString(params.get("year")));
		insertMap.put("mm",  EgovStringUtil.isNullToString(params.get("mm")));
		insertMap.put("dd",  EgovStringUtil.isNullToString(params.get("dd")));
		insertMap.put("yearMmdd",  EgovStringUtil.isNullToString(params.get("yearMmdd")));
	 

		insertMap.put("itemSeq",  EgovStringUtil.isNullToString(params.get("itemSeq")));
		insertMap.put("unitSeq",  EgovStringUtil.isNullToString(params.get("unitSeq")));
		insertMap.put("unitNm",  EgovStringUtil.isNullToString(params.get("unitNm")));
		insertMap.put("onoffNM",  EgovStringUtil.isNullToString(params.get("onoffNM")));
		insertMap.put("unitYn",  EgovStringUtil.isNullToString(params.get("unitYn")));
		
		// unitYn =1 unit_sql1
		
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		
		//저장
		int saveResult = 0;
		//update resultUpdate
		saveResult = z3Sales2ResultService.ResultDetailUpdate(insertMap);
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
//	/**
//	 * 실적등록엑셀 실적등록 과 최종 실적등록 테이블에 입력과 업데이트 
//	 * @param model
//	 * @param params
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws Exception
//	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultDetailAppSave.do")
	public ModelAndView sales2ResultDetailAppSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		int insertCnt = 0;
		String resultSeq = "";
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		Map<String, Object> ChkMap = new HashMap<String, Object>();
		ChkMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		ChkMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		ChkMap.put("storeSeq",  EgovStringUtil.isNullToString(params.get("storeSeq")));
		ChkMap.put("storeNm",  EgovStringUtil.isNullToString(params.get("storeNm")));
		ChkMap.put("startDay",  EgovStringUtil.isNullToString(params.get("startDay")));
		ChkMap.put("endDay",  EgovStringUtil.isNullToString(params.get("endDay")));
		ChkMap.put("unitSeq",  EgovStringUtil.isNullToString(params.get("unitSeq")));
		ChkMap.put("unitNm",  EgovStringUtil.isNullToString(params.get("unitNm")));
		ChkMap.put("onoffNM",  EgovStringUtil.isNullToString(params.get("onoffNM")));
		ChkMap.put("unitYn",  EgovStringUtil.isNullToString(params.get("unitYn")));
		
		// unitYn =1 unit_sql1
		List<Map<String, Object>> resultDetailList01 = null;
		resultDetailList01 = z3Sales2ResultService.selectResultDetail01(ChkMap);
		
		for(Map<String, Object> resultDetail: resultDetailList01){
			List<Map<String, Object>> insertDetailMap;
			resultDetail.put("resultDt", resultDetail.get("yearMmdd"));
			insertDetailMap = z3Sales2ResultService.resultMngAndDetailCnt(resultDetail);
			if(Integer.parseInt(EgovStringUtil.isNullToString(insertDetailMap.get(0).get("resultCnt"))) > 0){
				
				int historyMap;
				resultDetail.put("resultDt", resultDetail.get("yearMmdd"));
				historyMap = z3Sales2ResultService.resultHistoryMng(insertDetailMap.get(0));
				if(historyMap>0){
					modelAndView.addObject("result", false);
					//이미 수정 요청 있음 
				}else{
					if(Integer.parseInt(EgovStringUtil.isNullToString(insertDetailMap.get(0).get("detailCnt")))>0){
						//detail update
						Map<String, Object> updateMap = new HashMap<String, Object>();
						if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("1")){
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								updateMap.put("qty", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("hisYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								updateMap.put("qtyOn", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amtOn", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("hisOnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYnOn", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
							
							
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("2")){
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								updateMap.put("qty2", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt2", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his2Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn2", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								updateMap.put("qty2On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt2On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his2OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn2On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("3")){
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								updateMap.put("qty3", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt3", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his3Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn3", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								updateMap.put("qty3On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt3On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his3OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn3On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("4")){
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								updateMap.put("qty4", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt4", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his4Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn4", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								updateMap.put("qty4On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt4On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his4OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn4On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("5")){
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								updateMap.put("qty5", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt5", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his5Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn5", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								updateMap.put("qty5On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								updateMap.put("amt5On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								updateMap.put("his5OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn5On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}
						updateMap.put("modUserSeq", loginVO.getIdx());
						updateMap.put("resultSeq", insertDetailMap.get(0).get("resultSeq"));
						updateMap.put("itemSeq", resultDetail.get("itemSeq"));
						z3Sales2MyResultRequestService.updateDetailResultL(updateMap);
						modelAndView.addObject("result", true);
					}else{
						Map<String, Object> insertMap = new HashMap<String, Object>();
						if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("1")){
							insertMap.put("unitSeq1", resultDetail.get("unitSeq"));
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								insertMap.put("qty", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("hisYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								insertMap.put("qtyOn", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amtOn", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("hisOnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYnOn", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("2")){
							insertMap.put("unitSeq2", resultDetail.get("unitSeq"));
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								insertMap.put("qty2", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt2", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his2Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn2", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								insertMap.put("qty2On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt2On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his2OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn2On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("3")){
							insertMap.put("unitSeq3", resultDetail.get("unitSeq"));
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								insertMap.put("qty3", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt3", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his3Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn3", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								insertMap.put("qty3On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt3On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his3OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn3On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("4")){
							insertMap.put("unitSeq4", resultDetail.get("unitSeq"));
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								insertMap.put("qty4", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt4", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his4Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn4", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								insertMap.put("qty4On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt4On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his4OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn4On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("5")){
							insertMap.put("unitSeq5", resultDetail.get("unitSeq"));
							if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
								insertMap.put("qty5", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt5", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his5Yn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn5", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
								insertMap.put("qty5On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
								insertMap.put("amt5On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
								insertMap.put("his5OnYn", "Y");
								Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
								requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
								requestYninsertMap.put("modUserSeq", loginVO.getIdx());
								requestYninsertMap.put("requestYn5On", "Y");
								z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
							}
						}
						insertMap.put("resultSeq", insertDetailMap.get(0).get("resultSeq"));
						insertMap.put("zemosIdx", resultDetail.get("zemosIdx"));
						insertMap.put("wrkplcIdx", resultDetail.get("wrkplcIdx"));
						insertMap.put("storeSeq", resultDetail.get("storeSeq"));
						insertMap.put("itemSeq", resultDetail.get("itemSeq"));
						insertMap.put("regUserSeq", loginVO.getIdx());
						//detail insert
						z3Sales2UserResultService.insertResultDetail(insertMap);
						insertMap.put("resultDetailSeq", insertMap.get("result_detail_seq"));
						z3Sales2UserResultService.insertResultLDetail(insertMap);
						modelAndView.addObject("result", true);
					}
				}
			}else{
				//mng detail insert
				Map<String, Object> insertMngMap = new HashMap<String, Object>();
				insertMngMap.put("resultDt", resultDetail.get("yearMmdd"));
				insertMngMap.put("zemosIdx", resultDetail.get("zemosIdx"));
				insertMngMap.put("wrkplcIdx", resultDetail.get("wrkplcIdx"));
				insertMngMap.put("storeSeq", resultDetail.get("storeSeq"));
				insertMngMap.put("regUserSeq", loginVO.getIdx());
				z3Sales2UserResultService.insertResultMng(insertMngMap);
				insertMngMap.put("resultSeq", insertMngMap.get("result_seq"));
				z3Sales2UserResultService.insertResultLMng(insertMngMap);
				resultSeq = EgovStringUtil.isNullToString(insertMngMap.get("result_seq"));
				Map<String, Object> insertResultDetailMap = new HashMap<String, Object>();
				insertResultDetailMap.put("zemosIdx", resultDetail.get("zemosIdx"));
				insertResultDetailMap.put("wrkplcIdx", resultDetail.get("wrkplcIdx"));
				insertResultDetailMap.put("storeSeq", resultDetail.get("storeSeq"));
				insertResultDetailMap.put("itemSeq", resultDetail.get("itemSeq"));
				insertResultDetailMap.put("regUserSeq", loginVO.getIdx());
				insertResultDetailMap.put("resultSeq", resultSeq);
				
				if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("1")){
					insertResultDetailMap.put("unitSeq1", resultDetail.get("unitSeq"));
					if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
						insertResultDetailMap.put("qty", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
						insertResultDetailMap.put("qtyOn", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amtOn", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYnOn", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}
				}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("2")){
					insertResultDetailMap.put("unitSeq2", resultDetail.get("unitSeq"));
					if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
						insertResultDetailMap.put("qty2", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt2", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn2", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
						insertResultDetailMap.put("qty2On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt2On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn2On", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}
				}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("3")){
					insertResultDetailMap.put("unitSeq3", resultDetail.get("unitSeq"));
					if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
						insertResultDetailMap.put("qty3", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt3", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn3", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
						insertResultDetailMap.put("qty3On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt3On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn3On", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}
				}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("4")){
					insertResultDetailMap.put("unitSeq4", resultDetail.get("unitSeq"));
					if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
						insertResultDetailMap.put("qty4", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt4", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn4", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
						insertResultDetailMap.put("qty4On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt4On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn4On", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}
				}else if(EgovStringUtil.isNullToString(resultDetail.get("unitYn")).equals("5")){
					insertResultDetailMap.put("unitSeq5", resultDetail.get("unitSeq"));
					if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("오프라인")){
						insertResultDetailMap.put("qty5", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt5", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn5", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}else if(EgovStringUtil.isNullToString(resultDetail.get("onoffNM")).equals("온라인")){
						insertResultDetailMap.put("qty5On", EgovStringUtil.isNullToString(resultDetail.get("qty")).replace(",", ""));
						insertResultDetailMap.put("amt5On", EgovStringUtil.isNullToString(resultDetail.get("amt")).replace(",", ""));
						Map<String, Object> requestYninsertMap = new HashMap<String, Object>();
						requestYninsertMap.put("resultexSeq", resultDetail.get("resultexSeq"));
						requestYninsertMap.put("modUserSeq", loginVO.getIdx());
						requestYninsertMap.put("requestYn5On", "Y");
						z3Sales2ResultService.resultExRequestYnUpdate(requestYninsertMap);
					}
				}
				z3Sales2UserResultService.insertResultDetail(insertResultDetailMap);
				insertResultDetailMap.put("resultDetailSeq", insertResultDetailMap.get("result_detail_seq"));
				z3Sales2UserResultService.insertResultLDetail(insertResultDetailMap);
				modelAndView.addObject("result", true);
			}
		}
		
		
		int Cnt = 0;
		
		
		//저장
		int saveResult = 0;
		
		// 리턴
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
	@RequestMapping("/zemos3/family/sales2/sales2ResultSave.do")
	public ModelAndView sales2ResultSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("resultSeq",  EgovStringUtil.isNullToString(params.get("resultSeq")));
		insertMap.put("storeSeq",  EgovStringUtil.isNullToString(params.get("storeSeq")));
		insertMap.put("storeNm",  EgovStringUtil.isNullToString(params.get("storeNm")));
		insertMap.put("unitSeq",  EgovStringUtil.isNullToString(params.get("unitSeq")));
		insertMap.put("unitNm",  EgovStringUtil.isNullToString(params.get("unitNm")));
		insertMap.put("amt",  EgovStringUtil.isNullToString(params.get("amt")));
		insertMap.put("qty",  EgovStringUtil.isNullToString(params.get("qty")));
		insertMap.put("amtOn",  EgovStringUtil.isNullToString(params.get("amtOn")));
		insertMap.put("qtyOn",  EgovStringUtil.isNullToString(params.get("qtyOn")));
		insertMap.put("year",  EgovStringUtil.isNullToString(params.get("year")));
		insertMap.put("mm",  EgovStringUtil.isNullToString(params.get("mm")));
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int saveResult = 0;
		
		//update
		saveResult = z3Sales2ResultService.resultUpdate(insertMap);
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
	/**
	 * 엑셀 다운로드
	 * @param params
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultExcelDownload.do")
	public void sales2ResultExcelDownload(@RequestParam Map<String, Object> params, final HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		//다운로드 엑셀 파일명
		String excelFileName = "";
		
		//엑셀 템플릿 파일명
		String excelTempFileName = "";
		
		List<Map<String, Object>> resultList = null;
		List<Map<String, Object>> dateList = null;
		
		if ( "A".equals(EgovStringUtil.isNullToString(params.get("gbn"))) ) {
			excelFileName = "전체실적등록";
		} else {
			excelFileName = EgovStringUtil.isNullToString(params.get("storeNm")) + "_실적등록";
		}
		
		excelTempFileName = "sales_result_template";
		
		resultList = z3Sales2ResultService.selectResultExcelDown(params);
		
		map.put("list", resultList);
		MakeExcel me = new MakeExcel();
		map.put("list", resultList);
		me.download(request, response, map, excelFileName, excelTempFileName + ".xlsx");
	}
	
	/**
	 * 엑셀 업로드
	 * @param model
	 * @param params
	 * @param multi
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultExcelUpload.do")
	public ModelAndView sales2ResultExcelUpload(ModelMap model, @RequestParam Map<String, Object> params,
			MultipartHttpServletRequest multi, HttpServletRequest request, HttpServletResponse response)
					throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		modelAndView.addObject("result", false);

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("editIdx", loginVO.getIdx());
		params.put("zemosIdx", EgovStringUtil.isNullToString(params.get("zemosIdx")));
		params.put("wrkplcIdx", EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		params.put("idx", EgovStringUtil.isNullToString(params.get("idx")));

		List<MultipartFile> file = multi.getFiles("dataFile");

		int result = 0;

		String filename = EgovStringUtil.isNullToString(params.get("fileName"));
		String ext = filename.substring(filename.lastIndexOf(".") + 1, filename.length());

		// excel파일을 서버에 저장하지 않고 바고 읽어서 처리.
		java.util.Iterator<String> fileIter = multi.getFileNames();
		MultipartFile mFile = multi.getFile((String) fileIter.next());
		InputStreamReader isr = new InputStreamReader(mFile.getInputStream());
		BufferedReader in = new BufferedReader(isr);

		int deleteResult = 0;
		String year = null;
		String mm = null;
		String dd = null;
		
		String yearMonth = null;

		String yearArr[] = new String[99999];
		String month[] = new String[99999];
		String day[] = new String[99999];
		List<String> monthList = new ArrayList<String>();
		
		// 품목명
		String itemName = null;
		List<String> itemNameArr = new ArrayList<String>();
		// 매장명
		String storeName = null;
		// 단위명
		String unitName = null;
		//실적등록일자
		String yyyymmdd = null;
		// 수량
		int qty = 0;
		// 금액
		double amt = 0;
		// 온/오프구분
		String onoffName = null;
		String unitGubun = null;
		String unitSeq = null;
		String itemSeq = null;
		
		double data = 0;
		double data01 = 0;
		
		String storeSeq = null;
		List<String> storeNameArr = new ArrayList<String>();
		List<String> storeNameArr2 = new ArrayList<String>();
		
		// 단위
		List<String> unitNameArr = new ArrayList<String>();
		List<String> unitNameArr2 = new ArrayList<String>();

		// 온/오프구분
		List<String> onoffNameArr = new ArrayList<String>();
		List<String> onoffNameArr2 = new ArrayList<String>();
		
		List<String> yyyymmddArr = new ArrayList<String>();
		List<String> yyyymmddArr2 = new ArrayList<String>();
		
		//List<String> storeSeqArr = new ArrayList<String>();
		int rows = 0;
		//int itemCnt = z3SalesGoalService.selectItemCnt(params);
		int savelResult = 0;
		boolean chk = true;
		
		// 매장명이 등록 매장과 엑셀의 매장이 맞는지 체크.
		List<Map<String, Object>> storeNmList = z3Sales2ResultService.selectStoreNm(params);
		System.out.println("##### storeNmList > " + storeNmList);
				
		// 품목명이 등록 품목과 엑셀의 품목이 맞는지 체크.
		List<Map<String, Object>> itemNmList = z3Sales2ResultService.selectitemNm(params);
		System.out.println("##### itemNmList > " + itemNmList);
		
		try{
			XSSFWorkbook workbook = new XSSFWorkbook(mFile.getInputStream());

			if (workbook != null && workbook.getNumberOfSheets() > 0) {
				for (int index = 0; index < workbook.getNumberOfSheets(); index++) {
					XSSFSheet sheet = workbook.getSheetAt(index);
					
					rows = sheet.getPhysicalNumberOfRows();
					
					for (Row row : sheet) {
						if (row == null) {
							continue;
						}

						// 매장명(firstCell)
						Cell shopName;
						Cell monthly;
						Cell storeNmCell;
						Cell itemNmCell;
						Cell unitNmCell;
						Cell onoffNmCell;
						Cell qtyCell;
						Cell amtCell;
						Cell yyyymmddCell;
						
						int rowCnt = row.getRowNum();
						
						if ( row.getRowNum() > 0 ) {
							
							
							storeNmCell = row.getCell(0);
							
							if (storeNmCell == null) {
								continue;
							}
							 //System.out.println("1. ##### storeNmCell > " + storeNmCell);
							if (storeNmCell != null) {
								storeName = storeNmCell.getStringCellValue().trim();
								storeNameArr.add(storeName);
							}
							itemNmCell = row.getCell(1);
							
							if (itemNmCell == null) {
								continue;
							}
							 //System.out.println("2. ##### itemNmCell > " + itemNmCell);
							if (itemNmCell != null) {
								itemName = itemNmCell.getStringCellValue().trim();
								itemNameArr.add(itemName);
							}
							unitNmCell = row.getCell(2);
							
							if (unitNmCell == null) {
								continue;
							}
							 //System.out.println("3. ##### unitNmCell > " + unitNmCell);
							if (unitNmCell != null) {
								unitName = unitNmCell.getStringCellValue().trim();
								unitNameArr.add(unitName);
							}
							onoffNmCell = row.getCell(3);
							
							if (onoffNmCell == null) {
								continue;
							}
							 //System.out.println("4. ##### onoffNmCell > " + onoffNmCell);
							if (onoffNmCell != null) {
								onoffName = onoffNmCell.getStringCellValue().trim();
								onoffNameArr.add(onoffName);
							}
							yyyymmddCell = row.getCell(6);
							
							if (yyyymmddCell == null) {
								continue;
							}
							 //System.out.println("5. ##### yyyymmddCell > " + yyyymmddCell);
							if (yyyymmddCell != null) {
								yyyymmdd = yyyymmddCell.getStringCellValue().trim();
								yyyymmddArr.add(yyyymmdd);
							}
							//하나의 매장 등록 시 리스트와 엑셀의 매장이 일치하지 않았을 경우
							if ( "O".equals(EgovStringUtil.isNullToString(params.get("gbn"))) ) {
									shopName = row.getCell(0);
									for ( int a = 0; a < storeNmList.size(); a++ ) {
										if (!(storeNmList.get(a).get("storeNm").toString()).equals(shopName.getStringCellValue())) {
											//리턴
											modelAndView.addObject("result", false);
											model.put("resultError", "1");
											chk = false;
											return modelAndView;
										}
										System.out.println("6. ##### storeNm > " + storeNmList.get(a).get("storeNm").toString());
									}
									
							}
							//년.월.일
							for (int i = 0; i < rowCnt; i++) {
							monthly = row.getCell(6);
							if ( monthly == null || monthly.getStringCellValue() == null || "".equals(monthly.getStringCellValue()) ) {
								modelAndView.addObject("result", false);
								model.put("resultError", "5");
								chk = false;
								return modelAndView;
							}
							
							yearMonth = monthly.getStringCellValue().replaceAll("[ㄱ-힣]", "").replaceAll(" ", "");
							params.put("year", yearMonth.substring(0, 4));
							params.put("mm", yearMonth.substring(4, 6));
							params.put("dd", yearMonth.substring(6, 8));
							
							if ( row.getRowNum() == 1 ) {
		                           year = yearMonth.substring(0, 4);
		                           mm = yearMonth.substring(4, 6);
		                    //       dd = yearMonth.substring(6, 8);
		                        }																
							
							
							if ( yearMonth.length() != 8 ) {
								//날짜형식이 6자리가 아닐경우
								modelAndView.addObject("result", false);
								model.put("resultError", "4");
								chk = false;
								return modelAndView;
							}
							
							yearArr[i] = yearMonth.substring(0, 4);
							month[i] = yearMonth.substring(4, 6);
							dd = yearMonth.substring(6, 8);
							day[i] = yearMonth.substring(6, 8);
							//System.out.println("7. ##### year > " + year);
							//System.out.println("7-1. ##### yearArr > " + yearArr);
							//System.out.println("8. ##### mm > " + mm);
							//System.out.println("8-1. ##### month > " + month);
							//System.out.println("9. ##### dd > " + dd);
							//System.out.println("9-1. ##### day > " + day);
						}
							
							//갯수
							data = 0;
							Double cellValue = null;
							//금액
							data01 = 0;
							Double cellValue01 = null;

							qtyCell = row.getCell(4);
							amtCell = row.getCell(5);

							if (qtyCell != null) {
								try {
									cellValue = getCellValue(workbook, qtyCell);
									cellValue01 = getCellValue(workbook, amtCell);
								} catch (NumberFormatException e) {
									// 엑셀 데이터가 숫자가 아닐경우
									modelAndView.addObject("result", false);
									model.put("resultError", "3");
									chk = false;
									e.printStackTrace();
									return modelAndView;
								}

								if (cellValue == null) {
									cellValue = (double) 0; // 변경 소스
								}
								if (cellValue01 == null) {
									cellValue01 = (double) 0; // 변경 소스
								}

								data = cellValue;
								data01 = cellValue01;
								//System.out.println("##### c: " + 4 + " > storeName : data[c] >>>>> " + storeName + " : " + data);
								//System.out.println("##### c: " + 4 + " > itemName : data[c] >>>>> " + itemName + " : " + data);
								//System.out.println("##### c: " + 4 + " > unitName : data[c] >>>>> " + unitName + " : " + data);
								//System.out.println("##### c: " + 4 + " > storeName : data[c] >>>>> " + storeName + " : " + data01);
								//System.out.println("##### c: " + 4 + " > itemName : data[c] >>>>> " + itemName + " : " + data01);
								//System.out.println("##### c: " + 4 + " > unitName : data[c] >>>>> " + unitName + " : " + data01);
								//System.out.println("---------------------------------------------------------------");
								
							}
							
						}

						
						if (row.getRowNum() < 2) {
							continue;
						}
						

						Map<String, Object> insertMap = new HashMap<String, Object>();
						for (int i = 0; i < rowCnt; i++) {
							if (row == null) {
								continue;
							}
							//년도가 다를경우
							if ( !year.equals(yearArr[i])  ) {
								//리턴
								modelAndView.addObject("result", false);
								model.put("resultError", "4");
								chk = false;
								return modelAndView;
							}
							
							//월 형식이 다를경우
							//if ( !mm.equals(month[i]) ) {
								////리턴
								//modelAndView.addObject("result", false);
								//model.put("resultError", "5");
								//chk = false;
								//return modelAndView;
							//}
						}
					}
				}
				
				//System.out.println("##### 비교 : "+storeNameArr.containsAll(storeNameArr2));
				
				if ( chk == true ) {
		               for (int index = 0; index < workbook.getNumberOfSheets(); index++) {
		                  XSSFSheet sheet = workbook.getSheetAt(index);
		                  
		                  rows = sheet.getPhysicalNumberOfRows();
		                  
		                  for (Row row : sheet) {
		                     if (row == null) {
		                        continue;
		                     }
		                     
		                     // 매장명(firstCell)
		                     Cell storeNmCell;
		                     Cell itemNmCell;
		                     Cell unitNmCell;
							 Cell onoffNmCell;
							 Cell yyyymmddCell;
							 
							 int rowCnt = row.getRowNum();
							 
		                     if ( row.getRowNum() > 0 ) {
		                        storeNmCell = row.getCell(0);
		                        
		                        if (storeNmCell == null) {
									continue;
								}
		                        System.out.println("11. ##### storeNmCell > " + storeNmCell);
		                        if (storeNmCell != null) {
		                           storeName = storeNmCell.getStringCellValue().trim();
		                           storeNameArr.add(storeName);
		                        }
		                        itemNmCell = row.getCell(1);
		                        
		                        if (itemNmCell == null) {
									continue;
								}
								 System.out.println("22. ##### itemNmCell > " + itemNmCell);
								if (itemNmCell != null) {
									itemName = itemNmCell.getStringCellValue().trim();
									itemNameArr.add(itemName);
								}
		                        unitNmCell = row.getCell(2);
		                        
		                        if (unitNmCell == null) {
									continue;
								}
		                        System.out.println("33. ##### unitNmCell > " + unitNmCell);
		                        if (unitNmCell != null) {
		                        	unitName = unitNmCell.getStringCellValue().trim();
		                        	unitNameArr.add(unitName);
		                        }
		                        onoffNmCell = row.getCell(3);
		                        
		                        if (onoffNmCell == null) {
									continue;
								}
		                        System.out.println("44. ##### onoffNmCell > " + onoffNmCell);
		                        if (onoffNmCell != null) {
		                        	onoffName = onoffNmCell.getStringCellValue().trim();
		                        	onoffNameArr.add(onoffName);
		                        }
		                        yyyymmddCell = row.getCell(6);
								
								if (yyyymmddCell == null) {
									continue;
								}
								 System.out.println("55. ##### yyyymmddCell > " + yyyymmddCell);
								if (yyyymmddCell != null) {
									yyyymmdd = yyyymmddCell.getStringCellValue().trim();
									yyyymmddArr.add(yyyymmdd);
								}
								
								Cell monthly;
								//년.월.일
								for (int i = 0; i < rowCnt; i++) {
								monthly = row.getCell(6);
								if ( monthly == null || monthly.getStringCellValue() == null || "".equals(monthly.getStringCellValue()) ) {
									modelAndView.addObject("result", false);
									model.put("resultError", "5");
									chk = false;
									return modelAndView;
								}
								
								yearMonth = monthly.getStringCellValue().replaceAll("[ㄱ-힣]", "").replaceAll(" ", "");
								params.put("year", yearMonth.substring(0, 4));
								params.put("mm", yearMonth.substring(4, 6));
								params.put("dd", yearMonth.substring(6, 8));
								
								if ( row.getRowNum() == 1 ) {
			                           year = yearMonth.substring(0, 4);
			                           mm = yearMonth.substring(4, 6);
			                    //       dd = yearMonth.substring(6, 8);
			                        }																
								
								
								if ( yearMonth.length() != 8 ) {
									//날짜형식이 6자리가 아닐경우
									modelAndView.addObject("result", false);
									model.put("resultError", "4");
									chk = false;
									return modelAndView;
								}
								
								yearArr[i] = yearMonth.substring(0, 4);
								month[i] = yearMonth.substring(4, 6);
								dd = yearMonth.substring(6, 8);
								day[i] = yearMonth.substring(6, 8);
								//System.out.println("77. ##### year > " + year);
								//System.out.println("77-1. ##### yearArr > " + yearArr);
								//System.out.println("88. ##### mm > " + mm);
								//System.out.println("88-1. ##### month > " + month);
								//System.out.println("99. ##### dd > " + dd);
								//System.out.println("99-1. ##### day > " + day);
							}
								//갯수
								data = 0;
								Double cellValue = null;
								//금액
								data01 = 0;
								Double cellValue01 = null;
								
								Cell qtyCell;
								Cell amtCell;
								
								qtyCell = row.getCell(4);
								amtCell = row.getCell(5);

								if (qtyCell != null) {
									try {
										cellValue = getCellValue(workbook, qtyCell);
										cellValue01 = getCellValue(workbook, amtCell);
									} catch (NumberFormatException e) {
										// 엑셀 데이터가 숫자가 아닐경우
										modelAndView.addObject("result", false);
										model.put("resultError", "3");
										chk = false;
										e.printStackTrace();
										return modelAndView;
									}

									if (cellValue == null) {
										cellValue = (double) 0; // 변경 소스
									}
									if (cellValue01 == null) {
										cellValue01 = (double) 0; // 변경 소스
									}

									data = cellValue;
									data01 = cellValue01;
									//System.out.println("##### c: " + 4 + " > storeName : data[c] >>>>> " + storeName + " : " + data);
									//System.out.println("##### c: " + 4 + " > itemName : data[c] >>>>> " + itemName + " : " + data);
									//System.out.println("##### c: " + 4 + " > unitName : data[c] >>>>> " + unitName + " : " + data);
									//System.out.println("##### c: " + 4 + " > storeName : data[c] >>>>> " + storeName + " : " + data01);
									//System.out.println("##### c: " + 4 + " > itemName : data[c] >>>>> " + itemName + " : " + data01);
									//System.out.println("##### c: " + 4 + " > unitName : data[c] >>>>> " + unitName + " : " + data01);
									//System.out.println("---------------------------------------------------------------");
									
								}
		                 }
		                     System.out.println("##### storeName > " + storeName);
		                     System.out.println("##### itemName > " + itemName);
		                     System.out.println("##### unitName > " + unitName);
		                     System.out.println("##### onoffName > " + onoffName);
		                     System.out.println("##### yyyymmddArr > " + yyyymmdd);
		                     
		                     System.out.println("##### year > " + year);
		                     System.out.println("##### mm > " + mm);
		                     System.out.println("##### dd > " + dd);
		                     
		                     System.out.println("##### data > " + data);	//갯수
		                     System.out.println("##### data01 > " + data01); //금액
		                    
		                     
		                     if (row.getRowNum() < 1) {
		                        continue;
		                     }
		                     
		                     
		                     Map<String, Object> insertMap = new HashMap<String, Object>();
		                     
		                     System.out.println("##### gbn > " + EgovStringUtil.isNullToString(params.get("gbn")));
		                     
		                     //단위SEQ 온/오프 구분값 확인
		                     params.put("unitName", unitName);
		                     params.put("onoffName", onoffName);
		                     params.put("storeNm", storeName);
		                     params.put("itemName", itemName);
		                     
		                     List<Map<String, Object>> storeUnitList = z3Sales2ResultService.selectUnitList(params);
		                     
		                      unitGubun = EgovStringUtil.isNullToString(storeUnitList.get(0).get("unitGubun").toString());
		                      unitSeq = EgovStringUtil.isNullToString(storeUnitList.get(0).get("unitSeq").toString());
		                      
		                      System.out.println("##### unitGubun > " + unitGubun); 
		                      System.out.println("##### unitSeq > " + unitSeq); 
		                      // 품목명으로 품목SEQ 가져 오기
		                      
		                      List<Map<String, Object>> selectitemList = z3Sales2ResultService.selectitemList(params);
		                      
		                      itemSeq = EgovStringUtil.isNullToString(selectitemList.get(0).get("itemSeq").toString());
		                      
		                    	int resultCnt = 0;
		                    	if (year != null) {
		                    		
		                    		insertMap.put("zemosIdx", EgovStringUtil.isNullToString(params.get("zemosIdx")));
			                        insertMap.put("wrkplcIdx", EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
			                        insertMap.put("storeNm", storeName);
			                        insertMap.put("itemName", itemName);
			                        insertMap.put("unitName", unitName);
			                        insertMap.put("onoffName", onoffName);
			                        insertMap.put("unitGubun", unitGubun);
			                        insertMap.put("unitSeq", unitSeq);
			                        insertMap.put("itemSeq", itemSeq);
			                        
			                        insertMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
			                        insertMap.put("gbn", EgovStringUtil.isNullToString(params.get("gbn")));
			                        insertMap.put("year", year);
			                        insertMap.put("mm", mm);
			                        insertMap.put("dd", dd);
			                        insertMap.put("qty", data);	  //qty
			                        insertMap.put("amt", data01);  //amt
			                        insertMap.put("regUserSeq", loginVO.getIdx());
			                        insertMap.put("modUserSeq", loginVO.getIdx());

			                    	resultCnt = z3Sales2ResultService.selectresulCnt01(insertMap);
			                    	
			                    	if (resultCnt > 0) {
									savelResult = z3Sales2ResultService.resultUpdate(insertMap);
			                    	}else {
									savelResult = z3Sales2ResultService.insertResult(insertMap);
			                    	}
		                    	}

		                  }
		               }
		            }
		         }
		         mFile.getInputStream().close();
		      } catch ( Exception e ) {
		         e.printStackTrace();
		         throw e;
		      }

		      // 리턴
		      modelAndView.addObject("result", true);

		      return modelAndView;
		   }
	
	
	/**
	 * 엑셀 데이터 타입에따라 분류
	 * 
	 * @param workbook
	 * @param cell
	 * @return
	 */
	private Double getCellValue(Workbook workbook, Cell cell) {
		Double l = null;

		if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			l = (double) cell.getNumericCellValue();
		} else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
			final FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
			final CellValue cellValue = evaluator.evaluate(cell);
			l = (double) cellValue.getNumberValue();
		} else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
			l = Double.parseDouble(cell.getStringCellValue());
		}

		return l;
	}
	
}