package mybatis.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;

public class HeartDAO {
	
	
	public static int count(String bo_idx){
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = 0;
		cnt = ss.selectOne("heart.count", bo_idx);

		ss.close();

		return cnt;
	}
	
	public static boolean check(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		boolean check = false;
		
		int cnt = ss.selectOne("heart.check", map);
		
		if(cnt>0) 
			check = true;

		ss.close();
		
		return check;
	}
	
	public static void add(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();

		int cnt = ss.insert("heart.add", map);
		
		if(cnt>0)
			ss.commit();
		else
			ss.rollback();

		ss.close();
	}
	
	public static void remove(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();

		int cnt = ss.delete("heart.remove", map);
		
		if(cnt>0)
			ss.commit();
		else
			ss.rollback();

		ss.close();
	}
	
	public static String boardsCount(ArrayList<String> list) {
		SqlSession ss = FactoryService.getFactory().openSession();
		String bo_idx;
		Map<String, Object> bo_idx_map = ss.selectOne("heart.boardsCount", list);

		ss.close();
		if(bo_idx_map != null) {
			bo_idx = bo_idx_map.get("bo_idx").toString();
		}else {
			bo_idx = null;
		}
		return bo_idx;
		
	}
}
