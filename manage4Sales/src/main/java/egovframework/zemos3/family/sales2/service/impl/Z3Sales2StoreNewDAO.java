package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류3 DAO 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2StoreNewDAO")
public class Z3Sales2StoreNewDAO extends ZenielMAbstractDAO {
	
	/**
	 * 매장 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectStoreNewCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewCnt", params);
	}
	
	/**
	 * 매장 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNewList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewList", params);
	}
	
	public List<Map<String, Object>> selectStoreNewDetailList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewDetailList", params);
	}
	
	public List<Map<String, Object>> selectStoreNewDetailItemList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewDetailItemList", params);
	}
	
	
	public List<Map<String, Object>> selectStoreNewSmList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewSmList", params);
	}
	
	public int storeInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2StoreNew.storeInsert", params);
	}
	
	public int storeDetailInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2StoreNew.storeNewDetailInsert", params);
	}
	
	public int storeItemInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2StoreNew.storeItemInsert", params);
	}
	
	public int storeSmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2StoreNew.storeSmInsert", params);
	}
	
	public int storeSmCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2StoreNew.storeSmCnt", params);
	}
	
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewUseNameList", params);
	}
	
	public List<Map<String, Object>> selectItemListNoDetail(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2StoreNew.selectItemListNoDetail", params);
	}
	
	public int storeUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2StoreNew.storeUpdate", params);
    }
	
	public int storeDetailUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2StoreNew.storeDetailUpdate", params);
	}
	
	public int storeDetailItemUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2StoreNew.storeDetailItemUpdate", params);
	}
	
	public int storeSmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2StoreNew.storeSmUpdate", params);
	}
	
	public int storeSmDeleteYnUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2StoreNew.storeSmDeleteYnUpdate", params);
	}
	
	public int selectStoreNewSmCount(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2StoreNew.selectStoreNewSmCount", params);
	}
	
}
