%{
  //Declarciones y tambien las importaciones
const {Declaracion} = require('../instrucciones/Declaracion.ts');
const {Print} = require('../instrucciones/Print.ts');
const {PrintLn} = require('../instrucciones/PrintLn.ts');
const {Bloque} = require('../instrucciones/bloque.ts');
const {Asignacion} = require('../instrucciones/Asignacion.ts');
const {Casteo} = require('../instrucciones/Casteo.ts');
const {Incremento} = require('../instrucciones/Incremento.ts')
const {Decremento} = require('../instrucciones/Decremento.ts')
const {Vector} = require('../instrucciones/Vector.ts')
const {Vector2} = require('../instrucciones/Vector2.ts')
const {AccesoVector} = require('../instrucciones/AccesoVector.ts')
const {ModificarVector} = require('../instrucciones/ModificarVector.ts')
const {OTernario} = require('../instrucciones/OTernario.ts')
const {If} = require('../instrucciones/If.ts')
const {Elif} = require('../instrucciones/Elif.ts')
const {SwitchG} = require('../instrucciones/Switch.ts')
const {WhileG} = require('../instrucciones/While.ts')
const {For} = require('../instrucciones/For.ts')
const {DoWhile} = require('../instrucciones/DoWhile.ts')
const {DoUntil} = require('../instrucciones/DoUntil.ts')
const {Break} = require('../instrucciones/Break.ts')
const {Continue} = require('../instrucciones/Continue.ts')
const {Return} = require('../instrucciones/Return.ts')
const {Funcion} = require('../instrucciones/Funcion.ts')
const {Metodo} = require('../instrucciones/Metodo.ts')
const {Ejecutar} = require('../instrucciones/Ejecutar.ts')
const {Lower} = require('../instrucciones/Lower.ts')
const {Upper} = require('../instrucciones/Upper.ts')
const {Round} = require('../instrucciones/Round.ts')
const {Length} = require('../instrucciones/Length.ts')
const {Typeof} = require('../instrucciones/Typeof.ts')
const {ToString} = require('../instrucciones/ToString.ts')
const {ToCharArray} = require('../instrucciones/ToCharArray.ts')
const {Push} = require('../instrucciones/Push.ts')
const {Pop} = require('../instrucciones/Pop.ts')
const {Run} = require('../instrucciones/Run.ts')
const {LCase} = require('../instrucciones/LCase.ts')
const {Prueba} = require('../instrucciones/Prueba.ts')
const { Singleton}=  require("../Singleton/Singleton")
const { error } =require("../tool/error")




%}

%lex
%options case-insensitive

