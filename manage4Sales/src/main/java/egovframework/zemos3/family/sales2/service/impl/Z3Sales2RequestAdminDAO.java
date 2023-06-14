package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 수정요청관리 DAO 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2RequestAdminDAO")
public class Z3Sales2RequestAdminDAO extends ZenielMAbstractDAO {
	
	public List<Map<String, Object>> selectSales2RequestAdmin(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2RequestAdmin.selectSales2RequestAdmin", params);
	}
	
}
