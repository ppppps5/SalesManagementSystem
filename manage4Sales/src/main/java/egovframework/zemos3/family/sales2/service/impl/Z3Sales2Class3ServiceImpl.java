package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class3Service;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 분류3 서비스Impl 클래스
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
@Service("z3Sales2Class3Service")
public class Z3Sales2Class3ServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2Class3Service {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//분류3 DAO
	@Resource(name = "z3Sales2Class3DAO")
	private Z3Sales2Class3DAO z3Sales2Class3DAO;

	/**
	 *분류3 count
	 */
	public int selectSales2Class3Cnt(Map<String, Object> params) throws Exception {
		return z3Sales2Class3DAO.selectSales2Class3Cnt(params);
	}
	
	/**
	 * 분류3 List
	 */
	public List<Map<String, Object>> selectSales2Class3(Map<String, Object> params) throws Exception {
		return z3Sales2Class3DAO.selectSales2Class3(params);
	}
	
	public List<Map<String, Object>> selectClass3NameList(Map<String, Object> params) throws Exception {
		return z3Sales2Class3DAO.selectClass3NameList(params);
	}
	
	/**
	 * 분류3 List
	 */
	public List<Map<String, Object>> selectSales2Class03(Map<String, Object> params) throws Exception {
		return z3Sales2Class3DAO.selectSales2Class03(params);
	}
	
	/**
	 * 분류3 insert
	 */
	public int class3Insert(Map<String, Object> params) throws Exception {
		return z3Sales2Class3DAO.class3Insert(params);
	}
	
	/**
	 * 분류3 update
	 */
	public int class3Update(Map<String, Object> params) throws Exception {
		return z3Sales2Class3DAO.class3Update(params);
	}
	
}
