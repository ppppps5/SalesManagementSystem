package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2CloseService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 분류1 서비스Impl 클래스
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
@Service("z3Sales2CloseService")
public class Z3Sales2CloseServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2CloseService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//분류1 DAO
	@Resource(name = "z3Sales2CloseDAO")
	private Z3Sales2CloseDAO z3Sales2CloseDAO;
	
	/**
	 *마감 count
	 */
	public int selectSales2CloseCnt(Map<String, Object> params) throws Exception {
		return z3Sales2CloseDAO.selectSales2CloseCnt(params);
	}
	
	/**
	 * 마감 List
	 */
	public List<Map<String, Object>> selectSales2Close(Map<String, Object> params) throws Exception {
		return z3Sales2CloseDAO.selectSales2Close(params);
	}
	
	/**
	 * 마감01 List
	 */
	public List<Map<String, Object>> selectSales2Class01(Map<String, Object> params) throws Exception {
		return z3Sales2CloseDAO.selectSales2Class01(params);
	}
	/**
	 * 화면 년도 selectbox(현재년도의 이전 15년 ~ 이후 3년)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
		return z3Sales2CloseDAO.selectYyyy(params);
	}
	
	/**
	 * 마감 insert
	 */
	public int closeInsert(Map<String, Object> params) throws Exception {
		return z3Sales2CloseDAO.closeInsert(params);
	}
	
	/**
	 * 마감 update
	 */
	public int closeUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2CloseDAO.closeUpdate(params);
	}
	
}
