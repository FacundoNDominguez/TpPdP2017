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