<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- controllo sulla presenza dei prodotti nella lista prodotti. Se la lista è nulla, 
	viene reindirizzato l'utente alla pagina del catalogo. Successivamente, viene assegnato 
	il valore dell'attributo "index" presente nella sessione alla variabile index. -->
	
	<%
	ArrayList<?> prodotti = (ArrayList<?>) request.getAttribute("prodotti");
	if(prodotti == null){
		response.sendRedirect("./catalogo");
		return;
	}
	
	int index = (int) request.getSession().getAttribute("index"); 
	
	%>
<!DOCTYPE html>
<html lang = "en">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.bean.*,it.unisa.model.dao.ProdottoDAO,java.sql.*"%>


<head>
<link rel="stylesheet" href="css/style.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="icon" type="image/png" href="img/favicon.png" />
	<script type="text/javascript" src="script/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="script/AddCart.js"></script>
	
	
	<title>MobileWorld: Home</title>
</head>

<body>
	<%@include file="topdown/header.jsp" %>

	<div class="slideshow-container">
		<div class="sliderPreferences">
			
			<div class="mySlides fade">
				<img src="./img-banner/banner1.jpg" alt="banner iphone" height="400" width="100%">
			</div>	
			
			<div class="mySlides fade">
				<img src="./img-banner/banner2.jpg" alt= "banner samsung" height="400" width="100%">
			</div>
					
			<div class="mySlides fade">
				<img src="./img-banner/banner3.jpg" alt= "banner redmi" height="400" width="100%">
			</div>
		</div>
	<div style="text-align: center">
		<span class="dot"></span>
		<span class="dot"></span>
		<span class="dot"></span>
	</div>
	</div>
	<script>
		var slideIndex = 0;
		showSlides();
		
		function showSlides() {
			var i;
			var slides = document.getElementsByClassName("mySlides");
			var dots = document.getElementsByClassName("dot");
			for(i=0;i<slides.length;i++){
				slides[i].style.display = "none";
			}
			slideIndex++;
			if(slideIndex >slides.length) {slideIndex = 1}
			for(i=0;i<dots.length;i++){
				dots[i].className = dots[i].className.replace(" active","");
			}
			slides[slideIndex-1].style.display = "block";
			dots[slideIndex-1].className += " active";
			setTimeout(showSlides, 5000); //cambio ogni 10 secondi
		}
	</script>
	<div class="content">
	<br>
	<h2>Most Wanted</h2>
	<br>
	<div class="prodotti">
	<%
				Random random = new Random();
				int productListSize = prodotti.size();
				int maxIndex = Math.min(productListSize, 10); // Imposta il limite massimo per il numero di prodotti da visualizzare

				if (prodotti != null && productListSize != 0) {
					Set<Integer> randomIndexes = new HashSet<>();
					while (randomIndexes.size() < maxIndex) {
						int randomIndex = random.nextInt(productListSize);
						randomIndexes.add(randomIndex);
					}

					for (int randomIndex : randomIndexes) {
						ProdottoBean bean = (ProdottoBean) prodotti.get(randomIndex);
			%>
			<div class="product">
				<h3><%= bean.getNome() %></h3>
				<a href="./dettagli?tipologia=<%= bean.getTipologia() %>&id=<%= bean.getIdProdotto() %>">
					<img src="<%= bean.getPath() %>" alt= "Immagine prodotto" style="display: inline-block;" width="256px" height="256px" onmouseover="bigImg(this)" onmouseleave="normalImg(this)">
				</a>
				<div class="prezzo">€<%= bean.getPrezzo() %></div>
				<script>
					function bigImg(x) {
						x.style.height = "300px";
						x.style.width = "300px";
						x.style.border="1";
					}

					function normalImg(x) {
						x.style.height = "256px";
						x.style.width = "256px";
					}
				</script>
				<% if(bean.getQuantita() != 0) { %>
					<div class="iconInfo"><a href="./dettagli?tipologia=<%= bean.getTipologia() %>&id=<%= bean.getIdProdotto() %>"><button><img src="img/icona-info.png" alt= "Immagine info" class="image"></button></a></div>
					<div id="addDiv" class="iconCart"><button id="add" onclick="addTocart(<%= bean.getIdProdotto() %>), increment()"><img src="img/icon-cart.png" alt= "Immagine carrello" class="image"></button></div>
					<script type="text/javascript">
						function increment() {
							$.ajax({
								type: 'GET',
								url: 'cartCount',
								success: function(result) {
									$('#cont').html(result);
								}
							})
						}
					</script>
				<% } else { %>
					<div class="iconInfo"><a href="./dettagli?tipologia=<%= bean.getTipologia() %>&id=<%= bean.getIdProdotto() %>"><button><img src="img/icona-info.png" alt= "Immagine info" class="image"></button></a></div>
				<% } %>
			</div>
			<%
					}
				} else {
			%>
			<div>
				<div>Non ci sono prodotti</div>
			</div>
			<%
				}
			%>
		</div>

<br>
	<h2>Brand</h2>
<br>
<div class="gallery">
	<div class="gallery__column">
		<a href="./chooseType?tipologia=Apple" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/apple.jpg" alt= "Immagine iphone" class="gallery__image">
				
			</figure>
		</a>

		<a href="./chooseType?tipologia=OnePlus" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/oneplus.jpg" alt= "Immagine oneplus" class="gallery__image">
				
			</figure>
		</a>

	</div>
	
	 <div class="gallery__column">
		<a href="./chooseType?tipologia=Google" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/google.jpg" alt= "Immagine google" class="gallery__image">
				
			</figure>
		</a>

		<a href="./chooseType?tipologia=Samsung" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/samsung.jpg" alt= "Immagine samsung" class="gallery__image">
			</figure>
		</a>
	</div>
	
	<div class="gallery__column">
		<a href="./chooseType?tipologia=Huawei" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/huawei.jpg" alt= "Immagine huawei" class="gallery__image">
			</figure>
		</a>

		<a href="./chooseType?tipologia=Asus" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/asus.jpg" alt= "Immagine asus" class="gallery__image">
			</figure>
		</a>
	</div>
	
	<div class="gallery__column">
		<a href="./chooseType?tipologia=Oppo" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/oppo.jpg" alt= "Immagine oppo" class="gallery__image">
				
			</figure>
		</a>
		
		<a href="./chooseType?tipologia=Xiaomi" target="_self" class="gallery__link">
			<figure class="gallery__thumb">
				<img src="indexImg/xiaomi.jpg" alt= "Immagine xiaomi" class="gallery__image">
			
			</figure>
		</a>
	</div>
</div>
	
	<%@ include file="topdown/footer.jsp" %>
	 
</body>

</html>