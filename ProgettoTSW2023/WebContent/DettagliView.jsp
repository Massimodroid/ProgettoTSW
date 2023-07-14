<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	ProdottoBean prodotto = (ProdottoBean) request.getAttribute("prodotto");
    	ArrayList<?> prodotti = (ArrayList<?>) request.getAttribute("prodotti");
   		ArrayList<?> comms = (ArrayList<?>) request.getAttribute("commenti");
    %>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="it.unisa.model.bean.*, java.util.*"%>
<head>
<link rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="script/jquery-3.5.1.min.js"></script>

<script type="text/javascript" src="script/countElem.js"></script>
<script type="text/javascript" src="script/AddCart.js"></script>
<script type="text/javascript" src="prodotto.js"></script>


<meta charset="UTF-8">
<link rel="icon" type="image/png" href="img/favicon.png" />
 <link rel="stylesheet" href="prodotto.css">
 <link rel="stylesheet" href="style.css">
<title>MobileWorld: Dettagli <%=prodotto.getDescrizione() %></title>
</head>
<body>
<%@include file="topdown/header.jsp" %>

<div class="content">
<div class = "card-wrapper">
      <div class = "card">
      	<div class= "bloccoDes">
        <!-- card left -->
        <div class= "bloccoDesSx">
        <div class = "product-imgs">
          <div class = "img-display">
            <div class = "img-showcase">
              <img src = "<%=prodotto.getPath()%>" alt = "shoe image">
            </div>
          </div>
          
        </div>
        </div>
        <!-- card right -->
        <div class = "bloccoDesDx">
        <div class = "product-content">
          <h2 class = "product-title"><%=prodotto.getNome()%></h2>
         

          <div class = "product-price">
            <p class = "new-price">Prezzo: <span><%=prodotto.getPrezzo()%>€</span></p>
            <p class = "last-price">Iva: <span><%=prodotto.getIva()%>%</span></p>
          </div>

          <div class = "product-detail">
            <h2>Descrizione</h2>
            <p><%=prodotto.getDescrizione()%></p>
            
            <h3>Disponibilità: </h3><span><%=prodotto.getQuantita()%></span>
           
          </div>

          <div class = "purchase-info">
            
            <button type= "button" class= "btn" onclick="addTocart(<%=prodotto.getIdProdotto()%>),increment()"> Aggiungi al carrello <i class = "fas fa-shopping-cart"></i>
            </button>
            
          </div>

        </div>
         </div>
       </div>
      </div>
    </div>
   </div>
<%@include file="topdown/footer.jsp" %>

</body>
</html>