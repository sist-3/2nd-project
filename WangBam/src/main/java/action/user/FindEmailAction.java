package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import mybatis.dao.UserDAO;
import mybatis.vo.UserVO;

public class FindEmailAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath=null;
		if(request.getMethod().equals("GET")){
			viewPath = "jsp/user/findEmail.jsp";
		}else if(request.getMethod().equals("POST")){
			String us_name = request.getParameter("us_name");
			String[] phone = request.getParameterValues("us_tel");
			StringBuffer sb = new StringBuffer();
			for(String p : phone){
				sb.append(p);
			}
			String us_tel = sb.toString();
			Map<String, Object> map = new HashMap<>();
			map.put("us_name", us_name);
			map.put("us_tel", us_tel);
			UserVO[] u_list = UserDAO.findByNameAndTel(map);
			if(u_list.length == 0){
				request.setAttribute("message", "해당하는 사용자가 없습니다.");
				viewPath = "jsp/user/findEmail.jsp";
			}else{
				request.setAttribute("u_list", u_list);
				viewPath = "jsp/user/findEmailSuccess.jsp";
			}
		}
		return viewPath;
	} 
}
