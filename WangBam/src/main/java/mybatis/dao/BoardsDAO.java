package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.BoardsVO;

public class BoardsDAO {
	
	public static int allCount(String bo_type) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.selectOne("boards.allCount",bo_type);
		
		ss.close();
		
		return cnt;
	}
	
	//전체 게시글 목록 조회
	public static BoardsVO[] find(Map<String, String> map) { //타입별 게시글 배열 반환
		SqlSession ss = FactoryService.getFactory().openSession();
		
		BoardsVO[] ar = null;
		
		List<BoardsVO> list = ss.selectList("boards.find", map);
		
		if(list != null) {
			ar = new BoardsVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		
		return ar;
	}
	
	//유저가 자신의 문의사항 게시글 목록 조회
	public static BoardsVO[] findUserQuestion(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		BoardsVO[] ar = null;
		
		List<BoardsVO> list = ss.selectList("boards.allUserQuestion", map);
		
		if(list != null) {
			ar = new BoardsVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		
		return ar;
	}
	
	//글 작성
	public static int add(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.insert("boards.add", map);
		ss.close();
		
		return cnt;
	}
	
	//글 수정
	public static int update(Map<String, String> map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("boards.update", map);
		ss.close();
		
		return cnt;
	}
	
	//글 삭제
	public static int delete(String bo_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("boards.delete", bo_idx);
		ss.close();
		
		return cnt;
	}
	
	//게시글 상세보기
	public static BoardsVO[] findByidx(String bo_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		BoardsVO[] ar = null;
		
		List<BoardsVO> list = ss.selectList("boards.findByidx", bo_idx);
		
		if(list != null) {
			ar = new BoardsVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		
		return ar;
	}
	
	//답변상태 변경
	public static int updateByidx(String bo_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("boards.updateByidx", bo_idx);
		ss.close();
		
		return cnt;
	}
}
