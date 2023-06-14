package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 실적등록 DAO 클래스
 * 
 * @author 이엠룩
 * @since 2022.09.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2022.09.22  이엠룩          최초 생성
 *      </pre>
 */

@Repository("z3Sales2UserResultDAO")
public class Z3Sales2UserResultDAO extends ZenielMAbstractDAO {
	
	/**
	 * 실적 카운트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectResultMngCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2UserResult.selectResultMngCnt", params);
    }
	public int selectResultDetailCnt(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2UserResult.selectResultDetailCnt", params);
	}
	
	
	/**
	 * 실적 or 실적디테일 인설트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int insertResultMng(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2UserResult.insertResultMng", params);
	}
	public int insertResultLMng(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2UserResult.insertResultLMng", params);
	}
	public int insertResultDetail(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2UserResult.insertResultDetail", params);
	}
	public int insertResultLDetail(Map<String, Object> params) throws Exception {
		return insert("zenielm.zemos3.family.sales2.sales2UserResult.insertResultLDetail", params);
	}
	
	/**
	 * 실적 or 실적디테일 셀렉트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectResultMng(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2UserResult.selectResultMng", params);
	}
	public List<Map<String, Object>> selectResultDetail(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2UserResult.selectResultDetail", params);
	}
	/**
	 * 월마감 Yn
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectCloseYn(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2UserResult.selectCloseYn", params);
	}
	
	/**
	 * 실적디테일 업데이트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2UserResult.updateResultDetail", params);
	}
	public int updateResultLDetail(Map<String, Object> params) throws Exception {
		return update("zenielm.zemos3.family.sales2.sales2UserResult.updateResultLDetail", params);
	}
}
