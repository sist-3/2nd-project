package action.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;

public class BoardsDetailAction implements Action {
	
	List<BoardsVO> hit_list;
	
	public boolean checkView(BoardsVO vo) { //조회수 증가를 위해 이미 읽은 게시글인지 체크
		boolean checkHit = true;
		
		for(BoardsVO bvo: hit_list) {
			if(bvo.getBo_idx().equals(vo.getBo_idx())) {
				checkHit = false;
				break;
			}
		}
		return checkHit;
	}
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		String bidx = request.getParameter("bidx");
		String cPage = request.getParameter("cPage");
		
		HttpSession session = request.getSession();
		Object cnt = session.getAttribute("hit");
		
		if(cnt == null) { //없으면 만든다
			hit_list = new ArrayList<>();
			//생성된 리스트를 세션에 저장한다.
			session.setAttribute("hit", hit_list);
		}else {
			hit_list = (ArrayList<BoardsVO>)cnt;
		}
		
		BoardsVO vo = BoardsDAO.findByidx(bidx);
		
		
		if(vo != null) {
			if(checkView(vo)) {
				BoardsDAO.updateHit(bidx); //조회수 증가
				hit_list.add(vo); //읽은 게시물 추가
			}
			request.setAttribute("cPage", cPage);
			request.setAttribute("vo", vo);
			viewPath = "jsp/user/boardsDetail.jsp";
		}
		return viewPath;
	}
}
