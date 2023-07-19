package it.unisa.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.unisa.model.dao.UserDAO;
import it.unisa.model.bean.UserBean;



public class EmailCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(EmailCheck.class.getName());
	
	private static final UserDAO model = new UserDAO();
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Metodo vuoto - Nessuna implementazione richiesta per questa servlet
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserBean user;
		String email = request.getParameter("email");
	
		
		try {
			user = model.doRetrievebyemail(email);
			if(user!=null && user.isValid()) {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.print("Email già presente <br>");
			}
			
			
		} catch (SQLException e) {
			logger.log(Level.SEVERE, () -> "Errore CheckMail: " + e.getMessage());
		}
		
		
		
		
		
	}

}
