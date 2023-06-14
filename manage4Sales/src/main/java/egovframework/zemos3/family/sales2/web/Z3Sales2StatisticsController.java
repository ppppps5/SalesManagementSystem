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
import egovframework.zemos3.family.sales2.service.Z3Sales2GaolService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class1Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class2Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class3Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class4Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class5Service;
import egovframework.zemos3.family.sales2.service.Z3Sales2StatisticsService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ClassService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UnitService;

/**
 * 판매실적관리 통계 Controller
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
public class Z3Sales2StatisticsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2StatisticsController.class);

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

	//판매관리 분류1 Service
	@Resource(name = "z3Sales2Class1Service")
	protected Z3Sales2Class1Service z3Sales2Class1Service;

	//판매관리 분류2 Service
	@Resource(name = "z3Sales2Class2Service")
	protected Z3Sales2Class2Service z3Sales2Class2Service;
	
	//판매관리 분류3 Service
	@Resource(name = "z3Sales2Class3Service")
	protected Z3Sales2Class3Service z3Sales2Class3Service;
	
	//판매관리 분류3 Service
	@Resource(name = "z3Sales2Class4Service")
	protected Z3Sales2Class4Service z3Sales2Class4Service;	
	
	//판매관리 분류3 Service
	@Resource(name = "z3Sales2Class5Service")
	protected Z3Sales2Class5Service z3Sales2Class5Service;	
	
	//판매관리 품목 Service
	@Resource(name = "z3Sales2ItemService")
	protected Z3Sales2ItemService z3Sales2ItemService;
		
	//통계 Service
	@Resource(name = "z3Sales2StatisticsService")
	private Z3Sales2StatisticsService z3Sales2StatisticsService;
	
	//매장 Service
	@Resource(name = "z3Sales2StoreService")
	protected Z3Sales2StoreService z3Sales2StoreService;

	//목표 Service
	@Resource(name = "z3Sales2GaolService")
	protected Z3Sales2GaolService z3Sales2GaolService;
	
	//단위 Service
	@Resource(name = "z3Sales2UnitService")
	private Z3Sales2UnitService z3Sales2UnitService;
	
	/**
	 * 통계 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/zemos3/family/sales2/sales2Statistics.do")
	public String sales2Statistics(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Statistics";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		String zemosIdx = EgovStringUtil.isNullToString(params.get("zemosIdx"));
		String zemosNm = EgovStringUtil.isNullToString(params.get("zemosNm"));
		model.put("userAdminGbn", EgovStringUtil.isNullToString(params.get("userAdminGbn")));
		
		//매장명
		List<Map<String, Object>> storeUseName = null;
		storeUseName = z3Sales2GaolService.selectStoreNewUseNameList(params);
		model.put("storeUseName", storeUseName);
		
		//item명
		List<Map<String, Object>> itemNmList = null;
		itemNmList = z3Sales2ClassService.selectItemNmList(params);
		model.put("itemNmList", itemNmList);
		
		
		//분류명 1~5
		List<Map<String, Object>> class1NmList = null;
		List<Map<String, Object>> class2NmList = null;
		List<Map<String, Object>> class3NmList = null;
		List<Map<String, Object>> class4NmList = null;
		List<Map<String, Object>> class5NmList = null;
		
		class1NmList = z3Sales2ClassService.selectSales2Class1Nm(params);
		class2NmList = z3Sales2ClassService.selectSales2Class2Nm(params);
		class3NmList = z3Sales2ClassService.selectSales2Class3Nm(params);
		class4NmList = z3Sales2ClassService.selectSales2Class4Nm(params);
		class5NmList = z3Sales2ClassService.selectSales2Class5Nm(params);
		
		model.put("class1NmList", class1NmList);
		model.put("class2NmList", class2NmList);
		model.put("class3NmList", class3NmList);
		model.put("class4NmList", class4NmList);
		model.put("class5NmList", class5NmList);
		
		//셀렉박스 매장 List 권한 별
		List<Map<String, Object>> storeList = null;
		storeList = z3Sales2StoreService.selectBoxStoreList(params);
		model.put("storeList", 	storeList);
		
		//품목list 사용하는품목만
		List<Map<String, Object>> salesItem = z3Sales2ItemService.selectItemList02(params);
		model.put("salesItem", salesItem);
		
		//단위list 사용 하는 단위만 표현
		List<Map<String, Object>> unitList = null;
		unitList = z3Sales2UnitService.selectSales2Unit01(params);
		model.put("unitList", unitList);
		
		//분류1
		List<Map<String, Object>> salesClass1 = z3Sales2Class1Service.selectSales2Class01(params);
		model.put("salesClass1", salesClass1);
		
		//분류2
		List<Map<String, Object>> salesClass2 = z3Sales2Class2Service.selectSales2Class02(params);
		model.put("salesClass2", salesClass2);
		
		//분류3
		List<Map<String, Object>> salesClass3 = z3Sales2Class3Service.selectSales2Class03(params);
		model.put("salesClass3", salesClass3);
		
		//분류4
		List<Map<String, Object>> salesClass4 = z3Sales2Class4Service.selectSales2Class04(params);
		model.put("salesClass4", salesClass4);
		
		//분류5
		List<Map<String, Object>> salesClass5 = z3Sales2Class5Service.selectSales2Class05(params);
		model.put("salesClass5", salesClass5);
		
		
		
		//시작월, 종료월
		//통계확인월
		
		return rtnurl;
	}
	/**
	 * 통계관리(차트)
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2ChartDataList.do")
	public ModelAndView sales2ChartDataList(@RequestParam Map<String, Object> params, HttpServletResponse response) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		String chartName = EgovStringUtil.isNullToString(params.get("chartName"));
		String ItemSeq = EgovStringUtil.isNullToString(params.get("ItemSeq"));
		String goalYn = EgovStringUtil.isNullToString(params.get("goalYn"));
		String taxtYn = EgovStringUtil.isNullToString(params.get("taxtYn"));	
		String onoffNM = EgovStringUtil.isNullToString(params.get("onoffNM"));
		String Unit = EgovStringUtil.isNullToString(params.get("Unit"));
		String TOP1 = EgovStringUtil.isNullToString(params.get("TOP1"));
		String TOP2 = EgovStringUtil.isNullToString(params.get("TOP2"));
		params.put("ItemSeq", ItemSeq);
		params.put("goalYn", goalYn);
		params.put("taxtYn", taxtYn);
		params.put("onoffNM", onoffNM);
		params.put("Unit", Unit);
		params.put("TOP1", TOP1);
		params.put("TOP2", TOP2);
		
		// 결과
		int result = 0;
		String resultMsg = "";
		List<Map<String, Object>> resultList = null;
		
		List<Map<String, Object>> resultJson = new ArrayList<Map<String, Object>>();
		
		if ( "chart1".equals(chartName) ) {
			resultList = z3Sales2StatisticsService.selectReport(params);
			resultJson = sales2ChartJson1(resultList, resultJson);
		} else if("chart11".equals(chartName)){
			resultList = z3Sales2StatisticsService.selectReport(params);
			resultJson = sales2ChartJson11(resultList, resultJson);
		}
		 else if("chart2".equals(chartName)){
			resultList = z3Sales2StatisticsService.selectReportMonth(params);
			resultJson = sales2MonthChartJson1(resultList, resultJson);
		} else if("chart3".equals(chartName)){
			resultList = z3Sales2StatisticsService.selectReportStore(params);
			resultJson = sales2StoreChartJson1(resultList, resultJson);
		} else {
			resultList = z3Sales2StatisticsService.selectReportItem(params);
			resultJson = sales2ItemChartJson1(resultList, resultJson);
		}
		
		modelAndView.addObject("result", resultList.size());
		modelAndView.addObject("resultList", resultJson);
		modelAndView.addObject("resultMsg", resultMsg);

		return modelAndView;
	}
	
	public static List<Map<String, Object>> sales2ChartJson1(List<Map<String, Object>> resultList, List<Map<String, Object>> resultJson) {

		int i = 1;
		for (Map<String, Object> map : resultList) {
			
			if (map == null || map.isEmpty()) {
				continue;
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String dateMonth = EgovStringUtil.isNullToString(map.get("DATE_MONTH"));
			if (dateMonth == null || dateMonth.isEmpty()) {
				continue;
			}
			
			if (dateMonth.length() < 6) {
				continue;
			}
			
			resultMap.put("month", dateMonth.substring(4, 6) + "월");
			
			String goalYn = EgovStringUtil.isNullToString(map.get("goalYn"));		
			
			if(goalYn.equals("1")){
				//목표
				resultMap.put("totGoal", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_GOAL")).replaceAll(",", "")));				
			}	
				//실적
				resultMap.put("totResult", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_RESULT")).replaceAll(",", "")));
				
			
			resultMap.put("color1", "#04D215");
			resultMap.put("color2", "#2A0CD0");
			resultMap.put("color3", "#FC8803");
			resultMap.put("color4", "#1FCFC6");
			
			resultJson.add(resultMap);
			
			i++;
			
			if (i == 13) {
				break;
			}
		}
		
		return resultJson;
	}
	
	public static List<Map<String, Object>> sales2ChartJson11(List<Map<String, Object>> resultList, List<Map<String, Object>> resultJson) {

		int i = 1;
		for (Map<String, Object> map : resultList) {
			
			if (map == null || map.isEmpty()) {
				continue;
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String dateMonth = EgovStringUtil.isNullToString(map.get("DATE_MONTH"));
			if (dateMonth == null || dateMonth.isEmpty()) {
				continue;
			}
			
			if (dateMonth.length() < 6) {
				continue;
			}
			
			resultMap.put("month", dateMonth.substring(4, 6) + "월");
			
			String goalYn = EgovStringUtil.isNullToString(map.get("goalYn"));		
			
			if(goalYn.equals("1")){
				//목표
				resultMap.put("totGoal", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_GOAL")).replaceAll(",", "")));				
			}	
				//실적
				resultMap.put("totResult", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_RESULT")).replaceAll(",", "")));
				
			
			resultMap.put("color1", "#04D215");
			resultMap.put("color2", "#2A0CD0");
			resultMap.put("color3", "#FC8803");
			resultMap.put("color4", "#1FCFC6");
			
			resultJson.add(resultMap);
			
			i++;
			
			if (i == 13) {
				break;
			}
		}
		
		return resultJson;
	}
	
	public static List<Map<String, Object>> sales2MonthChartJson1(List<Map<String, Object>> resultList, List<Map<String, Object>> resultJson) {

		int i = 1;
		for (Map<String, Object> map : resultList) {
			
			if (map == null || map.isEmpty()) {
				continue;
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String date = EgovStringUtil.isNullToString(map.get("DATE"));
			if (date == null || date.isEmpty()) {
				continue;
			}
			
			if (date.length() < 8) {
				continue;
			}
			
			resultMap.put("day", date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8));
			
			//실적
			resultMap.put("totResult", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_RESULT")).replaceAll(",", "")));
			
			String color = get2Color(date.substring(6, 8));
			resultMap.put("color", color);
			
			//resultMap.put("color1", "#04D215");
			//resultMap.put("color2", "#2A0CD0");
			
			resultJson.add(resultMap);
			
			//i++;
			
			//if (i == resultList.size()) {
			//	break;
			//}
		}
		
		return resultJson;
	}
	
	public static List<Map<String, Object>> sales2StoreChartJson1(List<Map<String, Object>> resultList, List<Map<String, Object>> resultJson) {

		int i = 1;
		for (Map<String, Object> map : resultList) {
			
			if (map == null || map.isEmpty()) {
				continue;
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String storenm = EgovStringUtil.isNullToString(map.get("storenm"));
			if (storenm == null || storenm.isEmpty()) {
				continue;
			}					
			
			resultMap.put("storenm", storenm);
			
			//목표
			resultMap.put("totGoal", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_GOAL")).replaceAll(",", "")));
			//실적
			resultMap.put("totResult", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_RESULT")).replaceAll(",", "")));
			
			resultMap.put("color1", "#04D215");
			resultMap.put("color2", "#2A0CD0");
			resultJson.add(resultMap);
			
			i++;
			
			//if (i == 13) {
			//	break;
			//}
		}
		
		return resultJson;
	}
	
	public static List<Map<String, Object>> sales2ItemChartJson1(List<Map<String, Object>> resultList, List<Map<String, Object>> resultJson) {

		int i = 1;
		for (Map<String, Object> map : resultList) {
			
			if (map == null || map.isEmpty()) {
				continue;
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			String itemnm = EgovStringUtil.isNullToString(map.get("itemnm"));
			if (itemnm == null || itemnm.isEmpty()) {
				continue;
			}					
			
			resultMap.put("itemnm", itemnm);
			
			//실적
			resultMap.put("totResult", Double.parseDouble(EgovStringUtil.isNullToString(map.get("TOT_RESULT")).replaceAll(",", "")));
			
			resultMap.put("color2", "#2A0CD0");
			resultJson.add(resultMap);
			
			i++;
			
			//if (i == 13) {
			//	break;
			//}
		}
		
		return resultJson;
	}
	
	/**
	 * 그래프색 코드값 반환
	 * 
	 * @param kind
	 * 
	 * @return String
	 */
	private static String get2Color(String kind) {
		
		String color = "";
        switch (kind) {
        
	        case "01":
	        	color = "#FF0F00";
	            break;
	            
	        case "02":
	        	color = "#FF6600";
	            break;
	            
	        case "03":
	        	color = "#FF9E01";
	            break;
	            
	        case "04":
	        	color = "#FCD202";
	            break;
	            
	        case "05":
	        	color = "#F8FF01";
	            break;
	            
	        case "06":
	        	color = "#B0DE09";
	            break;
	            
	        case "07":
	        	color = "#04D215";
	            break;
	            
	        case "08":
	        	color = "#0D8ECF";
	            break;
	            
	        case "09":
	        	color = "#0D52D1";
	            break;
	            
	        case "10":
	        	color = "#2A0CD0";
	            break;
	            
	        case "11":
	        	color = "#8A0CCF";
	            break;
	            
	        case "12":
	        	color = "#CD0D74";
	            break;
	        
	        case "13":
	        	color = "#CD0A74";
	        	break;
	        case "14":
	        	color = "#CD0B74";
	        	break;
	        case "15":
	        	color = "#CD0C74";
	        	break;
	        case "16":
	        	color = "#CD0E74";
	        	break;
	        case "17":
	        	color = "#CD0F74";
	        	break;
	        case "18":
	        	color = "#CD0G74";
	        	break;
	        case "19":
	        	color = "#CD0H74";
	        	break;
	        case "20":
	        	color = "#CD0I74";
	        	break;
	        case "21":
	        	color = "#CD0J74";
	        	break;
	        case "22":
	        	color = "#CD0K74";
	        	break;
	        case "23":
	        	color = "#CD0L74";
	        	break;
	        case "24":
	        	color = "#CD0M74";
	        	break;
	        case "25":
	        	color = "#CD0N74";
	        	break;
	        case "26":
	        	color = "#CD0O74";
	        	break;
	        case "27":
	        	color = "#CD0P74";
	        	break;
	        case "28":
	        	color = "#CD0Q74";
	        	break;
	        case "29":
	        	color = "#CD0R74";
	        	break;
	        case "30":
	        	color = "#CD0S74";
	        	break;
	        case "31":
	        	color = "#CD0T74";
	        	break;    
	            
	        case "1":
	        	color = "#FF0F00";
	            break;
	            
	        case "2":
	        	color = "#FF6600";
	            break;
	            
	        case "3":
	        	color = "#FF9E01";
	            break;
	            
	        case "4":
	        	color = "#FCD202";
	            break;
	            
	        case "5":
	        	color = "#F8FF01";
	            break;
	            
	        case "6":
	        	color = "#B0DE09";
	            break;
	            
	        case "7":
	        	color = "#04D215";
	            break;
	            
	        case "8":
	        	color = "#0D8ECF";
	            break;
	            
	        case "9":
	        	color = "#0D52D1";
	            break;
	            
	        default:
	            break;
        }
        
        return color;
	}
	
}
