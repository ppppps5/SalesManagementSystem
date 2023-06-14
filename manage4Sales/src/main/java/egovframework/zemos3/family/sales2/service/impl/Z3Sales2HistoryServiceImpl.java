package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2HistoryService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 이력 서비스Impl 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2HistoryService")
public class Z3Sales2HistoryServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2HistoryService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//이력 DAO
	@Resource(name = "z3Sales2HistoryDAO")
	private Z3Sales2HistoryDAO z3Sales2HistoryDAO;
	
	/**
	 * 이력 List
	 */
	public List<Map<String, Object>> salesHistory(Map<String, Object> params) throws Exception {
		return z3Sales2HistoryDAO.salesHistory(params);
	}
	/**
	 *이력 count
	 */
	public Map<String, Object> salesHistoryCnt(Map<String, Object> params) throws Exception {
		return z3Sales2HistoryDAO.salesHistoryCnt(params);
	}
	
}
