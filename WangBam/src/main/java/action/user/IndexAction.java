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
		if(b_ar != null) {
			request.setAttribute("b_ar", b_ar);
		}
		
		HashMap<String, String> map2 = new HashMap<>();
		map2.put("start", "1");
		map2.put("end", "6");
		
		ProductVO[] p_ar = ProductDAO.findProductByName(map2);
		if(p_ar != null) {
			request.setAttribute("p_ar", p_ar);
		}

		
		return "/jsp/user/main.jsp";
	}

}
