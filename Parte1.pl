%1

programa(fernando, cobol).
programa(fernando, visualBasic).
programa(fernando, java),.

programa(julieta, java).
programa(marcos, java).

programa(santiago, emacs).
programa(santiago, javaASD).

rol(fernando, analistaFuncional).
rol(andres, projectLeader).

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