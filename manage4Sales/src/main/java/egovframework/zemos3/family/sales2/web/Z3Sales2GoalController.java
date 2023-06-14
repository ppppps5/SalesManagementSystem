package egovframework.zemos3.family.sales2.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.lang3.ArrayUtils;

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


/**
 * 판매실적관리 목표관리 Controller
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Controller
public class Z3Sales2GoalController { 

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2GaolController.class);

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

	//목표 Service
	@Resource(name = "z3Sales2GaolService")
	private Z3Sales2GaolService z3Sales2GaolService;
	
	/**
	 * 목표관리 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Goal.do")
	public String sales2Goal(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Goal";

		/* 페이징(전처리) */
		params = zemosPagingUtil.setPrePagingValue(params);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		List<Map<String, Object>> storeList = null;
		List<Map<String, Object>> yyyyList = null;
		List<Map<String, Object>> goalList = null;
		
		int goalCnt = 0;
		//double totSumGoal = 0;
		
		if ( EgovStringUtil.isNullToString(params.get("yyyy")) == null 
				|| "".equals(EgovStringUtil.isNullToString(params.get("yyyy"))) ) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());
	        params.put("yyyy", strToday);
	        model.put("yyyy", strToday);
		} else {
			model.put("yyyy", EgovStringUtil.isNullToString(params.get("yyyy")));
		}
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2GaolService.selectStoreNewUseNameList(params);
		
		//매장 List
		storeList = z3Sales2GaolService.selectBoxStoreList(params);
		
		//현재년도의 이전 15년 ~ 이후 3년
		yyyyList = z3Sales2GaolService.selectYyyy(params);
		
		//단위
		List<Map<String, Object>> unitList = null;
		unitList = z3Sales2GaolService.selectUnit(params);
		
		//온라인 오프라인
		List<Map<String, Object>> onoffList = null;
		onoffList = z3Sales2GaolService.selectOnoff(params);
		
		int unitCnt = 0;
		int onoffCnt = 0;
		//합계
		List<Map<String, Object>> totSumGoal = null;
		
		goalList = z3Sales2GaolService.selectGoal(params);
		goalCnt = z3Sales2GaolService.selectGoalCnt(params);
		totSumGoal = z3Sales2GaolService.selectTotSumGoal(params);
		
		if ( EgovStringUtil.isNullToString(params.get("type")) == null 
				|| "".equals(EgovStringUtil.isNullToString(params.get("type"))) ) {
			model.put("pageReloadGbn", "N");
		}
		
		model.put("storeList", storeList);
		model.put("yyyyList", yyyyList);
		model.put("unitList", unitList);
		model.put("onoffList", onoffList);
		model.put("goalList", goalList);
		model.put("goalCnt", goalCnt);
		model.put("totSumGoal", totSumGoal);
		model.put("storeUseName", storeUseName);
		
		/* 페이징(후처리) */
		zemosPagingUtil.setNextPagingValue(params, goalCnt, model);
		
		return rtnurl;
	}
	
	/**
	 * 목표등록 상세화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2GoalDetail.do")
	public String sales2GoalDetail(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2GoalDetail";
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		if ( EgovStringUtil.isNullToString(params.get("year")) == null 
				|| "".equals(EgovStringUtil.isNullToString(params.get("year"))) ) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
	        Calendar c1 = Calendar.getInstance();
	        String strToday = sdf.format(c1.getTime());
	        params.put("year", strToday);
	        model.put("year", strToday);
		} else {
			model.put("year", EgovStringUtil.isNullToString(params.get("year")));
		}
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2GaolService.selectStoreNewUseNameList(params);
		
		List<Map<String, Object>> goalDetailList = null;
		
		goalDetailList = z3Sales2GaolService.selectGoalDetail(params);
		
		model.put("goalDetailList", goalDetailList);
		model.put("storeUseName", storeUseName);
		
		return rtnurl;
	}
	
	@RequestMapping("/zemos3/family/sales2/sales2GoalSave.do")
	public ModelAndView sales2GoalSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//params.zemosIdx  = $("#zemosIdx"+trCnt).val();
		//params.wrkplcIdx = $("#wrkplcIdx"+trCnt).val();
		//params.storeSeq  = $("#storeSeq"+trCnt).val();
		//params.goalSeq   = $("#goalSeq"+trCnt).val();
		//params.yyyy      = $("#yyyy"+trCnt).val();
		//params.mm        = $("#mm"+trCnt).val();
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("storeSeq",  EgovStringUtil.isNullToString(params.get("storeSeq")));
		insertMap.put("goalSeq",  EgovStringUtil.isNullToString(params.get("goalSeq")));
		insertMap.put("amt",  EgovStringUtil.isNullToString(params.get("amt")));
		insertMap.put("year",  EgovStringUtil.isNullToString(params.get("year")));
		insertMap.put("mm",  EgovStringUtil.isNullToString(params.get("mm")));
		insertMap.put("itemSeq",  EgovStringUtil.isNullToString(params.get("itemSeq")));
		
		insertMap.put("unitSeq",  EgovStringUtil.isNullToString(params.get("unitSeq")));
		insertMap.put("unitNm",  EgovStringUtil.isNullToString(params.get("unitNm")));
		insertMap.put("onoffNM",  EgovStringUtil.isNullToString(params.get("onoffNM")));
		insertMap.put("unitYn",  EgovStringUtil.isNullToString(params.get("unitYn")));
		insertMap.put("offYn",  EgovStringUtil.isNullToString(params.get("offYn")));
		insertMap.put("onYn",  EgovStringUtil.isNullToString(params.get("onYn")));
		insertMap.put("unitYn",  EgovStringUtil.isNullToString(params.get("unitYn")));
		
		// unitYn =1 unit_sql1
		
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int saveResult = 0;
		//update
		saveResult = z3Sales2GaolService.goalUpdate(insertMap);
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
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
	   @RequestMapping("/zemos3/family/sales2/sales2GoalExcelUpload.do")
	   public ModelAndView sales2GoalExcelUpload(ModelMap model, @RequestParam Map<String, Object> params, MultipartHttpServletRequest multi, HttpServletRequest request, HttpServletResponse response) throws Exception {

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

	      // excel파일을 서버에 저장하지 않고 바로 읽어서 처리.
	      java.util.Iterator<String> fileIter = multi.getFileNames();
	      MultipartFile mFile = multi.getFile((String) fileIter.next());
	      InputStreamReader isr = new InputStreamReader(mFile.getInputStream());
	      BufferedReader in = new BufferedReader(isr);

	      int deleteResult = 0;
	      //월별로 row insert할 경우
	      String mm1[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" }; //1월~12월 입력시에 사용 
	      String mm2[] = { "", "", "", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" }; // 단위/온오프 추가
	      String yearMonth = null;
	      String year = null;
//	      String yearArr[] = new String[15]; //단위//온오프추가 12 > 14 품목명 추가 > 15
	      String yearArr[] = new String[99999]; //단위//온오프추가 12 > 14 품목명 추가 > 15
	      List<String> monthList = new ArrayList<String>();
	      //String month[] = null;
//	      String month[] = new String[15]; //단위//온오프추가 12 > 14 품목명 추가 > 15
	      String month[] = new String[99999]; //단위//온오프추가 12 > 14 품목명 추가 > 15
	      //품목명
	      String itemName = null;
	      List<String> itemNameArr = new ArrayList<String>();
	      //매장명
	      String storeName = null;
	      //단위명
		  String unitName = null;
		  //온/오프구분
		  String onoffName = null;
		  String unitGubun = null;
		  String unitSeq = null;
		  String itemSeq = null;
		  
		  String storeSeq = null;
	      List<String> storeNameArr = new ArrayList<String>();
	      List<String> storeNameArr2 = new ArrayList<String>();
	      
	     //단위
		 List<String> unitNameArr = new ArrayList<String>();
		 List<String> unitNameArr2 = new ArrayList<String>();
			
		 //온/오프구분
		 List<String> onoffNameArr = new ArrayList<String>();
		 List<String> onoffNameArr2 = new ArrayList<String>();
	      //List<String> storeSeqArr = new ArrayList<String>();
	      int rows = 0;
	      //int itemCnt = z3SalesGoalService.selectItemCnt(params);
	      int savelResult = 0;
	      boolean chk = true;
	      
	      //매장명이 tb_store테이블에 등록 매장과 엑셀의 매장이 맞는지 체크.
	      List<Map<String, Object>> storeNmList = z3Sales2GaolService.selectStoreNm(params);
	      System.out.println("##### storeNmList > " + storeNmList);
     
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
	                  
	                  
	                  if ( row.getRowNum() > 0 ) {
	                     storeNmCell = row.getCell(0);
	                     //System.out.println("1. ##### storeNmCell > " + storeNmCell);
	                     if (storeNmCell != null) {
	                        storeName = storeNmCell.getStringCellValue().trim();
	                        storeNameArr.add(storeName);
	                     }
	                     itemNmCell = row.getCell(1);
	                     if (itemNmCell == null) {
	                    	 continue;
	                     }
	                     if (itemNmCell != null) {
	                    	 itemName = itemNmCell.getStringCellValue().trim();
	                    	 itemNameArr.add(itemName);
	                     }
	                     unitNmCell = row.getCell(2);
						 //System.out.println("2. ##### unitNmCell > " + unitNmCell);
						 if (unitNmCell != null) {
							 unitName = unitNmCell.getStringCellValue().trim();
							 unitNameArr.add(unitName);
							}
						 onoffNmCell = row.getCell(3);
						 //System.out.println("3. ##### onoffNmCell > " + onoffNmCell);
						 if (onoffNmCell != null) {
							 onoffName = onoffNmCell.getStringCellValue().trim();
							 onoffNameArr.add(onoffName);
							}
	                  }
	                  
	                  //하나의 매장 등록 시 리스트와 엑셀의 매장이 일치하지 않았을 경우
	                  if ( "O".equals(EgovStringUtil.isNullToString(params.get("gbn"))) ) {
	                     if (row.getRowNum() > 0) {
	                        shopName = row.getCell(0);
	                        for ( int a = 0; a < storeNmList.size(); a++ ) {
	                           if (!(storeNmList.get(a).get("storeNm").toString()).equals(shopName.getStringCellValue())) {
	                        	   storeSeq = EgovStringUtil.isNullToString(storeNmList.get(0).get("storeSeq").toString());
	                              //리턴
	                              modelAndView.addObject("result", false);
	                              model.put("resultError", "1");
	                              chk = false;
	                              return modelAndView;
	                           }
	                        }
	                     }
	                  }
	                  System.out.println("##### storeSeq > " + storeSeq);
	                  
	                  if (row.getRowNum() == 0) {
	                     for ( int i = 3; i < 15; i++ ) { // 년월 시작 2번째 부터
	                        monthly = row.getCell(i+1);
	                        
	                        if ( monthly == null || monthly.getStringCellValue() == null || "".equals(monthly.getStringCellValue()) ) {
	                           modelAndView.addObject("result", false);
	                           model.put("resultError", "5");
	                           chk = false;
	                           return modelAndView;
	                        }
	                        
	                        yearMonth = monthly.getStringCellValue().replaceAll("[ㄱ-힣]", "").replaceAll(" ", "");
	                        params.put("year", yearMonth.substring(0, 4));
	                        
	                        if ( i == 3 ) {
	                           year = yearMonth.substring(0, 4);
	                        }
	                        
	                        if ( yearMonth.length() != 6 ) {
	                           //날짜형식이 6자리가 아닐경우
	                           modelAndView.addObject("result", false);
	                           model.put("resultError", "4");
	                           chk = false;
	                           return modelAndView;
	                        }
	                        
	                        yearArr[i] = yearMonth.substring(0, 4);
	                        month[i] = yearMonth.substring(4, 6);
	                        //System.out.println("2. ##### monthly > " + monthly);// 위에 선언문에 12 > 14로 안 바꿔주면 에러 yearArr month
	                     }
	                     //System.out.println("---------------------------------------------------------------");
	                  }
	                  
	                  if (row.getRowNum() < 2) {
	                     continue;
	                     
	                  }
	                  
	                  double[] data = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; // 단위/온오프라인 추가

	                  Cell cell;
	                  Double cellValue = null;

	                  for (int c = 3; c < 15; c++) {
	                     cell = row.getCell(1 + c);
	                     System.out.println("cell이 뭐냐? cell --> " + cell);
	                     if (cell != null) {
	                        try {
	                           cellValue = getCellValue(workbook, cell);
	                           System.out.println(cellValue);
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

	                        data[c] = cellValue;
	                        System.out.println("##### c: " + c + " > storeName : data[c] >>>>> " + storeName + " : " + data[c]);
	                        System.out.println("##### c: " + c + " > itemName : data[c] >>>>> " + itemName + " : " + data[c]);
	                        System.out.println("##### c: " + c + " > unitName : data[c] >>>>> " + unitName + " : " + data[c]);
	                        System.out.println("##### c: " + c + " > onoffName : data[c] >>>>> " + onoffName + " : " + data[c]);
	                        System.out.println("---------------------------------------------------------------");
	                     }
	                  }

	                  Map<String, Object> insertMap = new HashMap<String, Object>();
	                  for (int i = 3; i < data.length; i++) {
	                     //년도가 다를경우
	                     if ( !year.equals(yearArr[i])  ) {
	                        //리턴
	                        modelAndView.addObject("result", false);
	                        model.put("resultError", "4");
	                        chk = false;
	                        return modelAndView;
	                     }
	                     
	                     //월 형식이 다를경우
	                     if ( !mm2[i].equals(month[i]) ) {
	                        //리턴
	                        modelAndView.addObject("result", false);
	                        model.put("resultError", "5");
	                        chk = false;
	                        return modelAndView;
	                     }
	                  }
	               }
	            }
	            
	            //매장 전체 등록 시 리스트와 엑셀의 매장이 일치하지 않았을 경우
	            if ( "A".equals(EgovStringUtil.isNullToString(params.get("gbn"))) ) {
	               if ( storeNameArr.containsAll(storeNameArr2) == false ) {
	                  //리턴
	                  modelAndView.addObject("result", false);
	                  model.put("resultError", "1");
	                  chk = false;
	                  return modelAndView;
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
						 
	                     if ( row.getRowNum() > 0 ) {
	                        storeNmCell = row.getCell(0);
	                        System.out.println("2. ##### storeNmCell > " + storeNmCell);
	                        if (storeNmCell != null) {
	                           storeName = storeNmCell.getStringCellValue().trim();
	                           storeNameArr.add(storeName);
	                        }
	                        itemNmCell = row.getCell(1);
	                        System.out.println("2. ##### itemNmCell > " + itemNmCell);
	                        if (itemNmCell != null) {
	                        	itemName = itemNmCell.getStringCellValue().trim();
	                        	itemNameArr.add(itemName);
	                        }
	                        unitNmCell = row.getCell(2);
	                        System.out.println("2. ##### unitNmCell > " + unitNmCell);
	                        if (unitNmCell != null) {
	                        	unitName = unitNmCell.getStringCellValue().trim();
	                        	unitNameArr.add(unitName);
	                        }
	                        onoffNmCell = row.getCell(3);
	                        System.out.println("2. ##### onoffNmCell > " + onoffNmCell);
	                        if (onoffNmCell != null) {
	                        	onoffName = onoffNmCell.getStringCellValue().trim();
	                        	onoffNameArr.add(onoffName);
	                        }
	                     }
	                     System.out.println("##### storeName > " + storeName);
	                     System.out.println("##### itemName > " + itemName);
	                     System.out.println("##### unitName > " + unitName);
	                     System.out.println("##### onoffName > " + onoffName);
	                     params.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
	                     
	                     params.put("storeNm", storeName);
	                     params.put("onoffName", onoffName);
	                     //if (row.getRowNum() == 0) { // insert/update만 사용으로 제외 처리
	                        //기존에 등록되어있던 목표 삭제 (품목별 변경으로 기존 데이터는 디비에서 삭제 처리)
	                       // deleteResult = z3Sales2GaolService.deleteGoal(params);
	                     //}
	                     
	                     if (row.getRowNum() < 1) {
	                        continue;
	                     }
	                     
	                     double[] data = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };// 단위/온오프라인 추가

	                     Cell cell;
	                     Double cellValue = null;

	                     for (int c = 3; c < 15; c++) {
	                        cell = row.getCell(1 + c);

	                        if (cell != null) {
	                           try {
	                              cellValue = getCellValue(workbook, cell);
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

	                           data[c] = cellValue;
	                        }
	                     }
	                     
	                     
	                     Map<String, Object> insertMap = new HashMap<String, Object>();
	                     
	                     System.out.println("##### gbn > " + EgovStringUtil.isNullToString(params.get("gbn")));
	                     
	                     //단위SEQ 온/오프 구분값 확인
	                     params.put("unitName", unitName);
	                     params.put("onoffName", onoffName);
	                     params.put("storeNm", storeName);
	                     params.put("itemNm", itemName);
	                     
	                     List<Map<String, Object>> storeUnitList = z3Sales2GaolService.selectUnitList(params);
	                     
	                      unitGubun = EgovStringUtil.isNullToString(storeUnitList.get(0).get("unitGubun").toString());
	                      unitSeq = EgovStringUtil.isNullToString(storeUnitList.get(0).get("unitSeq").toString());
	                      
	                      System.out.println("##### unitGubun > " + unitGubun); 
	                      System.out.println("##### unitSeq > " + unitSeq); 
	                      
	                      List<Map<String, Object>> selectitemList = z3Sales2GaolService.selectitemList(params);
	                      System.out.println("1. ##### itemSeq > " + itemSeq);
	                      
	                      if(selectitemList.size()!=0) {
	                    	  itemSeq = EgovStringUtil.isNullToString(selectitemList.get(0).get("itemSeq").toString());
	                    	  System.out.println("2. ##### itemSeq > " + itemSeq);
	                      }
	                      
	                     for (int i = 3; i < data.length; i++) { // 단위/온오프라인 추가
	                    	int goalCnt = 0;
	                    	
	                        insertMap.put("zemosIdx", EgovStringUtil.isNullToString(params.get("zemosIdx")));
	                        insertMap.put("wrkplcIdx", EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
	                        insertMap.put("storeNm", storeName);
	                        insertMap.put("itemNm", itemName);
	                        insertMap.put("unitName", unitName);
	                        insertMap.put("onoffName", onoffName);
	                        insertMap.put("unitGubun", unitGubun);
	                        insertMap.put("unitSeq", unitSeq);
	                        insertMap.put("itemSeq", itemSeq);
	                        
	                        insertMap.put("storeSeq", EgovStringUtil.isNullToString(params.get("storeSeq")));
	                        //insertMap.put("onoffName", EgovStringUtil.isNullToString(params.get("onoffName")));
	                        insertMap.put("gbn", EgovStringUtil.isNullToString(params.get("gbn")));
	                        insertMap.put("year", EgovStringUtil.isNullToString(params.get("year")));
	                        insertMap.put("mm", mm2[i]);
	                        insertMap.put("amt", data[i]);
	                        insertMap.put("regUserSeq", loginVO.getIdx());
	                        insertMap.put("modUserSeq", loginVO.getIdx());

	                        goalCnt = z3Sales2GaolService.selectGoalCnt01(insertMap);
							if (goalCnt > 0) {
								savelResult = z3Sales2GaolService.updateGoal(insertMap);
							}else {
								savelResult = z3Sales2GaolService.insertGoal(insertMap);
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
	 * 엑셀 다운로드
	 * @param params
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2GoalExcelDownload.do")
	public void salesGoalExcelDownload(@RequestParam Map<String, Object> params, final HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		//다운로드 엑셀 파일명
		String excelFileName = "";
		//엑셀 템플릿 파일명
		String excelTempFileName = "";
		
		//단위명
		String unitName = null;
		//온/오프구분
		String onoffName = null;
		String unitGubun = null;
		String unitSeq = null;
		  
		List<Map<String, Object>> resultList = null;
		
		if ( "A".equals(EgovStringUtil.isNullToString(params.get("gbn"))) ) {
			excelFileName = "전체목표등록";
		} else {
			excelFileName = EgovStringUtil.isNullToString(params.get("storeNm")) + "_목표등록";
		}
		
		excelTempFileName = "sales_goal_template";
		
		//단위SEQ 온/오프 구분값 확인 + 품목명 추가
		params.put("itemName", EgovStringUtil.isNullToString(params.get("itemNm")));
        params.put("unitName", EgovStringUtil.isNullToString(params.get("unitNm")));
        params.put("onoffName", EgovStringUtil.isNullToString(params.get("onoffNm")));
        
		List<Map<String, Object>> selectUnitList01 = z3Sales2GaolService.selectUnitList01(params);
		
		unitGubun = EgovStringUtil.isNullToString(selectUnitList01.get(0).get("unitGubun").toString());
        unitSeq = EgovStringUtil.isNullToString(selectUnitList01.get(0).get("unitSeq").toString());
        
        params.put("unitGubun", unitGubun);
        params.put("unitSeq", unitSeq);
        
        resultList = z3Sales2GaolService.selectExcelDown(params);
		
		map.put("storeNm", EgovStringUtil.isNullToString(params.get("storeNm")));
		map.put("itemNm", EgovStringUtil.isNullToString(params.get("itemNm")));
		map.put("unitNm", EgovStringUtil.isNullToString(params.get("unitNm")));
		map.put("onoffNm", EgovStringUtil.isNullToString(params.get("onoffNm")));
		map.put("unitGubun", unitGubun);
		map.put("unitSeq", unitSeq);
		map.put("year", EgovStringUtil.isNullToString(params.get("year")));
		map.put("list", resultList);
		
		MakeExcel me = new MakeExcel();
		map.put("list", resultList);
		me.download(request, response, map, excelFileName, excelTempFileName + ".xlsx");
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
