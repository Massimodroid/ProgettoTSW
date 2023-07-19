package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.dao.*;
import it.unisa.model.bean.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class RegistrazioneControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(RegistrazioneControl.class.getName());
	
       private static final UserDAO modelUser = new UserDAO();
   
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			UserBean user = new UserBean();
			user.setNome(request.getParameter("nm"));
			user.setCognome(request.getParameter("cgm"));
			user.setEmail(request.getParameter("email"));
			user.setPassword(request.getParameter("psw"));
			modelUser.doSave(user);
			user = modelUser.doRetrieveUtente(request.getParameter("email"), request.getParameter("psw"));
			request.getSession().setAttribute("Utente", user);
		}catch(SQLException e) {
			
			logger.log(Level.SEVERE, "context: " + e.getMessage(), e);
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/catalogo");
		dispatcher.forward(request, response);	
	}
}
