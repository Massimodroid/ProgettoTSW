<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	UserBean us = (UserBean) request.getSession().getAttribute("Utente");
		
    %>
<!DOCTYPE html>
<html lang="en">
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="it.unisa.model.bean.UserBean"  %>
<%@page import="it.unisa.model.Carrello"  %>
<%@page import="it.unisa.model.ProdottoCarrello"  %>
<%@page import="java.util.*"  %>
<head>

<link rel="stylesheet" href="css/style.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="script/countElem.js"></script>
<script type="text/javascript" src="script/jquery-3.5.1.min.js"></script>


<title>Header</title>
</head>
<body>
	
<div class="header" id="header">
	<div class="logo">
		<a href="./catalogo">
			<img src="img/logoTelefoniDef.png" alt="Logo Sito">
		</a>
	</div>
	
	<div class="searchbox">
	 <form action="./chooseType" method="get">
   		 <div class="search">
     		 <input type="search" id="search" class="searchTerm" placeholder="Ricerca..." name = "search" autocomplete="off">
     		 <button type="submit" class="searchButton">
      			 <img src="./img/search.png" alt="Immagine ricerca">
    		 </button>
  		 </div>
	</form>
	</div>
	
	<div class="userCar">
	<div class="carrello">
	
		 <a href="carrello"><div id="cont" class="contatore"></div></a>
		 <script type="text/javascript"> 
						function increment(){
							$.ajax({
								type: 'GET',
								url: 'cartCount',
								success: function(result){
									$('#cont').html(result);
								}
							})
						}
				</script>
	
	<a href="carrello">
		
		<img src="img/carrello.png" class="image" alt="Immagine Carrello">
	</a>
	</div>
	<div class="utente" class="image">
<%if(us == null || !us.isValid()){ %>

	<a href="./LoginView.jsp">
		<img src="img/utente.png" id="UserImage" class="image" alt="Immagine Utente">
	</a>
<%} %>
	</div>
		<div class="ciaoutente">
<%
	if(us!=null && us.isValid()){
%>
			<a href="./infoUtente">Ciao <%=us.getNome()%></a>
<%} %>
	</div>
	</div>
	
	<div class="catalogov">
		<a href="./LoginView.jsp">Utente</a><br>
		<a href="carrello">Carrello</a>
	</div>
</div>

<div class="navmenu">
		<a href="catalogo" style="text-decoration: none; padding-right: 10px;">HOME</a>
		
		<a href="./ChiSiamo.jsp" class="navmenuspacer" style="text-decoration: none">CHI SIAMO</a>
</div>
<div class="menuSmartUser">
	<img id ="btnOpenMenu"src="./img/MenuNav.png" width="30" height="30" alt="Immagine NavMenu">
</div>
<div id="menu" style="display:none;" class="menuSmartUserView">
	  <a href="catalogo">Home</a>
	  <a href="./ChiSiamo.jsp" class="navmenuspacer">Chi siamo</a>
	  		
</div>			
		<script type="text/javascript">
			$('#btnOpenMenu').click(function(){
				 $("#menu").slideToggle();
			})
			$("#btnCat").click(function(){
					 $("#catShow").slideToggle();
				 })
			$('#componentiShow').click(function(){
				$('#componentiShowDiv').slideToggle();
			})
			$('#computerShow').click(function(){
				$('#computerShowDiv').slideToggle();
			})
			
			$(window).resize(function() {
				if ($(window).width() >= 480){
					$("#menu").css("display","none");
					return;
				}
			});
			
		</script>


</body>
</html>