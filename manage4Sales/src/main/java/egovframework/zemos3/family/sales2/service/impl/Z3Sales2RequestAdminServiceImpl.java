package egovframework.zemos3.family.sales2.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2RequestAdminService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 수정요청관리 서비스Impl 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2RequestAdminService")
public class Z3Sales2RequestAdminServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2RequestAdminService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//수정요청관리 DAO
	@Resource(name = "z3Sales2RequestAdminDAO")
	private Z3Sales2RequestAdminDAO z3Sales2RequestAdminDAO;
		
}
