package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2UserService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 메인 서비스Impl 클래스
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
@Service("z3Sales2UserService")
public class Z3Sales2UserServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2UserService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//메인 DAO
	@Resource(name = "z3Sales2UserDAO")
	private Z3Sales2UserDAO z3Sales2UserDAO;

	/**
	 * 년도(현재년도 ~ 20년전)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return z3Sales2UserDAO.selectYyyy(params);
	}
	
	/**
	 * 상단 기준별 통합 목표 실적 합계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectGoalResultTot1(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return z3Sales2UserDAO.selectGoalResultTot1(params);
	}
	
//	/**
//	 * 목표1
//	 * @param params
//	 * @return
//	 * @throws Exception
//	 */
//	@Override
//	public Map<String, Object> selectGoalResultTot1(Map<String, Object> params) throws Exception {
//		// TODO Auto-generated method stub
//		return z3Sales2UserDAO.selectGoalResultTot1(params);
//	}
	
	/**
	 * 목표2
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectGoalResultTot2(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return z3Sales2UserDAO.selectGoalResultTot2(params);
	}
	
//	/**
//	 * 목표2
//	 * @param params
//	 * @return
//	 * @throws Exception
//	 */
//	@Override
//	public Map<String, Object> selectGoalResultTot2(Map<String, Object> params) throws Exception {
//		// TODO Auto-generated method stub
//		return z3Sales2UserDAO.selectGoalResultTot2(params);
//	}
	
	/**
	 * 통합 실적
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectResultTot1(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return z3Sales2UserDAO.selectResultTot1(params);
	}
	
	/**
	 * 통합 실적
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectResultTot2(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return z3Sales2UserDAO.selectResultTot2(params);
	}
	
//	/**
//	 * 통합 실적
//	 * @param params
//	 * @return
//	 * @throws Exception
//	 */
//	@Override
//	public Map<String, Object> selectResultTot1(Map<String, Object> params) throws Exception {
//		// TODO Auto-generated method stub
//		return z3Sales2UserDAO.selectResultTot1(params);
//	}
//	
//	/**
//	 * 통합 실적
//	 * @param params
//	 * @return
//	 * @throws Exception
//	 */
//	@Override
//	public Map<String, Object> selectResultTot2(Map<String, Object> params) throws Exception {
//		// TODO Auto-generated method stub
//		return z3Sales2UserDAO.selectResultTot2(params);
//	}
	
	/**
	 * 메인 판매실적 통합 리스트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectUserMain(Map<String, Object> params) throws Exception {
		// TODO Auto-generated method stub
		return z3Sales2UserDAO.selectUserMain(params);
	}
	
	/**
	 * 날짜조회
	 */
	public Map<String, Object> salesDay(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.salesDay(params);
	}
	
	/**
	 * 사용자 실적등록 Master 조회
	 */
	public Map<String, Object> selectUserResultMngList(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.selectUserResultMngList(params);
	}
	
	/**
	 * 사용자 실적등록 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectUserResultDetailList(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.selectUserResultDetailList(params);
	}
	
	/**
	 * 사용자 실적등록 Detail 단일 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserResultDetailContent(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.selectUserResultDetailContent(params);
	}
	
	/**
	 * 사용자 실적등록 수정요청 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> selectUserResultWDetailList(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.selectUserResultWDetailList(params);
	}
	
	
	/**
	 * 사용자 실적등록 Master Insert
	 */
	public int insertResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.insertResultMng(params);
	}
	
	/**
	 * 사용자 실적등록 Master Update
	 */
	public int updateResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.updateResultMng(params);
	}
	
	/**
	 * 사용자 실적등록 Master Delete
	 */
	public int deleteResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.deleteResultMng(params);
	}
	
	/**
	 * 사용자 실적등록 Detail Insert
	 */
	public int insertResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.insertResultDetail(params);
	}
	
	/**
	 * 사용자 실적등록 Detail Update
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.updateResultDetail(params);
	}
	
	/**
	 * 사용자 실적등록 Detail Delete
	 */
	public int deleteResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.deleteResultDetail(params);
	}
	
	/**
	 * 수정요청 Master Save
	 */
	public int saveMasterResult(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.saveMasterResult(params);
	}
	
	/**
	 * 수정요청 Master update
	 */
	public int updateMasterResult(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.updateMasterResult(params);
	}
	
	/**
	 * 수정요청 Detail Save
	 */
	public int saveDetailResult(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.saveDetailResult(params);
	}
	
	/**
	 * 수정요청 Detail update
	 */
	public int updateDetailResult(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.updateDetailResult(params);
	}
	
	/**
	 * file테이블(ZM_ATCHMNFL) FILE_OWNER 업데이트
	 */
	public int updateFileOwner(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.updateFileOwner(params);
	}
	
	/**
	 * 수정요청 달러 update
	 */
	public int updateResultDaller(Map<String, Object> params) throws Exception {
		return z3Sales2UserDAO.updateResultDaller(params);
	}
}
