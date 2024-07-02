package action.user;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.ProductVO;

public class IndexAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HashMap<String, String> map = new HashMap<>();
		map.put("bo_type", "0");
		map.put("begin", "1");
		map.put("end", "4");
		
		BoardsVO[] b_ar = BoardsDAO.find(map);
		ProductVO[] p_ar = ProductDAO.findproductByMonth();
		int cnt = ProductDAO.allProduct().length;
		request.setAttribute("cnt", cnt);
		if(b_ar != null) {
			request.setAttribute("b_ar", b_ar);
		}
		if(p_ar != null) {
			request.setAttribute("p_ar", p_ar);
		}
		

		
		return "/jsp/user/main.jsp";
	}

}
