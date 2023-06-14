package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 이력 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2HistoryService {
	
	public List<Map<String, Object>> salesHistory(Map<String, Object> params) throws Exception;
	
	public Map<String, Object> salesHistoryCnt(Map<String, Object> params) throws Exception;
	
	
}
