package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 통계 DAO 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Repository("z3Sales2StatisticsDAO")
public class Z3Sales2StatisticsDAO extends ZenielMAbstractDAO {
	
	/**
	 * 통계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStatistics(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Statistics.selectStatistics", params);
	}
	
	public List<Map<String, Object>> selectReport(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Statistics.selectReport", params);
	}
	
	public List<Map<String, Object>> selectReportMonth(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Statistics.selectReportMonth", params);
	}
	
	public List<Map<String, Object>> selectReportStore(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Statistics.selectReportStore", params);
	}
	
	public List<Map<String, Object>> selectReportItem(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Statistics.selectReportItem", params);
	}
	
}
