%1

programa(fernando, cobol).
programa(fernando, visualBasic).
programa(fernando, java).

programa(julieta, java).

programa(marcos, java).

programa(santiago, emacs).
programa(santiago, java).

rol(fernando, analistaFuncional).
rol(andres, proyectLeader).

rol(Sujeto, programador):- programa(Sujeto, _).


%2 
/*
a. programa(fernando, Lenguaje).
b. programa(Quien, java).
c. programa(_, assembler).
d. rol(fernando, programador).
e. rol(fernando, Roles).
f. rol(Quien, programador).
g. rol(_, proyectLeader).

*/

%1

construccion(prometeus, cobol).

construccion(sumatra, java).
construccion(sumatra, net).

trabaja(prometeus, fernando).
trabaja(prometeus, santiago).

trabaja(sumatra, julieta).
trabaja(sumatra, marcos).
trabaja(sumatra, andres).

%2

correctoAsigando(Sujeto, Proyecto):- trabaja(Proyecto, Sujeto), programa(Sujeto, Lenguaje), construccion(Proyecto, Lenguaje).

correctoAsigando(Sujeto, Proyecto):- trabaja(Proyecto, Sujeto), rol(Sujeto, analistaFuncional).

correctoAsigando(Sujeto, Proyecto):- trabaja(Proyecto, Sujeto), rol(Sujeto, proyectLeader).

proyectoBienDefinido(Proyecto):- forall(trabaja(Proyecto , Sujeto), correctoAsigando(Sujeto, Proyecto)), unicoLeader(Proyecto)	.

unicoLeader(Proyecto):- trabaja(Proyecto, Sujeto1), trabaja(Proyecto, Sujeto2), rol(Sujeto1, proyectLeader), not(rol(Sujeto2, proyectLeader)).


%Casos de Prueba




%4

copadoCon(fernando, santiago).
copadoCon(santiago,julieta).
copadoCon(santiago, marcos).
copadoCon(julieta,andres).

enseniaria(Maestro,Lenguaje, Aprendiz):-
	programa(Maestro, Lenguaje),
	not(programa(Aprendiz, Lenguaje)).

copadoConNivel(Maestro, Aprendiz, 0):-
	copadoCon(Maestro, Aprendiz).
copadoConNivel(Maestro, Aprendiz, 1):-
	copadoConNivel(Maestro, Intermedio, 0),
	copadoCon(Intermedio, Aprendiz).
	

lePuedeEnseniar(Maestro, Lenguaje, Aprendiz):-
	copadoConNivel(Maestro, Aprendiz, 0),
	enseniaria(Maestro,Lenguaje, Aprendiz).

lePuedeEnseniar(Maestro, Lenguaje, Aprendiz):-
	copadoConNivel(Maestro, Aprendiz, 1),
	enseniaria(Maestro, Lenguaje, Aprendiz).



%5


tarea(fernando, evolutiva(compleja)).  
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algoritmica(150)).
tarea(marcos, algoritmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)). 


cantidadEvolutivaXComp(Sujeto, Complejidad, Cantidad):-
	tarea(Sujeto, evolutiva(_)),
	findall(1, tarea(Sujeto, evolutiva(Complejidad)), ListaEvo),
	length(ListaEvo, Cantidad).


sumarEvolutivas(Sujeto, Puntos):-
	cantidadEvolutivaXComp(Sujeto, simple, CantSimples),
	cantidadEvolutivaXComp(Sujeto, compleja, CantComplejas),
	Puntos is ( CantComplejas*5 + CantSimples*3 ).
sumarEvolutivas(Sujeto, 0):-
	not(tarea(Sujeto, evolutiva(_) ) ).

tareaCorrectivaQueSuma(Sujeto, Lineas):-
	tarea(Sujeto, correctiva(Lineas, _) ),
	Lineas > 50.

tareaCorrectivaQueSuma(Sujeto, Lineas):-
	tarea(Sujeto, correctiva(Lineas,brainfuck)).

sumarCorrectivas(Sujeto, Puntos):-
	tareaCorrectivaQueSuma(Sujeto, _),
	findall(Lineas, tareaCorrectivaQueSuma(Sujeto, Lineas), ListaCorrectiva),
	length(ListaCorrectiva, CantCorrectivas),
	Puntos is (CantCorrectivas * 4 ).
sumarCorrectivas(Sujeto, 0):-
	not(tareaCorrectivaQueSuma(Sujeto, _)).

sumarAlgoritmicas(Sujeto, Puntos):-
	tarea(Sujeto, algoritmica(_)),
	findall(Lineas, tarea(Sujeto, algoritmica(Lineas)), ListaAlgoritmicas),
	sumlist(ListaAlgoritmicas, SumatoriaLineas),
	Puntos is SumatoriaLineas / 10.
sumarAlgoritmicas(Sujeto, 0):-
	not(tarea(Sujeto, algoritmica(_))).


puntosSenior(Sujeto, PuntosSenior):-
	sumarAlgoritmicas(Sujeto, PuntosAlgoritmicos),
	sumarCorrectivas(Sujeto, PuntosCorrectivos),
	sumarEvolutivas(Sujeto, PuntosEvolutivos),
	PuntosSenior is PuntosEvolutivos + PuntosCorrectivos + PuntosAlgoritmicos.


%Casos De Prueba