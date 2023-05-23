# SFU CMPT 379 Compilers Summer 2023 - Milestone 1

This milestone is due on Friday, June 9, by 11:59 pm. The assignment requires converting a provided compiler into a compiler that works for an expanded language. 

## Provided Languages

Brief descriptions of the languages Tan-0 and Tan-1 are included in this assignment. 

## Base Compiler

The base compiler provided takes Tan-0 programs as input and produces an intermediate code called Abstract Stack Language. You can download the base compiler and the Abstract Stack Machine emulator from the course website.

## Development 

All development is to be done in Java. Eclipse is recommended for development work, and it can be downloaded for free at [www.eclipse.org](www.eclipse.org). 

Use your own repository (using a tool of your choice) to store your assignment work. Your repository must not be publicly accessible. It is also recommended to commit at least once each day that you work on your compiler.

## Intellectual Property

The compiler that you develop includes my (Shermer’s) intellectual property. It might be used by current or future students in the course to cheat. You are legally and academically prohibited from storing your project in a public repository or from otherwise making public your code, for now and forever. 

## Milestone 1 Checkpoints

1. Download the base compiler.
2. Commit the base compiler to your repository.
3. Ensure that the `-ea` flag is used for all java executions.
4. Run the tan tests that come with the compiler.
5. Study the file `asmCodeGenerator/codeStorage/ASMOpcode.java`.
6. Run your ASM program(s) by using `ASMEmu.exe`.
7. Explore the "applications" package and see what each application does.
8. Break the assignment down into several features that can be added one-at-a-time to the compiler.
9. Implement each feature in turn.

## Language Tan-0

Whitespace can be used to separate tokens, but is not necessary if the text is unambiguous.
Tokens:
integerLiteral → [ 0..9 ]+ // has type "integer"
booleanLiteral → true | false // has type "boolean"
identifier → [ a..z_ ]+
punctuator → unaryOperator | operator | punctuation
unaryOperator → –
operator → + | * | >
punctuation → ; | { | }| :=
Grammar:
S → main mainBlock
mainBlock → { statement* }
statement → declaration
printStatement
declaration → const identifier := expression ; // immutable (constant) value
// identifier gets the type of the expression.
printStatement → print printExpressionList ; // print the expr values
printExpressionList → printSeparator* (expression printSeparator+)* expression?
// a separated list of expressions (can be zero of them)
printSeparator → \| \n | \s
expression → unaryOperator expression // only “-” implemented as unary
expression operator expression // all operations left-associative (binary “-” not implemented)
literal
literal → integerLiteral | booleanLiteral | identifier
Any word (sequence of roman letters and underscores) shown in bold in the grammar above is a keyword and cannot be used as an identifier. Also, true and false are keywords. Identifiers must be declared (appear as the identifier in a declaration) before they are used as a literal. They are only considered declared after the end of their declaration statement.
In a print statement, the appearance of an expression in the printExpressionList means that the value of the expression is printed. The appearance of \n means that a newline is printed. The appearance of \s means that a space is printed. A \, on the other hand, prints nothing.
print 3 \s\s 4 \ 5 \s\n;
prints a 3, then two spaces, then a 4, then a 5 (no space between 4 and 5), then a space, then a newline.
The operand of a unaryOperator must be of integer type. The operands in a binary expression must both be of integer type. The operators provided do not take any boolean operands. Booleans are stored as 0 (false) and 1 (true) in memory. (Do not store true values as anything other than 1.)
The result of "expression > expression" is boolean, and the results of "expression + expression" and "expression * expression" are integer.
