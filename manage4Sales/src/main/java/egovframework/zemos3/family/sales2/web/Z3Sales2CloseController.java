package egovframework.zemos3.family.sales2.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import egovframework.zemos3.family.sales2.service.Z3Sales2CloseService;


/**
 * 판매실적관리 분류1 Controller
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
public class Z3Sales2CloseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2CloseController.class);

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
	@Resource(name = "z3Sales2CloseService")
	private Z3Sales2CloseService z3Sales2CloseService;
	
	/**
	 * 마감 화면
	 * @param model
	 * @param params
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/sales2Close.do")
	public String sales2Close(ModelMap model, @RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rtnurl = "egovframework/zemos3/family/sales2/sales2Close";

		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		params.put("regUserSeq", loginVO.getIdx());
		
		// 권한
		List<String> resultAuth = zemosService.zemosAuth(params);
		model.put("resultAuth", resultAuth);
		
		int closeCnt = 0;
		List<Map<String, Object>> yyyyList = null;
		List<Map<String, Object>> closeList = null;
		
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
		
		//현재년도의 이전 15년 ~ 이후 3년
		yyyyList = z3Sales2CloseService.selectYyyy(params);
		
		closeCnt = z3Sales2CloseService.selectSales2CloseCnt(params);
		
		if ( closeCnt == 0 ) {
			
			Map<String, Object> insertMap = new HashMap<String, Object>();
			
			insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
			insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
			insertMap.put("yyyy",  EgovStringUtil.isNullToString(params.get("yyyy")));
			
			z3Sales2CloseService.closeInsert(insertMap);
		}
		
		closeList = z3Sales2CloseService.selectSales2Close(params);
		
		
		model.put("yyyyList", yyyyList);
		
		model.put("closeCnt", closeCnt);
		model.put("closeList", closeList);
		
		
		
		return rtnurl;
	}
	
	/**
	 * 마감 저장
	 * @param model
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/zemos3/family/sales2/closeSave.do")
	public ModelAndView closeSave(ModelMap model, @RequestParam Map<String, Object> params) throws Exception {

		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.addObject("result", false);
		
		// 로그인 정보
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, Object> insertMap = new HashMap<String, Object>();
		insertMap.put("zemosIdx",   EgovStringUtil.isNullToString(params.get("zemosIdx")));
		insertMap.put("wrkplcIdx",  EgovStringUtil.isNullToString(params.get("wrkplcIdx")));
		insertMap.put("Yyyy",   EgovStringUtil.isNullToString(params.get("Yyyy")));
		insertMap.put("closeYn", 	    EgovStringUtil.isNullToString(params.get("closeYn")));
		insertMap.put("closeSeq",  EgovStringUtil.isNullToString(params.get("closeSeq")));
		insertMap.put("regUserSeq", loginVO.getIdx());
		insertMap.put("modUserSeq", loginVO.getIdx());
		
		//저장
		int saveResult = 0;
		
		if ( "insert".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//insert
			saveResult = z3Sales2CloseService.closeInsert(insertMap);
		} else if ( "update".equals(EgovStringUtil.isNullToString(params.get("saveGbn"))) ) {
			//update
			saveResult = z3Sales2CloseService.closeUpdate(insertMap);
		}
		
		// 리턴
		modelAndView.addObject("result", true);
		model.put("resultResponse", saveResult);
		
		return modelAndView;
	}
	
}
