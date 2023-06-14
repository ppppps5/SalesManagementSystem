package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ResultService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 실적등록 서비스Impl 클래스
 * 
 * @author 이엠룩
 * @since 2022.09.21
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.09.21  이엠룩          최초 생성
 *      </pre>
 */
@Service("z3Sales2ResultService")
public class Z3Sales2ResultServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2ResultService {

	@Resource(name = "z3ZemosMenuErpHDAO")
	private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;

	@Resource(name = "userService")
	protected UserService userService;

	@Resource(name = "pushService")
	protected PushService pushService;

	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;

	// 실적등록 DAO
	@Resource(name = "z3Sales2ResultDAO")
	private Z3Sales2ResultDAO z3Sales2ResultDAO;

	/**
	 * 실적등록 count
	 */
	public int selectResultCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectResultCnt(params);
	}

	/**
	 * 실적등록 List
	 */
	public List<Map<String, Object>> selectResult(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectResult(params);
	}
	
	/**
	 * 실적Mng, Detail countList
	 */
	public List<Map<String, Object>> resultMngAndDetailCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.resultMngAndDetailCnt(params);
	}
	
	/**
	 * resultHistoryMng
	 */
	public int resultHistoryMng(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.resultHistoryMng(params);
	}
	
	/**
	 * 실적등록 List
	 */
	public List<Map<String, Object>> selectResultDetail(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectResultDetail(params);
	}
	
	/**
	 * 실적등록 List
	 */
	public List<Map<String, Object>> selectResultDetail01(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectResultDetail01(params);
	}
	/**
	 * 매장 명칭 List
	 */
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectStoreNewUseNameList(params);
	}
	
	/**
	 * 품목 명칭 List
	 */
	public List<Map<String, Object>> storeitemName(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.storeitemName(params);
	}
	
	/**
	 * 셀렉박스 매장 List
	 */
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectBoxStoreList(params);
	}

	/**
	 * 실적등록 합계 금액
	 */
	public List<Map<String, Object>> selectSumTotalList(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectSumTotalList(params);
	}
	
	/**
	 * 실적등록 엑셀 다운로드
	 */
	public List<Map<String, Object>> selectResultExcelDown(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectResultExcelDown(params);
	}
	
	/**
	 * 실적등록 엑셀 업로드
	 */
	public List<Map<String, Object>> sales2ResultExcelUpload(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.sales2ResultExcelUpload(params);
	}
	
	/**
	 * 실적등록 엑셀 업로드시 매장명 확인
	 */
	public List<Map<String, Object>> selectStoreNm(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectStoreNm(params);
	}
	
	/**
	 * UNIT의 SEQ 계산
	 */
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectUnitList(params);
	}
	
	/**
	 * 실적등록 엑셀 업로드시 품목명 확인
	 */
	public List<Map<String, Object>> selectitemNm(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectitemNm(params);
	}
	
	/**
	 * 실적등록 엑셀 업로드시 품목 SEQ 계산
	 */
	public List<Map<String, Object>> selectitemList(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectitemList(params);
	}
	/**
	 * 실적등록 count
	 */
	public int selectresulCnt01(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.selectresulCnt01(params);
	}
	/**
	 * 실적등록 insert
	 */
	public int insertResult(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.insertResult(params);
	}
	
	/**
	 * 실적등록 update
	 */
	public int resultUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.resultUpdate(params);
	}
	
	/**
	 * 실적등록 requestYn update
	 */
	public int resultExRequestYnUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.resultExRequestYnUpdate(params);
	}
	
	/**
	 * 실적등록 상세update
	 */
	public int ResultDetailUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ResultDAO.ResultDetailUpdate(params);
	}

}