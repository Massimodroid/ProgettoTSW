package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.dao.ProdottoDAO;
import it.unisa.model.bean.ProdottoBean;

public class ChooseTypeControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(ChooseTypeControl.class.getName());
	
       private static final ProdottoDAO model = new ProdottoDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<ProdottoBean> prodotti = new ArrayList<>();
		String tipologia = request.getParameter("tipologia");
		String like = request.getParameter("like");
		String search = request.getParameter("search");
		
		try {
			if(tipologia!=null || like!=null) {
			prodotti = model.retrieveByType(tipologia,like);
			}
			else {
				prodotti = model.search(search);
			}
			if(prodotti!=null) {
				
				request.setAttribute("prodotti", prodotti);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Tipologia.jsp");
				dispatcher.forward(request, response);
				return;
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, () -> "Errore in Choose Type Control" + e.getMessage());
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/catalogo");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Non sono richieste operazioni specifiche per le richieste POST in questo servlet.
	    // Il servlet gestisce solo le richieste GET.
	}

}
