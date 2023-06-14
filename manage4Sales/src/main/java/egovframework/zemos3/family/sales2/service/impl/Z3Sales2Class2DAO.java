package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류2 DAO 클래스
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2Class2DAO")
public class Z3Sales2Class2DAO extends ZenielMAbstractDAO {

	/**
	 * 분류2 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class2Cnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class2.selectSales2Class2Cnt", params);
	}
	
	/**
	 * 분류2 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class2(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class2.selectSales2Class2", params);
	}
	
	public List<Map<String, Object>> selectClass2NameList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class2.selectClass2NameList", params);
	}
	
	/**
	 * 분류2 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class02(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class2.selectSales2Class02", params);
	}
	
	/**
	 * 분류2 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2Insert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Class2.class2Insert", params);
    }
	
	/**
	 * 분류2 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2Update(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Class2.class2Update", params);
    }
}
