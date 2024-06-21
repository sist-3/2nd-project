package mybatis.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.BoardsVO;

public class BoardsDAO {
	//전체 게시글 갯수 조회
	public static int allCount(String bo_type) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.selectOne("boards.allCount",bo_type);
		
		ss.close();
		
		return cnt;
	}
	//검색된 전체 게시글 갯수 조회
	public static int allSearchCount(Map<String, String> s_map) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.selectOne("boards.allSearchCount",s_map);
		
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
	
	//카테고리별 리뷰 목록 조회
		public static BoardsVO[] findReview(Map<String, String> map) { //타입별 게시글 배열 반환
			SqlSession ss = FactoryService.getFactory().openSession();
			
			BoardsVO[] ar = null;
			
			List<BoardsVO> list = ss.selectList("boards.findReview", map);
			
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
		if(cnt > 0)
			ss.commit();
		else
			ss.rollback();
		ss.close();
		
		return cnt;
	}
	
	//게시글 상세보기
	public static BoardsVO findByidx(String bo_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		BoardsVO vo = ss.selectOne("boards.findByidx", bo_idx);
		ss.close();
		
		return vo;
	}
	
	//답변상태 변경
	public static int updateByidx(String bo_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.update("boards.updateByidx", bo_idx);
		ss.close();
		
		return cnt;
	}
	
	//상품상세페이지 문의,리뷰 게시판
	public static BoardsVO[] findBypdidx(String pd_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		BoardsVO[] ar = null;
		List<BoardsVO> list = ss.selectList("boards.findBypdidx",pd_idx);
		if(list != null) {
			ar = new BoardsVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		
		return ar;
	}
	
	//리뷰 게시판 글 수
		public static int countReview(String ct_idx) {
			SqlSession ss = FactoryService.getFactory().openSession();
			
			int cnt = ss.selectOne("boards.countReview",ct_idx);
			
			ss.close();
			
			return cnt;
		}
	
}
