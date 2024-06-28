package action.admin;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;

public class SaveImageAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		ServletContext app = request.getServletContext();
		String realPath = app.getRealPath("/upload");
		try {
			MultipartRequest mr = new MultipartRequest(
					request, realPath, 1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());

			File f = mr.getFile("upload");
			String f_name = null;
			if (f != null)
				f_name = f.getName();

			request.setAttribute("f_name", f_name);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "jsp/admin/saveImage.jsp";
	}

}
