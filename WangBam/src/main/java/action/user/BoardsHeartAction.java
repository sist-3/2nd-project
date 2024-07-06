package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.HeartDAO;
import mybatis.vo.BoardsVO;

public class BoardsHeartAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String doCheck = request.getParameter("doCheck");
		
		String bo_idx = request.getParameter("bo_idx");
		String us_idx = request.getParameter("us_idx");
		
		Map<String, String> map = new HashMap<>();
		map.put("bo_idx", bo_idx);
		if(us_idx != null)
			map.put("us_idx", us_idx);
		else
			map.put("us_idx", "0");
		
		
		switch(doCheck) {
		case "add":
			HeartDAO.add(map);
			break;
		case "remove":
			HeartDAO.remove(map);
			break;
		}
		BoardsVO vo = BoardsDAO.findByidx(bo_idx);
		boolean check = HeartDAO.check(map);
		int count = HeartDAO.count(bo_idx);
		
		request.setAttribute("check", check);
		request.setAttribute("count", count);
		request.setAttribute("vo", vo);
		
		return "/jsp/user/noticeDetail.jsp";
	}

}
