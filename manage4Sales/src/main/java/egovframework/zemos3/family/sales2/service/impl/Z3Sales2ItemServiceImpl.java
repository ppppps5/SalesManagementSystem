package egovframework.zemos3.family.sales2.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.push.service.PushService;
import egovframework.com.user.service.UserService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.zemos3.com.admin.service.Z3AdminService;
import egovframework.zemos3.family.sales2.service.Z3Sales2ItemService;
import egovframework.zemos3.zemos.menu.service.impl.Z3ZemosMenuErpHDAO;

/**
 * 판매관리 품목 서비스Impl 클래스
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
@Service("z3Sales2ItemService")
public class Z3Sales2ItemServiceImpl extends EgovAbstractServiceImpl implements Z3Sales2ItemService {

	@Resource(name="z3ZemosMenuErpHDAO")
    private Z3ZemosMenuErpHDAO z3ZemosMenuErpHDAO;
	
	@Resource(name = "userService")
    protected UserService userService;
	
	@Resource(name = "pushService")
    protected PushService pushService;
	
	@Resource(name = "z3AdminService")
	protected Z3AdminService z3AdminService;
	
	//품목 DAO
	@Resource(name = "z3Sales2ItemDAO")
	private Z3Sales2ItemDAO z3Sales2ItemDAO;
	
	public List<Map<String, Object>> selectUnitList(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectUnitList(params);
	}
	
	public int selectUnitListCnt(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectUnitListCnt(params);
	}
	
	public List<Map<String, Object>> selectItemList(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectItemList(params);
	}
	
	public List<Map<String, Object>> selectItemList01(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectItemList01(params);
	}
	
	public List<Map<String, Object>> selectItemList02(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectItemList02(params);
	}
	
	public List<Map<String, Object>> selectItemDetailList(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectItemDetailList(params);
	}
	
	public List<Map<String, Object>> selectItemUseNameList(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectItemUseNameList(params);
	}
	
	public int selectItem(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.selectItem(params);
	}
	
	public int itemInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.itemInsert(params);
	}
	
	public int itemDetailInsertD(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.itemDetailInsertD(params);
	}
	
	public int itemDetailDeleteD(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.itemDetailDeleteD(params);
	}
	
	public int StoreitemInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.StoreitemInsert(params);
	}
	
	public int itemDetailInsert(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.itemDetailInsert(params);
	}
	
	public int itemUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.itemUpdate(params);
	}
	
	public int StoreitemUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.StoreitemUpdate(params);
	}
	
	public int itemDetailUpdate(Map<String, Object> params) throws Exception {
		return z3Sales2ItemDAO.itemDetailUpdate(params);
	}
}
