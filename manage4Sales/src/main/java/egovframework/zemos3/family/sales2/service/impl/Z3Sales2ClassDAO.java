package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 분류1 DAO 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2ClassDAO")
public class Z3Sales2ClassDAO extends ZenielMAbstractDAO {
	
	/**
	 * 매장명칭 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNmList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Class.selectStoreNmList", params);
	}
	
	/**
	 * 품목명칭 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectItemNmList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Class.selectItemNmList", params);
	}
	
	public int selectSales2Class1NmCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class1NmCnt", params);
	}
	
	public int selectSales2Class2NmCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class2NmCnt", params);
	}
	
	public int selectSales2Class3NmCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class3NmCnt", params);
	}
	
	public int selectSales2Class4NmCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class4NmCnt", params);
	}
	
	public int selectSales2Class5NmCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class5NmCnt", params);
	}
	
	/**
	 * 분류명칭1 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class1Nm(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class1Nm", params);
	}
	
	/**
	 * 분류명칭2 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class2Nm(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class2Nm", params);
	}
	
	/**
	 * 분류명칭3 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class3Nm(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class3Nm", params);
	}
	
	/**
	 * 분류명칭4 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class4Nm(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class4Nm", params);
	}
	
	/**
	 * 분류명칭5 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Class5Nm(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Class.selectSales2Class5Nm", params);
	}
	
	/**
	 * 매장명칭 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int storeNmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2Class.storeNmInsert", params);
	}
	
	/**
	 * 품목명칭 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int itemNmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2Class.itemNmInsert", params);
	}
	
	/**
	 * 분류명칭1 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class1NmInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Class.class1NmInsert", params);
    }
	
	/**
	 * 분류명칭2 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2NmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2Class.class2NmInsert", params);
	}
	
	/**
	 * 분류명칭3 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class3NmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2Class.class3NmInsert", params);
	}
	
	/**
	 * 분류명칭4 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4NmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2Class.class4NmInsert", params);
	}
	
	/**
	 * 분류명칭5 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class5NmInsert(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2Class.class5NmInsert", params);
	}
	
	/**
	 * 매장명칭 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int storeNmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Class.storeNmUpdate", params);
	}
	
	/**
	 * 품목명칭 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int itemNmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Class.itemNmUpdate", params);
	}
	
	/**
	 * 분류명칭1 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class1NmUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Class.class1NmUpdate", params);
    }
	
	/**
	 * 분류명칭2 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class2NmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Class.class2NmUpdate", params);
	}
	
	/**
	 * 분류명칭3 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class3NmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Class.class3NmUpdate", params);
	}
	
	/**
	 * 분류명칭4 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class4NmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Class.class4NmUpdate", params);
	}
	
	/**
	 * 분류명칭5 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int class5NmUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Class.class5NmUpdate", params);
	}
	
}
