package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UnitService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 단위 서비스Impl 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2UnitService")
public class Z3Sales2UnitServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2UnitService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//단위 DAO
	@Resource(name = "z3Sales2UnitDAO")
	private Z3Sales2UnitDAO z3Sales2UnitDAO; 
	
	/**
	 *단위 count
	 */
	public int selectSales2UnitCnt(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.selectSales2UnitCnt(params);
	}
	/**
	 *단위 count for insert
	 */
	public int selectSales2UnitCntForInsert(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.selectSales2UnitCntForInsert(params);
	}
	
	/**
	 * 단위 List 
	 */
	public List<Map<String, Object>> selectSales2Unit(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.selectSales2Unit(params);
	}
	
	/**
	 * 단위 List
	 */
	public List<Map<String, Object>> selectSales2Unit01(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.selectSales2Unit01(params);
	}
		
	/**
	 * 단위 insert
	 */
	public int unitInsert(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.unitInsert(params);
	}
	
	/**
	 * 단위 update
	 */
	public int unitUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.unitUpdate(params);
	}
	
	/**
	 * 품목단위 insert
	 */
	public int ItemunitInsert(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.ItemunitInsert(params);
	}
	
	/**
	 * 품목단위 update
	 */
	public int ItemunitUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2UnitDAO.ItemunitUpdate(params);
	}
	
}