cadena [\"][^\"]*[\"]
caracter ([\'][^\n\']* [\'])
numero [0-9]+([.][0-9]+)?
bool    "true"|"false"    

%%

\s+                   /* skip whitespace */
"//".*                              // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas

{cadena}        return 'cadena'
{numero}        return 'numero'
{bool}          return 'bool'
{caracter}      return 'char'


"String"   return 'pr_string'
"Int"   return 'pr_int'
"Boolean" return 'pr_bool'
"Char" return 'pr_char'
"Double" return 'pr_double'
"Print" return 'pr_print'
"Println" return 'pr_println'
"New" return 'pr_new'
"If" return 'pr_if'
"Elif" return 'pr_elif'
"Else" return 'pr_else'
"Case" return 'pr_case'
"Switch" return 'pr_switch'
"Default" return 'pr_default'
"While" return 'pr_while'
"For" return 'pr_for'
"Do" return 'pr_do'
"Until" return 'pr_until'
"Break" return 'pr_break'
"Continue" return 'pr_continue'
"Return" return 'pr_return'
"Void" return 'pr_void'
"toLower" return 'pr_tolower'
"toUpper" return 'pr_toupper'
"Round" return 'pr_round'
"Length" return 'pr_length'
"Typeof" return 'pr_typeof'
"ToString" return 'pr_tostring'
"ToCharArray" return 'pr_tochararray'
"Push" return 'pr_push'
"Pop" return 'pr_pop'
"Run" return 'pr_run'

"++" return "++"
"--" return "--"
">=" return ">="
"<=" return "<="
"&&"  return '&&'
"==" return "=="
"." return '.'
";"  return ';'
","  return ','
"+"  return '+'
"-"  return '-'
"*"  return '*'
"/"  return '/'
"^" return '^'
"%"  return '%'
"?" return '?'
")"  return ')'
"("  return '('
"}"  return '}'
"{"  return '{'
"["  return '['
"]"  return ']'
"="  return '='
","  return ','
"<"  return '<'
">"  return '>'
"!=" return "!="
":"  return ':'
"|" return '|'



([a-zA-Z_])[a-zA-Z0-9_ñÑ]*	return 'expreID';

<<EOF>>		            return 'EOF'


.      { 
        let s= Singleton.getInstance()
        s.add_error(new error("Lexico","No se reconoce el caracter "+yytext,yylineno+1,yylloc.first_column+1));
    }


/lex
%left '+'
%left '-'
%left '*'
%left '/'
%left '^'
%left '%'
%left ':'
%left '?'
%left '>'
%left '<'
%left '>='
%left '<='
%left '=='
%left '&&'
%left '!='
%left '|'
%right '!'

%start INIT

%%


INIT :  LISTAINSTRUCCIONES  EOF  {return $1;}
;

LISTAINSTRUCCIONES: LISTAINSTRUCCIONES INSTRUCCION { $1.push($2);  $$= $1;  }
                |  INSTRUCCION {$$=[$1]} 
;

INSTRUCCION :
    DECLARACIONES {$$=$1;}
    | ASIGNACIONES {$$=$1;}
    | CASTEO {$$=$1;}
    | INCREMENTO {$$=$1;}
    | DECREMENTO {$$=$1;}
    | ENCAPSULAMIENTO {$$=$1;}
    | VECTORES {$$=$1;}
    | OTERNARIO {$$=$1;}
    | IF {$$=$1;}
    | SWITCH {$$=$1;}
    | WHILE {$$=$1;}
    | FOR {$$=$1;}
    | DOWHILE {$$=$1;}
    | DOUNTIL {$$=$1;}
    | BREAK {$$=$1;}
    | CONTINUE {$$=$1;}
    | RETURN {$$=$1;}
    | FUNCIONES {$$=$1;}
    | METODO  {$$=$1;}
    | EJECUTAR {$$=$1;}
    | PRINT {$$=$1;}
    | PRINTLN {$$=$1;}
    | TOLOWER {$$=$1;}
    | TOUPPER {$$=$1;}
    | ROUND {$$=$1;}
    | LENGTH {$$=$1;}
    | TYPEOF {$$=$1;}
    | TOSTRING {$$=$1;}
    | TOCHARARRAY {$$=$1;}
    | PUSH {$$=$1;}
    | POP {$$=$1;}
    | RUN {$$=$1;}
    | error {let s= Singleton.getInstance()
        s.add_error(new error("Sintactico","No se esperaba el caracter "+yytext,yylineno+1,@1.first_column+1));}
;


DECLARACIONES:  TIPOS EXID '=' OPERACIONA ';' {$$= new Declaracion($2,$1,$4,@1.first_line,@1.first_column); }
    | TIPOS EXID '=' 'cadena' ';' {$$= new Declaracion($2,$1,$4,@1.first_line,@1.first_column); }
    | TIPOS EXID '=' 'char' ';' {$$= new Declaracion($2,$1,$4,@1.first_line,@1.first_column); }
    | TIPOS EXID '=' 'bool' ';' {$$= new Declaracion($2,$1,$4,@1.first_line,@1.first_column); }
    | TIPOS EXID ';' {$$= new Declaracion($2,$1,[],@1.first_line,@1.first_column); }
;


EXID: EXID ',' 'expreID' {$1.push($3); $$ =$1;}
        | 'expreID' {$$ = [$1]}
;

ASIGNACIONES: EXID '=' OPERACIONA ';' {$$= new Asignacion($1, $3,@1.first_line,@1.first_column);}
        | EXID '=' 'cadena' ';' {$$= new Asignacion($1, $3,@1.first_line,@1.first_column);}
        | EXID '=' 'bool' ';' {$$= new Asignacion($1, $3,@1.first_line,@1.first_column);}
        | EXID '=' 'char' ';' {$$= new Asignacion($1, $3,@1.first_line,@1.first_column);}
        | EXID '=' EXID ';'  {$$= new Asignacion($1, $3,@1.first_line,@1.first_column);}
;

OPERACIONA: OPERACIONA EXPRESIONES {$$=$1;}
        | EXPRESIONES {$$=$1;}
;

EXPRESIONES: EXPRESION {$$=$1;}
        | RELACIONAL {$$=$1;}
        | LOGICO {$$=$1;}
;

EXPRESION: EXPRESION '+' EXPRESION {$$=$1 + '+' + $3;}
            | EXPRESION '-' EXPRESION {$$=$1 + '-' + $3;}
            | EXPRESION '*' EXPRESION {$$=$1 + '*' + $3;}
            | EXPRESION '/' EXPRESION {$$=$1 + '/' + $3;}
            | EXPRESION '^' EXPRESION {$$=$1 + '^' + $3;}
            | EXPRESION '%' EXPRESION {$$=$1 + '%' + $3;}
            | EXPRESION ':' EXPRESION {$$=$1 + ':' + $3;}
            | EXPRESION '?' EXPRESION {$$=$1 + '?' + $3;}
            | '(' EXPRESION ')' {$$= "(" + $2 + ")";}
            | '[' EXPRESION ']' {$$= "[" + $2 + "]";}
            | 'numero' {$$=$1;}
;

RELACIONAL: EXPRESION '>' EXPRESION {$$=$1 + '>' + $3;}
        | EXPRESION '<' EXPRESION {$$=$1 + '<' + $3;}
        | EXPRESION '>=' EXPRESION {$$=$1 + '>=' + $3;}
        | EXPRESION '<=' EXPRESION {$$=$1 + '<=' + $3;}
        | EXPRESION '==' EXPRESION {$$=$1 + '==' + $3;}
        | EXPRESION '!=' EXPRESION {$$=$1 + '!=' + $3;}
;

LOGICO: EXPRESION '|' EXPRESION {$$=$1 + '|' + $3;}
        | EXPRESION '&&' EXPRESION {$$=$1 + '&&' + $3;}
        | '!' EXPRESION {$$=$2;}
;

CASTEO: TIPOS EXID '=' '(' TIPOS ')' OPERACIONA ';' {$$= new Casteo($1, $2, $5, $7);}
        | TIPOS EXID '=' '(' TIPOS ')' 'cadena' ';' {$$= new Casteo($2, $1, $5, $7);}
        | TIPOS EXID '=' '(' TIPOS ')' 'char' ';' {$$= new Casteo($2, $1, $5, $7);}
        | TIPOS EXID '=' '(' TIPOS ')' 'bool' ';' {$$= new Casteo($2, $1, $5, $7);}
;

INCREMENTO: 'expreID' '++' ';' {$$= new Incremento($1,$2);}
        | '++' 'expreID' ';' {$$= new Incremento($2,$1);}
;

DECREMENTO: 'expreID' '--' ';' {$$= new Decremento($1,$2);}
        | '--' 'expreID' ';' {$$= new Decremento($2,$1);}
;


ENCAPSULAMIENTO: '{' LISTAINSTRUCCIONES '}' { $$= new Bloque($2,@1.first_line,@1.first_column);}
                | '{' 'cadena' ',' 'cadena' '}' { $$= new Bloque($4,@1.first_line,@1.first_column);}
;

VECTORES: DECLARARVECTOR {$$=$1;}
        | DECLARARVECTOR2 {$$=$1;}
        | ACCESOVECTOR {$$=$1;}
        | MODIFICARVECTOR {$$=$1;}
;

DECLARARVECTOR: TIPOS '[' ']' EXID '=' 'pr_new' TIPOS '[' 'numero' ']' ';' {$$= new Vector($1,$4,$7,$9);}
        | TIPOS '[' ']' '[' ']' EXID '=' 'pr_new' TIPOS '[' '(' TIPOS ')' 'cadena' ']' '[' 'numero' ']' ';' {$$= new Vector($1,$6,$9, '[' + '(' + $12 + ')'+ $14 + ']' + '[' + $17 + ']');}
        | TIPOS '[' ']' '[' ']' EXID '=' 'pr_new' TIPOS '[' 'numero' ']' '[' 'numero' ']' ';' {$$= new Vector($1,$6,$9,'[' + $11+ ']' + '[' + $14 + ']');}
;

DECLARARVECTOR2: TIPOS '[' ']' EXID '='  '{' LISTAVALORES '}' ';' {$$= new Vector2($1,$4,$7,null);}
        | TIPOS '[' ']' '[' ']' EXID '=' '{' '{' LISTAVALORES '}' ',' '{' LISTAVALORES '}' '}' ';' {$$= new Vector2($1,$6,$10,$14);}
;


ACCESOVECTOR: TIPOS EXID '=' 'expreID' '[' 'numero' ']' ';' {$$= new AccesoVector($1,$2,$4,$6,null);}
        | TIPOS EXID '=' 'expreID' '[' 'numero' ']' '[' 'numero' ']' ';' {$$= new Vector($1,$2,$4,$6,$9);}
        
;

MODIFICARVECTOR: EXID '[' 'numero' ']' '=' 'cadena' ';' {$$= new ModificarVector($1, $3, $6, null);}
        | EXID '[' 'numero' ']'  '=' 'cadena' '+' 'expreID' '[' 'numero' ']' ';' {$$= new ModificarVector($1,$3,$6 + $8, $10);}
;

TIPOS: 'pr_int' {$$=$1;}
    |'pr_char' {$$=$1;}
    |'pr_string' {$$=$1;}
    | 'pr_bool' {$$=$1;}
    | 'pr_double' {$$=$1;}
;

LISTAVALORES: 'cadena' ',' 'cadena' LISTAVALORES  {$$=$1 + ',' + $3;}
            | 'numero' ',' 'numero' LISTAVALORES {$$=$1 + ',' + $3;}
            | 'numero' ',' 'numero' {$$=$1 + ',' + $3;}
            | 'cadena' , 'cadena' {$$=$1 + ',' + $3;}
;


OTERNARIO: EXID '=' EXID '>' 'numero' '?' 'bool' ':' 'bool' ';' {$$= new OTernario($1,$3,$5,$7,$9);}
        | EXID '=' EXID '>' 'char' '?' 'bool' ':' 'bool' ';' {$$= new OTernario($1,$3,$5,$7,$9);}
        | EXID '=' EXID '>' 'char' '?' 'numero' ':' 'numero' ';' {$$= new OTernario($1,$3,$5,$7,$9);}
        | EXID '=' EXID '>' 'char' '?' 'cadena' ':' 'cadena' ';' {$$= new OTernario($1,$3,$5,$7,$9);}
;


IF: 'pr_if' '(' CONDICIONIF ')' '{' LISTAINSTRUCCIONES '}' { $$= new If($3,$6,null,null,@1.first_line,@1.first_column);}
    | 'pr_if' '(' CONDICIONIF ')' '{' LISTAINSTRUCCIONES '}' 'pr_else' '{' LISTAINSTRUCCIONES '}' { $$= new If($3,$6,null,$10,@1.first_line,@1.first_column);}
    | 'pr_if' '(' CONDICIONIF ')' '{' LISTAINSTRUCCIONES '}' LISTAELIF 'pr_else' '{' LISTAINSTRUCCIONES '}'  { $$= new If($3,$6,$8,$11,@1.first_line,@1.first_column);}
;


LISTAELIF: 'pr_elif' '(' CONDICIONIF ')' '{' LISTAINSTRUCCIONES '}' LISTAELIF {$$=new Elif($3,$6);}
        | 'pr_elif' '(' CONDICIONIF ')' '{' LISTAINSTRUCCIONES '}' {$$=new Elif($3,$6);}
;


CONDICIONIF: 'expreID' OPERAD 'numero' {$$=$1 + $2 + $3;}
        | 'expreID' OPERAD 'cadena' {$$=$1 + $2 + $3;}
        | 'expreID' OPERAD 'caracter' {$$=$1 + $2 + $3;}
        | 'expreID' OPERAD 'bool' {$$=$1 + $2 + $3;}
        | 'cadena' OPERAD 'cadena' {$$=$1 + $2 + $3;}
        | 'cadena' OPERAD 'numero' {$$=$1 + $2 + $3;}
        | 'cadena' OPERAD 'caracter' {$$=$1 + $2 + $3;}
        | 'cadena' OPERAD 'bool' {$$=$1 + $2 + $3;}
        | 'expreID' OPERAD 'numero' '&&' 'expreID' OPERAD 'numero'  {$$=$1 + $2 + $3 + '&&' + $5 + $6 + $7;}
        | 'expreID' OPERAD 'cadena' '+' 'cadena' {$$=$1 + $2 + $3 + '+' + $4;}
        | 'expreID' OPERAD 'cadena' + OPERACIONA {$$=$1 + $2 + $3 + '+' + $4;}
;

OPERAD: '<' {$$=$1;}
        | '>' {$$=$1;}
        | '<=' {$$=$1;}
        | '>=' {$$=$1;}
        | "==" {$$=$1;}
        | "!=" {$$=$1;}
;


SWITCH: 'pr_switch' '(' EXID ')' '{' LISTACASE '}' {$$= new SwitchG($3, $6);}
;



LISTACASE: 'pr_case' 'numero' ':' LISTAINSTRUCCIONES LISTACASE {$$=new LCase($2,$4);}
        | 'pr_case' 'numero' ':' LISTAINSTRUCCIONES {$$=new LCase($2,$4);}
        | 'pr_default' ':' LISTAINSTRUCCIONES {$$= new LCase($1,$3);}
;


WHILE: 'pr_while' '(' CONDICIONIF ')' '{' LISTAINSTRUCCIONES '}' {$$= new WhileG($3,$6);}
;

FOR: 'pr_for' '(' TIPOS 'expreID' '=' OPERACIONA ';' 'expreID' OPERAD OPERACIONA ';' 'expreID' '+' '+' ')' '{' LISTAINSTRUCCIONES '}' {$$= new For($3 + $4 + $6,$8 + $9 + $10,$12 + '+' + '+', $17);}
        | 'pr_for' '(' 'expreID' '=' OPERACIONA ';' 'expreID' OPERAD OPERACIONA ';' 'expreID' '=' EXPRESIONES ')' '{' LISTAINSTRUCCIONES '}' {$$= new For($3 + $5 ,$7 + $8 + $9 + $10,$12 + $14,$16);}
;

DOWHILE: 'pr_do' '{' LISTAINSTRUCCIONES '}' 'pr_while' '(' CONDICIONIF ')' ';' {$$ = new DoWhile($3,$7);}
        | 'pr_do' '{' LISTAINSTRUCCIONES '}' 'pr_while' '(' OPERACIONA ')' ';' {$$ = new DoWhile($3,$7);}
;

DOUNTIL: 'pr_do' '{' LISTAINSTRUCCIONES '}' 'pr_until' '(' CONDICIONIF ')' ';' {$$ = new DoUntil($3,$7);}
        | 'pr_do' '{' LISTAINSTRUCCIONES '}' 'pr_until' '(' OPERACIONA ')' ';' {$$ = new DoUntil($3,$7);}
;

BREAK: 'pr_break' ';' {$$=new Break($1);}
;

CONTINUE: 'pr_continue' ';' {$$=new Continue($1);}
;

RETURN: 'pr_return' ';' {$$=new Return($1,$1);}
    | 'pr_return' OPERACIONA ';' {$$=new Return($1,$2);}
    | 'pr_return' EXID ';' {$$=new Return($1,$2);}
    | 'pr_return' 'cadena' {$$=new Return($1,$2);}
;


FUNCIONES: EXID '(' LISTAPARAMETROS ')' ':' TIPOS '{' LISTAINSTRUCCIONES '}' {$$=new Funcion($1,$3,$6,$8);}
        | EXID '(' ')' ':' TIPOS '{' LISTAINSTRUCCIONES '}' {$$=new Funcion($1,null,$5,$7);}
;

LISTAPARAMETROS: TIPOS 'expreID' {$$=$1 + $2;}
                | LISTAPARAMETROS ',' TIPOS 'expreID' {$$=$3 + $4;}
;

METODO: EXID '(' ')' ':' 'pr_void' '{' LISTAINSTRUCCIONES '}' {$$= new Metodo($1,null,$7);}
        | EXID '(' ')' '{' LISTAINSTRUCCIONES '}' {$$= new Metodo($1,null,$5);}
        | EXID '(' LISTAPARAMETROS ')' ':' 'pr_void' '{' LISTAINSTRUCCIONES '}' {$$= new Metodo($1,$3,$8);}
        | EXID '(' LISTAPARAMETROS ')' '{' LISTAINSTRUCCIONES '}' {$$= new Metodo($1,$3,$6);}
;

EJECUTAR: EXID '(' ')' ';' {$$= new Ejecutar($1, null);}
        | EXID '(' OPERACIONA ')' ';' {$$= new Ejecutar($1, $3);}
;


PRINT: 'pr_print' '(' 'cadena' ')' ';' {$$= new Print($3,@1.first_line,@1.first_column);}
    | 'pr_print' '(' 'expreID' ')' ';' {$$= new Print($3,@1.first_line,@1.first_column);}
    | 'pr_print' '(' 'cadena' ')' '+' 'expreID' ';' {$$= new Print($3,@1.first_line,@1.first_column);}
    | 'pr_print' '(' 'expreID' ')' '+' 'expreID' ';' {$$= new Print($3,@1.first_line,@1.first_column);}
    | 'pr_print' '(' 'cadena' ')' '+' OPERACIONA ';' {$$= new Print($3,@1.first_line,@1.first_column);}
    | 'pr_print' '(' 'expreID' ')' '+' OPERACIONA ';' {$$= new Print($3,@1.first_line,@1.first_column);}
;

PRINTLN: 'pr_println' '(' 'cadena' ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'expreID' ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'cadena' ')' '+' 'expreID' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'expreID' ')' '+' 'expreID' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'cadena' ')' '+' 'numero' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'expreID' ')' '+' 'numero' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'expreID' '+' OPERACIONA ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'cadena' '+' OPERACIONA ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'cadena' '+' 'expreID' '+' 'cadena' ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'expreID' '+' 'expreID' '+' 'cadena' ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
    | 'pr_println' '(' 'expreID' '+' 'cadena' '+' 'expreID' ')' ';' {$$= new PrintLn($3,@1.first_line,@1.first_column);}
;

TOLOWER: TIPOS EXID '=' 'pr_tolower' '(' 'cadena' ')' ';' {$$ = new Lower($2,$6);}
        | TIPOS EXID '=' 'pr_tolower' '(' PRUEBA ')' ';' {$$= new Lower($2,$6);}
;

TOUPPER: TIPOS EXID '=' 'pr_toupper' '(' 'cadena' ')' ';' {$$ = new Upper($2,$6);}
        | TIPOS EXID '=' 'pr_toupper' '(' 'cadena' '+' 'numero' ')' ';' {$$= new Upper($2,$6);}
        | EXID '=' 'pr_toupper' '(' 'cadena' ')' ';' {$$ = new Upper($1,$5);}
        | EXID '=' 'pr_toupper' '(' 'cadena' '+' OPERACIONA ')' ';' {$$= new Upper($1, $5);}
;

ROUND: TIPOS EXID '=' 'pr_round' '(' OPERACIONA ')' ';' {$$= new Round($2,$6);}
        | EXID '=' 'pr_round' '(' OPERACIONA ')' ';' {$$= new Round($1,$5);}
;


LENGTH:  TIPOS EXID '=' 'pr_length' '(' EXID ')' ';' {$$= new Length($2,$6);}
        | TIPOS EXID '=' 'pr_length' '(' EXID '[' 'numero' ']' ')' ';' {$$= new Length($2,$6 + '[' + $8 + ']');}
        |'pr_length' '(' 'expreID' ')' ';' {$$= new Length(null,$3);}
;

TYPEOF: 'pr_typeof' '(' OPERACIONA ')' ';' {$$ = new Typeof($3,$3);}
        |TIPOS EXID '=' 'pr_typeof' '(' 'numero' ')' ';' {$$= new Typeof($2,$6); }
        |TIPOS EXID '=' 'pr_typeof' '(' 'cadena' ')' ';' {$$= new Typeof($2,$6); }
        |TIPOS EXID '=' 'pr_typeof' '(' 'bool' ')' ';' {$$= new Typeof($2,$6); }
        |TIPOS EXID '=' 'pr_typeof' '(' 'caracter' ')' ';' {$$= new Typeof($2,$6); }
        |TIPOS EXID '=' 'pr_typeof' '(' EXID ')' ';' {$$= new Typeof($2,$6); }
;

TOSTRING: 'pr_tostring' '(' 'numero' ')' ';' {$$ = new ToString($3,$3);}
        |TIPOS EXID '=' 'pr_tostring' '(' OPERACIONA ')' ';' {$$= new ToString($2,$6); }
        |TIPOS EXID '=' 'pr_tostring' '(' EXID ')' ';' {$$= new ToString($2,$6); }
        |TIPOS EXID '=' 'pr_tostring' '(' 'cadena' ')' ';' {$$= new ToString($2,$6); }
        |TIPOS EXID '=' 'pr_tostring' '(' 'caracter' ')' ';' {$$= new ToString($2,$6); }
        |TIPOS EXID '=' 'pr_tostring' '(' 'bool' ')' ';' {$$= new ToString($2,$6); }
;

TOCHARARRAY: 'pr_tochararray' '(' OPERACIONA ')' ';' {$$ = new ToCharArray($3,$3);}
        |TIPOS '[' ']' EXID '=' 'pr_tochararray' '(' OPERACIONA ')' ';' {$$= new ToCharArray($4,$8); }
        |TIPOS '[' ']' EXID '=' 'pr_tochararray' '(' EXID ')' ';' {$$= new ToCharArray($4,$8); }
        |TIPOS '[' ']' EXID '=' 'pr_tochararray' '(' 'cadena' ')' ';' {$$= new ToCharArray($4,$8); }
        |TIPOS '[' ']' EXID '=' 'pr_tochararray' '(' 'caracter' ')' ';' {$$= new ToCharArray($4,$8); }
        |TIPOS '[' ']' EXID '=' 'pr_tochararray' '(' 'bool' ')' ';' {$$= new ToCharArray($4,$8); }
;


PUSH: EXID '.' 'pr_push' '(' OPERACIONA ')' ';' {$$= new Push($1,$5);}
    | EXID '.' 'pr_push' '(' 'cadena' ')' ';' {$$= new Push($1,$5);}
    | EXID '.' 'pr_push' '(' 'caracter' ')' ';' {$$= new Push($1,$5);}
    | EXID '.' 'pr_push' '(' ')' ';' {$$= new Push($1,$1);}
;

POP: EXID '.' 'pr_pop' '(' OPERACIONA ')' ';' {$$= new Pop($1);}
    | EXID '.' 'pr_pop' '(' 'cadena' ')' ';' {$$= new Pop($1);}
    | EXID '.' 'pr_pop' '(' 'caracter' ')' ';' {$$= new Pop($1);}
    | EXID '.' 'pr_pop' '(' ')' ';' {$$= new Pop($1);}
;

RUN: 'pr_run' EXID '(' ')' ';' {$$= new Run($2,$2);}
    | 'pr_run' EXID '(' OPERACIONA ')' ';' {$$= new Run($2,$4);}
    | 'pr_run' EXID '(' 'cadena' ')' ';' {$$= new Run($2,$4);}
    | 'pr_run' EXID '(' 'caracter' ')' ';' {$$= new Run($2,$4);}
;


PRUEBA: 'cadena' '+' OPERACIONA {$$= new Prueba($1,$2);}
;