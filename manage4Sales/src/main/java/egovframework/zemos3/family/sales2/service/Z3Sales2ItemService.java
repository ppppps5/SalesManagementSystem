package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 품목 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2ItemService {
	
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception;

	public int selectUnitListCnt(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectItemList(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectItemList01(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectItemList02(Map<String, Object> params) throws Exception;

	public List<Map<String, Object>> selectItemDetailList(Map<String, Object> params) throws Exception;

	public List<Map<String, Object>> selectItemUseNameList(Map<String, Object> params) throws Exception;
	
	public int selectItem(Map<String, Object> params) throws Exception;
	
	public int itemInsert(Map<String, Object> params) throws Exception;
	
	public int itemDetailInsertD(Map<String, Object> params) throws Exception;
	
	public int StoreitemInsert(Map<String, Object> params) throws Exception;
	
	public int itemDetailInsert(Map<String, Object> params) throws Exception;
	
	public int itemDetailDeleteD(Map<String, Object> params) throws Exception;
	
	public int itemUpdate(Map<String, Object> params) throws Exception;
	
	public int StoreitemUpdate(Map<String, Object> params) throws Exception;
	
	public int itemDetailUpdate(Map<String, Object> params) throws Exception;
	
}
