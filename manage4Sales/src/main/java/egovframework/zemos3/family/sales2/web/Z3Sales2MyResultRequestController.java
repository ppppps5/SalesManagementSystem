package egovframework.zemos3.family.sales2.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.xalan.xsltc.compiler.sym;
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
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2MyResultRequestService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreNewService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UserResultService;


/**
 * 판매실적관리 나의등록 현황 및 수정요청 Controller
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Controller
public class Z3Sales2MyResultRequestController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2MyResultRequestController.class);

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

	//나의등록 현황 및 수정요청 Service
	@Resource(name = "z3Sales2MyResultRequestService")
	private Z3Sales2MyResultRequestService z3Sales2MyResultRequestService;
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreService")
	private Z3Sales2StoreService z3Sales2StoreService;
	
	//매장관리 Service
	@Resource(name = "z3Sales2StoreNewService")
	private Z3Sales2StoreNewService z3Sales2StoreNewService;
	
	//실적 Service
	@Resource(name = "z3Sales2UserResultService")
	private Z3Sales2UserResultService z3Sales2UserResultService;
	
	//실적 Service
	@Resource(name = "z3Sales2ItemService")
	private Z3Sales2ItemService z3Sales2ItemService;
	
	@Resource(name = "fileService")
	protected FileService fileService;
	
	/**
	 * 나의등록현황(판매관리자)
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2MyResultNew.do")
	public String sales2MyResult(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rtnurl = "egovframework/zemos3/family/sales2/sales2MyResultNew";

		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String yyyyMm = EgovStringUtil.isNullToString(params.get("yyyyMm"));
		
		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		//현재년도의 이전년도(20년)
		List<Map<String, Object>> yyyyList = z3Sales2MyResultRequestService.selectYyyy(params);
		
		if ( params.get("yyyyMm") == null ) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());
	        params.put("yyyyMm", strToday);
	        model.put("yyyy", strToday.substring(0, 4));
	        
	        if ( EgovStringUtil.isNullToString(params.get("dmm")) == null || "".equals(EgovStringUtil.isNullToString(params.get("dmm"))) ) {
	        	model.put("mm", strToday.substring(4, 6));
	        } else {
	        	model.put("mm", EgovStringUtil.isNullToString(params.get("dmm")));
	        }
		} else {
			model.put("yyyy", yyyyMm.substring(0, 4));
	        
			if ( EgovStringUtil.isNullToString(params.get("dmm")) == null || "".equals(EgovStringUtil.isNullToString(params.get("dmm"))) ) {
				model.put("mm", yyyyMm.substring(4, 6));
			} else {
				model.put("mm", EgovStringUtil.isNullToString(params.get("dmm")));
			}
		}
		List<Map<String, Object>> closeYn = null;
		Map<String, Object> closeYnSearch= new HashMap<String, Object>();
		closeYnSearch.put("zemosIdx", params.get("zemosIdx"));
		closeYnSearch.put("wrkplcIdx", params.get("wrkplcIdx"));
		closeYnSearch.put("yyyy", model.get("yyyy"));
		closeYnSearch.put("mm", model.get("mm"));
		closeYn = z3Sales2UserResultService.selectCloseYn(closeYnSearch);
		model.put("closeYn", closeYn);
		List<Map<String, Object>> storeList = null;
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		model.put("storeList", 	storeList);
		String searchYyyyMm = model.get("yyyy")+"-"+model.get("mm");
		model.put("storeUseNm", z3Sales2StoreNewService.selectStoreNewUseNameList(params));
		params.put("searchYyyyMm", searchYyyyMm);
		//나의등록현황 count
		int selectMyResultCnt = z3Sales2MyResultRequestService.selectMyResultCntNew(params);
		//나의등록현황 list
		List<Map<String, Object>> selectMyResult = z3Sales2MyResultRequestService.selectMyResultNew(params);
		//나의등록현황 total
		List<Map<String, Object>> selectMyResultTot = z3Sales2MyResultRequestService.selectMyResultTotNew(params);
		//나의등록현황 totalNoOnOff
		List<Map<String, Object>> selectMyResultTotNoOnOff = z3Sales2MyResultRequestService.selectMyResultTotNewNoOnOff(params);
		
		
		
		model.put("userAdminGbn", EgovStringUtil.isNullToString(params.get("userAdminGbn")));
		model.put("yyyyList", yyyyList);
		model.put("selectMyResultCnt", selectMyResultCnt);
		model.put("selectMyResult", selectMyResult);
		model.put("selectMyResultTot", selectMyResultTot);
		model.put("selectMyResultTotNoOnOff", selectMyResultTotNoOnOff);
		
		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, selectMyResultCnt, model);
		
		return rtnurl;
	}
	
	/**
	 * 수정요청화면(판매관리자)
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultModifyNew.do")
	public String sales2ResultModifyNew(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rtnurl = "egovframework/zemos3/family/sales2/sales2ResultModifyNew";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		//history mng 조회
		Map<String, Object> result = null;
		result = z3Sales2MyResultRequestService.salesHistoryMng(params);
		
		String idx = "";
		if ( result != null && result.size() > 0 ) {
			for ( int i = 0; i < result.size(); i++ ) {
				if ( EgovStringUtil.isNullToString(result.get("idx")) != null ) {
					idx = EgovStringUtil.isNullToString(result.get("idx"));
					result.put("imageIdxEnc", AES128Util.encrypt(EgovStringUtil.isNullToString(idx)));
				}
			}
		}
		
		//실적상세 조회
		List<Map<String, Object>> resultDetailList = null;
		resultDetailList = z3Sales2MyResultRequestService.selectMyResultNewItem(params);
		
		List<Map<String, Object>> unitCostList = null;
		params.put("selectUseYn", "Y");
		unitCostList = z3Sales2StoreService.selectStoreDetailItem(params);
		model.put("unitCostList", unitCostList);
		
		List<Map<String, Object>> storeDetailItem = null;
		params.put("selectUseYn", "Y");
		storeDetailItem = z3Sales2StoreService.selectStoreDetailItem(params);
		model.put("itemList", storeDetailItem);
		model.put("storeUseNm", z3Sales2StoreNewService.selectStoreNewUseNameList(params));
		model.put("result", result);
		model.put("resultDetailList", resultDetailList);
		model.put("resultDt", EgovStringUtil.isNullToString(params.get("resultDt")));
		model.put("userAdminGbn", EgovStringUtil.isNullToString(params.get("userAdminGbn")));
		
		return rtnurl;
	}
	
	/**
	 * 수정요청관리
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultModifyANew.do")
	public String sales2ResultModifyANew(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rtnurl = "egovframework/zemos3/family/sales2/sales2ResultModifyANew";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		//history mng 조회
		Map<String, Object> result = null;
		result = z3Sales2MyResultRequestService.salesHistoryMng(params);
		
		String idx = "";
		if ( result != null && result.size() > 0 ) {
			for ( int i = 0; i < result.size(); i++ ) {
				if ( EgovStringUtil.isNullToString(result.get("idx")) != null ) {
					idx = EgovStringUtil.isNullToString(result.get("idx"));
					result.put("imageIdxEnc", AES128Util.encrypt(EgovStringUtil.isNullToString(idx)));
				}
			}
		}
		
		//실적상세 조회
		List<Map<String, Object>> resultDetailList = null;
		resultDetailList = z3Sales2MyResultRequestService.selectHistoryDetailItem(params);
		
		List<Map<String, Object>> itemNm = null;
		itemNm = z3Sales2ItemService.selectItemUseNameList(params);
		model.put("itemNm", itemNm);
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2StoreNewService.selectStoreNewUseNameList(params);
		model.put("storeUseName", storeUseName);
		
		List<Map<String, Object>> unitCostList = null;
		params.put("selectUseYn", "Y");
		unitCostList = z3Sales2StoreService.selectStoreDetailItem(params);
		model.put("unitCostList", unitCostList);
		
		List<Map<String, Object>> storeDetailItem = null;
		params.put("selectUseYn", "Y");
		storeDetailItem = z3Sales2StoreService.selectStoreDetailItem(params);
		model.put("itemList", storeDetailItem);
		model.put("storeUseNm", z3Sales2StoreNewService.selectStoreNewUseNameList(params));
		model.put("result", result);
		model.put("resultDetailList", resultDetailList);
		model.put("resultDt", EgovStringUtil.isNullToString(params.get("resultDt")));
		model.put("userAdminGbn", EgovStringUtil.isNullToString(params.get("userAdminGbn")));
		
		return rtnurl;
	}
	
	
	/**
	 * 수정요청 저장
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultModifySaveNew.do")
	public ModelAndView sales2ResultModifySave(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		int saveMasterResult = 0;
		int saveDetailResult = 0;
		
		String zemosIdx    = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm     = EgovStringUtil.isNullToString(params.get("zemosNm"));
		String modifyGbn   = EgovStringUtil.isNullToString(params.get("modifyGbn"));
		String wrkplcIdx   = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		String historySeqM = EgovStringUtil.isNullToString(params.get("historySeqM"));
		String description = EgovStringUtil.isNullToString(params.get("description"));
		String rejectDesc  = EgovStringUtil.isNullToString(params.get("rejectDesc"));
		String modifyDt    = EgovStringUtil.isNullToString(params.get("modifyDt")).replaceAll("-", "");
		String newInsert = EgovStringUtil.isNullToString(params.get("new"));
		
		LinkedHashSet<String> itemSeqHash = new LinkedHashSet<>(Arrays.asList(request.getParameterValues("itemSeq")));
		String[] itemSeq = itemSeqHash.toArray(new String[0]);
		String[] unitSeq = request.getParameterValues("unitSeq");
		String[] onOffYn = request.getParameterValues("onOffYn");
		String[] storeSeq = request.getParameterValues("storeSeq");
		String[] resultSeq = request.getParameterValues("resultSeq");
		String[] resultDetailSeq = request.getParameterValues("resultDetailSeq");
		String[] resultQty = request.getParameterValues("resultQty");
		String[] changeQty = request.getParameterValues("changeQty");
		String[] resultAmt = request.getParameterValues("resultAmt");
		String[] changeAmt = request.getParameterValues("changeAmt");
		String[] historySeq = request.getParameterValues("historySeq");
		String[] detailHistorySeq = request.getParameterValues("detailHistorySeq");
		String[] requestYn = request.getParameterValues("requestYn");
		String[] requestYnA = request.getParameterValues("requestYnA");
		String[] resultChangeSeq = request.getParameterValues("resultChangeSeq");
		
		int cnt = 0;
			//master
			Map<String, Object> saveMasterMap = new HashMap<String, Object>();
			
			
				saveMasterMap.put("zemosIdx", zemosIdx);
				saveMasterMap.put("wrkplcIdx", wrkplcIdx);
				saveMasterMap.put("storeSeq", EgovStringUtil.isNullToString(storeSeq[0]));
				saveMasterMap.put("resultSeq", EgovStringUtil.isNullToString(resultSeq[0]));
				saveMasterMap.put("requestYn", "W");
				saveMasterMap.put("description", EgovStringUtil.isNullToString(params.get("description")));
				saveMasterMap.put("regUserSeq", loginVO.getIdx());
				saveMasterMap.put("modUserSeq", loginVO.getIdx());
				List<Map<String, Object>> detailList = z3Sales2StoreNewService.selectStoreNewDetailList(params);
				
				if(z3Sales2MyResultRequestService.selectHistoryCnt(saveMasterMap) == 0){
					//history master table insert					
					saveMasterResult = z3Sales2MyResultRequestService.saveMasterResult(saveMasterMap);
					String unitSeq1 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq1"));
					String unitSeq2 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq2"));
					String unitSeq3 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq3"));
					String unitSeq4 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq4"));
					String unitSeq5 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq5"));
					for ( int i = 0; i < itemSeq.length; i++ ) {
						//detail
						Map<String, Object> saveDetailHisYnMap = new HashMap<String, Object>();
						Map<String, Object> saveDetailMap = new HashMap<String, Object>();
						saveDetailMap.put("historySeq", saveMasterMap.get("history_seq"));
						saveDetailMap.put("zemosIdx", zemosIdx);
						saveDetailMap.put("wrkplcIdx", wrkplcIdx);
						saveDetailMap.put("storeSeq", EgovStringUtil.isNullToString(storeSeq[i]));
						saveDetailMap.put("itemSeq", EgovStringUtil.isNullToString(itemSeq[i]));
						saveDetailMap.put("modifyDt", modifyDt);
							if(unitSeq[i].equals(unitSeq1)){
								saveDetailMap.put("unitSeq1", unitSeq[i]);
								if(onOffYn[i].equals("0")){
									saveDetailHisYnMap.put("hisYn", "W");
									saveDetailMap.put("resultAmt", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("resultQty", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("changeAmt", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("changeQty", EgovStringUtil.isNullToString(changeQty[i]));
								}else if(onOffYn[i].equals("1")){
									saveDetailHisYnMap.put("hisOnYn", "W");
									saveDetailMap.put("resultAmtOn", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("resultQtyOn", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("changeAmtOn", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("changeQtyOn", EgovStringUtil.isNullToString(changeQty[i]));
								}
							}else if(unitSeq[i].equals(unitSeq2)){
								saveDetailMap.put("unitSeq2", unitSeq[i]);
								if(onOffYn[i].equals("0")){
									saveDetailHisYnMap.put("his2Yn", "W");
									saveDetailMap.put("result2Amt", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result2Qty", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change2Amt", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change2Qty", EgovStringUtil.isNullToString(changeQty[i]));
								}else if(onOffYn[i].equals("1")){
									saveDetailHisYnMap.put("his2OnYn", "W");
									saveDetailMap.put("result2AmtOn", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result2QtyOn", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change2AmtOn", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change2QtyOn", EgovStringUtil.isNullToString(changeQty[i]));
								}
							}else if(unitSeq[i].equals(unitSeq3)){
								saveDetailMap.put("unitSeq3", unitSeq[i]);
								if(onOffYn[i].equals("0")){
									saveDetailHisYnMap.put("his3Yn", "W");
									saveDetailMap.put("result3Amt", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result3Qty", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change3Amt", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change3Qty", EgovStringUtil.isNullToString(changeQty[i]));
								}else if(onOffYn[i].equals("1")){
									saveDetailHisYnMap.put("his3OnYn", "W");
									saveDetailMap.put("result3AmtOn", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result3QtyOn", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change3AmtOn", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change3QtyOn", EgovStringUtil.isNullToString(changeQty[i]));
								}
							}else if(unitSeq[i].equals(unitSeq4)){
								saveDetailMap.put("unitSeq4", unitSeq[i]);
								if(onOffYn[i].equals("0")){
									saveDetailHisYnMap.put("his4Yn", "W");
									saveDetailMap.put("result4Amt", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result4Qty", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change4Amt", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change4Qty", EgovStringUtil.isNullToString(changeQty[i]));
								}else if(onOffYn[i].equals("1")){
									saveDetailHisYnMap.put("his4OnYn", "W");
									saveDetailMap.put("result4AmtOn", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result4QtyOn", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change4AmtOn", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change4QtyOn", EgovStringUtil.isNullToString(changeQty[i]));
								}
							}else if(unitSeq[i].equals(unitSeq5)){
								saveDetailMap.put("unitSeq5", unitSeq[i]);
								if(onOffYn[i].equals("0")){
									saveDetailHisYnMap.put("his5Yn", "W");
									saveDetailMap.put("result5Amt", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result5Qty", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change5Amt", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change5Qty", EgovStringUtil.isNullToString(changeQty[i]));
								}else if(onOffYn[i].equals("1")){
									saveDetailHisYnMap.put("his5OnYn", "W");
									saveDetailMap.put("result5AmtOn", EgovStringUtil.isNullToString(resultAmt[i]));
									saveDetailMap.put("result5QtyOn", EgovStringUtil.isNullToString(resultQty[i]));
									saveDetailMap.put("change5AmtOn", EgovStringUtil.isNullToString(changeAmt[i]));
									saveDetailMap.put("change5QtyOn", EgovStringUtil.isNullToString(changeQty[i]));
								}
							}
							saveDetailMap.put("regUserSeq", loginVO.getIdx());
							saveDetailMap.put("modUserSeq", loginVO.getIdx());
							saveDetailHisYnMap.put("regUserSeq", loginVO.getIdx());
							saveDetailHisYnMap.put("resultDetailSeq", resultDetailSeq[i]);
							z3Sales2MyResultRequestService.updateResultDetailHisYn(saveDetailHisYnMap);
							//history detail table insert
							saveDetailResult = z3Sales2MyResultRequestService.saveDetailResultNew(saveDetailMap);
					}
				}else{
					saveMasterMap = z3Sales2MyResultRequestService.salesHistoryMng(saveMasterMap);
					List<Map<String, Object>> historyDetailList = null;
					historyDetailList = z3Sales2MyResultRequestService.salesHistoryDetailForHistorySeq(saveMasterMap);
					for(int i = 0; i < historyDetailList.size(); i++){
						for (int j = 0; j < itemSeq.length; j++) {
							if(EgovStringUtil.isNullToString(historyDetailList.get(i).get("item_seq")).equals(itemSeq[j])){
								cnt++;
								itemSeqHash.remove(itemSeq[j]);
								String unitSeq1 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq1"));
								String unitSeq2 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq2"));
								String unitSeq3 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq3"));
								String unitSeq4 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq4"));
								String unitSeq5 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq5"));
									//detail
									Map<String, Object> saveDetailHisYnMap = new HashMap<String, Object>();
									Map<String, Object> saveDetailMap = new HashMap<String, Object>();
									saveDetailMap.put("detailHistorySeq", historyDetailList.get(i).get("detail_history_seq"));
										if(unitSeq[j].equals(unitSeq1)){
											saveDetailMap.put("unitSeq1", unitSeq[j]);
											if(onOffYn[j].equals("0")){
												saveDetailHisYnMap.put("hisYn", "W");
												saveDetailMap.put("resultAmt", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("resultQty", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("changeAmt", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("changeQty", EgovStringUtil.isNullToString(changeQty[j]));
											}else if(onOffYn[j].equals("1")){
												saveDetailHisYnMap.put("hisOnYn", "W");
												saveDetailMap.put("resultAmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("resultQtyOn", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("changeAmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("changeQtyOn", EgovStringUtil.isNullToString(changeQty[j]));
											}
										}else if(unitSeq[j].equals(unitSeq2)){
											saveDetailMap.put("unitSeq2", unitSeq[j]);
											if(onOffYn[j].equals("0")){
												saveDetailHisYnMap.put("his2Yn", "W");
												saveDetailMap.put("result2Amt", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result2Qty", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change2Amt", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change2Qty", EgovStringUtil.isNullToString(changeQty[j]));
											}else if(onOffYn[j].equals("1")){
												saveDetailHisYnMap.put("his2OnYn", "W");
												saveDetailMap.put("result2AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result2QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change2AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change2QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
											}
										}else if(unitSeq[j].equals(unitSeq3)){
											saveDetailMap.put("unitSeq3", unitSeq[j]);
											if(onOffYn[j].equals("0")){
												saveDetailHisYnMap.put("his3Yn", "W");
												saveDetailMap.put("result3Amt", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result3Qty", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change3Amt", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change3Qty", EgovStringUtil.isNullToString(changeQty[j]));
											}else if(onOffYn[j].equals("1")){
												saveDetailHisYnMap.put("his3OnYn", "W");
												saveDetailMap.put("result3AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result3QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change3AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change3QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
											}
										}else if(unitSeq[j].equals(unitSeq4)){
											saveDetailMap.put("unitSeq4", unitSeq[j]);
											if(onOffYn[j].equals("0")){
												saveDetailHisYnMap.put("his4Yn", "W");
												saveDetailMap.put("result4Amt", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result4Qty", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change4Amt", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change4Qty", EgovStringUtil.isNullToString(changeQty[j]));
											}else if(onOffYn[j].equals("1")){
												saveDetailHisYnMap.put("his4OnYn", "W");
												saveDetailMap.put("result4AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result4QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change4AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change4QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
											}
										}else if(unitSeq[j].equals(unitSeq5)){
											saveDetailMap.put("unitSeq5", unitSeq[j]);
											if(onOffYn[j].equals("0")){
												saveDetailHisYnMap.put("his5Yn", "W");
												saveDetailMap.put("result5Amt", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result5Qty", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change5Amt", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change5Qty", EgovStringUtil.isNullToString(changeQty[j]));
											}else if(onOffYn[j].equals("1")){
												saveDetailHisYnMap.put("his5OnYn", "W");
												saveDetailMap.put("result5AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
												saveDetailMap.put("result5QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
												saveDetailMap.put("change5AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
												saveDetailMap.put("change5QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
											}
										}
										saveDetailMap.put("regUserSeq", loginVO.getIdx());
										saveDetailHisYnMap.put("regUserSeq", loginVO.getIdx());
										saveDetailHisYnMap.put("resultDetailSeq", resultDetailSeq[j]);
										z3Sales2MyResultRequestService.updateResultDetailHisYn(saveDetailHisYnMap);
										//history detail table update
										saveDetailResult = z3Sales2MyResultRequestService.updateHistoryResultDetailNew(saveDetailMap);
							}
						}
					}
				if(cnt<itemSeq.length){
					for (int j = 0; j < itemSeq.length; j++){
						if(itemSeq[j].equals(itemSeqHash.toString().replace("[", "").replace("]", ""))){
							String unitSeq1 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq1"));
							String unitSeq2 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq2"));
							String unitSeq3 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq3"));
							String unitSeq4 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq4"));
							String unitSeq5 = EgovStringUtil.isNullToString(detailList.get(0).get("unitSeq5"));
							//detail
							Map<String, Object> saveDetailHisYnMap = new HashMap<String, Object>();
							Map<String, Object> saveDetailMap = new HashMap<String, Object>();
							saveDetailMap.put("historySeq", saveMasterMap.get("historySeq"));
							saveDetailMap.put("zemosIdx", zemosIdx);
							saveDetailMap.put("wrkplcIdx", wrkplcIdx);
							saveDetailMap.put("storeSeq", EgovStringUtil.isNullToString(storeSeq[j]));
							saveDetailMap.put("itemSeq", EgovStringUtil.isNullToString(itemSeq[j]));
							saveDetailMap.put("modifyDt", modifyDt);
								if(unitSeq[j].equals(unitSeq1)){
									saveDetailMap.put("unitSeq1", unitSeq[j]);
									if(onOffYn[j].equals("0")){
										saveDetailHisYnMap.put("hisYn", "W");
										saveDetailMap.put("resultAmt", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("resultQty", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("changeAmt", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("changeQty", EgovStringUtil.isNullToString(changeQty[j]));
									}else if(onOffYn[j].equals("1")){
										saveDetailHisYnMap.put("hisOnYn", "W");
										saveDetailMap.put("resultAmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("resultQtyOn", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("changeAmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("changeQtyOn", EgovStringUtil.isNullToString(changeQty[j]));
									}
								}else if(unitSeq[j].equals(unitSeq2)){
									saveDetailMap.put("unitSeq2", unitSeq[j]);
									if(onOffYn[j].equals("0")){
										saveDetailHisYnMap.put("his2Yn", "W");
										saveDetailMap.put("result2Amt", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result2Qty", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change2Amt", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change2Qty", EgovStringUtil.isNullToString(changeQty[j]));
									}else if(onOffYn[j].equals("1")){
										saveDetailHisYnMap.put("his2OnYn", "W");
										saveDetailMap.put("result2AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result2QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change2AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change2QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
									}
								}else if(unitSeq[j].equals(unitSeq3)){
									saveDetailMap.put("unitSeq3", unitSeq[j]);
									if(onOffYn[j].equals("0")){
										saveDetailHisYnMap.put("his3Yn", "W");
										saveDetailMap.put("result3Amt", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result3Qty", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change3Amt", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change3Qty", EgovStringUtil.isNullToString(changeQty[j]));
									}else if(onOffYn[j].equals("1")){
										saveDetailHisYnMap.put("his3OnYn", "W");
										saveDetailMap.put("result3AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result3QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change3AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change3QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
									}
								}else if(unitSeq[j].equals(unitSeq4)){
									saveDetailMap.put("unitSeq4", unitSeq[j]);
									if(onOffYn[j].equals("0")){
										saveDetailHisYnMap.put("his4Yn", "W");
										saveDetailMap.put("result4Amt", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result4Qty", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change4Amt", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change4Qty", EgovStringUtil.isNullToString(changeQty[j]));
									}else if(onOffYn[j].equals("1")){
										saveDetailHisYnMap.put("his4OnYn", "W");
										saveDetailMap.put("result4AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result4QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change4AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change4QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
									}
								}else if(unitSeq[j].equals(unitSeq5)){
									saveDetailMap.put("unitSeq5", unitSeq[j]);
									if(onOffYn[j].equals("0")){
										saveDetailHisYnMap.put("his5Yn", "W");
										saveDetailMap.put("result5Amt", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result5Qty", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change5Amt", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change5Qty", EgovStringUtil.isNullToString(changeQty[j]));
									}else if(onOffYn[j].equals("1")){
										saveDetailHisYnMap.put("his5OnYn", "W");
										saveDetailMap.put("result5AmtOn", EgovStringUtil.isNullToString(resultAmt[j]));
										saveDetailMap.put("result5QtyOn", EgovStringUtil.isNullToString(resultQty[j]));
										saveDetailMap.put("change5AmtOn", EgovStringUtil.isNullToString(changeAmt[j]));
										saveDetailMap.put("change5QtyOn", EgovStringUtil.isNullToString(changeQty[j]));
									}
								}
								saveDetailMap.put("regUserSeq", loginVO.getIdx());
								saveDetailMap.put("modUserSeq", loginVO.getIdx());
								saveDetailHisYnMap.put("regUserSeq", loginVO.getIdx());
								saveDetailHisYnMap.put("resultDetailSeq", resultDetailSeq[j]);
								z3Sales2MyResultRequestService.updateResultDetailHisYn(saveDetailHisYnMap);
								//history detail table insert
								saveDetailResult = z3Sales2MyResultRequestService.saveDetailResultNew(saveDetailMap);
							}
						}
					}
				}
				params.put("zemosIdx", zemosIdx);
				params.put("wrkplcIdx", wrkplcIdx);
				params.put("resultSeq", saveMasterMap.get("resultSeq"));
				params.put("storeSeq", saveMasterMap.get("storeSeq"));
				params.put("resultDt", modifyDt);
				
					
			
//			// 새소식 && 푸쉬알림 처리 (비동기)  
//			
//			params.put("name", 		loginVO.getName());
//			params.put("sabun", 	loginVO.getSabun());
//			params.put("regIdx", 	loginVO.getIdx());
//			params.put("editIdx", 	loginVO.getIdx());
//			params.put("resultDt", EgovStringUtil.isNullToString(params.get("modifyDt")));
//			//운영방영때 주석 삭제
//			z3Sales2MyResultRequestService.SalesUserPush(params);
//			
//			// 리턴
			modelAndView.addObject("result", true);		
			return modelAndView;
	}
	@RequestMapping("/zemos3/family/sales2/salesResultModifySaveOkAndReject.do")
	public ModelAndView salesResultModifySaveOkAndReject(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		int saveMasterResult = 0;
		int saveDetailResult = 0;
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String wrkplcIdx = EgovStringUtil.isNullToString(params.get("wrkplcIdx"));
		String historySeq = EgovStringUtil.isNullToString(params.get("historySeq"));
		String storeSeq = EgovStringUtil.isNullToString(params.get("storeSeq"));
		String resultSeq = EgovStringUtil.isNullToString(params.get("resultSeq"));
		String resultDt = EgovStringUtil.isNullToString(params.get("modifyDt"));
		String requestYn = EgovStringUtil.isNullToString(params.get("requestYnB"));
		
		Map<String, Object> saveMasterMap = new HashMap<String, Object>();
		saveMasterMap = z3Sales2MyResultRequestService.salesHistoryMng(params);
		List<Map<String, Object>> historyDetailMap = new ArrayList<Map<String, Object>>();
		historyDetailMap = z3Sales2MyResultRequestService.salesHistoryDetailForHistorySeq(params);
		
		//승인/반려 처리 시 요청이 이미 처리 됐는지 확인
		if(EgovStringUtil.isNullToString(saveMasterMap.get("requestYn")).equals("W")){
			//승인 처리시 업데이트 로직
			if(requestYn.equals("Y")){
				for(Map<String, Object> historyDetail : historyDetailMap){
					Map<String, Object> updateDetailLMap = new HashMap<String, Object>();
					updateDetailLMap.put("resultSeq", resultSeq);
					updateDetailLMap.put("itemSeq", EgovStringUtil.isNullToString(historyDetail.get("item_seq")));
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq1")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt")).equals("")){
							updateDetailLMap.put("qty", EgovStringUtil.isNullToString(historyDetail.get("change_qty")));
							updateDetailLMap.put("amt", EgovStringUtil.isNullToString(historyDetail.get("change_amt")));
							updateDetailLMap.put("hisYn", "Y");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
							updateDetailLMap.put("qtyOn", EgovStringUtil.isNullToString(historyDetail.get("change_qty_on")));
							updateDetailLMap.put("amtOn", EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")));
							updateDetailLMap.put("hisOnYn", "Y");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq2")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change2_amt")).equals("")){
							updateDetailLMap.put("qty2", EgovStringUtil.isNullToString(historyDetail.get("change2_qty")));
							updateDetailLMap.put("amt2", EgovStringUtil.isNullToString(historyDetail.get("change2_amt")));
							updateDetailLMap.put("his2Yn", "Y");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change2_amt_on")).equals("")){
							updateDetailLMap.put("qty2On", EgovStringUtil.isNullToString(historyDetail.get("change2_qty_on")));
							updateDetailLMap.put("amt2On", EgovStringUtil.isNullToString(historyDetail.get("change2_amt_on")));
							updateDetailLMap.put("his2OnYn", "Y");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq3")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change3_amt")).equals("")){
							updateDetailLMap.put("qty3", EgovStringUtil.isNullToString(historyDetail.get("change3_qty")));
							updateDetailLMap.put("amt3", EgovStringUtil.isNullToString(historyDetail.get("change3_amt")));
							updateDetailLMap.put("his3Yn", "Y");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change3_amt_on")).equals("")){
							updateDetailLMap.put("qty3On", EgovStringUtil.isNullToString(historyDetail.get("change3_qty_on")));
							updateDetailLMap.put("amt3On", EgovStringUtil.isNullToString(historyDetail.get("change3_amt_on")));
							updateDetailLMap.put("his3OnYn", "Y");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq4")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change4_amt")).equals("")){
							updateDetailLMap.put("qty4", EgovStringUtil.isNullToString(historyDetail.get("change4_qty")));
							updateDetailLMap.put("amt4", EgovStringUtil.isNullToString(historyDetail.get("change4_amt")));
							updateDetailLMap.put("his4Yn", "Y");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
							updateDetailLMap.put("qty4On", EgovStringUtil.isNullToString(historyDetail.get("change4_qty_on")));
							updateDetailLMap.put("amt4On", EgovStringUtil.isNullToString(historyDetail.get("change4_amt_on")));
							updateDetailLMap.put("his4OnYn", "Y");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq5")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change5_amt")).equals("")){
							updateDetailLMap.put("qty5", EgovStringUtil.isNullToString(historyDetail.get("change5_qty")));
							updateDetailLMap.put("amt5", EgovStringUtil.isNullToString(historyDetail.get("change5_amt")));
							updateDetailLMap.put("his5Yn", "Y");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
							updateDetailLMap.put("qty5On", EgovStringUtil.isNullToString(historyDetail.get("change5_qty_on")));
							updateDetailLMap.put("amt5On", EgovStringUtil.isNullToString(historyDetail.get("change5_amt_on")));
							updateDetailLMap.put("his5OnYn", "Y");
						}
					}
					updateDetailLMap.put("modUserSeq", loginVO.getIdx());
					z3Sales2MyResultRequestService.updateDetailResultL(updateDetailLMap);
				}
				Map<String, Object> updateHistortRequestYnMap = new HashMap<String, Object>();
				updateHistortRequestYnMap.put("historySeq", historySeq);
				updateHistortRequestYnMap.put("requestYn", requestYn);
				updateHistortRequestYnMap.put("modUserSeq", loginVO.getIdx());
				z3Sales2MyResultRequestService.updateHistoryResult(updateHistortRequestYnMap);
				modelAndView.addObject("result", true);
			//반려 처리시 업데이트 로직
			}else{
				for(Map<String, Object> historyDetail : historyDetailMap){
					Map<String, Object> updateDetailLMap = new HashMap<String, Object>();
					updateDetailLMap.put("resultSeq", resultSeq);
					updateDetailLMap.put("itemSeq", EgovStringUtil.isNullToString(historyDetail.get("item_seq")));
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq1")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt")).equals("")){
							updateDetailLMap.put("hisYn", "N");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
							updateDetailLMap.put("hisOnYn", "N");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq2")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change2_amt")).equals("")){
							updateDetailLMap.put("his2Yn", "N");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change2_amt_on")).equals("")){
							updateDetailLMap.put("his2OnYn", "N");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq3")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change3_amt")).equals("")){
							updateDetailLMap.put("his3Yn", "N");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change3_amt_on")).equals("")){
							updateDetailLMap.put("his3OnYn", "N");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq4")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change4_amt")).equals("")){
							updateDetailLMap.put("his4Yn", "N");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
							updateDetailLMap.put("his4OnYn", "N");
						}
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq5")).equals("")){
						if(!EgovStringUtil.isNullToString(historyDetail.get("change5_amt")).equals("")){
							updateDetailLMap.put("his5Yn", "N");
						}
						if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
							updateDetailLMap.put("his5OnYn", "N");
						}
					}
					updateDetailLMap.put("modUserSeq", loginVO.getIdx());
					z3Sales2MyResultRequestService.updateDetailResultL(updateDetailLMap);
				}
				
				Map<String, Object> updateHistortRequestYnMap = new HashMap<String, Object>();
				updateHistortRequestYnMap.put("historySeq", historySeq);
				updateHistortRequestYnMap.put("requestYn", requestYn);
				updateHistortRequestYnMap.put("rejectDesc", EgovStringUtil.isNullToString(params.get("rejectDesc")));
				updateHistortRequestYnMap.put("modUserSeq", loginVO.getIdx());
				z3Sales2MyResultRequestService.updateHistoryResult(updateHistortRequestYnMap);
				modelAndView.addObject("result", true);		
			}
		}else{
			modelAndView.addObject("result", "R");		
		}
		
		
		
		int cnt = 0;
		
		params.put("zemosIdx", zemosIdx);
		params.put("wrkplcIdx", wrkplcIdx);
		params.put("resultSeq", resultSeq);
		params.put("storeSeq", storeSeq);
		params.put("resultDt", resultDt);
		
		
		
//			// 새소식 && 푸쉬알림 처리 (비동기)  
//			
//			params.put("name", 		loginVO.getName());
//			params.put("sabun", 	loginVO.getSabun());
//			params.put("regIdx", 	loginVO.getIdx());
//			params.put("editIdx", 	loginVO.getIdx());
//			params.put("resultDt", EgovStringUtil.isNullToString(params.get("modifyDt")));
//			//운영방영때 주석 삭제
//			z3Sales2MyResultRequestService.SalesUserPush(params);
//			
		
		// 리턴
		return modelAndView;
	}
	
	/**
	 * 나의등록현황 삭제요청
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultRequestDelete.do")
	public ModelAndView sales2ResultRequestDelete(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		System.out.println("params ====> " + params);
		int updateResultDetail = z3Sales2MyResultRequestService.updateResultMng(params);
		//updateResultDetail
		
		// 리턴
		modelAndView.addObject("result", true);
		
		return modelAndView;
	}
	
	/**
	 * 실적정보 삭제
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ResultDeleteNew.do")
	public ModelAndView sales2ResultDeleteNew(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> saveMasterMap = new HashMap<String, Object>();
		saveMasterMap = z3Sales2MyResultRequestService.salesHistoryMng(params);
		List<Map<String, Object>> historyDetailMap = new ArrayList<Map<String, Object>>();
		historyDetailMap = z3Sales2MyResultRequestService.salesHistoryDetailForHistorySeq(params);
		if(EgovStringUtil.isNullToString(saveMasterMap.get("requestYn")).equals("W")){
			for(Map<String, Object> historyDetail : historyDetailMap){
				Map<String, Object> updateDetailLMap = new HashMap<String, Object>();
				updateDetailLMap.put("resultSeq", EgovStringUtil.isNullToString(params.get("resultSeq")));
				updateDetailLMap.put("itemSeq", EgovStringUtil.isNullToString(historyDetail.get("item_seq")));
				if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq1")).equals("")){
					if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt")).equals("")){
						updateDetailLMap.put("hisYn", "D");
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
						updateDetailLMap.put("hisOnYn", "D");
					}
				}
				if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq2")).equals("")){
					if(!EgovStringUtil.isNullToString(historyDetail.get("change2_amt")).equals("")){
						updateDetailLMap.put("his2Yn", "D");
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("change2_amt_on")).equals("")){
						updateDetailLMap.put("his2OnYn", "D");
					}
				}
				if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq3")).equals("")){
					if(!EgovStringUtil.isNullToString(historyDetail.get("change3_amt")).equals("")){
						updateDetailLMap.put("his3Yn", "D");
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("change3_amt_on")).equals("")){
						updateDetailLMap.put("his3OnYn", "D");
					}
				}
				if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq4")).equals("")){
					if(!EgovStringUtil.isNullToString(historyDetail.get("change4_amt")).equals("")){
						updateDetailLMap.put("his4Yn", "D");
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
						updateDetailLMap.put("his4OnYn", "D");
					}
				}
				if(!EgovStringUtil.isNullToString(historyDetail.get("unit_seq5")).equals("")){
					if(!EgovStringUtil.isNullToString(historyDetail.get("change5_amt")).equals("")){
						updateDetailLMap.put("his5Yn", "D");
					}
					if(!EgovStringUtil.isNullToString(historyDetail.get("change_amt_on")).equals("")){
						updateDetailLMap.put("his5OnYn", "D");
					}
				}
				updateDetailLMap.put("modUserSeq", loginVO.getIdx());
				z3Sales2MyResultRequestService.updateDetailResultL(updateDetailLMap);
			}
			
			Map<String, Object> updateHistortRequestYnMap = new HashMap<String, Object>();
			updateHistortRequestYnMap.put("historySeq", EgovStringUtil.isNullToString(params.get("historySeq")));
			updateHistortRequestYnMap.put("requestYn", "D");
			updateHistortRequestYnMap.put("modUserSeq", loginVO.getIdx());
			z3Sales2MyResultRequestService.updateHistoryResult(updateHistortRequestYnMap);
			modelAndView.addObject("result", true);	
			
			modelAndView.addObject("result", true);
		}else if(EgovStringUtil.isNullToString(saveMasterMap.get("requestYn")).equals("Y")){
			modelAndView.addObject("result", false);
			modelAndView.addObject("YN", "Y");
		}else if(EgovStringUtil.isNullToString(saveMasterMap.get("requestYn")).equals("N")){
			modelAndView.addObject("result", false);
			modelAndView.addObject("YN", "N");
		}
		
		// 리턴
		return modelAndView;
	}
	
	/**
	 * 수정요청관리(현장관리자, 잡컨설턴트)
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ModifyRequestAdminNew.do")
	public String sales2ModifyRequestAdmin(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2ModifyRequestAdminNew";

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
		if(!EgovStringUtil.isNullToString(params.get("startDate")).equals("")){
			String[] startYyyy = EgovStringUtil.isNullToString(params.get("startDate")).split("-");
			String syyyy = startYyyy[0].toString();
			String smm = startYyyy[1].toString();
			List<Map<String, Object>> closeYn = null;
			
			Map<String, Object> closeYnSearch= new HashMap<String, Object>();
			closeYnSearch.put("zemosIdx", params.get("zemosIdx"));
			closeYnSearch.put("wrkplcIdx", params.get("wrkplcIdx"));
			closeYnSearch.put("yyyy", syyyy);
			closeYnSearch.put("mm", smm);
			closeYn = z3Sales2UserResultService.selectCloseYn(closeYnSearch);
			model.put("closeYn", closeYn);
			model.put("userAdminGbn", userAdminGbn);
		}else{
			List<Map<String, Object>> closeYn = null;
			
			Map<String, Object> closeYnSearch= new HashMap<String, Object>();
			closeYnSearch.put("zemosIdx", params.get("zemosIdx"));
			closeYnSearch.put("wrkplcIdx", params.get("wrkplcIdx"));
			closeYnSearch.put("yyyy", yyyy);
			closeYnSearch.put("mm", mm);
			closeYn = z3Sales2UserResultService.selectCloseYn(closeYnSearch);
			model.put("closeYn", closeYn);
			model.put("userAdminGbn", userAdminGbn);
		}
		
		//현재년도의 이전년도(20년)
		List<Map<String, Object>> yyyyList = z3Sales2MyResultRequestService.selectYyyy(params);
		model.put("yyyyList", yyyyList);
		
		if ( params.get("type") == null || params.get("type") == "" ) {
			model.put("pageReloadGbn", "N");
		}
		
		List<Map<String, Object>> storeList = null;
		List<Map<String, Object>> selectSalesPresent = null;
		
		int selectSalesPresentCnt = 0;
		Map<String, Object> selectSalesPresentTotal = null;
		
		if ( "select".equals(params.get("type")) || "pageNo".equals(params.get("type")) ) {
			storeList = z3Sales2StoreService.selectBoxStoreList(params);
			model.put("storeList", 	storeList);
			
			List<Map<String, Object>> storeUseName = null;
			storeUseName = z3Sales2StoreNewService.selectStoreNewUseNameList(params);
			model.put("storeUseName", 	storeUseName);
			
			selectSalesPresent = z3Sales2MyResultRequestService.selectResultAmendList(params);
			model.put("selectSalesPresent", selectSalesPresent);
			
			selectSalesPresentTotal = z3Sales2MyResultRequestService.selectSalesPresentTotal(params);
			model.put("selectSalesPresentTotal", selectSalesPresentTotal);
			model.put("startDate", params.get("startDate"));
			model.put("endDate", params.get("endDate"));
			model.put("requestYn", params.get("requestYn"));
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
		
		
		if(EgovStringUtil.isNullToString(params.get("pages")).equals("record")){
			model.put("pages", EgovStringUtil.isNullToString(params.get("pages")));
			//history mng 조회
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			result = z3Sales2MyResultRequestService.salesHistoryMngList(params);
			model.put("result", result);
			 
			List<Map<String, Object>> itemNm = null;
			itemNm = z3Sales2ItemService.selectItemUseNameList(params);
			model.put("itemNm", itemNm);
			//실적상세 조회
			List<Map<String, Object>> resultDetailList = null;
			resultDetailList = z3Sales2MyResultRequestService.selectHistoryDetailItem(params);
			model.put("resultDetailList", resultDetailList);
		}
		if(EgovStringUtil.isNullToString(params.get("pages")).equals("record2")){
			model.put("pages", EgovStringUtil.isNullToString(params.get("pages")));
			//history mng 조회
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			result = z3Sales2MyResultRequestService.salesHistoryMngList(params);
			model.put("result", result);
			
			List<Map<String, Object>> itemNm = null;
			itemNm = z3Sales2ItemService.selectItemUseNameList(params);
			model.put("itemNm", itemNm);
			//실적상세 조회
			List<Map<String, Object>> resultDetailList = null;
			resultDetailList = z3Sales2MyResultRequestService.selectHistoryDetailItem(params);
			model.put("resultDetailList", resultDetailList);
		}
		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, selectSalesPresentCnt, model);
		
		return rtnurl;
	}
	
	/**
	 * file여부 체크
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	/*
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
	*/
}

