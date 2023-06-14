package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2StatisticsService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 통계 서비스Impl 클래스
 * 
 * @author 이엠룩
 * @since 2021.08.13
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2021.08.13  이엠룩          최초 생성 
 *  </pre>
 */
@Service("z3Sales2StatisticsService")
public class Z3Sales2StatisticsServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2StatisticsService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//통계 DAO
	@Resource(name = "z3Sales2StatisticsDAO")
	private Z3Sales2StatisticsDAO z3Sales2StatisticsDAO;
		
	
	/**
	 * 통계	 */
	public List<Map<String, Object>> selectStatistics(Map<String, Object> params) throws Exception {
		return z3Sales2StatisticsDAO.selectStatistics(params);
	}
	
	public List<Map<String, Object>> selectReport(Map<String, Object> params) throws Exception {
		return z3Sales2StatisticsDAO.selectReport(params);
	}
	
	public List<Map<String, Object>> selectReportMonth(Map<String, Object> params) throws Exception {
		return z3Sales2StatisticsDAO.selectReportMonth(params);
	}
	
	public List<Map<String, Object>> selectReportStore(Map<String, Object> params) throws Exception {
		return z3Sales2StatisticsDAO.selectReportStore(params);
	}
	
	public List<Map<String, Object>> selectReportItem(Map<String, Object> params) throws Exception {
		return z3Sales2StatisticsDAO.selectReportItem(params);
	}
}
