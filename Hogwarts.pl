 
mago(harry, mestiza, [coraje, amistad, orgullo, inteligencia]).
mago(ron, pura, [amistad, diversion, coraje]).
mago(hermione, impura, [inteligencia, coraje, responsabilidad, amistad, orgullo]).
mago(hannahAbbott, mestiza, [amistad, diversion]).
mago(draco, pura, [inteligencia, orgullo]).
mago(lunaLovegood, mestiza, [inteligencia, responsabilidad, amistad, coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).
 
caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).


permiteEntrar(gryffindor, _).
permiteEntrar(ravenclaw, _).
permiteEntrar(hufflepuff, _).

permiteEntrar(slytherin, Mago):-
	mago(Mago, pura, _).


tieneCaracter(Mago, Casa):-
	mago(Mago, _, Caracteres),
	casa(Casa),
	forall( caracteriza(Casa, Caracter) , member(Caracter, Caracteres) ).

casaPosible(Mago, Casa):-
	permiteEntrar(Casa, Mago),
	tieneCaracter(Mago, Casa),
	not(odia(Mago, Casa)).

compatibles(Primero, Segundo):-
	mago(Primero,_, Caracteres),
	member(amistad, Caracteres),
	casaPosible(Primero, Casa),
	casaPosible(Segundo, Casa).

cadenaDeAmistades([Primero,Segundo|Resto]):-
	compatibles(Primero, Segundo),
	cadenaDeAmistades([Segundo|Resto]).

cadenaDeAmistades([Primero,Segundo]):-
	compatibles(Primero, Segundo).



lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).
 
alumnoFavorito(flitwick, hermione).
alumnoFavorito(snape, draco).
alumnoOdiado(snape, harry).

hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, responder(dondeSeEncuentraUnBezoar, 15, snape)).
hizo(hermione, responder(wingardiumLeviosa, 25, flitwick)).
hizo(ron, irA(bosque)).
hizo(draco, irA(mazmorras)).

accionMala(fueraDeCama, 50).
accionMala(lugarProhibido(Lugar, Puntos), Puntos).

accionBuena(responder(_, Puntos, Profe), Puntos).
accionBuena(buenaAccion(_, Puntos), Puntos).
	


esBuenAlumno(Mago):-
	hizo(Mago,_).
