package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.bean.OrdineBean;
import it.unisa.model.bean.UserBean;
import it.unisa.model.dao.OrdiniDAO;


public class OrdiniControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(OrdiniControl.class.getName());
	
       private static final OrdiniDAO model = new OrdiniDAO();

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserBean user = (UserBean) request.getSession().getAttribute("Utente");
		ArrayList<OrdineBean> ordini = new ArrayList<>();
		try {
			ordini = model.doRetrieveAll(user.getIdUtente());
			request.setAttribute("ordini", ordini);
			
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Errore OrdiniControl: " + e.getMessage(), e);
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/OrdiniView.jsp");
		dispatcher.forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
