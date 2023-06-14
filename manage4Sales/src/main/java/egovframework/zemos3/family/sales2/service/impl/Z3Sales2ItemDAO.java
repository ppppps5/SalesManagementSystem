package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.ZenielMAbstractDAO;

/**
 * 판매관리 품목 DAO 클래스
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
@Repository("z3Sales2ItemDAO")
public class Z3Sales2ItemDAO extends ZenielMAbstractDAO {
	
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Item.selectUnitList", params);
	}
	
	public int selectUnitListCnt(Map<String, Object> params) throws Exception {
		return selectOne("zenielm.zemos3.family.sales2.sales2Item.selectUnitListCnt", params);
	}
	
	public List<Map<String, Object>> selectItemList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Item.selectItemList", params);
	}
	
	public List<Map<String, Object>> selectItemList01(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Item.selectItemList01", params);
	}
	
	public List<Map<String, Object>> selectItemList02(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Item.selectItemList02", params);
	}
	
	public List<Map<String, Object>> selectItemDetailList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Item.selectItemDetailList", params);
	}
	
	public List<Map<String, Object>> selectItemUseNameList(Map<String, Object> params) throws Exception {
    	return selectList("zenielm.zemos3.family.sales2.sales2Item.selectItemUseNameList", params);
	}
	
	public int selectItem(Map<String, Object> params) throws Exception {
    	return selectOne("zenielm.zemos3.family.sales2.sales2Item.selectItem", params);
    }
	
	public int itemInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Item.itemInsert", params);
    }
	
	public int itemDetailInsertD(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Item.itemDetailInsertD", params);
    }
	
	public int itemDetailDeleteD(Map<String, Object> params) throws Exception {
    	return delete("zenielm.zemos3.family.sales2.sales2Item.itemDetailDeleteD", params);
    }
	
	public int StoreitemInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Item.StoreitemInsert", params);
    }
	
	public int itemDetailInsert(Map<String, Object> params) throws Exception {
    	return insert("zenielm.zemos3.family.sales2.sales2Item.itemDetailInsert", params);
    }
	
	public int itemUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Item.itemUpdate", params);
    }
	
	public int StoreitemUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Item.StoreitemUpdate", params);
    }
	
	public int itemDetailUpdate(Map<String, Object> params) throws Exception {
    	return update("zenielm.zemos3.family.sales2.sales2Item.itemDetailUpdate", params);
    }
	
}
