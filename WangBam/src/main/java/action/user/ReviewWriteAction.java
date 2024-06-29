package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CategoryDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.CategoryVO;
import mybatis.vo.ProductVO;

public class ReviewWriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		String enc_type = request.getContentType();
		 
		if (enc_type == null || !enc_type.startsWith("multipart")) {
			String pd_idx = request.getParameter("pd_idx");
			request.setAttribute("pd_idx", pd_idx);
			
			viewPath = "/jsp/user/reviewWrite.jsp";
			
		} else if (enc_type.startsWith("multipart")) {
	
			try {
				  //ServletContext app = request.getServletContext();
				 //String realPath = app.getRealPath("/upload");

				MultipartRequest mr = new MultipartRequest(
						request, "C:/2nd-project/WangBam/src/main/webapp/img", 1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());

				String bo_title = mr.getParameter("bo_title");
				String us_idx = mr.getParameter("us_idx");
				String bo_content = mr.getParameter("bo_content");
				String pd_idx = mr.getParameter("pd_idx");

				Map<String, String> map = new HashMap<>();
				map.put("us_idx", us_idx );
				map.put("pd_idx", pd_idx );
				map.put("bo_type", "2");
				map.put("bo_title", bo_title );
				map.put("bo_content", bo_content );
				
				BoardsDAO.add(map);

				viewPath = "/jsp/user/add_success_review.jsp";
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return viewPath;
	}

}
