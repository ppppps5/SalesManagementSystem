package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 목표 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2GoalService {
	
	/**
	 * 화면 년도 selectbox(현재년도의 이전 15년 ~ 이후 3년)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception;
	
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception;
	
	/**
	 * 화면 매장 selectbox
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectGoalCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표등록 여부  count insert /update 구분위해
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectGoalCnt01(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGoal(Map<String, Object> params) throws Exception;
	
	/**
	 * 단위 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUnit(Map<String, Object> params) throws Exception;
	
	/**
	 * 온라인 오프라인 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectOnoff(Map<String, Object> params) throws Exception;
	
	
	/**
	 * 엑셀 다운로드
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectExcelDown(Map<String, Object> params) throws Exception;
	
	/**
	 * total sum
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectTotSumGoal(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표등록 상세화면
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGoalDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표등록 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int goalUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 매장명이 ZM_SALES_STORE 테이블에 등록 매장과 엑셀의 매장이 맞는지 체크.
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNm(Map<String, Object> params) throws Exception;
	/**
	 * UNIT의 SEQ 계산
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception;
	
	/**
	 * UNIT의 SEQ 계산
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUnitList01(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표 삭제
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteGoal(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표 등록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertGoal(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표등록 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateGoal(Map<String, Object> params) throws Exception;
	
	/**
	 * 목표등록 엑셀 업로드시 품목SEQ 계산
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectitemList(Map<String, Object> params) throws Exception;
}
