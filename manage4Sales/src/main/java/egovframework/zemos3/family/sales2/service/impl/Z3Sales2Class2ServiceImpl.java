package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2Class2Service;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 분류2 서비스Impl 클래스
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
@Service("z3Sales2Class2Service")
public class Z3Sales2Class2ServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2Class2Service {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//분류2 DAO
	@Resource(name = "z3Sales2Class2DAO")
	private Z3Sales2Class2DAO z3Sales2Class2DAO;
		
	/**
	 *분류2 count
	 */
	public int selectSales2Class2Cnt(Map<String, Object> params) throws Exception {
		return z3Sales2Class2DAO.selectSales2Class2Cnt(params);
	}
	
	/**
	 * 분류2 List
	 */
	public List<Map<String, Object>> selectSales2Class2(Map<String, Object> params) throws Exception {
		return z3Sales2Class2DAO.selectSales2Class2(params);
	}
	
	public List<Map<String, Object>> selectClass2NameList(Map<String, Object> params) throws Exception {
		return z3Sales2Class2DAO.selectClass2NameList(params);
	}
	
	/**
	 * 분류2 List
	 */
	public List<Map<String, Object>> selectSales2Class02(Map<String, Object> params) throws Exception {
		return z3Sales2Class2DAO.selectSales2Class2(params);
	}
	
	/**
	 * 분류2 insert
	 */
	public int class2Insert(Map<String, Object> params) throws Exception {
		return z3Sales2Class2DAO.class2Insert(params);
	}
	
	/**
	 * 분류2 update
	 */
	public int class2Update(Map<String, Object> params) throws Exception {
		return z3Sales2Class2DAO.class2Update(params);
	}
}
