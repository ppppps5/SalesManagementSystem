package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class5Service;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 분류3 서비스Impl 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2Class5Service")
public class Z3Sales2Class5ServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2Class5Service {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//분류3 DAO
	@Resource(name = "z3Sales2Class5DAO")
	private Z3Sales2Class5DAO z3Sales2Class5DAO;

	/**
	 *분류3 count
	 */
	public int selectSales2Class5Cnt(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.selectSales2Class5Cnt(params);
	}
	
	/**
	 * 분류3 List
	 */
	public List<Map<String, Object>> selectSales2Class5(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.selectSales2Class5(params);
	}
	
	public List<Map<String, Object>> selectSales2Class05(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.selectSales2Class05(params);
	}
	
	public List<Map<String, Object>> selectClass5NameList(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.selectClass5NameList(params);
	}
	
	/**
	 * 분류3 List
	 */
	public List<Map<String, Object>> selectSales2Class03(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.selectSales2Class03(params);
	}
	
	/**
	 * 분류3 insert
	 */
	public int class5Insert(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.class5Insert(params);
	}
	
	/**
	 * 분류3 update
	 */
	public int class5Update(Map<String, Object> params) throws Exception {
		return z3Sales2Class5DAO.class5Update(params);
	}
	
}
