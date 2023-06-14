package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 분류2 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2Class2Service {

	/**
	 * 분류2 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class2Cnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류2 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class2(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectClass2NameList(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류2 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class02(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류2 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2Insert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류2 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2Update(Map<String, Object> params) throws Exception;
}
