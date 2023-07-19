<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

    <%

        ProdottoBean prodotto = (ProdottoBean) request.getAttribute("prodotto");

        ArrayList<?> prodotti = (ArrayList<?>) request.getAttribute("prodotti");

           ArrayList<?> comms = (ArrayList<?>) request.getAttribute("commenti");

    %>

<%@ page import="it.unisa.model.bean.*, java.util.*" %>

<!DOCTYPE html>

<html lang="en">

<head>

  <meta charset="UTF-8">

  <link rel="icon" type="image/png" href="img/favicon.png" />

  <link rel="stylesheet" href="prodotto.css">

  <link rel="stylesheet" href="style.css">

  <title>MobileWorld: Dettagli <%= prodotto.getDescrizione() %></title>

</head>

<body>

  <%@ include file="topdown/header.jsp" %>

 

  <div class="content">

    <% if (prodotto != null) { %>

      <div class="card-wrapper">

        <div class="card">

          <div class="bloccoDes">

            <!-- card left -->

            <div class="bloccoDesSx">

              <div class="product-imgs">

                <div class="img-display">

                  <div class="img-showcase">

                    <img src="<%= prodotto.getPath() %>" alt="shoe image">

                  </div>

                </div>

              </div>

            </div>

            <!-- card right -->

            <div class="bloccoDesDx">

              <div class="product-content">

                <h2 class="product-title"><%= prodotto.getNome() %></h2>

                <div class="product-price">

                  <p class="new-price">Prezzo: <span><%= prodotto.getPrezzo() %>€</span></p>

                  <p class="last-price">Iva: <span><%= prodotto.getIva() %>%</span></p>

                </div>

                <div class="product-detail">

                  <h2>Descrizione</h2>

                  <p><%= prodotto.getDescrizione() %></p>

                  <% if (prodotto.getQuantita() == 0) { %>

                    <h4>Quantità non disponibile</h4>

                  <% } else if (prodotto.getQuantita() >= 1) { %>

                    <h3>Disponibilità:</h3><span><%= prodotto.getQuantita() %></span>
                    <div class="purchase-info">

                  <button type="button" class="btn" onclick="addTocart(<%= prodotto.getIdProdotto() %>), increment()"> Aggiungi al carrello <i class="fas fa-shopping-cart"></i></button>

                </div>

                  <% } %>

                </div>

                

              </div>

            </div>

          </div>

        </div>

      </div>

 

      <!-- Recensioni -->

      <div class="recensioniW">

        <label style="">Recensioni</label>

      </div>

 

      <div class="BloccoRec">

        <!-- Blocco inserimento recensione e controllo se utente loggato o meno -->

        <div class="BloccoRecSx">

          <label>Scrivi qui la tua recensione</label><br>

          <textarea rows="5" cols="40" id="commento" maxlength="200" style="resize: none;" placeholder="Max 200 Caratteri"></textarea><br>

          <input type="button" onclick="sendCom()" value="Invia"><br><br>

        

          <span id="notLogin"></span>

          <div class="notlogRec">

            <script type="text/javascript">

              $('#allcomm').click(function() {

                $('#allCom').css("display", "flex");

                $('#hideLink').css("display", "block");

                $('#inserisciCom').css("display", "none");

              });

            </script>

            

            <script type="text/javascript">

              function sendCom() {

                var com = $("#commento").val();

                var idProd = <%= prodotto.getIdProdotto() %>;

                $.ajax({

                  type: 'GET',

                  data: { commento: com, prod: idProd },

                  url: 'comControl',

                  success: function(result) {

                    if (result == 1) {

                      $('#commento').val('');

                      location.reload();

                    } else if (result == 0) {

                      $('#notLogin').css("color", "red").html("Esegui il login o Registrati");

                      $('#commento').val('');

                    }

                  }

                });

              }

            </script>

          </div>

          <br>

          <div class="avviso">

            <label style="color:grey; font-style: italic; font-size:15px;">*Massimo una recensione a prodotto</label>

          </div>

        </div>

      

        <!-- Blocco di tutte le recensioni e dovuti controlli -->

        <div class="BloccoRecDx">

          <% if (comms.size() > 0) { %>

            <% for (int i = 0; i < comms.size(); i++) {

                CommentoBean val = (CommentoBean) comms.get(i); %>

              <div class="comsUtenti">

                <div class="areaCommento">

                  <div class="imgComm">

                    <img src="./img/UserBlank.png" width="60px" height="60px" alt="Immagine Commento">

                  </div>

                  <h4><%= val.getNome() %> <%= val.getCognome() %></h4>

                  <span><%= val.getData() %></span>

                  <p><%= val.getCommento() %></p>

                </div>

              </div>

            <% } %>

          <% } else { %>

            <p>Non ci sono Commenti</p>

          <% } %>

        </div>

        

        <div id="hideLink" style="display: none;">

          <a id="hide" href="">Nascondi</a>

        </div>

        <script type="text/javascript">

          $('#hide').click(function() {

            $('#allCom').css("display", "none");

          });

        </script>

      </div>

    <% } %>

  </div>

 

  <%@ include file="topdown/footer.jsp" %>

</body>

</html>