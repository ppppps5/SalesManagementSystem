package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 분류1 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2CloseService {
	
	/**
	 * 마감 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2CloseCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 마감 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Close(Map<String, Object> params) throws Exception;
	
	/**
	 * 마감01 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	
	public List<Map<String, Object>> selectSales2Class01(Map<String, Object> params) throws Exception;
	
	/**
	 * 마감 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int closeInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 마감 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int closeUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 화면 년도 selectbox(현재년도의 이전 15년 ~ 이후 3년)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception;
	
}
