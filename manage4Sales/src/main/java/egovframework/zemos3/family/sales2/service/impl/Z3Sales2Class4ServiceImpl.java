package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class4Service;
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
@Service("z3Sales2Class4Service")
public class Z3Sales2Class4ServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2Class4Service {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//분류3 DAO
	@Resource(name = "z3Sales2Class4DAO")
	private Z3Sales2Class4DAO z3Sales2Class4DAO;

	/**
	 *분류3 count
	 */
	public int selectSales2Class4Cnt(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.selectSales2Class4Cnt(params);
	}
	
	/**
	 * 분류3 List
	 */
	public List<Map<String, Object>> selectSales2Class4(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.selectSales2Class4(params);
	}
	
	public List<Map<String, Object>> selectSales2Class04(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.selectSales2Class04(params);
	}
	
	public List<Map<String, Object>> selectClass4NameList(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.selectClass4NameList(params);
	}
	
	/**
	 * 분류3 List
	 */
	public List<Map<String, Object>> selectSales2Class03(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.selectSales2Class03(params);
	}
	
	/**
	 * 분류3 insert
	 */
	public int class4Insert(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.class4Insert(params);
	}
	
	/**
	 * 분류3 update
	 */
	public int class4Update(Map<String, Object> params) throws Exception {
		return z3Sales2Class4DAO.class4Update(params);
	}
	
}
