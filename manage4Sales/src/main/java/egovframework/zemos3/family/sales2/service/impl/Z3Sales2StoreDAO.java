package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류3 DAO 클래스
 * 
 * @author 이엠룩
 * @since 2021.08.13
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2021.08.13  이엠룩          최초 생성 
 *  </pre>
 */
@Repository("z3Sales2StoreDAO")
public class Z3Sales2StoreDAO extends ZenielMAbstractDAO {
	
	/**
	 * 매장 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectStoreCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Store.selectStoreCnt", params);
	}
	
	/**
	 * onOff count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int onOffCnt(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2Store.onOffCnt", params);
	}
	
	/**
	 * 매장 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Store.selectStoreList", params);
	}
	
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Store.selectBoxStoreList", params);
	}
	
	public List<Map<String, Object>> selectAppStoreList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Store.selectAppStoreList", params);
	}
	
	public int selectStore(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Store.selectStore", params);
    }
	
	public int storeInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Store.storeInsert", params);
    }
	
	public int storeUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Store.storeUpdate", params);
    }
	
	public Map selectStoreDetailCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Store.selectStoreDetailCnt", params);
    }
	
	public Map<String, Object> selectStoreDetail(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Store.selectStoreDetail", params);
    }
	
	public int storeDetailItemCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Store.storeDetailItemCnt", params);
    }	
	
	public List<Map<String, Object>> selectStoreDetailItem(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Store.selectStoreDetailItem", params);
	}
	
	public int storeDetailInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Store.storeDetailInsert", params);
    }
	
	public int storeDetailItemInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Store.storeDetailItemInsert", params);
    }
	
	public int storeDetailUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Store.storeDetailUpdate", params);
    }
	
	public int storeDetailItemUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Store.storeDetailItemUpdate", params);
    }
	
	public List<Map<String, Object>> storeuserList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Store.storeuserList", params);
	}
	
	
}
