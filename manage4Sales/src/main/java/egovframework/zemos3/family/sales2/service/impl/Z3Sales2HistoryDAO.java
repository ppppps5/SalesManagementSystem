package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 이력 DAO 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2HistoryDAO")
public class Z3Sales2HistoryDAO extends ZenielMAbstractDAO {
	
	/**
	 * 이력 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> salesHistory(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2History.salesHistory", params);
	}
	/**
	 * 이력 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> salesHistoryCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2History.salesHistoryCnt", params);
	}
}
