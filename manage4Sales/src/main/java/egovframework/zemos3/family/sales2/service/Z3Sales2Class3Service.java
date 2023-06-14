package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 분류3 서비스 클래스
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
public interface Z3Sales2Class3Service {
	
	/**
	 * 분류3 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class3Cnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class3(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectClass3NameList(Map<String, Object> params) throws Exception;
	
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
	public int class3Insert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류3 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class3Update(Map<String, Object> params) throws Exception;
	
}
