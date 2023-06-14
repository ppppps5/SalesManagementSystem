package egovframework.zemos3.family.sales2.web;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import egovframework.com.login.service.LoginService;
import egovframework.com.user.service.UserService;
import egovframework.zemos.zemos.service.ZemosService;
import egovframework.zemos.zemossetup.service.ZemosSetupService;
import egovframework.zemos3.family.sales2.service.Z3Sales2MainService;


/**
 * 판매실적관리 메인 Controller
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Controller
public class Z3Sales2MainController {

	private static final Logger LOGGER = LoggerFactory.getLogger(Z3Sales2MainController.class);

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

	//메인 Service
	@Resource(name = "z3Sales2MainService")
	private Z3Sales2MainService z3Sales2MainService;
}
