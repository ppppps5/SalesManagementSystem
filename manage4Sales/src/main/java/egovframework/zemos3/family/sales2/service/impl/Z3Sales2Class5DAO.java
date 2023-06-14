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
@Repository("z3Sales2Class5DAO")
public class Z3Sales2Class5DAO extends ZenielMAbstractDAO {

	/**
	 * 분류3 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2Class5Cnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class5.selectSales2Class5Cnt", params);
	}
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class5(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class5.selectSales2Class5", params);
	}
	
	public List<Map<String, Object>> selectSales2Class05(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class5.selectSales2Class05", params);
	}
	
	public List<Map<String, Object>> selectClass5NameList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class5.selectClass5NameList", params);
	}
	
	/**
	 * 분류3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class03(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class5.selectSales2Class03", params);
	}
	
	/**
	 * 분류3 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class5Insert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Class5.class5Insert", params);
    }
	
	/**
	 * 분류3 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class5Update(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Class5.class5Update", params);
    }
	
}
