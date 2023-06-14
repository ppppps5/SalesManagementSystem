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
import egovframework.zemos3.family.sales2.service.Z3Sales2UnitService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;


/**
 * 판매실적관리 단위 Controller
 * 
 * @author 이엠룩
 * @since 2022.08.29
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.08.29  이엠룩          최초 생성 
 *  </pre>
 */
@Controller
public class Z3Sales2UnitController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2UnitController.class);

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

	//단위 Service
	@Resource(name = "z3Sales2UnitService")
	private Z3Sales2UnitService z3Sales2UnitService;
	
	//품목 Service
	@Resource(name = "z3Sales2ItemService")
	private Z3Sales2ItemService z3Sales2ItemService;
	
	/**
	 * 단위 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Unit.do")
	public String sales2Unit(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Unit";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		int unitCnt = 0;
		List<Map<String, Object>> unitList = null;
		
		unitCnt = z3Sales2UnitService.selectSales2UnitCnt(params);
		unitList = z3Sales2UnitService.selectSales2Unit(params);
		
		model.put("unitCnt", unitCnt);
		model.put("unitList", unitList);
		
		return rtnurl;
	}
	
	/**
	 * 단위 저장
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/unitSave.do")
	public ModelAndView unitSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("unitNm",   EgovStringUtil.isNullToString(params.get("unitNm")));
		insertMap.put("useYn", 	    EgovStringUtil.isNullToString(params.get("useYn")));
		insertMap.put("unitSeq",  EgovStringUtil.isNullToString(params.get("unitSeq")));
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int saveResult = 0;
		int saveItemResult = 0;
		
		//중복값 체크 cnt
		int cnt = 0;
		//중복값 체크 cnt
		cnt = z3Sales2UnitService.selectSales2UnitCntForInsert(insertMap);
		
		int cnt1 = 0;
		//중복값 체크 cnt
		cnt1 = z3Sales2ItemService.selectItem(insertMap);
		
		if ( cnt > 0 ) {
			//throw new Exception();
			modelAndView.addObject("result", false);
			model.put("resultError", "1");
			return modelAndView; 
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//insert
			saveResult = z3Sales2UnitService.unitInsert(insertMap);
			if ( cnt1 > 0 ) {
				saveItemResult = z3Sales2UnitService.ItemunitInsert(insertMap); 
			}
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//update
			saveResult = z3Sales2UnitService.unitUpdate(insertMap);
			//if ( cnt1 > 0 ) {
				saveItemResult = z3Sales2UnitService.ItemunitUpdate(insertMap); 
			//}
		}
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
}
