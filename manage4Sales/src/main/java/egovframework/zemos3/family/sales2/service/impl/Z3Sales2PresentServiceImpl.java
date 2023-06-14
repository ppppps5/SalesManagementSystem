package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2PresentService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 판매관리현황 서비스Impl 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2PresentService")
public class Z3Sales2PresentServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2PresentService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//판매관리현황 DAO
	@Resource(name = "z3Sales2PresentDAO")
	private Z3Sales2PresentDAO z3Sales2PresentDAO;
	
	/**
	 * 셀렉박스 품목 List
	 */
	public List<Map<String, Object>> selectItemsList(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectItemsList(params);
	}
	
	/**
	 * 셀렉박스 온오프 List
	 */
	public List<Map<String, Object>> selectBoxOnoffList(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectBoxOnoffList(params);
	}
	
	/**
	 * 판매관리현황
	 */
	public List<Map<String, Object>> selectSales2Present(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectSales2Present(params);
	}
	
	/**
	 * 판매관리현황 합계
	 */
	public List<Map<String, Object>> selectSalesPresentSum(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectSalesPresentSum(params);
	}
	
	/**
	 * 판매관리현황 cnt
	 */
	public Map<String, Object> selectSales2PresentCnt(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectSales2PresentCnt(params);
	}
	
	/**
	 * 판매관리현황 월대장 월의 첫날 구하기
	 */
	public List<Map<String, Object>> selectFirstDayOfMonth(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectFirstDayOfMonth(params);
	}
	
	/**
	 * 판매관리현황 월대장
	 */
	public List<Map<String, Object>> selectSalesPresentMonth(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectSalesPresentMonth(params);
	}
	
	/**
	 * 판매관리현황 상세
	 */
	public List<Map<String, Object>> selectSalesPresentDetail(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectSalesPresentDetail(params);
	}
	
	public Map<String, Object> selectSalesPresentDetailCnt(Map<String, Object> params) throws Exception {
		return z3Sales2PresentDAO.selectSalesPresentDetailCnt(params);
	}
	
}
