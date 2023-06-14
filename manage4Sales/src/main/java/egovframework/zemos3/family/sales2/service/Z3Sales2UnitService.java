package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 단위 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2UnitService {
	
	/**
	 * 단위 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2UnitCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 단위 count for insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2UnitCntForInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 단위 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Unit(Map<String, Object> params) throws Exception;
	
	/**
	 * 단위 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Unit01(Map<String, Object> params) throws Exception;
	
	/**
	 * 단위 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int unitInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 품목단위 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int ItemunitInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 단위 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int unitUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 품목단위 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int ItemunitUpdate(Map<String, Object> params) throws Exception;
	
}
