package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 판매관리현황 DAO 클래스
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
@Repository("z3Sales2PresentDAO")
public class Z3Sales2PresentDAO extends ZenielMAbstractDAO {
	
	/**
	 * 셀렉박스 품목 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectItemsList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Present.selectItemsList", params);
	}
	
	/**
	 * 셀렉박스 온오프 List
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectBoxOnoffList(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Present.selectBoxOnoffList", params);
	}
	
	/**
	 * 판매관리현황
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSales2Present(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Present.selectSales2Present", params);
	}
	
	/**
	 * 판매관리현황 합계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSalesPresentSum(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Present.selectSalesPresentSum", params);
	}
	
	/**
	 * 판매관리현황 cnt
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectSales2PresentCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Present.selectSales2PresentCnt", params);
	}
		
	/**
	 * 판매관리현황 월대장 월의 첫날 구하기
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectFirstDayOfMonth(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Present.selectFirstDayOfMonth", params);
	}
	
	/**
	 * 판매관리현황 월대장
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSalesPresentMonth(Map<String, Object> params) throws Exception {
		return selectList("zenielm.zemos3.family.sales2.sales2Present.selectSalesPresentMonth", params);
	}
	
	/**
	 * 판매관리현황 상세
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectSalesPresentDetail(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Present.selectSalesPresentDetail", params);
	}
	
	public Map<String, Object> selectSalesPresentDetailCnt(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Present.selectSalesPresentDetailCnt", params);
	}
}
