package com.fpdisys.dist.menu.domain;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.Serializable;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;



/**
 * 메뉴 트리맵 (HashMap 을 TreeMap 형태로)
 * @Class Name MenuTreeMap.java
 * @Description
 * @author swchoi
 * @since 2020.05.14
 * @version 1.0
 */
public class MenuTreeMap implements Serializable {
	private static final long serialVersionUID = -8187810119635894875L;
	private HashMap<String, MenuVO> menuMap = new HashMap<String, MenuVO>();
	private List<MenuVO> topList = new LinkedList<MenuVO>();
    protected Log log = LogFactory.getLog(this.getClass());
    /**
     * 메뉴 객체 TreeMap에 삽입
     * @param bean
     */
    public final void put(MenuVO bean){
        if(bean == null){
            return;
        }
        log.debug("bean.getMenuId() = " + bean.getMenuId());
        log.debug("bean.getUpperId() = " + bean.getUpperId());
        String menuId = bean.getMenuId();
        String upperId = bean.getUpperId();
        
        if(menuMap.containsKey(menuId)){
            menuMap.remove(menuId);
        }

        menuMap.put(menuId, bean);

        MenuVO parent = (MenuVO)menuMap.get(upperId);

        if(parent != null){
            parent.addChild(bean);
        } else {
            if(topList.contains(bean)){
                // 같은 menuId를 가진 MenuVO obj를 삭제한다.
                topList.remove(bean);
            }
            topList.add(bean);
        }
        log.debug("topList = " + topList);
    }
    
    /**
     * 메뉴분류 최상위 레벨 목록 반환
     * @return
     */
    public List<MenuVO> getTopLevelCategories(){
        return Collections.unmodifiableList(topList);
    }
    
    /**
     * 메뉴분류 카운트 반환
     * @return
     */
    public int size(){
        return menuMap.size();
    }
    
    /**
     * TreeMap 저장된 메뉴 DTO 객체 리턴
     * @param menuId
     * @return
     */
    public MenuVO getById(String menuId){
        return (MenuVO)menuMap.get(menuId);
    }
	
	/**
	 * 지정 menuId의 지정 상위 뎁스의 메뉴 정보 반환
	 * @param menuId
	 * @param depth
	 * @return
	 */
	public MenuVO getByUpperId(String menuId, int depth) {
		MenuVO menu = getById(menuId);
		if(menu != null) {
			if(menu.getDepth().intValue() > depth) {
				menu = getByUpperId(menu.getUpperId(), depth);
			}
		}
		return menu;
	}

	public MenuVO getMenuList(String target) {
		// TODO Auto-generated method stub
		return (MenuVO)menuMap.get(target);
	}

}
