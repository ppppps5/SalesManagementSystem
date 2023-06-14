package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 나의등록현황 및 수정요청 DAO 클래스
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
@Repository("z3Sales2MyResultRequestDAO")
public class Z3Sales2MyResultRequestDAO extends ZenielMAbstractDAO {
	
	/**
	 * 년도(현재년도 ~ 20년전)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectYyyy", params);
	}
	
	/**
	 * 나의등록현황 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectMyResultCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultCnt", params);
	}
	
	/**
	 * 실적등록현황 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectMyResultCntNew(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultCntNew", params);
	}
	
	/**
	 * 나의등록현황 list
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResult(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResult", params);
	}
	
	/**
	 * 실적등록현황 list
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultNew(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultNew", params);
	}
	
	/**
	 * 실적등록현황groupByItem list
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultNewItem(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultNewItem", params);
	}
	
	/**
	 * 히스토리디테일 list
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectHistoryDetailItem(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectHistoryDetailItem", params);
	}
	
	/**
	 * 나의등록현황 total
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMyResultTot(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultTot", params);
	}
	
	/**
	 * 실적등록현황 total
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultTotNew(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultTotNew", params);
	}
	
	/**
	 * 실적등록현황 total NoOnOff
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectMyResultTotNewNoOnOff(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectMyResultTotNewNoOnOff", params);
	}
	
	/**
	 * History Master 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> salesHistoryMng(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.salesHistoryMng", params);
	}
	
	/**
	 * History Master List조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> salesHistoryMngList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.salesHistoryMngList", params);
	}
	
	/**
	 * 사용자 실적등록 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserResultDetailList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectUserResultDetailList", params);
	}
	
	/**
	 * salesHistoryDetailForHistorySeq 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> salesHistoryDetailForHistorySeq(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.salesHistoryDetailForHistorySeq", params);
	}
	
	/**
	 * 수정요청 history Master Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveMasterResult(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2MyResultRequest.saveMasterResult", params);
	}
	
	/**
	 * 수정요청 history Detail Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveDetailResult(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2MyResultRequest.saveDetailResult", params);
	}
	
	/**
	 * 수정요청 history Detail Save New
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveDetailResultNew(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2MyResultRequest.saveDetailResultNew", params);
	}
	
	/**
	 * ResultDetailAllCnt ALL 값 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectUserResultDetailAllCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectUserResultDetailAllCnt", params);
	}
	
	/**
	 * ResultDetailYCnt reult_yn Y 값 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectUserResultDetailYNCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectUserResultDetailYNCnt", params);
	}
	
	/**
	 * 수정요청 Detail delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteDetailHistory(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2MyResultRequest.deleteDetailHistory", params);
	}
	
	/**
	 * 수정요청 master delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteHistory(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2MyResultRequest.deleteHistory", params);
	}
	
	/**
	 * result Master update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateMasterResult(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateMasterResult", params);
	}
	
	/**
	 * result L Detail update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateDetailResultL(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateDetailResultL", params);
	}
	
	/**
	 * result history update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateHistoryResult(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateHistoryResult", params);
	}
	
	/**
	 * result Detail hisYn Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetailHisYn(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateResultDetailHisYn", params);
	}
	
	/**
	 * History Detail update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateHistoryResultDetailNew(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateHistoryResultDetailNew", params);
	}
	
	/**
	 * result mng Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultMng(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateResultMng", params);
	}
	
	/**
	 * result Detail Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2MyResultRequest.updateResultDetail", params);
	}
	
	/**
	 * 판매관리현황
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSalesPresent(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectSalesPresent", params);
	}
	/**
	 * 수정요청 내역
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultAmendList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectResultAmendList", params);
	}
	
	/**
	 * 판매관리현황 count
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectSalesPresentCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectSalesPresentCnt", params);
	}
	
	/**
	 * selectHistoryCnt 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectHistoryCnt(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectHistoryCnt", params);
	}
	
	/**
	 * selectHistoryDetailCnt 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectHistoryDetailCnt(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectHistoryDetailCnt", params);
	}
	
	/**
	 * 판매관리현황 total
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSalesPresentTotal(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2MyResultRequest.selectSalesPresentTotal", params);
	}
	
	
	/**
	 * result master delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultMng(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2MyResultRequest.deleteResultMng", params);
	}
	
	/**
	 * result detail delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultDetail(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2MyResultRequest.deleteResultDetail", params);
	}
	
}
