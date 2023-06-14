package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 통계 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2StatisticsService {

	/**
	 * 통계 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStatistics(Map<String, Object> params) throws Exception;
	/**
	 * 통계 차트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectReport(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectReportMonth(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectReportStore(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectReportItem(Map<String, Object> params) throws Exception;

}
