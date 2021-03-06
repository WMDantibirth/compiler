grammar CX;
r: program;
program: statement*;

statement
: expressionstatement
| compoundstatement
| selectionstatement
| iterationstatement
| basetype IDENTIFIER LEFTPARENTHESIS (VOID|basetype IDENTIFIER? (COMMA basetype IDENTIFIER?)*)? RIGHTPARENTHESIS (SEMICOLON|LEFTBRACE statement* RIGHTBRACE)
| RETURN (expression|VOID)? SEMICOLON
| WRITE expression SEMICOLON
| WRITELN expression SEMICOLON
| READ IDENTIFIER SEMICOLON
| CONST? basetype IDENTIFIER (LEFTSQUAREBRACKET INTEGERNUMBER RIGHTSQUAREBRACKET)? (ASSIGN expression)? (COMMA IDENTIFIER(LEFTSQUAREBRACKET INTEGERNUMBER RIGHTSQUAREBRACKET)? (ASSIGN expression)?)* SEMICOLON?
| SEMICOLON
| EXIT SEMICOLON
;

compoundstatement: LEFTBRACE statement* RIGHTBRACE;

expressionstatement: expression? SEMICOLON;

selectionstatement: IF LEFTPARENTHESIS expression RIGHTPARENTHESIS statement (ELSE statement)?;

iterationstatement
: WHILE LEFTPARENTHESIS expression RIGHTPARENTHESIS statement
| FOR LEFTPARENTHESIS expression? SEMICOLON expression? SEMICOLON expression? RIGHTPARENTHESIS statement
| DO statement WHILE LEFTPARENTHESIS expression RIGHTPARENTHESIS SEMICOLON
| REPEAT statement UNTIL LEFTPARENTHESIS expression RIGHTPARENTHESIS SEMICOLON
;

expression
: assignmentexpression
;

assignmentexpression
: conditionalexpression
| IDENTIFIER (LEFTSQUAREBRACKET expression RIGHTSQUAREBRACKET)? ASSIGN assignmentexpression
;

conditionalexpression
: logicalorexpression
| logicalorexpression QUESTIONMARK expression COLON conditionalexpression
;

logicalorexpression
: logicalandexpression
| logicalorexpression LOGICALOR logicalandexpression
;

logicalandexpression
: inclusiveorexpression
| logicalandexpression LOGICALAND inclusiveorexpression
;

inclusiveorexpression
: exclusiveorexpression
| inclusiveorexpression IOR exclusiveorexpression
;

exclusiveorexpression
: andexpression
| exclusiveorexpression XOR andexpression
;

andexpression
: equalityexpression
| andexpression AND equalityexpression
;

equalityexpression
: relationalexpression
| equalityexpression EQUAL relationalexpression
| equalityexpression NOTEQUAL relationalexpression
;

relationalexpression
: additiveexpression
| relationalexpression LESSTHAN additiveexpression
| relationalexpression GREATERTHAN additiveexpression
| relationalexpression LESSTHANOREQUAL additiveexpression
| relationalexpression GREATERTHANOREQUAL additiveexpression
;

additiveexpression
: multiplicativeexpression
| additiveexpression PLUS multiplicativeexpression
| additiveexpression MINUS multiplicativeexpression
;

multiplicativeexpression
: castexpression
| multiplicativeexpression MUL castexpression
| multiplicativeexpression DIV castexpression
| multiplicativeexpression MOD castexpression
;

castexpression
: LEFTPARENTHESIS basetype RIGHTPARENTHESIS castexpression
| unaryexpression
;

unaryexpression
: postfixexpression
| PLUSPLUS unaryexpression
| MINUSMINUS unaryexpression
| NOT castexpression
| ODD castexpression
| MINUS castexpression
;

postfixexpression
: primaryexpression
| postfixexpression PLUSPLUS
| postfixexpression MINUSMINUS
| IDENTIFIER LEFTSQUAREBRACKET expression RIGHTSQUAREBRACKET
;

primaryexpression
: IDENTIFIER
| constant
| LEFTPARENTHESIS expression RIGHTPARENTHESIS
| IDENTIFIER LEFTPARENTHESIS (expression (COMMA expression)*)? RIGHTPARENTHESIS
;

constant: TRUE | FALSE | INTEGERNUMBER | REALNUMBER;

basetype: INT | VOID | BOOLEAN | REAL;

COMMENT
: (BEGININLINECOMMENT .*? NEWLINE
| BEGINCOMMENT .*? ENDCOMMENT) -> skip
;

WHITESPACE: (' '|'\t')+ -> skip;
NEWLINE: '\r'? '\n' -> skip;

WRITE: 'write';
WRITELN: 'writeln';
INT: 'int';
BOOLEAN: 'bool';
LEFTBRACE: '{';
RIGHTBRACE: '}';
VOID: 'void';
RETURN: 'return';
SEMICOLON: ';';
IF: 'if';
DO: 'do';
LEFTPARENTHESIS: '(';
RIGHTPARENTHESIS: ')';
LEFTSQUAREBRACKET: '[';
RIGHTSQUAREBRACKET: ']';
ELSE: 'else';
WHILE: 'while';
FOR: 'for';
TRUE: 'true';
FALSE: 'false';
ASSIGN: '=';
PLUS: '+';
MINUS: '-';
MUL: '*';
DIV: '/';
EQUAL: '==';
NOTEQUAL: '!=';
LESSTHAN: '<';
GREATERTHAN: '>';
LESSTHANOREQUAL: '<=';
GREATERTHANOREQUAL: '>=';
NOT: '!';
LOGICALAND: '&&';
LOGICALOR: '||';
IOR: '|';
XOR: '^';
BEGININLINECOMMENT: '//';
BEGINCOMMENT: '/*';
ENDCOMMENT: '*/';
COMMA: ',';
LEFTSHIFT: '<<';
RIGHTSHIFT: '>>';
AND: '&';
QUESTIONMARK: '?';
INTEGERNUMBER: '0' | [1-9][0-9]*;
REALNUMBER: [1-9][0-9]*'.'[0-9]* | '0.'[0-9]*;
COLON: ':';
MOD: '%';
ODD: 'odd';
MINUSMINUS: '--';
PLUSPLUS: '++';
REPEAT: 'repeat';
UNTIL: 'until';
REAL: 'real';
READ: 'read';
EXIT: 'exit';
CONST: 'const';
IDENTIFIER: ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
