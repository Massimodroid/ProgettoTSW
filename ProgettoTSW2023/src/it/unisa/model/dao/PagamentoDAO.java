package it.unisa.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.model.bean.CartaBean;
import it.unisa.model.bean.UserBean;

public class PagamentoDAO {
	private static final String TABLE_NAME_Pagamento = "Metodo_Pagamento";
	private static DataSource ds;
	
	static {
		try {
			Context init = new InitialContext();
			Context env = (Context) init.lookup("java:comp/env");
			
			ds = (DataSource) env.lookup("jdbc/smartphone");
			
		}catch(NamingException e) {
			System.out.println("Errore: "+e.getMessage());
		}
	}
	
	public void doSave(CartaBean carta, UserBean user) throws SQLException {
	    String insertCarta = "INSERT INTO " + TABLE_NAME_Pagamento + " (Codice_Segreto, Numero_Carta, Data, Circuito) VALUES (?, ?, ?, ?)";
	    String updateSQL = "UPDATE utente SET Numero_Carta = ? WHERE ID = ?";
	    
	    try (Connection con = ds.getConnection();
	         PreparedStatement prSCarta = con.prepareStatement(insertCarta);
	         PreparedStatement prSUtente = con.prepareStatement(updateSQL)) {
	        
	        prSCarta.setInt(1, carta.getCodiceSegreto());
	        prSCarta.setString(2, carta.getNumeroCarta());
	        prSCarta.setDate(3, carta.getDataScadenza());
	        prSCarta.setString(4, carta.getCircuito());
	        
	        prSUtente.setString(1, carta.getNumeroCarta());
	        prSUtente.setInt(2, user.getIdUtente());
	        
	        prSCarta.executeUpdate();
	        prSUtente.executeUpdate();
	        user.setNumeroCarta(carta.getNumeroCarta());
	        
	    } catch (SQLException e) {
	        
	        throw e;
	    }
	}

	public CartaBean doRetrieveCarta(String numeroCarta) throws SQLException{
		ResultSet result;
        Connection con = null;
        PreparedStatement prS = null;
        String selectQuery = "Select * from "+TABLE_NAME_Pagamento+" WHERE Numero_Carta = ?";
        CartaBean carta = new CartaBean();
        try {
        	con = ds.getConnection();
        	prS = con.prepareStatement(selectQuery);
        	prS.setString(1, numeroCarta);
        	result = prS.executeQuery();
        	while(result.next()) {
        		carta.setCodiceSegreto(result.getInt("Codice_Segreto"));
        		carta.setNumeroCarta(result.getString("Numero_Carta"));
        		carta.setDataScadenza(result.getDate("Data"));
        		carta.setCircuito(result.getString("Circuito"));
        	}
        }finally {
        	try {
        		if(prS != null)
        			prS.close();
        		
        	}finally {
        		if(con != null)
        			con.close();
        	}
        }
        return carta;
	}
}
