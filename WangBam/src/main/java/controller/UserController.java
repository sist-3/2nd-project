package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;

/**
 * Servlet implementation class Controller
 */
@WebServlet(
		urlPatterns = { "/" }, 
		initParams = { 
				@WebInitParam(name = "myParam", value = "/WEB-INF/u_action.properties")
		})
public class UserController extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	private HashMap<String, Action> actionMap;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        actionMap = new HashMap<>();
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init() throws ServletException {
		String props_path = getInitParameter("myParam");
		
		ServletContext application = getServletContext();
		
		String realPath = application.getRealPath(props_path);

		Properties prop = new Properties();
		
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(realPath);
			
			prop.load(fis);//action.properties파일의 내용들을
		} catch (Exception e) {
		}
		
		Iterator<Object> it = prop.keySet().iterator();//키들만
		
		while(it.hasNext()) {
			String key = (String)it.next();
			
			String value = prop.getProperty(key);
				
			try {
				Object obj = 
					Class.forName(value).newInstance();
				actionMap.put(key, (Action)obj);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}//while의 끝
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");

		if(type == null)
			type = "index";
		
		Action action = actionMap.get(type);
		String viewPath = null;
		if(action == null) {
			action = actionMap.get("index");
		}
		try {
			viewPath = action.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		RequestDispatcher disp = request.getRequestDispatcher(viewPath);
		disp.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
