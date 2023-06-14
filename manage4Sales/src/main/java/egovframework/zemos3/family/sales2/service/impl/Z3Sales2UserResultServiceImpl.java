package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UserResultService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 실적등록 서비스Impl 클래스
 * 
 * @author 이엠룩
 * @since 2022.09.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.09.22  이엠룩          최초 생성
 *      </pre>
 */

@Service("z3Sales2UserResultService")
public class Z3Sales2UserResultServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2UserResultService  {

	@Resource(name = "z3ZemosMenuErpHDAO")
	private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;

	@Resource(name = "userService")
	protected UserService userService;

	@Resource(name = "pushService")
	protected PushService pushService;

	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;

	// 실적등록 DAO
	@Resource(name = "z3Sales2UserResultDAO")
	private Z3Sales2UserResultDAO z3Sales2UserResultDAO;
	
	/**
	 * 실적Mng count
	 */
	public int selectResultMngCnt(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.selectResultMngCnt(params);
	}
	
	/**
	 * 실적Detail count
	 */
	public int selectResultDetailCnt(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.selectResultDetailCnt(params);
	}
	
	/**
	 * 실적Mng List
	 */
	public List<Map<String, Object>> selectResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.selectResultMng(params);
	}
	
	/**
	 * 실적Detail List
	 */
	public List<Map<String, Object>> selectResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.selectResultDetail(params);
	}
	/**
	 * 월마감 Yn
	 */
	public List<Map<String, Object>> selectCloseYn(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.selectCloseYn(params);
	}
	
	/**
	 * 실적Mng insert
	 */
	public int insertResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.insertResultMng(params);
	}
	public int insertResultLMng(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.insertResultLMng(params);
	}
	
	/**
	 * 실적Detail insert
	 */
	public int insertResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.insertResultDetail(params);
	}
	public int insertResultLDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.insertResultLDetail(params);
	}
	/**
	 * 실적Detail update
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.updateResultDetail(params);
	}
	public int updateResultLDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserResultDAO.updateResultLDetail(params);
	}
}
