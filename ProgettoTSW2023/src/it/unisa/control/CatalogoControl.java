package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Logger;

import it.unisa.model.dao.ProdottoDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CatalogoControl extends HttpServlet {
    private static final long serialVersionUID = 1656464L;
    private static final String INDEX = "index";
     Logger logger = Logger.getLogger(CatalogoControl.class.getName());

    private static ProdottoDAO model = new ProdottoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int index = 0;
        if (request.getSession().getAttribute(INDEX) == null) {
            request.getSession().setAttribute(INDEX, index);
        } else {
            index = (int) request.getSession().getAttribute(INDEX);
        }

        try {
            request.removeAttribute("prodotti");
            request.setAttribute("prodotti", model.doRetrieveAll());
        } catch (SQLException e) {
            logger.log(null, () -> "Errore: " + e.getMessage());
        }

        String action = request.getParameter("action");
        if (action != null) {
            if (action.contentEquals("add")) {
                index++;
                request.getSession().setAttribute(INDEX, index);
            } else if (action.contentEquals("sub")) {
                index--;
                request.getSession().setAttribute(INDEX, index);
            } else if (action.contentEquals("set")) {
                int x = Integer.parseInt(request.getParameter(INDEX));
                index = x - 1;
                request.getSession().setAttribute(INDEX, index);
            }
        }

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/CatalogoView.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
