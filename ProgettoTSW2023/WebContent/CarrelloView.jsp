<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %> 
    
    <%
    	Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
    	UserBean utente = (UserBean) request.getSession().getAttribute("Utente");
    %>
<!DOCTYPE html>
<html lang = "en">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.bean.*,it.unisa.model.*,java.lang.Math,java.text.DecimalFormat
"%>
<head>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="script/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="script/countElem.js"></script>

<script type="text/javascript" src="script/AddCart.js"></script>


<meta charset="UTF-8">
<link rel="icon" type="image/png" href="img/favicon.png" />
<title>MobileWorld: Carrello</title>
</head>
<body>
<%@include file="topdown/header.jsp" %>
<br>
<div class="content">

	<%if(carrello != null && carrello.getAllItem().size()>0){ %>
	<div class="carrelloView">
	<h2>Carrello</h2>
	<div style="margin: 0 5px 0 0;text-align:right;position:relative;top:90%;">Prezzo</div>
	
	<!-- recupera gli oggetti del carrello dal carrello corrente e li itera utilizzando un ciclo for-each. 
	Per ogni oggetto nel carrello, viene estratto il bean del prodotto associato. -->
	<%
			List<ProdottoCarrello> prodcarr = carrello.getAllItem();
			DecimalFormat df = new DecimalFormat("###.##");
			double tot = 0;
			for(ProdottoCarrello beancart: prodcarr){
				ProdottoBean bean = beancart.getProdotto();
			
		%> 
	<hr>
	<div class="cartblock">
	<div class="imageCarrello"><img src="<%=bean.getPath()%>" alt = "Immagine carrello" style="float: left;" width="256px" height="256px"></div>
	<div class="descrizioneCarrello"><h3 style="width: 80%; display: inline;"><%=beancart.getDescrizione()%></h3></div>
	<div class="prezzoCarrello"><div class="prezzoresponsive">€<%=df.format(beancart.getPrezzoTotale())%></div></div>
	<div class="dettaglipref"><p>QUANTITA':<%=bean.getQuantita()%></p>
	<form action="./carrello" style="text-align: left;" method="get">
            <input type="number" class="numCount" name="numCount" style="width: 40px; padding:5px; border-radius: 5px;" name ="num" min="1" max="<%=bean.getQuantita()%>" placeholder="<%=beancart.getNumProdotto()%>">
            <input type="hidden" name="id" value="<%=bean.getIdProdotto() %>">
            <input type="hidden" name="op" value="cambiaQ">
            <input type="submit" class="AggQuant" value="Aggiorna Quantità">
    </form>
    <div class="rimuoviCarrello">
    <a href="./carrello?op=cancC&id=<%=beancart.getProdottoID() %>">Rimuovi</a>
    </div>
    </div>
    </div>
    
	<%tot += beancart.getPrezzoTotale();} %>
	</div>
	<div style="float: right; height:180px; width: 20%; border-radius: 10px; background-color: #e9eceb; border: 2px solid ; margin: 10px 10px 10px 10px;">
    <div style="display: inline;">
    <h3 style="margin-bottom: 0;">Totale:</h3>
    <p style="font-style:oblique; font-size: 15px; margin-top: 5px; margin-bottom: 10px;">Comprende l'IVA</p>
    <h3 style="margin-top: 0;">€<%=df.format(tot)%></h3>
   
	 <%if((utente!=null && utente.isValid()) && utente.getNumeroCarta()!=null){%>
                 <div class="payCart"><a href="./carrello?op=acquista">Acquista</a></div>
        <%}else if(utente!=null && utente.isValid()){ %>
            <div class="payCart"><a href="CompletaConfigView.jsp">Completa la tua registrazione</a></div>
        <%}else{ %>
        	<div class="payCart"><a href="LoginView.jsp">Accedi</a></div>
        <%} %>
 </div>
    </div>	
	<%}else {%>
		<h2>Il carrello è vuoto</h2>
	<%} %>
</div>
	<br>
	<%@include file="topdown/footer.jsp" %>
</body>
</html>