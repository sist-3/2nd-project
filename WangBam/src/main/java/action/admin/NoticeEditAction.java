package action.admin;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import mybatis.dao.BoardsDAO;
import mybatis.vo.BoardsVO;

public class NoticeEditAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewPath = null;
		String enc_type = request.getContentType();
		String bo_idx = request.getParameter("bo_idx");
		String cPage = request.getParameter("cPage");
		
		
		if(!enc_type.startsWith("multipart")) {
			BoardsVO vo = BoardsDAO.findByidx(bo_idx);
			
			request.setAttribute("vo", vo);
			viewPath = "/jsp/admin/noticeEdit.jsp";
			
			
			
		}else if(enc_type.startsWith("multipart")){
			ServletContext app = request.getServletContext();
			
			String realPath = app.getRealPath("/upload");
			try {
				MultipartRequest mr = new MultipartRequest(request, realPath, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
				
				String bo_title = mr.getParameter("title");
				String bo_content = mr.getParameter("content");
				String bo_idx2 = mr.getParameter("bo_idx");
				
				File f = mr.getFile("file");
				String fname = null;
				String oname = null;
				if(f!=null) {
					fname = f.getName();
					oname = mr.getOriginalFileName("file");
				}
				
				Map<String, String> map = new HashMap<>();
				//map.put("us_idx",us_idx); 이거 가능한가?
				map.put("bo_idx", bo_idx2);
				map.put("bo_title", bo_title);
				map.put("bo_content", bo_content);
				
				
				BoardsDAO.update(map);
				
				viewPath = "admin?type=noticeDetail&bo_idx="+bo_idx2;
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		return viewPath;
	}

}
