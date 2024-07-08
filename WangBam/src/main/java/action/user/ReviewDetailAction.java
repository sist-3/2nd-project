package action.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.HeartDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.UserVO;

public class ReviewDetailAction implements Action {
	
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
HttpSession session = request.getSession();
		
		UserVO uvo = null;
		String us_idx = null;
		Object cnt = session.getAttribute("hit");
		Object obj = session.getAttribute("user");
		String bo_idx = request.getParameter("bo_idx");
		String cPage = request.getParameter("cPage");
		
		if(obj != null) {
			uvo = (UserVO) obj;
			us_idx = uvo.getUs_idx();
		}
		if(cnt == null) {
			hit_list = new ArrayList<>();
			session.setAttribute("hit", hit_list);
		}else {
			hit_list = (ArrayList<BoardsVO>)cnt;
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("bo_idx", bo_idx);
		if(us_idx != null)
			map.put("us_idx", us_idx);
		else
			map.put("us_idx", "0");
		
		
		BoardsVO vo = BoardsDAO.findByidx(bo_idx);
		int count = HeartDAO.count(bo_idx);
		boolean check = HeartDAO.check(map);
		
		if(vo != null) {
			if(checkView(vo)) {
				BoardsDAO.updateHit(bo_idx); //조회수 증가
				hit_list.add(vo); //읽은 게시물 추가
			}
			request.setAttribute("cPage", cPage);
			request.setAttribute("vo", vo);
			request.setAttribute("count", count);
			request.setAttribute("check", check);
		}
		return "jsp/user/reviewDetail.jsp";
	}
}
