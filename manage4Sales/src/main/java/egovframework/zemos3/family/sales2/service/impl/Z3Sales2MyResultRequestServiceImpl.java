package egovframework.zemos3.family.sales2.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.ZemosCommonConstant;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2MyResultRequestService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 분류3 서비스Impl 클래스
 * 
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
@Service("z3Sales2MyResultRequestService")
public class Z3Sales2MyResultRequestServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2MyResultRequestService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//나의등록현황 및 수정요청 DAO
	@Resource(name = "z3Sales2MyResultRequestDAO")
	private Z3Sales2MyResultRequestDAO z3Sales2MyResultRequestDAO;

	/**
	 * 년도(현재년도 ~ 20년전)
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectYyyy(params);
	}
	
	/**
	 * 나의등록현황 count
	 */
	public int selectMyResultCnt(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultCnt(params);
	}
	
	/**
	 * 실적등록현황 count
	 */
	public int selectMyResultCntNew(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultCntNew(params);
	}
	
	/**
	 * 나의등록현황 list
	 */
	public List<Map<String, Object>> selectMyResult(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResult(params);
	}
	
	/**
	 * 실적등록현황 list
	 */
	public List<Map<String, Object>> selectMyResultNew(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultNew(params);
	}
	/**
	 * 실적등록현황groupByItem list
	 */
	public List<Map<String, Object>> selectMyResultNewItem(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultNewItem(params);
	}
	
	/**
	 * 히스토리디테일 list
	 */
	public List<Map<String, Object>> selectHistoryDetailItem(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectHistoryDetailItem(params);
	}
	
	/**
	 * 나의등록현황 total
	 */
	public Map<String, Object> selectMyResultTot(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultTot(params);
	}
	
	/**
	 * 실적등록현황 total
	 */
	public List<Map<String, Object>> selectMyResultTotNew(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultTotNew(params);
	}
	
	/**
	 * 실적등록현황 totalNoOnOff
	 */
	public List<Map<String, Object>> selectMyResultTotNewNoOnOff(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectMyResultTotNewNoOnOff(params);
	}
	
	/**
	 * History Master 조회
	 */
	public Map<String, Object> salesHistoryMng(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.salesHistoryMng(params);
	}
	
	/**
	 * History Master List조회
	 */
	public List<Map<String, Object>> salesHistoryMngList(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.salesHistoryMngList(params);
	}
	
	/**
	 * 사용자 실적등록 Detail 조회
	 */
	public List<Map<String, Object>> selectUserResultDetailList(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectUserResultDetailList(params);
	}
	
	/**
	 * salesHistoryDetailForHistorySeq 조회
	 */
	public List<Map<String, Object>> salesHistoryDetailForHistorySeq(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.salesHistoryDetailForHistorySeq(params);
	}
	
	/**
	 * 수정요청 history Master Save
	 */
	public int saveMasterResult(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.saveMasterResult(params);
	}
	
	/**
	 * 수정요청 history Detail Save
	 */
	public int saveDetailResult(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.saveDetailResult(params);
	}
	
	/**
	 * 수정요청 history Detail Save New
	 */
	public int saveDetailResultNew(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.saveDetailResultNew(params);
	}
	
	/**
	 * ResultDetailAllCnt ALL 값 조회
	 */
	public int selectUserResultDetailAllCnt(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectUserResultDetailAllCnt(params);
	}
	
	/**
	 * ResultDetailYCnt reult_yn Y 값 조회
	 */
	public int selectUserResultDetailYNCnt(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectUserResultDetailYNCnt(params);
	}
	
	/**
	 * 수정요청 Detail delete
	 */
	public int deleteDetailHistory(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.deleteDetailHistory(params);
	}
	
	/**
	 * 수정요청 master delete
	 */
	public int deleteHistory(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.deleteHistory(params);
	}
	
	/**
	 * result Master update
	 */
	public int updateMasterResult(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateMasterResult(params);
	}
	
	/**
	 * result L Detail update
	 */
	public int updateDetailResultL(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateDetailResultL(params);
	}
	
	/**
	 * result history update
	 */
	public int updateHistoryResult(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateHistoryResult(params);
	}
	
	/**
	 * History detail update
	 */
	public int updateHistoryResultDetailNew(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateHistoryResultDetailNew(params);
	}
	
	/**
	 * result Detail hisYn Update
	 */
	public int updateResultDetailHisYn(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateResultDetailHisYn(params);
	}
	
	/**
	 * result mng Update
	 */
	public int updateResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateResultMng(params);
	}
	
	/**
	 * result Detail Update
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.updateResultDetail(params);
	}
	
	/**
	 * 판매관리현황
	 */
	public List<Map<String, Object>> selectSalesPresent(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectSalesPresent(params);
	}
	
	/**
	 * 수정요청 내역
	 */
	public List<Map<String, Object>> selectResultAmendList(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectResultAmendList(params);
	}
	
	/**
	 * 판매관리현황 count
	 */
	public int selectSalesPresentCnt(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectSalesPresentCnt(params);
	}
	
	/**
	 * selectHistoryCnt
	 */
	public int selectHistoryCnt(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectHistoryCnt(params);
	}
	
	/**
	 * selectHistoryDetailCnt
	 */
	public int selectHistoryDetailCnt(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectHistoryDetailCnt(params);
	}
	
	/**
	 * 판매관리현황 total
	 */
	public Map<String, Object> selectSalesPresentTotal(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.selectSalesPresentTotal(params);
	}
	
	/**
	 * result master delete
	 */
	public int deleteResultMng(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.deleteResultMng(params);
	}
	
	/**
	 * result detail delete
	 */
	public int deleteResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2MyResultRequestDAO.deleteResultDetail(params);
	}
	
	/**
	 * 판매관리실적 수정요청(사용자) 푸시하기
	 * 
	 * @param Map<String, Object> params
	 * @return int
	 * @exception Exception
	 */
	public void SalesUserPush(Map<String, Object> params) throws Exception {

		// 로그인 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		// 제모스 관리자에게 PUSH 알림 발송
		// 제모스 사용자인 경우 담당자에게 PUSH 알림 발송
		//////////////////////////////////////// 새소식 & 푸쉬 시작

		String ntcnTitle 	= ZemosCommonConstant.salesEvent.toString();
		String userAdminGbn 	= "A";
		String resultDt 	= EgovStringUtil.isNullToString(params.get("resultDt"));
		String ntcnUrl 		= "/zemos3/family/sales2/sales2ModifyRequestAdmin.do";
		String ntcnText 	= loginVO.getName()+ "("+ loginVO.getCustName()+ "/" + loginVO.getCustwoName()+ ")" + ZemosCommonConstant.requestSalesMsg.toString();
		String delReceive 	= EgovStringUtil.isNullToString(params.get("del"));
		if (!EgovStringUtil.isEmpty(delReceive)) {
			if (delReceive.equals("1")) {
				ntcnText = loginVO.getName() + "("+ loginVO.getCustName()+ "/" + loginVO.getCustwoName()+ ")" + ZemosCommonConstant.cancelFamilylMsg.toString();
			}
		}

		String zemosIdx = EgovStringUtil.isNullToString(loginVO.getZemosIdx());
		String wrkplcIdx = EgovStringUtil.isNullToString(loginVO.getZemosWrkplcIdx());

		// 제모스 사용자인 경우 담당자에게 PUSH 알림 발송
		// 담당자 정보 조회
		Map<String, Object> jobManagerParams = new HashMap<String, Object>();
		jobManagerParams.put("sabun", loginVO.getSabun());
		List<Map<String, Object>> jobManagerList = z3ZemosMenuErpHDAO.jobManagerInfo(jobManagerParams);
		if (jobManagerList == null || jobManagerList.isEmpty()) {
			return;
		}

		for (Map<String, Object> jobManagerMap : jobManagerList) {

			// 사용자정보 조회
			Map<String, Object> userParams = new HashMap<String, Object>();
			userParams.put("sabun", EgovStringUtil.isNullToString(jobManagerMap.get("sabun")));
			List<Map<String, Object>> userList = userService.selectUser(userParams);

			// 제모스 알림 및 푸쉬  
			ntcnUrl += "?zemosIdx=" + zemosIdx + "&wrkplcIdx=" + wrkplcIdx+ "&userAdminGbn="+ userAdminGbn;
			pushService.sendAlramPush(userList, ntcnTitle, ntcnUrl, ntcnText, zemosIdx, wrkplcIdx, "", "", "URL");
		}
		
		// 대행 잡컨설턴트가 있을 경우 대행 잡컨설턴트에게도 알림 발송
		Map<String, Object> managerParams = new HashMap<String, Object>();
		managerParams.put("zemosIdx", 	zemosIdx);
		managerParams.put("authSe", 	ZemosCommonConstant.zemosJobMngCode.toString());
		List<Map<String, Object>> managerList = z3AdminService.zemosEmpList(managerParams);
		if (!EgovStringUtil.isEmptyMapList(managerList)) {
			
			for (Map<String, Object> managerMap : managerList) {

				// 사용자정보 조회
				Map<String, Object> userParams = new HashMap<String, Object>();
				userParams.put("sabun", EgovStringUtil.isNullToString(managerMap.get("USER_SABUN")));
				List<Map<String, Object>> userList = userService.selectUser(userParams);

				// 제모스 알림 및 푸쉬
				ntcnUrl += "?zemosIdx=" + zemosIdx + "&wrkplcIdx=" + wrkplcIdx+ "&userAdminGbn="+ userAdminGbn;
				pushService.sendAlramPush(userList, ntcnTitle, ntcnUrl, ntcnText, zemosIdx, wrkplcIdx, "", "", "URL");
			}
		}

		// 제모스 사용자인 경우 담당자에게 PUSH 알림 발송 끝
		//////////////////////////////////////// 새소식 & 푸쉬 끝
	}
}
