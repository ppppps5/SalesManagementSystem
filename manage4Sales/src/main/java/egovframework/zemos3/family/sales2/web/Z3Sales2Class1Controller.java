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


/**
 * 판매실적관리 분류1 Controller
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Controller
public class Z3Sales2Class1Controller {

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

	//분류1 Service
	@Resource(name = "z3Sales2Class1Service")
	private Z3Sales2Class1Service z3Sales2Class1Service;
	
	/**
	 * 분류1 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Class1.do")
	public String sales2Class1(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Class1";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		int class1Cnt = 0;
		List<Map<String, Object>> class1List = null;
		
		class1Cnt = z3Sales2Class1Service.selectSales2Class1Cnt(params);
		class1List = z3Sales2Class1Service.selectSales2Class1(params);
		
		
		
		model.put("class1Cnt", class1Cnt);
		model.put("class1List", class1List);
		
		String class1UseNm = EgovStringUtil.isNullToString(params.get("class1UseNm"));
		
		List<Map<String, Object>> class1UseName = null;
		class1UseName = z3Sales2Class1Service.selectClass1NameList(params);
		
		model.put("class1UseName", class1UseName);
		model.put("class1UseNm", class1UseNm);
		
		return rtnurl;
	}
	
	/**
	 * 분류1 저장
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/class1Save.do")
	public ModelAndView class1Save(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("class1Nm",   EgovStringUtil.isNullToString(params.get("class1Nm")));
		insertMap.put("useYn", 	    EgovStringUtil.isNullToString(params.get("useYn")));
		insertMap.put("class1Seq",  EgovStringUtil.isNullToString(params.get("class1Seq")));
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int saveResult = 0;
		
		//중복값 체크 cnt
		int cnt = 0;
		//중복값 체크 cnt
		cnt = z3Sales2Class1Service.selectSales2Class1Cnt(insertMap);
		
		if ( cnt > 0 ) {
			//throw new Exception();
			modelAndView.addObject("result", false);
			model.put("resultError", "1");
			return modelAndView;
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//insert
			saveResult = z3Sales2Class1Service.class1Insert(insertMap);
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//update
			saveResult = z3Sales2Class1Service.class1Update(insertMap);
		}
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
}
