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
import egovframework.zemos3.family.sales2.service.Z3Sales2Class3Service;


/**
 * 판매실적관리 분류3 Controller
 * 
 * @author 이엠룩
 * @since 2022.09.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.09.01  이엠룩          최초 생성 
 *  </pre>
 */
@Controller
public class Z3Sales2Class3Controller {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2Class3Controller.class);

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

	//분류3 Service
	@Resource(name = "z3Sales2Class3Service")
	private Z3Sales2Class3Service z3Sales2Class3Service;
	
	/**
	 * 분류3 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Class3.do")
	public String sales2Class3(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Class3";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		int class3Cnt = 0;
		List<Map<String, Object>> class3List = null;
		
		class3Cnt = z3Sales2Class3Service.selectSales2Class3Cnt(params);
		class3List = z3Sales2Class3Service.selectSales2Class3(params);
		
		model.put("class3Cnt", class3Cnt);
		model.put("class3List", class3List);
		
		String class3UseNm = EgovStringUtil.isNullToString(params.get("class1UseNm"));
		
		List<Map<String, Object>> class3UseName = null;
		class3UseName = z3Sales2Class3Service.selectClass3NameList(params);
		
		model.put("class3UseName", class3UseName);
		model.put("class3UseNm", class3UseNm);
		
		return rtnurl;
	}
	
	/**
	 * 분류3 저장
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/class3Save.do")
	public ModelAndView class3Save(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("class3Nm",   EgovStringUtil.isNullToString(params.get("class3Nm")));
		insertMap.put("useYn", 	    EgovStringUtil.isNullToString(params.get("useYn")));
		insertMap.put("class3Seq",  EgovStringUtil.isNullToString(params.get("class3Seq")));
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int saveResult = 0;
		
		//중복값 체크 cnt
		int cnt = 0;
		//중복값 체크 cnt
		cnt = z3Sales2Class3Service.selectSales2Class3Cnt(insertMap);
		
		if ( cnt > 0 ) {
			//throw new Exception();
			modelAndView.addObject("result", false);
			model.put("resultError", "1");
			return modelAndView;
		}
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//insert
			saveResult = z3Sales2Class3Service.class3Insert(insertMap);
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//update
			saveResult = z3Sales2Class3Service.class3Update(insertMap);
		}
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
}
