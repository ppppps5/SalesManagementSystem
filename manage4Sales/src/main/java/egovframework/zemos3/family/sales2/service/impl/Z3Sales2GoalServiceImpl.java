package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2GaolService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 목표 서비스Impl 클래스
 * 
 * @author 이엠룩
 * @since 2022.09.13
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
@Service("z3Sales2GaolService")
public class Z3Sales2GaolServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2GaolService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//목표 DAO
	@Resource(name = "z3Sales2GaolDAO")
	private Z3Sales2GaolDAO z3Sales2GaolDAO;
	
	/**
	 * 화면 년도 selectbox(현재년도의 이전 15년 ~ 이후 3년)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectYyyy(params);
	}
	
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectStoreNewUseNameList(params);
	}
	
	/**
	 * 화면 매장 selectbox
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectBoxStoreList(params);
	}
	
	/**
	 * 목표 count
	 */
	public int selectGoalCnt(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectGoalCnt(params);
	}
	
	/**
	 * 목표 등록 여부 count
	 */
	public int selectGoalCnt01(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectGoalCnt01(params);
	}
	
	/**
	 * 목표 List
	 */
	public List<Map<String, Object>> selectGoal(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectGoal(params);
	}
	
	public List<Map<String, Object>> selectUnit(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectUnit(params);
	}
	
	public List<Map<String, Object>> selectOnoff(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectOnoff(params);
	}
	
	/**
	 * 엑셀 다운로드
	 */
	public List<Map<String, Object>> selectExcelDown(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectExcelDown(params);
	}
	
	/**
	 * total sum
	 */
	public List<Map<String, Object>> selectTotSumGoal(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectTotSumGoal(params);
	}
	
	/**
	 * 목표등록 상세화면
	 */
	public List<Map<String, Object>> selectGoalDetail(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectGoalDetail(params);
	}
	
	/**
	 * 목표등록 update
	 */
	public int goalUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.goalUpdate(params);
	}
	
	/**
	 * 매장명이 ZM_SALES_STORE 테이블에 등록 매장과 엑셀의 매장이 맞는지 체크.
	 */
	public List<Map<String, Object>> selectStoreNm(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectStoreNm(params);
	}
	
	/**
	 * UNIT의 SEQ 계산
	 */
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectUnitList(params);
	}
	
	/**
	 * UNIT의 SEQ 계산
	 */
	public List<Map<String, Object>> selectUnitList01(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectUnitList01(params);
	}
	
	/**
	 * 목표삭제
	 */
	public int deleteGoal(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.deleteGoal(params);
	}
	
	/**
	 * 목표등록
	 */
	public int insertGoal(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.insertGoal(params);
	}
	
	/**
	 * 목표등록 update
	 */
	public int updateGoal(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.updateGoal(params);
	}
	
	/**
	 * 목표등록 엑셀 업로드시 품목 SEQ 계산
	 */
	public List<Map<String, Object>> selectitemList(Map<String, Object> params) throws Exception {
		return z3Sales2GaolDAO.selectitemList(params);
	}
}
