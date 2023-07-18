function addTocart(i){
					let op = "aggC";
					let id = i;
					$.ajax({
						type: 'GET',
						data:{op:op,id:id},
						url: 'carrello',
					})
					
				}