package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 실적등록 DAO 클래스
 * 
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *      </pre>
 */
@Repository("z3Sales2ResultDAO")
public class Z3Sales2ResultDAO extends ZenielMAbstractDAO {

	/**
	 * 실적등록 count
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectResultCnt(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2Result.selectResultCnt", params);
	}

	/**
	 * 실적등록 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResult(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectResult", params);
	}
	
	/**
	 * 실적등록상세 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultDetail(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectResultDetail", params);
	}
	
	/**
	 * 실적등록상세 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultDetail01(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectResultDetail01", params);
	}

	/**
	 * 매장명칭 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNewUseNameList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectStoreNewUseNameList", params);
	}
	
	/**
	 * 품목명칭 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> storeitemName(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.storeitemName", params);
	}
	
	/**
	 * 셀렉박스 매장 List
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBoxStoreList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectBoxStoreList", params);
	}
	
	/**
	 * 실적등록 합계 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSumTotalList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectSumTotalList", params);
	}

	
	/**
	 * 실적등록 엑셀 다운로드
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultExcelDown(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Result.selectResultExcelDown", params);
	}
	
	/**
	 * 실적등록 엑셀 업로드
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> sales2ResultExcelUpload(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.sales2ResultExcelUpload", params);
	}
	
	/**
	 * 실적등록 엑셀 업로드시 매장명 확인
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectStoreNm(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectStoreNm", params);
	}
	
	/**
	 * UNIT의 SEQ 계산
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Result.selectUnitList", params);
	}
	/**
	 * 실적등록 엑셀 업로드시 품목명 확인
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectitemNm(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectitemNm", params);
	}
	
	/**
	 * 실적등록 엑셀 업로드시 품목SEQ 계산
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectitemList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.selectitemList", params);
	}
	
	/**
	 * 실적등록 count
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectresulCnt01(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2Result.selectresulCnt01", params);
	}
	/**
	 * 실적Mng, Detail count
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> resultMngAndDetailCnt(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Result.resultMngAndDetailCnt", params);
	}
	/**
	 * resultHistoryMng
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int resultHistoryMng(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2Result.resultHistoryMng", params);
	}
	/**
	 * 실적등록 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResult(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Result.insertResult", params);
	}
	
	/**
	 * 실적등록 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int resultUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Result.resultUpdate", params);
	}
	
	/**
	 * 실적등록 requestYn update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int resultExRequestYnUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Result.resultExRequestYnUpdate", params);
	}
	
	/**
	 * 실적등록 상세update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int ResultDetailUpdate(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2Result.ResultDetailUpdate", params);
	}
}