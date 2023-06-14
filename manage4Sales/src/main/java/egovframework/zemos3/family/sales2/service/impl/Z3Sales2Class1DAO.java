package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류1 DAO 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2Class1DAO")
public class Z3Sales2Class1DAO extends ZenielMAbstractDAO {
	
	/**
	 * 분류1 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class1Cnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class1.selectSales2Class1Cnt", params);
	}
	
	/**
	 * 분류1 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class1(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class1.selectSales2Class1", params);
	}
	
	public List<Map<String, Object>> selectClass1NameList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class1.selectClass1NameList", params);
	}
	
	/**
	 * 분류1 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class01(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class1.selectSales2Class01", params);
	}
	
	/**
	 * 분류1 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class1Insert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Class1.class1Insert", params);
    }
	
	/**
	 * 분류1 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class1Update(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Class1.class1Update", params);
    }
	
}
