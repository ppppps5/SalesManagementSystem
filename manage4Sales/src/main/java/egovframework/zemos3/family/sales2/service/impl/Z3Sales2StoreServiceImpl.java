package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StoreService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 분류3 서비스Impl 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2StoreService")
public class Z3Sales2StoreServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2StoreService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//매장관리 DAO
	@Resource(name = "z3Sales2StoreDAO")
	private Z3Sales2StoreDAO z3Sales2StoreDAO;

	/**
	 *매장 count
	 */
	public int selectStoreCnt(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectStoreCnt(params);
	}
	
	/**
	 *onOff count
	 */
	public int onOffCnt(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.onOffCnt(params);
	}
	
	/**
	 * 매장 List
	 */
	public List<Map<String, Object>> selectStoreList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectStoreList(params);
	}
	
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectBoxStoreList(params);
	}
	
	public List<Map<String, Object>> selectAppStoreList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectAppStoreList(params);
	}
	
	public int selectStore(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectStore(params);
	}
	
	public int storeInsert(Map<String, Object> params) throws Exception {
		//z3Sales2StoreDAO.store2DetailInsert(params);
		//z3Sales2StoreDAO.store2ItemInsert(params);
		return z3Sales2StoreDAO.storeInsert(params);
	}
	
	public int storeUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeUpdate(params);
	}
	
	public Map selectStoreDetailCnt(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectStoreDetailCnt(params);
	}
	
	
	public Map<String, Object> selectStoreDetail(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectStoreDetail(params);
	}
	
	public int storeDetailItemCnt(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeDetailItemCnt(params);
	}
	
	public List<Map<String, Object>> selectStoreDetailItem(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.selectStoreDetailItem(params);
	}
	
	
	public int storeDetailInsert(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeDetailInsert(params);
	}
	
	public int storeDetailItemInsert(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeDetailItemInsert(params);
	}
	
	public int storeDetailUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeDetailUpdate(params);
	}
	
	public int storeDetailItemUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeDetailItemUpdate(params);
	}
	
	public List<Map<String, Object>> storeuserList(Map<String, Object> params) throws Exception {
		return z3Sales2StoreDAO.storeuserList(params);
	}
}
