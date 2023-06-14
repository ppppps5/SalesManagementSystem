package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 매장관리 서비스 클래스
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
public interface Z3Sales2StoreNewService {

	public List<Map<String, Object>> selectStoreNewList(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectStoreNewDetailList(Map<String, Object> params) throws Exception;
	
	
	public List<Map<String, Object>> selectStoreNewDetailItemList(Map<String, Object> params) throws Exception;
	
	
	public List<Map<String, Object>> selectStoreNewSmList(Map<String, Object> params) throws Exception;
	
	public int storeInsert(Map<String, Object> params) throws Exception;
	
	public int storeDetailInsert(Map<String, Object> params) throws Exception;
	
	public int storeItemInsert(Map<String, Object> params) throws Exception;
	
	public int storeSmInsert(Map<String, Object> params) throws Exception;
	
	public int storeSmCnt(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectItemListNoDetail(Map<String, Object> params) throws Exception;
	
	public int storeUpdate(Map<String, Object> params) throws Exception;
	
	public int storeDetailUpdate(Map<String, Object> params) throws Exception;
	
	public int storeDetailItemUpdate(Map<String, Object> params) throws Exception;
	
	public int storeSmUpdate(Map<String, Object> params) throws Exception;
	
	public int storeSmDeleteYnUpdate(Map<String, Object> params) throws Exception;
	
	public int selectStoreNewSmCount(Map<String, Object> params) throws Exception;
}
