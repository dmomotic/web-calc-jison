%lex

%options case-insensitive

%%

/**********************************************************************************
                      PALABRAS RESERVADAS Y SIMBOLOS A RECONOCER 
**********************************************************************************/
"Evaluar"           return 'Evaluar';
";"                 return ';';
"("                 return '(';
")"                 return ')';
"["                 return '[';
"]"                 return ']';

"+"                 return '+';
"-"                 return '-';
"*"                 return '*';
"/"                 return '/';

/**********************************************************************************
                 IGNORAMOS ESPACIOS EN BLANCO Y SALTOS DE LINEA
**********************************************************************************/
[ \r\t]+            {}
\n                  {}

/**********************************************************************************
                            EXPRESIONES REGULARES
**********************************************************************************/
[0-9]+("."[0-9]+)?\b    return 'DECIMAL';
[0-9]+\b                return 'ENTERO';

<<EOF>>                 return 'EOF';

.                       { console.log(`******** ERROR LEXICO ********\nLinea: ${yylloc.first_line}\nColumna: ${yylloc.first_column}\nLexema: ${yytext}`); }

/lex
%{

	
%}

/**********************************************************************************
                            PRECEDENCIAS Y ASOCIATIVIDAD
**********************************************************************************/

%left '+' '-'
%left '*' '/'
%left UMENOS

%start ini

%% 
/**********************************************************************************
                                  GRAMATICA
**********************************************************************************/

ini : instrucciones EOF  { return $1; }
;

instrucciones : instrucciones instruccion  { $1.push($2);  $$=$1;}
	| instruccion                          { $$ = [$1]; }
;

instruccion : 'Evaluar' '[' expresion ']' ';'  { $$ = $3; }
;

expresion : '-' expresion %prec UMENOS  { $$ = new Aritmetica($2,'negativo',null);; }
	| expresion '+' expresion           { $$ = new Aritmetica($1,'+',$3); }
	| expresion '-' expresion           { $$ = new Aritmetica($1,'-',$3); }
	| expresion '*' expresion           { $$ = new Aritmetica($1,'*',$3); }
	| expresion '/' expresion           { $$ = new Aritmetica($1,'/',$3); }
	| ENTERO                            { $$ = Number($1); }
	| DECIMAL                           { $$ = Number($1); }
	| '(' expresion ')'                 { $$ = $2; }
;

/**********************************************************************************
                                  NOTA
**********************************************************************************/
 
	/* 1.- Si se desea agregar mayor funcionalidad en el archivo de gramatica "analizador.jison" se debe modificar el archivo js 
		generado "analizador.js" luego de haber compilado con Jison, ya que, se esta utilizando la libreria RequireJS para poder 
		modularizar la estructura  completa del proyecto, razon por la cual se deben importar los modulos a utilizar en este 
		nuevo archivo generado. 
		Para este ejemplo la primer linea del archivo generado, que tiene un aspecto similar a
		   		
			(function() {

		quedaria de la siguiente manera

			define(['./../expresion/aritmetica'], function (Aritmetica) {
	
		Y tambien se deben eliminar los parentesis "()" ubicados antes del punto y coma ";" del cierre de la definicion
		de la funcion. (Se encuentra hasta en las ultimas lineas del mismo archivo generado "analizador.js")

		Si se desea agregar mas clases para la creacion de nodos aqui en la gramatica, estas importaciones deben realizarse como 
		en la modificacion anterior pero separadas por una coma, suponiendo que vamos a utilizar una clase llamada "Logica" que 
		represente nuestras operaciones logicas (and, or, not).

			define(['./../expresion/aritmetica','./../arbol/logica'], function (Aritmetica, Logica){

		Estas importaciones se realizan para tener acceso a los constructores de las clases, por ejemplo new Aritmetica(), de lo 
		contrario no podriamos utilizar estos constructores para la creacion de los nodos de nuestro AST.

		Quizas no sea la manera mas optima, pero fue la unica que encontre para poder trabajar con distintos archivos javascript 
		en diferentes rutas y que estos pudieran ser utilizados aqui en la gramatica para la creacion de los nodos, ya que esta
		aplicacion corre completamente del lado del cliente.

		OBSEVACION: Si la aplicación corriera del lado del servidor se podría haber utilizado nodejs para facilitar la tarea de 
		importaciones a traves de sus modulos, lo que nos evitaría tener que editar el archivo generado "analizador.js" cada vez 
		que se compile el archivo de la gramatica "analizador.jison".
	*/