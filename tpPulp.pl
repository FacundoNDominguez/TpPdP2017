%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
pareja(bernardo, charo).
pareja(bernardo, bianca).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(bianca, george).
trabajaPara(charo, george).

%p1
saleCon(Quien, Cual):- pareja(Quien, Cual).
saleCon(Quien, Cual):- pareja(Cual, Quien).

trabajaPara(Jefe, bernardo):-
	trabajaPara(marsellus, Jefe),
	Jefe \= jules.

trabajaPara(Jefe, george):-
	saleCon(bernardo, Jefe).

esFiel(Personaje):- personaje(Personaje,_),
	not((saleCon(Personaje, Persona1), 
	saleCon(Personaje, Persona2),
	Persona1 \= Persona2)).

acatarOrdenes(Jefe, Persona):-
	trabajaPara(Jefe, Persona).

acatarOrdenes(Jefe, Persona):-
	trabajaPara(Jefe, Intermedio),
	acatarOrdenes(Intermedio, Persona).


% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).


% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).


amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

amigo2(P1, P2):- amigo(P1, P2).
amigo2(P1, P2):- amigo(P2, P1).

esPeligroso(Persona):- personaje(Persona, mafioso(maton)).

esPeligroso(Persona):- personaje(Persona, ladron(Lista)), 
	member(licorerias, Lista).

cercano(Persona1, Persona2):- amigo2(Persona1, Persona2).
cercano(Persona1, Persona2):- relacionLaboral(Persona1,Persona2).

relacionLaboral(P1, P2):- trabajaPara(P1, P2).
relacionLaboral(P1, P2):- trabajaPara(P2, P1).


sanCayetano(Persona):- cercano(Persona, _), forall(cercano(Persona, Colega), encargo(Persona, Colega, _)).


nivelRespeto(Persona, Nivel):- personaje(Persona, actriz(Lista)), length(Lista, CantidadPelis), Nivel is CantidadPelis / 10.

nivelRespeto(Persona,Nivel):- personaje(Persona, mafioso(resuelveProblemas)), Nivel is 10.

nivelRespeto(Persona,Nivel):- personaje(Persona, mafioso(capo)), Nivel is 20.

nivelRespeto(vincent, 15).

esRespetable(Persona):- personaje(Persona,_),
	nivelRespeto(Persona, Nivel), 
	Nivel > 9.

respetabilidad(Respetables, NoRespetables):-
	findall(Persona, esRespetable(Persona), ListaRespetable),
	length(ListaRespetable, Respetables),
	findall(Persona1, ( personaje(Persona1, _), not(esRespetable(Persona1) ) ), ListaNoRespetable),
	length(ListaNoRespetable, NoRespetables).

cantidadEncargos(Persona, Cantidad):-
	personaje(Persona,_),
	findall(Encargo, encargo(_, Persona, Encargo), ListaEncargos),
	length(ListaEncargos, Cantidad).

masAtareado(Persona):- 
	cantidadEncargos(Persona, CantidadEncargos),
	forall((cantidadEncargos(Persona1, CantidadEncargos1), Persona\=Persona1), CantidadEncargos > CantidadEncargos1).

3)1)
escuadron([Personaje]):-nivelRespeto(Personaje, Nivel), Nivel > 15.
escuadron([Personje1, Personaje2| Otros]):- nivelRespeto(Personaje1, NivelPersonaje1), nivelRespeto(Personaje2, NivelPersonaje2), (NivelPersonaje1 + NivelPersonaje2) > 15, escuadron([Personaje2| Otros]).

2)
batallon([Personaje], EncargosTotales):- 
	cantidadEncargos(Personaje, Cantidad),
	EncargosTotal < Cantidad.
	
batallon([Personaje1, Personaje2 | Otros], EncargosTotales):- 
	cantidadEncargos(Personaje1, Cantidad1),
	cantidadEncargos(Personaje2, Cantidad2),
	batallon([Personaje2 | Otros], EncargosTotales),
	EncargosTotal < Cantidad1 + Cantidad2.
	
3)
quieneSuperan(Personajes, NumeroASuperar, Criterio, Quienes):- 
	Criterio(Personaje, Numero),
	Numero > NumeroASuperar,
	findall(Personaje, member(Personaje, Personajes), PersonajesQueLoSuperan).
	
4)
sumaPersonajes([Personaje, OtroPersonaje | Otros], Criterio, Total):-
	Criterio(Personaje,Numero),
	Criterio(OtroPersonaje,OtroNumero),
	sumaPersonajes([OtroPersonaje | Otros], Criterio, Total),
	Total is Numero + OtroNumero.	
	
