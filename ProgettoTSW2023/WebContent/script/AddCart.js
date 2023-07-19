/*Viene effettuata una chiamata AJAX di tipo GET al percorso "carrello" con i parametri "op" e "id" 
per specificare l'operazione di aggiunta al carrello e l'ID dell'elemento da aggiungere.*/

function addTocart(i){
					let op = "aggC";
					let id = i;
					$.ajax({
						type: 'GET',
						data:{op:op,id:id},
						url: 'carrello',
					})
					
				}