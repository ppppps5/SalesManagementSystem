package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류3 DAO 클래스
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
@Repository("z3Sales2Class4DAO")
public class Z3Sales2Class4DAO extends ZenielMAbstractDAO {

	/**
	 * 분류3 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class4Cnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class4.selectSales2Class4Cnt", params);
	}
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class4(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class4.selectSales2Class4", params);
	}
	
	public List<Map<String, Object>> selectSales2Class04(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class4.selectSales2Class04", params);
	}
	
	public List<Map<String, Object>> selectClass4NameList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class4.selectClass4NameList", params);
	}
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class03(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class4.selectSales2Class03", params);
	}
	
	/**
	 * 분류3 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4Insert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Class4.class4Insert", params);
    }
	
	/**
	 * 분류3 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4Update(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Class4.class4Update", params);
    }
	
}
