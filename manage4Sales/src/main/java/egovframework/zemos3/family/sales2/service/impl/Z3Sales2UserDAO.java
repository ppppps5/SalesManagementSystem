package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 메인 DAO 클래스
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
@Repository("z3Sales2UserDAO")
public class Z3Sales2UserDAO extends ZenielMAbstractDAO {
	
	/**
	 * 년도(현재년도 ~ 20년전)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectYyyy(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectYyyy", params);
	}
	
	/**
	 * 목표 1
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectGoalResultTot1(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2User.selectGoalResultTot1", params);
	}
	
//	public Map<String, Object> selectGoalResultTot1(Map<String, Object> params) throws Exception {
//    	return selectOne("zenielm.zemos3.family.sales2.sales2User.selectGoalResultTot1", params);
//	}
	
	public List<Map<String, Object>> selectGoalResultTot2(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectGoalResultTot2", params);
	}
	
	/**
	 * 상단 기준별 통합 목표 실적 합계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	
	public List<Map<String, Object>> selectResultTot1(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectResultTot1", params);
	}
	
	public List<Map<String, Object>> selectResultTot2(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectResultTot2", params);
	}
	
//	public Map<String, Object> selectGoalResultTot2(Map<String, Object> params) throws Exception {
//		return selectOne("zenielm.zemos3.family.sales2.sales2User.selectGoalResultTot2", params);
//	}
//	
//	public Map<String, Object> selectResultTot1(Map<String, Object> params) throws Exception {
//		return selectOne("zenielm.zemos3.family.sales2.sales2User.selectResultTot1", params);
//	}
//	
//	public Map<String, Object> selectResultTot2(Map<String, Object> params) throws Exception {
//		return selectOne("zenielm.zemos3.family.sales2.sales2User.selectResultTot2", params);
//	}
	
	/**
	 * 메인 판매실적 통합 리스트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserMain(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectUserMain", params);
	}
	
	/**
	 * 날짜조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> salesDay(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2User.salesDay", params);
	}
	
	/**
	 * 사용자 실적등록 Master 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserResultMngList(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2User.selectUserResultMngList", params);
	}
	
	/**
	 * 사용자 실적등록 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserResultDetailList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectUserResultDetailList", params);
	}
	
	/**
	 * 사용자 실적등록 Detail 단일 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectUserResultDetailContent(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2User.selectUserResultDetailContent", params);
	}
	
	/**
	 * 사용자 실적등록 수정요청 Detail 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectUserResultWDetailList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2User.selectUserResultWDetailList", params);
	}

	
	/**
	 * 사용자 실적등록 Master Insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResultMng(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2User.insertResultMng", params);
	}
	
	/**
	 * 사용자 실적등록 Master Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultMng(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2User.updateResultMng", params);
	}
	
	/**
	 * 사용자 실적등록 Master Delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultMng(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2User.deleteResultMng", params);
	}
	
	/**
	 * 사용자 실적등록 Detail Insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResultDetail(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2User.insertResultDetail", params);
	}
	
	/**
	 * 사용자 실적등록 Detail Update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2User.updateResultDetail", params);
	}
	
	/**
	 * 사용자 실적등록 Detail Delete
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int deleteResultDetail(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2User.deleteResultDetail", params);
	}
	
	
	/**
	 * 수정요청 Master Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveMasterResult(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2User.saveMasterResult", params);
	}
	
	/**
	 * 수정요청 Master update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateMasterResult(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2User.updateMasterResult", params);
	}
	
	/**
	 * 수정요청 Detail Save
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int saveDetailResult(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2User.saveDetailResult", params);
	}
	
	/**
	 * 수정요청 Detail update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateDetailResult(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2User.updateDetailResult", params);
	}
	
	/**
	 * file테이블(ZM_ATCHMNFL) FILE_OWNER 업데이트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateFileOwner(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2User.updateFileOwner", params);
	}
	
	/**
	 * 수정요청 달러 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDaller(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2User.updateResultDaller", params);
	}
}
