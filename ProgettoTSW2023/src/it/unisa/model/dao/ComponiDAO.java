package it.unisa.model.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.bean.ProdottoBean;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.model.Carrello;
import it.unisa.model.ProdottoCarrello;
import it.unisa.model.bean.ComponiBean;
import it.unisa.model.bean.OrdineBean;

public class ComponiDAO {
	
	
	private static final String TABLE_NAME_COMPORRE = "comporre";
	private static DataSource ds;
	static {
		try {
			Context init = new InitialContext();
			Context env = (Context) init.lookup("java:comp/env");
			
			ds = (DataSource) env.lookup("jdbc/smartphone");
		}catch(NamingException e) {
			Logger logger = Logger.getLogger(ComponiDAO.class.getName());
			logger.log(Level.SEVERE, () -> "Errore ComponiDAO: " + e.getMessage());


		}
	}
	
	public void doSave(OrdineBean ordine,Carrello carrello) throws SQLException {
		Connection con = null;
		PreparedStatement prSComponi = null;
		List<ProdottoCarrello> prodCart = new ArrayList<>();
		
		
		
		
		String insertComporreSQL = "insert into "+TABLE_NAME_COMPORRE+" (ID_Articolo,ID_Ordine,IVA,Descrizione,Image,Tipologia,Prezzo_Articolo,Quantita_Selezionata)"
								  +" values(?,?,?,?,?,?,?,?)";
		try {
			con = ds.getConnection();
			prSComponi = con.prepareStatement(insertComporreSQL); 
			prodCart = carrello.getAllItem();
			for(int i=0;i<prodCart.size();i++) {
				ProdottoBean prod;
				prod = prodCart.get(i).getProdotto();
				prSComponi.setInt(1, prod.getIdProdotto());
				prSComponi.setInt(2, ordine.getIdOrdine());
				prSComponi.setDouble(3, prod.getIva());
				prSComponi.setString(4, prod.getDescrizione());
				prSComponi.setString(5, prod.getPath());
				prSComponi.setString(6, prod.getTipologia());
				prSComponi.setDouble(7, prod.getPrezzo());
				prSComponi.setInt(8, prodCart.get(i).getNumProdotto());
				prSComponi.executeUpdate();
			}
			
			
		}finally {
			try {
				if(prSComponi!=null) {
					prSComponi.close();
				}
				
			}finally {
				if(con != null)
					con.close();
				
			}
		}
		
	}
	public ArrayList<ComponiBean> doRetrieveByKey(int idOrdine) throws SQLException{
		Connection con = null;
		PreparedStatement prSComponi = null;
		ResultSet result;
		ArrayList<ComponiBean> elemComponi = new ArrayList<>();
		String selectSQL ="select * from "+TABLE_NAME_COMPORRE+" where ID_Ordine = ?";
		
		try {
			con = ds.getConnection();
			prSComponi = con.prepareStatement(selectSQL);
			prSComponi.setInt(1, idOrdine);
			result = prSComponi.executeQuery();
			
			while(result.next()) {
				ComponiBean bean = new ComponiBean();
				bean.setIdArticolo(result.getInt("ID_Articolo"));
				bean.setIdOrdine(result.getInt("ID_Ordine"));
				bean.setIva(result.getDouble("IVA"));
				bean.setPrezzo(result.getDouble("Prezzo_Articolo"));
				bean.setQuantita(result.getInt("Quantita_Selezionata"));
				bean.setDescrizione(result.getString("Descrizione"));
				bean.setPath(result.getString("Image"));
				bean.setTipologia(result.getString("Tipologia"));
				elemComponi.add(bean);
			}
			
		}finally {
			try {
				if(prSComponi!=null)
					prSComponi.close();
				
			}finally {
				if(con!=null)
					con.close();
			}
		}
		return elemComponi;
	}
	
}
