# SFU CMPT 379 Compilers Summer 2023 

This milestone is due on Friday, June 9, by 11:59 pm. The assignment requires converting a provided compiler into a compiler that works for an expanded language. 

## Current Goals - May 25th (Thursday)
- Finish till 1h of the checkpoints.
- Understand each parts of tan-0 and figure out what feature affects what component of the compiler so that additional feature can be added easily for Tan-1.

Features:

 Kavi - Operators, Comments.
 
 Wahid - Additional Data Types (Float, char, string), Mutability, Type Casting.
=======
 Wahid - Additional Data Types, Mutability and Type casting.

## Provided Languages

Brief descriptions of the languages Tan-0 and Tan-1 are included in this assignment. 

## Base Compiler

The base compiler provided takes Tan-0 programs as input and produces an intermediate code called Abstract Stack Language. You can download the base compiler and the Abstract Stack Machine emulator from the course website.

## Development 

All development is to be done in Java. Eclipse is recommended for development work, and it can be downloaded for free at [www.eclipse.org](www.eclipse.org). However we will use Intellij Idea. 

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
# Tan-0 Language Specification

Whitespace can be used to separate tokens, but is not necessary if the text is unambiguous.

## Tokens:

- `integerLiteral` → [ 0..9 ]+ (has type "integer")
- `booleanLiteral` → true | false (has type "boolean")
- `identifier` → [ a..z_ ]+
- `punctuator` → unaryOperator | operator | punctuation
- `unaryOperator` → -
- `operator` → + | * | >
- `punctuation` → ; | { | }| :=

## Grammar:

- `S` → main mainBlock
- `mainBlock` → { statement* }
- `statement` → declaration | printStatement
- `declaration` → const identifier := expression ; (immutable (constant) value)
  - identifier gets the type of the expression.
- `printStatement` → print printExpressionList ; (print the expr values)
- `printExpressionList` → printSeparator* (expression printSeparator+)* expression?
  - a separated list of expressions (can be zero of them)
- `printSeparator` → \| \n | \s
- `expression` → unaryOperator expression (only "-" implemented as unary)
  - expression operator expression (all operations left-associative, binary "-" not implemented)
  - literal
- `literal` → integerLiteral | booleanLiteral | identifier

Any word (sequence of roman letters and underscores) shown in bold in the grammar above is a keyword and cannot be used as an identifier. Also, `true` and `false` are keywords. Identifiers must be declared (appear as the identifier in a declaration) before they are used as a literal. They are only considered declared after the end of their declaration statement.

In a print statement, the appearance of an expression in the printExpressionList means that the value of the expression is printed. The appearance of \n means that a newline is printed. The appearance of \s means that a space is printed. A \, on the other hand, prints nothing.

print 3 \s\s 4 \ 5 \s\n;

prints a 3, then two spaces, then a 4, then a 5 (no space between 4 and 5), then a space, then a newline.

The operand of a unaryOperator must be of integer type. The operands in a binary expression must both be of integer type. The operators provided do not take any boolean operands. Booleans are stored as 0 (false) and 1 (true) in memory. (Do not store true values as anything other than 1.)

The result of "expression > expression" is boolean, and the results of "expression + expression" and "expression * expression" are integer.


## Language Tan-1
# Tan-1 Language Specification

## Tokens

- `integerLiteral` → [0..9]+ (_type: "integer"_)
- `floatingLiteral` → ([0..9]+.[0..9]+)((e|E)(+|-)[0..9]+)? (_type: "floating"_)
- `booleanLiteral` → true | false (_type: "boolean"_)
- `stringLiteral` → "[^"\n]*" (_type: “string”_)
- `characterLiteral` → 'α' | %[0..7][0..7][0..7] (_type: "character"_)
- `identifier` → [a..zA..Z_@][a..zA..Z_@0..9]*
- `punctuator` → `operator` | `punctuation`
  - `operator` → `unaryOperator` | `arithmeticOperator` | `comparisonOperator`
    - `unaryOperator` → + | –
    - `arithmeticOperator` → + | – | * | /
    - `comparisonOperator` → < | <= | == | != | > | >=
  - `punctuation` → ; | { | } | ( | ) | [ | ] | # | % | :=
- `comment` → #[^#\n]*(#|\n)

## Grammar

- `S` → main `blockStatement`
- `blockStatement` → { `statement`* }
- `statement` → `declaration` | `assignmentStatement` | `printStatement` | `blockStatement`
- `declaration` → const `identifier` := `expression` ; | var `identifier` := `expression` ;
- `assignmentStatement` → `target` := `expression` ;
  - `target` → `identifier`
- `printStatement` → print `printExpressionList` ;
  - `printExpressionList` → `printSeparator`* (`expression` `printSeparator`+)* `expression`?
    - `printSeparator` → \| \n | \s | \t
- `expression` → `unaryOperator` `expression` | `expression` `operator` `expression` | ( `expression` ) | < `type` >(`expression`) | `literal`
- `type` → bool | char | string | int | float
- `literal` → `integerLiteral` | `floatingLiteral` | `booleanLiteral` | `characterLiteral` | `stringLiteral` | `identifier`

## Variables

Declared with `const` or `var`.

- Boolean: 1 byte
- Character: 1 byte
- String: 4 bytes
- Integer: 4 bytes
- Floating: 8 bytes

## Casting

Allowed: char → int, int → char, int → float, float → int, int → bool, char → bool.

## Operator Precedence

1. Parentheses and casting
2. Unary – and +
3. / and *
4. - and +
5. Comparisons


## Features and Addition for implementation of Tan-1 from Tan-0
- New Data Types: Tan-1 introduces floating point numbers, strings, and characters in addition to the integers and booleans available in Tan-0. You will need to implement these new types, ensuring that they are parsed correctly and that operations on them behave as expected.

- Mutability: In Tan-1, you can declare mutable variables with the `var` keyword. Tan-0 only had immutable constants declared with `const`.

- Assignment Statement: Tan-1 introduces assignment statements that allow you to change the value of mutable variables.

- More Operators: Tan-1 has a wider range of arithmetic operators (`+`, `-`, `*`, `/`), comparison operators (`<`, `<=`, `==`, `!=`, `>`, `>=`), and unary operators (`+`, `-`). You will need to ensure all these operators are correctly parsed and evaluated.

- Type Casting: Tan-1 supports type casting between certain types. This needs to be implemented correctly according to the rules specified.

- Comments: Tan-1 supports comments starting with `#` and ending with a newline or another `#`. Your lexer will need to be updated to recognize and properly ignore comments.

- Block Statements and Scopes: Tan-1 introduces block statements that create new scopes. This means you'll need to implement a symbol table or equivalent mechanism to keep track of variable scopes.

- Extended Print Statements: Tan-1 expands the print statements by allowing a tab character (`\t`) as a separator.

- Error Handling: Tan-1 specifies certain runtime errors that must be detected and reported, such as division by zero and numeric overflows.

- Character Literals: Tan-1 supports both single ASCII characters and octal representations of ASCII characters.

To upgrade your compiler from Tan-0 to Tan-1, you would likely need to:
1. Modify your lexer to recognize the new token types (including floating point numbers, strings, characters, comments, and the new operators).
2. Expand your parser to understand the new syntax (like mutable variable declarations, assignment statements, and block statements).
3. Update your code generation step to handle the new data types and operations.
4. Implement error handling mechanisms to identify situations like division by zero and integer overflow.
5. Extend the symbol table to handle variable scopes introduced by block statements.

