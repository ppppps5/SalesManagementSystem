package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 단위 DAO 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2UnitDAO")
public class Z3Sales2UnitDAO extends ZenielMAbstractDAO {
	
	/**
	 * 단위 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2UnitCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Unit.selectSales2UnitCnt", params);
	}
	
	/**
	 * 단위 count for insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSales2UnitCntForInsert(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2Unit.selectSales2UnitCntForInsert", params);
	}
	
	/**
	 * 단위 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Unit(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Unit.selectSales2Unit", params);
	}
	
	/**
	 * 단위 List
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	public List<Map<String, Object>> selectSales2Unit01(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Unit.selectSales2Unit01", params);
	}
	
	/**
	 * 단위 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int unitInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Unit.unitInsert", params);
    }
	
	/**
	 * 단위 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int unitUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Unit.unitUpdate", params);
    }
	
	/**
	 * 품목단위 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int ItemunitInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Unit.ItemunitInsert", params);
    }
	
	/**
	 * 품목단위 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int ItemunitUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Unit.ItemunitUpdate", params);
    }
	
}
