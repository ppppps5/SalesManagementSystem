package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류1 DAO 클래스
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
@Repository("z3Sales2CloseDAO")
public class Z3Sales2CloseDAO extends ZenielMAbstractDAO {
	
	/**
	 * 마감 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2CloseCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Close.selectSales2CloseCnt", params);
	}
	
	/**
	 * 마감 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Close(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Close.selectSales2Close", params);
	}
	
	/**
	 * 마감01 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class01(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Close.selectSales2Class01", params);
	}
	/**
	 * 화면 년도 selectbox(현재년도의 이전 15년 ~ 이후 3년)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Close.selectYyyy", params);
	}
	
	/**
	 * 마감 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int closeInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Close.closeInsert", params);
    }
	
	/**
	 * 마감 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int closeUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Close.closeUpdate", params);
    }
	
}
