package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 메인 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2UserService {
	
	/**
	 * 년도(현재년도 ~ 20년전)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception;

	/**
	 * 상단 기준별 통합 목표 실적 합계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGoalResultTot1(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectGoalResultTot2(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectResultTot1(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectResultTot2(Map<String, Object> params) throws Exception;
	
	/**
	 * 메인 판매실적 통합 리스트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserMain(Map<String, Object> params) throws Exception;
	
	/**
	 * 날짜조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> salesDay(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Master 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserResultMngList(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectUserResultDetailList(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Detail 단일 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserResultDetailContent(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 수정요청 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectUserResultWDetailList(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Master Insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResultMng(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Master Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultMng(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Master Delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultMng(Map<String, Object> params) throws Exception;
	
	
	/**
	 * 사용자 실적등록 Detail Insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Detail Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Detail Delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 Master Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveMasterResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 Master update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateMasterResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 Detail Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveDetailResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 Detail update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateDetailResult(Map<String, Object> params) throws Exception;
	
	/**
	 * file테이블(ZM_ATCHMNFL) FILE_OWNER 업데이트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateFileOwner(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 달러 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDaller(Map<String, Object> params) throws Exception;
	
}
