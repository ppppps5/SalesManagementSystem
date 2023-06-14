package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ClassService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 품목/분류명관리 서비스Impl 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2ClassService")
public class Z3Sales2ClassServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2ClassService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	// 품목/분류명관리 DAO
	@Resource(name = "z3Sales2ClassDAO")
	private Z3Sales2ClassDAO z3Sales2ClassDAO;
	
	/**
	 * 매장명칭 List
	 */
	public List<Map<String, Object>> selectStoreNmList(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectStoreNmList(params);
	}
	
	/**
	 * 품목명칭 List
	 */
	public List<Map<String, Object>> selectItemNmList(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectItemNmList(params);
	}
	
	public int selectSales2Class1NmCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class1NmCnt(params);
	}
	
	public int selectSales2Class2NmCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class2NmCnt(params);
	}
	
	public int selectSales2Class3NmCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class3NmCnt(params);
	}
	
	public int selectSales2Class4NmCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class4NmCnt(params);
	}
	
	public int selectSales2Class5NmCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class5NmCnt(params);
	}
	
	/**
	 * 분류명칭1 List
	 */
	public List<Map<String, Object>> selectSales2Class1Nm(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class1Nm(params);
	}
	
	/**
	 * 분류명칭2 List
	 */
	public List<Map<String, Object>> selectSales2Class2Nm(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class2Nm(params);
	}
	
	/**
	 * 분류명칭3 List
	 */
	public List<Map<String, Object>> selectSales2Class3Nm(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class3Nm(params);
	}
	
	/**
	 * 분류명칭4 List
	 */
	public List<Map<String, Object>> selectSales2Class4Nm(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class4Nm(params);
	}
	
	/**
	 * 분류명칭5 List
	 */
	public List<Map<String, Object>> selectSales2Class5Nm(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.selectSales2Class5Nm(params);
	}
		
	/**
	 * 매장명칭 insert
	 */
	public int storeNmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.storeNmInsert(params);
	}
	
	/**
	 * 품목명칭 insert
	 */
	public int itemNmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.itemNmInsert(params);
	}
	
	/**
	 * 분류명칭1 insert
	 */
	public int class1NmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class1NmInsert(params);
	}
	
	/**
	 * 분류명칭2 insert
	 */
	public int class2NmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class2NmInsert(params);
	}
	
	/**
	 * 분류명칭3 insert
	 */
	public int class3NmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class3NmInsert(params);
	}
	
	/**
	 * 분류명칭4 insert
	 */
	public int class4NmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class4NmInsert(params);
	}
	
	/**
	 * 분류명칭5 insert
	 */
	public int class5NmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class5NmInsert(params);
	}
	
	/**
	 * 매장명칭 update
	 */
	public int storeNmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.storeNmUpdate(params);
	}
	
	/**
	 * 품목명칭 update
	 */
	public int itemNmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.itemNmUpdate(params);
	}
	
	/**
	 * 분류명칭1 update
	 */
	public int class1NmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class1NmUpdate(params);
	}
	
	/**
	 * 분류명칭2 update
	 */
	public int class2NmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class2NmUpdate(params);
	}
	
	/**
	 * 분류명칭3 update
	 */
	public int class3NmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class3NmUpdate(params);
	}
	
	/**
	 * 분류명칭4 update
	 */
	public int class4NmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class4NmUpdate(params);
	}
	
	/**
	 * 분류명칭5 update
	 */
	public int class5NmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ClassDAO.class5NmUpdate(params);
	}
	
}
