DROP DATABASE IF EXISTS smartphone;
CREATE DATABASE smartphone;
USE smartphone;

create table Utente(
ID int not null auto_increment,
Nome char(15) not null,
Cognome char(15) not null,
Email varchar(30) not null,
Password varchar(30) not null,
Numero_Carta varchar(16) references Metodo_Pagamento(Numero_Carta),
Ruolo varchar(20) not null,
primary key(ID)
);

USE smartphone;
create table Articolo(
ID int not null auto_increment,
Tipologia varchar(30) not null,
Nome varchar(60) not null,
Descrizione varchar(400) not null,
Prezzo double not null,
Quantita_Disponibile int not null,
IVA double not null,
Image varchar(250),
primary key (ID)
);

USE smartphone;

create table Ordine(
ID int not null auto_increment,
Stato char(20) not null,
Data date not null,
ID_Utente int references Utente(ID),
primary key(ID)
);

USE smartphone;

create table Comporre(
ID_Articolo int not null,
ID_Ordine int not null,
IVA double not null,
Descrizione varchar(400) not null,
Image varchar(250),
Tipologia varchar(30) not null,
Prezzo_Articolo double not null,
Quantita_Selezionata int not null,
primary key(ID_Articolo,ID_Ordine),
foreign key(ID_Ordine) references Ordine(ID)
on update cascade
on delete cascade
);

USE smartphone;

create table Indirizzo(
ID int not null,
Citta char(25)  not null,
Via char(40) not null,
Numero_Civico int not null,
Piano int,
Interno int,
Scala varchar(2),
primary key(ID),
foreign key(ID) references Utente(ID)
on update cascade
on delete cascade
);

USE smartphone;

create table Metodo_Pagamento(
Codice_Segreto int not null,
Numero_Carta varchar(25) not null,
Data date not null,
Circuito varchar(50) not null,
primary key(Codice_Segreto,Numero_Carta)
);

USE smartphone;

create table Valutazione(
ID_Utente int not null,
ID_Articolo int not null,
Commento varchar(200) not null,
Data date not null,
primary key(ID_Utente,ID_Articolo),
foreign key(ID_Utente) references Utente(ID)
on update cascade
on delete cascade,
foreign key(ID_Articolo) references Articolo(ID)
on update cascade
on delete cascade
)