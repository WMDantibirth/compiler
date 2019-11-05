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
| basetype IDENTIFIER ((ASSIGN expression)?|(COMMA IDENTIFIER(ASSIGN expression)?)*) SEMICOLON
| SEMICOLON
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
| IDENTIFIER ASSIGN assignmentexpression
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
: postfixexpression
| multiplicativeexpression MUL postfixexpression
| multiplicativeexpression DIV postfixexpression
| multiplicativeexpression MOD postfixexpression
;

postfixexpression
: primaryexpression
| postfixexpression PLUSPLUS
| postfixexpression MINUSMINUS
| NOT primaryexpression
;

primaryexpression
: IDENTIFIER
| constant
| LEFTPARENTHESIS expression RIGHTPARENTHESIS
| IDENTIFIER LEFTPARENTHESIS (expression (COMMA expression)*)? RIGHTPARENTHESIS
;

constant: TRUE | FALSE | NUMBER;

basetype: INT | VOID | BOOLEAN;

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
NUMBER: '0' | [1-9][0-9]*;
COLON: ':';
MOD: '%';
MINUSMINUS: '--';
PLUSPLUS: '++';
REPEAT: 'repeat';
UNTIL: 'until';
IDENTIFIER: ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*;
