package egovframework.zemos3.family.sales2.service;

import java.util.List;
import java.util.Map;

public interface Z3Sales2UserResultService {

	/**
	 * 실적Mng count
	 */
	public int selectResultMngCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Detail count
	 */
	public int selectResultDetailCnt(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Mng List
	 */
	public List<Map<String, Object>> selectResultMng(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Detail List
	 */
	public List<Map<String, Object>> selectResultDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 월마감 Yn
	 */
	public List<Map<String, Object>> selectCloseYn(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Mng insert
	 */
	public int insertResultMng(Map<String, Object> params) throws Exception;
	public int insertResultLMng(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Detail insert
	 */
	public int insertResultDetail(Map<String, Object> params) throws Exception;
	public int insertResultLDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 실적Detail update
	 */
	public int updateResultDetail(Map<String, Object> params) throws Exception;
	public int updateResultLDetail(Map<String, Object> params) throws Exception;
}
