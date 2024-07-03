package action.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.dao.CategoryDAO;
import mybatis.dao.ProductDAO;
import mybatis.vo.BoardsVO;
import mybatis.vo.CategoryVO;
import mybatis.vo.ProductVO;

public class ReviewEditAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		String enc_type = request.getContentType();
		String bo_idx = request.getParameter("bo_idx");
		String cPage = request.getParameter("cPage");
		
		if(enc_type == null) {
			BoardsVO vo = BoardsDAO.findByidx(bo_idx);
			
			request.setAttribute("cPage", cPage);
			request.setAttribute("vo", vo);
			
			viewPath = "/jsp/user/reviewEdit.jsp";
			
			
			
		}else if(enc_type.startsWith("multipart")){
			ServletContext app = request.getServletContext();
			
			String realPath = "C:/2nd-project/WangBam/src/main/webapp/img";
			try {
				MultipartRequest mr = new MultipartRequest(request, realPath, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
				
				String bo_title = mr.getParameter("bo_title");
				String bo_content = mr.getParameter("bo_content");
				String bo_idx2 = mr.getParameter("bo_idx");
				String pd_idx = mr.getParameter("pd_idx");
				String cPage2 = mr.getParameter("cPage");
				
				Map<String, String> map = new HashMap<>();
				map.put("bo_idx", bo_idx2);
				map.put("pd_idx", pd_idx );
				map.put("bo_title", bo_title);
				map.put("bo_content", bo_content);
				
				BoardsDAO.update(map);
				
				viewPath = "?type=reviewDetail&bo_type=1&bo_idx="+bo_idx2+"&cPage="+cPage2;
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		return viewPath;
	}

}
