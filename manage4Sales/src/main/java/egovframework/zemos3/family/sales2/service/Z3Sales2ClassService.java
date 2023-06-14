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
public interface Z3Sales2ClassService {
	
	/**
	 * 매장명칭 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNmList(Map<String, Object> params) throws Exception;
	
	/**
	 * 품목명칭 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectItemNmList(Map<String, Object> params) throws Exception;
	
	public int selectSales2Class1NmCnt(Map<String, Object> params) throws Exception;
	
	public int selectSales2Class2NmCnt(Map<String, Object> params) throws Exception;
	
	public int selectSales2Class3NmCnt(Map<String, Object> params) throws Exception;
	
	public int selectSales2Class4NmCnt(Map<String, Object> params) throws Exception;
	
	public int selectSales2Class5NmCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭1 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class1Nm(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭2 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class2Nm(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class3Nm(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭4 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class4Nm(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭5 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class5Nm(Map<String, Object> params) throws Exception;
	
	/**
	 * 매장명칭 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int storeNmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 품목명칭 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int itemNmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭1 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class1NmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭2 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2NmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭3 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class3NmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭4 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4NmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭5 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class5NmInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 매장명칭 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int storeNmUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 품목명칭 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int itemNmUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭1 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class1NmUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭2 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2NmUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭3 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class3NmUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭4 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4NmUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 분류명칭5 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class5NmUpdate(Map<String, Object> params) throws Exception;
	
}
