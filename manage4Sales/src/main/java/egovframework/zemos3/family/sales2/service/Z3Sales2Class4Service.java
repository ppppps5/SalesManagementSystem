package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 분류3 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2Class4Service {
	
	/**
	 * 분류3 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class4Cnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class4(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectSales2Class04(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectClass4NameList(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class03(Map<String, Object> params) throws Exception;

	/**
	 * 분류3 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4Insert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류3 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4Update(Map<String, Object> params) throws Exception;
	
}
