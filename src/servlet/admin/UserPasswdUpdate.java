package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.IUserDAO;
import dao.impl.UserDAOImpl;
import entity.User;

/**
 * Servlet implementation class UserPasswdUpdate
 */
public class UserPasswdUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPasswdUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String info=null;
		IUserDAO dao=new UserDAOImpl();
		String uid=(String)request.getParameter("uid");
		User user=dao.findByID(uid);
		//System.out.println((String)request.getParameter("pwd1"));
		
		String pass=request.getParameter("pwd1");
		String pass1=request.getParameter("pwd2");
		if(pass.equals(pass1)) {
			user.setUserPasswd(pass);
			if(dao.updatePasswdByID(user)==1) {
				info="修改密码成功！管理";
			}
			else info="修改密码失败，请检查后重试！";
		}else info="修改密码失败，请检查后重试！";
		user=dao.findByID(uid);
		request.setAttribute("info", info);
		request.getRequestDispatcher("/admin/userPasswdUpdate.jsp").forward(request, response);
		
	}

}
