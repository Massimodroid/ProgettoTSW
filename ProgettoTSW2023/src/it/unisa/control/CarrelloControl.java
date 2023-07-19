package it.unisa.control;
import it.unisa.model.*;
import it.unisa.model.bean.OrdineBean;
import it.unisa.model.bean.UserBean;
import it.unisa.model.dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.logging.Logger;




public class CarrelloControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String CARRELLO = "carrello";
	Logger logger = Logger.getLogger(AdminControl.class.getName());
	
    ProdottoDAO model = new ProdottoDAO();
       OrdiniDAO modelOrdini = new OrdiniDAO();
       ComponiDAO modelComponi = new ComponiDAO();
       
    
    public CarrelloControl() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Carrello carrello = (Carrello)request.getSession().getAttribute(CARRELLO);
		UserBean user = (UserBean)request.getSession().getAttribute("Utente");
		OrdineBean ordine = new OrdineBean();
		boolean state=false;
		if(carrello == null) {
			carrello = new Carrello();
			request.getSession().setAttribute(CARRELLO, carrello);
		}
		String op = request.getParameter("op");
		if(op != null) {
			int id;
			if(op.equalsIgnoreCase("aggC")) {
				 id = Integer.parseInt(request.getParameter("id"));
				 carrello.addItem(id);
				 
				}
			else if(op.equalsIgnoreCase("cancC")) {
				 id = Integer.parseInt(request.getParameter("id"));
				carrello.deleteItem(id);
				}
			else if(op.equalsIgnoreCase("cambiaQ")) {
				id = Integer.parseInt(request.getParameter("id"));
				int num = Integer.parseInt(request.getParameter("numCount"));
				carrello.setNumeroProdotto(id, num);
			}
			else if(op.equalsIgnoreCase("acquista")) {
				try {
					if(carrello != null && user.isValid()) {
						ordine.setStato("Confermato");
						Date data = new Date(System.currentTimeMillis());
						ordine.setData(data);
						ordine.setIdUtente(user.getIdUtente());
						modelOrdini.doSave(ordine);
						modelComponi.doSave(modelOrdini.doRetrieveByKey(user.getIdUtente()), carrello);
						List<ProdottoCarrello> list= new ArrayList<>();
						list = carrello.getAllItem();
						for(ProdottoCarrello prdC:list) {
							int idP= prdC.getProdottoID();
							int quant = prdC.getNumProdotto();
							model.refreshQuantitaTot(idP, quant);
						}
					}
					else {
						throw new SQLException();
					}
					
					
				} catch (SQLException e) {
					logger.log(null,"Errore Carrello Control: "+e.getMessage());
					
				}
				carrello.deleteAll();
				response.sendRedirect("./catalogo");
				state=true;
			}
			
		}
		
		request.getSession().setAttribute(CARRELLO, carrello);
		request.setAttribute(CARRELLO, carrello);
		if(state == false) {
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CarrelloView.jsp");
		dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
