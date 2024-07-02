package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;

import action.Action;
import mybatis.dao.CartDAO;
import mybatis.vo.CartVO;
import mybatis.vo.UserVO;

public class CartListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Object obj =session.getAttribute("user");
		if (obj!=null) {
			UserVO user = (UserVO)obj;
			String us_idx = user.getUs_idx();
			
			Map<String, String> map = new HashMap<>();
			
			map.put("us_idx", us_idx);

			CartVO[] cvo = CartDAO.allCart(us_idx);
			session.setAttribute("cvo", cvo);

			return "jsp/user/cart.jsp";
		}
		return"jsp/user/redirectMain.jsp";
		
		
	}
}
