package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 매장관리 서비스 클래스
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
public interface Z3Sales2StoreService {

	public List<Map<String, Object>> selectStoreList(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectAppStoreList(Map<String, Object> params) throws Exception;
	
	public int selectStore(Map<String, Object> params) throws Exception;
	
	public int storeInsert(Map<String, Object> params) throws Exception;
	
	public int storeUpdate(Map<String, Object> params) throws Exception;
	
	public Map selectStoreDetailCnt(Map<String, Object> params) throws Exception;
	
	public Map<String, Object> selectStoreDetail(Map<String, Object> params) throws Exception;
	
	public int storeDetailItemCnt(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectStoreDetailItem(Map<String, Object> params) throws Exception;
	
	public int storeDetailInsert(Map<String, Object> params) throws Exception;
	
	public int storeDetailItemInsert(Map<String, Object> params) throws Exception;
	
	public int storeDetailUpdate(Map<String, Object> params) throws Exception;
	
	public int storeDetailItemUpdate(Map<String, Object> params) throws Exception;
	
	public List storeuserList(Map<String, Object> params) throws Exception;
	
	public int onOffCnt(Map<String, Object> params) throws Exception;
}
