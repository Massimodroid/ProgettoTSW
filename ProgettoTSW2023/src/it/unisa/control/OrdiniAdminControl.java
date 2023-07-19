package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.bean.ComponiBean;
import it.unisa.model.bean.OrdineBean;
import it.unisa.model.bean.UserBean;
import it.unisa.model.dao.OrdiniDAO;
import it.unisa.model.dao.UserDAO;
import it.unisa.model.dao.ComponiDAO;


public class OrdiniAdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(OrdiniAdminControl.class.getName());
	
	private static final OrdiniDAO modelOrdini = new OrdiniDAO();
	private static final UserDAO modelUser = new UserDAO();
	private static final ComponiDAO model = new ComponiDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<OrdineBean> ordini = new ArrayList<>();
		String op = request.getParameter("op");
		
		if(op.equalsIgnoreCase("ricercaD")) {
			Date data1 = Date.valueOf(request.getParameter("data1"));
			Date data2 = Date.valueOf(request.getParameter("data2"));
			
			try {
				ordini = modelOrdini.doRetrieveForDate(data1, data2);
				if(ordini!=null) {
					request.setAttribute("ordini", ordini);
				}
			} catch (SQLException e) {
				logger.log(Level.SEVERE, () -> "Errore Ordini Admin Control: " + e.getMessage());
			}
		}
		if(op.equalsIgnoreCase("ricercaN")){
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			ArrayList<UserBean> utenti = new ArrayList<>();
			try {
				utenti=modelUser.doRetrieveUtenteForName(nome, cognome);
				request.setAttribute("utenti", utenti);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Admin/OrdiniGeneralAdmin.jsp");
				dispatcher.forward(request, response);
				return;
				
			} catch (SQLException e) {
				logger.log(Level.SEVERE, () -> "Errore Ordini Admin Control: " + e.getMessage());
			}
		}
		if(op.equalsIgnoreCase("dettagli")) {
			int id=Integer.parseInt(request.getParameter("id"));
			ArrayList<ComponiBean> bean = new ArrayList<>();
			try {
				bean = model.doRetrieveByKey(id);
			} catch (SQLException e) {
				logger.log(Level.SEVERE, () -> "context: " + e.getMessage());
			}
			request.setAttribute("componi", bean);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Admin/DettagliAdmin.jsp");
			dispatcher.forward(request, response);
			return;
		}
		if(op.equalsIgnoreCase("view")) {
			int id = Integer.parseInt(request.getParameter("id"));
			try {
				ordini = modelOrdini.doRetrieveAll(id);
				request.setAttribute("ordini", ordini);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Admin/OrdiniAdmin.jsp");
				dispatcher.forward(request, response);
				return;
			} catch (SQLException e) {
				logger.log(Level.SEVERE, () -> "context: " + e.getMessage());
			}
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Admin/OrdiniAdmin.jsp");
		dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
