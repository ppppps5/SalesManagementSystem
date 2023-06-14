package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

/**
 * 판매관리 실적등록 서비스 클래스
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
public interface Z3Sales2ResultService {

	/**
	 * 실적등록 count
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectResultCnt(Map<String, Object> params) throws Exception;

	/**
	 * 실적등록 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResult(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록상세 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록상세 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultDetail01(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Mng, Detail countList
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> resultMngAndDetailCnt(Map<String, Object> params) throws Exception;
	/**
	 * resultHistoryMng
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int resultHistoryMng(Map<String, Object> params) throws Exception;

	/**
	 * 매장명칭
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception;
	
	/**
	 * 품목명칭
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> storeitemName(Map<String, Object> params) throws Exception;

	/**
	 * 셀렉박스 매장 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception;

	/**
	 * 실적등록 합계 금액
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSumTotalList(Map<String, Object> params) throws Exception;

	/**
	 * 실적등록 엑셀 다운로드
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultExcelDown(Map<String, Object> params) throws Exception;

	/**
	 * 실적등록 엑셀 업로드
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> sales2ResultExcelUpload(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록 엑셀 업로드시 매장명 확인
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNm(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록 엑셀 업로드시 품목명 확인
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectitemNm(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록 엑셀 업로드시 품목SEQ 계산
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectitemList(Map<String, Object> params) throws Exception;
	
	/**
	 * UNIT의 SEQ 계산
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록 count
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectresulCnt01(Map<String, Object> params) throws Exception;

	/**
	 * 실적등록 insert
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResult(Map<String, Object> params) throws Exception;

	/**
	 * 실적등록 update
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int resultUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록 requestYn update
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int resultExRequestYnUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적등록 상세update
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int ResultDetailUpdate(Map<String, Object> params) throws Exception;

}
