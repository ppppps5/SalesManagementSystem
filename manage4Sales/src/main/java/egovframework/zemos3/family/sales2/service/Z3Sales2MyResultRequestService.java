package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 나의등록 현황 및 수정요청 서비스 클래스
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  </pre>
 */
public interface Z3Sales2MyResultRequestService {
	
	/**
	 * 년도(현재년도 ~ 20년전)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception;
	
	/**
	 * 나의등록현황 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectMyResultCnt(Map<String, Object> params) throws Exception;
	/**
	 * 실적등록현황 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectMyResultCntNew(Map<String, Object> params) throws Exception;
	
	/**
	 * 나의등록현황 list
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록현황 list
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultNew(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록현황groupByItem list
	 */
	public List<Map<String, Object>> selectMyResultNewItem(Map<String, Object> params) throws Exception;
	
	/**
	 * 히스토리 디테일 list
	 */
	public List<Map<String, Object>> selectHistoryDetailItem(Map<String, Object> params) throws Exception;
	
	/**
	 * 나의등록현황 total
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMyResultTot(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록현황 total
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultTotNew(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록현황 totalNoOnOff
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultTotNewNoOnOff(Map<String, Object> params) throws Exception;
	
	/**
	 * History Master 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> salesHistoryMng(Map<String, Object> params) throws Exception;
	
	/**
	 * History Master List조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> salesHistoryMngList(Map<String, Object> params) throws Exception;
	
	/**
	 * 사용자 실적등록 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String,Object>> selectUserResultDetailList(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 history Master Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveMasterResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 history Detail Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveDetailResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 history Detail Save New
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveDetailResultNew(Map<String, Object> params) throws Exception;
	
	/**
	 * ResultDetailAllCnt ALL 값 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectUserResultDetailAllCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * selectHistoryCnt
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectHistoryCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * selectHistoryDetailCnt
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectHistoryDetailCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * ResultDetailYCnt reult_yn Y 값 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectUserResultDetailYNCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 Detail delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteDetailHistory(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 master delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteHistory(Map<String, Object> params) throws Exception;
	
	/**
	 * result Master update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateMasterResult(Map<String, Object> params) throws Exception;
	
	/**
	 * result L Detail update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateDetailResultL(Map<String, Object> params) throws Exception;
	
	/**
	 * result history update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateHistoryResult(Map<String, Object> params) throws Exception;
	
	/**
	 * History Detail update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateHistoryResultDetailNew(Map<String, Object> params) throws Exception;
	
	/**
	 * result Detail hisYn Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetailHisYn(Map<String, Object> params) throws Exception;
	
	/**
	 * result mng Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultMng(Map<String, Object> params) throws Exception;
	
	/**
	 * result Detail Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 판매관리현황
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSalesPresent(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 내역
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultAmendList(Map<String, Object> params) throws Exception;
	
	/**
	 * 판매관리현황 cnt
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSalesPresentCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 판매관리현황 total
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSalesPresentTotal(Map<String, Object> params) throws Exception;
	
	/**
	 * result master delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultMng(Map<String, Object> params) throws Exception;
	
	/**
	 * result detail delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 수정요청 페이지(사용자) 푸시하기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void SalesUserPush(Map<String, Object> params) throws Exception;
	
	
	/**
	 * salesHistoryDetailForHistorySeq 조회
	 */
	public List<Map<String, Object>> salesHistoryDetailForHistorySeq(Map<String, Object> params) throws Exception;
}
