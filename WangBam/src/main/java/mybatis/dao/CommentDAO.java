package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.CommentVO;

public class CommentDAO {
	
	//댓글 조회
	public static CommentVO[] find(String bo_idx){
		SqlSession ss = FactoryService.getFactory().openSession();
		
		CommentVO[] ar = null;
		
		List<CommentVO> list = ss.selectList("comment.find",bo_idx);
		
		if(list!=null) {
			ar = new CommentVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		return ar;
	}
	
	//댓글 등록
	public static int add(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.insert("comment.add", map);
		
		ss.close();
		
		return cnt;
	}
	
	//댓글 수정
	public static int update(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("comment.update", map);
		
		ss.close();
		
		return cnt;
	}
	
	//댓글 삭제
	public static int update(String bo_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("comment.delete", bo_idx);
		
		ss.close();
		
		return cnt;
	}
}
