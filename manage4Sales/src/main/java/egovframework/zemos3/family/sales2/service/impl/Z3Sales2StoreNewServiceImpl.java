package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreNewService;
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
@Service("z3Sales2StoreNewService")
public class Z3Sales2StoreNewServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2StoreNewService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//매장관리 DAO
	@Resource(name = "z3Sales2StoreNewDAO")
	private Z3Sales2StoreNewDAO z3Sales2StoreNewDAO;

	/**
	 *매장 count
	 */
	public int selectStoreNewCnt(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewCnt(params);
	}
	
	
	/**
	 * 매장 List
	 */
	public List<Map<String, Object>> selectStoreNewList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewList(params);
	}
	
	public List<Map<String, Object>> selectStoreNewDetailList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewDetailList(params);
	}
	
	
	public List<Map<String, Object>> selectStoreNewDetailItemList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewDetailItemList(params);
	}
	
	
	public List<Map<String, Object>> selectStoreNewSmList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewSmList(params);
	}
	
	public int storeInsert(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeInsert(params);
	}
	
	public int storeDetailInsert(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeDetailInsert(params);
	}
	
	public int storeItemInsert(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeItemInsert(params);
	}
	
	public int storeSmInsert(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeSmInsert(params);
	}
	
	public int storeSmCnt(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeSmCnt(params);
	}
	
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewUseNameList(params);
	}
	
	public List<Map<String, Object>> selectItemListNoDetail(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectItemListNoDetail(params);
	}
	
	public int storeUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeUpdate(params);
	}
	
	public int storeDetailUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeDetailUpdate(params);
	}
	
	public int storeDetailItemUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeDetailItemUpdate(params);
	}
	
	public int storeSmUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeSmUpdate(params);
	}
	
	public int storeSmDeleteYnUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.storeSmDeleteYnUpdate(params);
	}
	
	public int selectStoreNewSmCount(Map<String, Object> params) throws Exception {
		return z3Sales2StoreNewDAO.selectStoreNewSmCount(params);
	}
	
}
