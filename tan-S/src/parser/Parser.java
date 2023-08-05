package parser;

import java.util.ArrayList;
import java.util.Arrays;

import logging.TanLogger;
import parseTree.*;
import parseTree.nodeTypes.*;
import semanticAnalyzer.types.PrimitiveType;
import parseTree.nodeTypes.IfStatementNode;
import semanticAnalyzer.types.Type;
import tokens.*;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import lexicalAnalyzer.Scanner;

//if error expecting print separator come to this file

public class Parser {
	private Scanner scanner;
	private Token nowReading;
	private Token previouslyRead;

	public static ParseNode parse(Scanner scanner) {
		Parser parser = new Parser(scanner);
		return parser.parse();
	}
	public Parser(Scanner scanner) {
		super();
		this.scanner = scanner;
	}

	public ParseNode parse() {
		readToken();
		return parseProgram();
	}
	//static public boolean funcInvo = false;
	////////////////////////////////////////////////////////////
	// "program" is the start symbol S
	// S -> MAIN mainBlock

	// S -> main blockStatement
// program → functionDefinition* main blockStatement
	private ParseNode parseProgram() {
		if(!startsProgram(nowReading)) {
			return syntaxErrorNode("program");
		}

		ParseNode program = new ProgramNode(nowReading);

		// While the next token starts a function definition, parse function definitions
		while(nowReading.isLextant(Keyword.SUBR)|| startsDeclaration(nowReading)) {
			if(startsDeclaration(nowReading)) {
				program.appendChild(parseDeclaration());
				continue;
			}
			//funcInvo = false;
			Token funcStart = nowReading;
			readToken(); // Consume SUBR Token

			ParseNode returnType = parseType();
			//System.out.print(returnType);
			ParseNode identifier = parseIdentifier();

			//funcInvo = true;
			ParseNode functionDefinition = parseFunctionDefinition(returnType);
			program.appendChild(ConstDeclarationNode.withChildren(funcStart, identifier, functionDefinition));
		}


		// Expect 'main' keyword
		expect(Keyword.MAIN);

		// Parse the main block
		ParseNode mainBlock = parseBlockStatement();
		program.appendChild(mainBlock);

		return program;
	}

	private boolean startsProgram(Token token) {
		return token.isLextant(Keyword.SUBR) || token.isLextant(Keyword.MAIN);
	}


	///////////////////////////////////////////////////////////
	// mainBlock

	// mainBlock -> { statement* }
	private ParseNode parseMainBlock() {
		if(!startsMainBlock(nowReading)) {
			return syntaxErrorNode("mainBlock");
		}
		ParseNode mainBlock = new MainBlockNode(nowReading);
		expect(Punctuator.OPEN_BRACE);

		while(startsStatement(nowReading)) {
			ParseNode statement = parseStatement();
			mainBlock.appendChild(statement);
		}
		expect(Punctuator.CLOSE_BRACE);
		return mainBlock;
	}
	private boolean startsMainBlock(Token token) {
		return token.isLextant(Punctuator.OPEN_BRACE);
	}


	///////////////////////////////////////////////////////////
	// statements

	// blockStatement -> { statement* }
	private ParseNode parseBlockStatement() {
		if (!startsBlockStatement(nowReading)) {
			return syntaxErrorNode("blockStatement");
		}
		ParseNode blockNode = new BlockStatementNode(nowReading);
		expect(Punctuator.OPEN_BRACE);

		while (startsStatement(nowReading)) {
			ParseNode statement = parseStatement();
			blockNode.appendChild(statement);
		}
		expect(Punctuator.CLOSE_BRACE);
		return blockNode;
	}

	private boolean startsBlockStatement(Token token) {
		return token.isLextant(Punctuator.OPEN_BRACE);
	}

	// statement -> declaration | printStmt | assignmentStmt | blockStatement
	private ParseNode parseStatement() {
		if (!startsStatement(nowReading)) {
			return syntaxErrorNode("statement");
		}
		if (startsDeclaration(nowReading)) {
			return parseDeclaration();
		}
		if(startsReturnStatement(nowReading)) {
			return parseReturnStatement();
		}
		if (startsPrintStatement(nowReading)) {
			return parsePrintStatement();
		}
		if (startsExpression(nowReading)) {
			return parseAssignmentStatement();
		}
		if (startsBlockStatement(nowReading)) {
			return parseBlockStatement();
		}
		if (startsIfStatement(nowReading)) {
			return parseIfStatement();
		}
		if (startsBreakStatement(nowReading)) {
			return parseBreakStatement();
		}
		if (startsContinueStatement(nowReading)) {
			return parseContinueStatement();
		}
		if (startsWhileStatement(nowReading)) {
			return parseWhileStatement();
		}
		if (startsForStatement(nowReading)) {
			return parseForStatement();
		}

		if(startsCallStatement(nowReading)) {
			return parseCallStatement();
		}

		return syntaxErrorNode("statement");
	}




	private boolean startsStatement(Token token) {
		return startsPrintStatement(token) ||
				startsDeclaration(token) ||
				startsExpression(token) ||
				startsReturnStatement(token) ||
				startsBlockStatement(token) ||
				startsIfStatement(token) ||
				startsWhileStatement(token) ||
				startsForStatement(token) ||
				startsBreakStatement(token) ||
				startsContinueStatement(token) ||
				startsCallStatement(token) ;
	}

	private boolean startsCallStatement(Token token) {
		return token.isLextant(Keyword.CALL);
	}

	//Function Calls
	private ParseNode parseCallStatement() {
		if(!startsCallStatement(nowReading)) {
			return syntaxErrorNode("call statement");
		}
		Token callKeyword = nowReading;
		readToken();
		ParseNode func = parseIdentifier();
		expect(Punctuator.TERMINATOR);
		return CallNode.withChildren(callKeyword, func);
	}

	private boolean startsFunctionInvocation(Token token) {
		return  !startsType(token);
	}

	private ParseNode parseFunctionInvocation(IdentifierNode identifier) {
		if(!startsFunctionInvocation(nowReading)) {
			return syntaxErrorNode("function invocation");
		}

		// Parse function name (an identifier)
		ParseNode functionName = identifier;


		if (nowReading.isLextant(Punctuator.OPEN_PARENTHESES))
			readToken();
		ArrayList<ParseNode> arr = new ArrayList<ParseNode>();
		// While the next token is not ')', parse arguments
		while(!nowReading.isLextant(Punctuator.CLOSE_PARENTHESES)) {
			// Parse an expression for the argument
			ParseNode argument = parseExpression();

			// Add the argument to the argument list
			arr.add(argument);

			// If the next token is ',', consume it and continue.
			// Otherwise, we're done parsing the argument list.
			if(nowReading.isLextant(Punctuator.SEPARATOR)) {
				readToken();
			} else {
				// Make sure we've reached the end of the argument list
				if(!nowReading.isLextant(Punctuator.CLOSE_PARENTHESES)) {
					return syntaxErrorNode("',' or ')'");
				}
				break;
			}
		}

		// Expect ')'
		expect(Punctuator.CLOSE_PARENTHESES);

		// Create a new FunctionInvocationNode (you need to define this class) and return it
		return FunctionInvocationNode.withChildren(functionName, arr.toArray(new ParseNode[arr.size()]));
	}


	// assignmentStmt -> identifier := expression TERMINATOR
	private ParseNode parseAssignmentStatement() {

		if(!startsExpression(nowReading)) {
			return syntaxErrorNode("assignment statement");
		}
		//
		ParseNode identifier = parseExpression();
		if(!(identifier instanceof IdentifierNode || identifier instanceof ArrayAccessNode)) {
			return syntaxErrorNode("Assignment Error");
		}

		expect(Punctuator.ASSIGN);

		ParseNode value = parseExpression();

		expect(Punctuator.TERMINATOR);

		return AssignmentNode.withChildren(identifier, value);
	}
	private boolean startsAssignmentStatement(Token token) {
		return token instanceof IdentifierToken;
	}

	// printStmt -> PRINT printExpressionList TERMINATOR
	private ParseNode parsePrintStatement() {
		if(!startsPrintStatement(nowReading)) {
			return syntaxErrorNode("print statement");
		}
		ParseNode result = new PrintStatementNode(nowReading);

		readToken();
		result = parsePrintExpressionList(result);

		expect(Punctuator.TERMINATOR);
		return result;
	}
	private boolean startsPrintStatement(Token token) {
		return token.isLextant(Keyword.PRINT);
	}

	// This adds the printExpressions it parses to the children of the given parent
	// printExpressionList -> printSeparator* (expression printSeparator+)* expression? (note that this is nullable)

	private ParseNode parsePrintExpressionList(ParseNode parent) {
		if(!startsPrintExpressionList(nowReading)) {
			return syntaxErrorNode("printExpressionList");
		}

		while(startsPrintSeparator(nowReading)) {
			parsePrintSeparator(parent);
		}
		while(startsExpression(nowReading)) {
			parent.appendChild(parseExpression());
			if(nowReading.isLextant(Punctuator.TERMINATOR)) {// copy this line for comments
				return parent;
			}
			do {
				parsePrintSeparator(parent);
			} while(startsPrintSeparator(nowReading));
		}
		return parent;
	}
	private boolean startsPrintExpressionList(Token token) {
		return startsExpression(token) || startsPrintSeparator(token) || token.isLextant(Punctuator.TERMINATOR);
	}


	// This adds the printSeparator it parses to the children of the given parent
	// printSeparator -> PRINT_SEPARATOR | PRINT_SPACE | PRINT_NEWLINE

	private void parsePrintSeparator(ParseNode parent) {
		if(!startsPrintSeparator(nowReading)) {
			ParseNode child = syntaxErrorNode("print separator");
			parent.appendChild(child);
			return;
		}

		if(nowReading.isLextant(Punctuator.PRINT_NEWLINE)) {
			readToken();
			ParseNode child = new NewlineNode(previouslyRead);
			parent.appendChild(child);
		}
		else if(nowReading.isLextant(Punctuator.PRINT_SPACE)) {
			readToken();
			ParseNode child = new SpaceNode(previouslyRead);
			parent.appendChild(child);
		}
		else if(nowReading.isLextant(Punctuator.PRINT_TAB)) {
			readToken();
			ParseNode child = new TabNode(previouslyRead);
			parent.appendChild(child);
		}
		else if(nowReading.isLextant(Punctuator.PRINT_SEPARATOR)) {
			readToken();
		}
	}
	private boolean startsPrintSeparator(Token token) {
		return token.isLextant(Punctuator.PRINT_SEPARATOR, Punctuator.PRINT_SPACE, Punctuator.PRINT_NEWLINE, Punctuator.PRINT_TAB);
	}


	// declaration -> CONST identifier := expression TERMINATOR | VAR identifier := expression TERMINATOR
	private ParseNode parseDeclaration() {
		if(!startsDeclaration(nowReading)) {
			return syntaxErrorNode("declaration");
		}
		Token declarationToken = nowReading;
		readToken();

		ParseNode identifier = parseIdentifier();
		expect(Punctuator.ASSIGN);
		ParseNode initializer = parseExpression();
		expect(Punctuator.TERMINATOR);

		if(declarationToken.isLextant(Keyword.CONST)) {
			return ConstDeclarationNode.withChildren(declarationToken, identifier, initializer);
		} else if(declarationToken.isLextant(Keyword.VAR)) {
			return VarDeclarationNode.withChildren(declarationToken, identifier, initializer);
		}
		return syntaxErrorNode("declaration");
	}
	private boolean startsDeclaration(Token token) {
		return token.isLextant(Keyword.CONST, Keyword.VAR);
	}

	//Arrays
	private ParseNode parseArrayLiteralOrAccess() {
		if (!startsparseArrayLiteralOrAccess(nowReading)) {
			return syntaxErrorNode("array literal");
		}
		Token openBracketToken = nowReading;
		readToken();
		ParseNode element = parseExpression();
		if (nowReading.isLextant(Punctuator.COLON)) {
			readToken(); // consume the ':'
			ParseNode indexExpression = parseExpression();
			expect(Punctuator.CLOSE_SQUARE_BRACKET);
			return ArrayAccessNode.withChildren(element, indexExpression);
		}

		ArrayList<ParseNode> elements = new ArrayList<>();
		elements.add(element);
		while (!nowReading.isLextant(Punctuator.CLOSE_SQUARE_BRACKET)) {
			if (nowReading.isLextant(Punctuator.SEPARATOR)) {
				readToken();
			}
			elements.add(parseExpression());
		}
		expect(Punctuator.CLOSE_SQUARE_BRACKET);
		return ArrayLiteralNode.withChildren(openBracketToken, elements);
	}




	// functionDefinition -> subr type identifier ( parameterList ) blockStatement
	// parse function definition
	private static boolean startsFunctionDefinition(Token token) {
		return token.isLextant(Punctuator.OPEN_PARENTHESES);
	}


	private boolean startsparseArrayLiteralOrAccess(Token token) {
		return token.isLextant(Punctuator.OPEN_SQUARE_BRACKET);
	}
/*	private boolean startsArrayLiteral(Token token) {
		return token.isLextant(Punctuator.OPEN_SQUARE_BRACKET);
	}*/

	private ParseNode parseType() {

		if (!startsType(nowReading)) {
			return syntaxErrorNode("type");
		}
		Token typeToken = nowReading;
		//System.out.print(typeToken);
		if (typeToken.isLextant(Punctuator.OPEN_SQUARE_BRACKET)) {
			readToken();
			ParseNode subType = parseType();
			expect(Punctuator.CLOSE_SQUARE_BRACKET);
			return ArrayTypeNode.withChildren(typeToken, subType);
		}
		readToken();

		return PrimitiveTypeNode.withTypeToken(typeToken);
	}

	private boolean startsType(Token token) {

		return token.isLextant(Punctuator.OPEN_SQUARE_BRACKET) || isPrimitiveType(token);
	}

	private boolean isPrimitiveType(Token token) {

		try {

			PrimitiveType.fromString(token.getLexeme());
			return true;
		} catch (IllegalArgumentException e) {

			return false;
		}
	}


	///Function Definition
	// functionDefinition → subr type identifier ( parameterList ) blockStatement
	private ParseNode parseFunctionDefinition(ParseNode returnType) {
		if(!startsFunctionDefinition(nowReading)) {
			return syntaxErrorNode("function definition");
		}

		if(nowReading.isLextant(Punctuator.OPEN_PARENTHESES)){
			readToken();
		}

		ParseNode parameterList = parseParameterList();

		// consume the ')' token
		expect(Punctuator.CLOSE_PARENTHESES);

		// parse the function body
		ParseNode functionBody = parseBlockStatement();
		// create a new FunctionDefinitionNode (you need to define this class) and return it
		return FunctionDefinitionNode.withChildren(returnType, parameterList, functionBody);
	}

	// parameterList → parameterSpecification ⋈ ,
	private ParseNode parseParameterList() {
		ParseNode parameterList = new ParameterListNode(nowReading);

		// While the next token is not ')', parse parameter specifications
		while(!nowReading.isLextant(Punctuator.CLOSE_PARENTHESES)) {
			// Make sure that the next token is a type (the start of a parameter specification)

			if(!startsType(nowReading)) {
				return syntaxErrorNode("type");
			}

			// Parse a parameter specification
			ParseNode parameterSpecification = parseParameterSpecification();
			parameterList.appendChild(parameterSpecification);

			// If the next token is ',', consume it and continue.
			// Otherwise, we're done parsing the parameter list.
			if(nowReading.isLextant(Punctuator.SEPARATOR)) {
				readToken();
			} else {
				// Make sure we've reached the end of the parameter list
				if(!nowReading.isLextant(Punctuator.CLOSE_PARENTHESES)) {
					return syntaxErrorNode("',' or ')'");
				}
				break;
			}
		}

		return parameterList;
	}


	// parameterSpecification → type identifier
	private ParseNode parseParameterSpecification() {
		ParseNode type = parseType();
		ParseNode identifier = parseIdentifier();
		return ParameterSpecificationNode.withChildren(type, identifier);
	}

	private ParseNode parseReturnStatement() {
		if(!startsReturnStatement(nowReading)) {
			return syntaxErrorNode("return statement");
		}
		ReturnStatementNode node = new ReturnStatementNode(nowReading);
		// consume the 'return' keyword
		expect(Keyword.RETURN);
		//ParseNode expression = null;
		// parse the expression
		if (startsExpression(nowReading))
			node.appendChild(parseExpression());

		// consume the ';' token
		expect(Punctuator.TERMINATOR);

		// create a new ReturnStatementNode (you need to define this class) and return it
		return node;
	}

	private boolean startsReturnStatement(Token token) {
		return token.isLextant(Keyword.RETURN);
	}


	////ARRAYS
	private ParseNode parseArrayInstantiation() {
		//ln("Hello, World!");
		if (!startsArrayInstantiation(nowReading)) {
			return syntaxErrorNode("array instantiation");
		}
		Token newArrayToken = nowReading;
		readToken();
		ParseNode arrayType = parseType();
		expect(Punctuator.OPEN_PARENTHESES);
		ParseNode sizeExpression = parseExpression();
		expect(Punctuator.CLOSE_PARENTHESES);

		return ArrayInstantiationNode.withChildren(newArrayToken, arrayType, sizeExpression);
	}

	private boolean startsArrayInstantiation(Token token) {
		return token.isLextant(Keyword.NEW);
	}


	private ParseNode parseWhileStatement(){
		if(!startsWhileStatement(nowReading)) {
			return syntaxErrorNode("While");
		}
		//we don't read token and we dont set anything equal to token

		ParseNode WhileNode = new WhileStatementNode(nowReading);
		expect(Keyword.WHILE);

		ParseNode expression = parseBracketsExpression();
		WhileNode.appendChild(expression);//first child is boolean constant node


		ParseNode whileBlock = parseBlockStatement();
		WhileNode.appendChild(whileBlock);

		return WhileNode;

	}
	private boolean startsWhileStatement (Token token){
		return token.isLextant(Keyword.WHILE);
	}

	private ParseNode parseIfStatement() {//why this return type why return some methods and not others
		if(!startsIfStatement(nowReading)) {
			return syntaxErrorNode("If");
		}
		//we don't read token and we dont set anything equal to token

		ParseNode IfNode = new IfStatementNode(nowReading);
		expect(Keyword.IF);

		ParseNode expression = parseBracketsExpression();
		IfNode.appendChild(expression);//first child is boolean constant node


		ParseNode ifBlock = parseBlockStatement();
		IfNode.appendChild(ifBlock);

		if(startsElseStatement(nowReading)){
			expect(Keyword.ELSE);
			ParseNode elseBlock = parseBlockStatement();
			IfNode.appendChild(elseBlock);
		}

		//if token == else then repeat above eventually use while statement to get infinite else if's

		return IfNode;

	}
	private boolean startsIfStatement (Token token){
		return token.isLextant(Keyword.IF);
	}

	private boolean startsElseStatement (Token token){
		return token.isLextant(Keyword.ELSE);
	}

	private ParseNode parseForStatement() {//why this return type why return some methods and not others
		if(!startsForStatement(nowReading)) {
			return syntaxErrorNode("For");
		}


		Token startToken = nowReading;
		expect(Keyword.FOR);
		expect(Punctuator.OPEN_PARENTHESES);
		// ParseNode expression = parseExpression();//reads expression by calling readtoken chang this to expect FROM AND TO
		ParseNode identifier = parseIdentifier();
		expect(Keyword.FROM);
		ParseNode from = parseExpression();
		expect(Keyword.TO);
		ParseNode to = parseExpression();
		expect(Punctuator.CLOSE_PARENTHESES);
		ParseNode forBlock = parseBlockStatement();
		//Token token = ;

		ParseNode ForNode = new ForStatementNode(startToken);//used to include identifer
		//ForNode = new ForStatementNode(startToken, VarDeclarationNode.withChildren(nowReading, identifier, from));
		//Token token = new StringToken();
		ForNode.appendChild(identifier);
		ForNode.appendChild(from);
		ForNode.appendChild(to);


		ForNode.appendChild(forBlock);




		return ForNode;

	}

	private boolean startsForStatement (Token token){
		return token.isLextant(Keyword.FOR);
	}

	private ParseNode parseBreakStatement() {
		if(!startsBreakStatement(nowReading)) {
			return syntaxErrorNode("Break");
		}
		expect(Keyword.BREAK);
		expect(Punctuator.TERMINATOR);
		return new BreakNode(nowReading);
	}

	private boolean startsBreakStatement (Token token){
		return token.isLextant(Keyword.BREAK);
	}

	private ParseNode parseContinueStatement() {
		if(!startsContinueStatement(nowReading)) {
			return syntaxErrorNode("Continue");
		}
		expect(Keyword.CONTINUE);
		expect(Punctuator.TERMINATOR);
		return new ContinueNode(nowReading);
	}

	private boolean startsContinueStatement (Token token){
		return token.isLextant(Keyword.CONTINUE);
	}

	///////////////////////////////////////////////////////////
	// expressions
	// expr                     -> comparisonExpression
	// comparisonExpression     -> additiveExpression [> additiveExpression]?
	// additiveExpression       -> multiplicativeExpression [+ multiplicativeExpression]*  (left-assoc)
	// multiplicativeExpression -> atomicExpression [MULT atomicExpression]*  (left-assoc)
	// atomicExpression         -> unaryExpression | literal
	// unaryExpression			-> UNARYOP atomicExpression
	// literal                  -> intNumber | identifier | booleanConstant

	// expr  -> comparisonExpression
/*	private boolean startsExpression(Token token) {
		return startsComparisonExpression(token) || startsparseArrayLiteralOrAccess(token) || startsArrayInstantiation(token) || startsArrayLength(token);
	}*/

	private ParseNode parseExpression() {

		if(!startsExpression(nowReading)) {
			return syntaxErrorNode("expression");
		}

		return parseBooleanExpression();
	}
	private boolean startsExpression(Token token) {
		//return startsComparisonExpression(token);

		return startsBooleanExpression(token);
	}

	//boolean expressions -> comparison expressions
	private ParseNode parseBooleanExpression(){

		if(!startsBooleanExpression(nowReading)) {
			return syntaxErrorNode("comparison expression");
		}

		ParseNode left = parseComparisonExpression();
		if(nowReading.isLextant(Punctuator.AND) || nowReading.isLextant(Punctuator.OR)){//goal have and and or different levels of importance
			Token booleanExpressionToken = nowReading;//solve left class 1st
			readToken();

			ParseNode right = parseComparisonExpression();

			return OperatorNode.withChildren(booleanExpressionToken, left, right);
		}

		return left;
	}

	private boolean startsBooleanExpression(Token token) {
		return startsComparisonExpression(token);
	}



	// comparisonExpression -> additiveExpression [> additiveExpression]?
	private ParseNode parseComparisonExpression() {
		if(!startsComparisonExpression(nowReading)) {
			return syntaxErrorNode("comparison expression");
		}

		ParseNode left = parseAdditiveExpression();
		if(nowReading.isLextant(Punctuator.GREATER)
				|| nowReading.isLextant(Punctuator.GREATERTHANOREQUAL)
				|| nowReading.isLextant(Punctuator.LESSER)
				|| nowReading.isLextant(Punctuator.LESSERTHANOREQUAL)
				|| nowReading.isLextant(Punctuator.EQUAL)
				|| nowReading.isLextant(Punctuator.NOTEQUAL)
		) {
			Token compareToken = nowReading;
			readToken();
			ParseNode right = parseAdditiveExpression();

			return OperatorNode.withChildren(compareToken, left, right);
		}
		return left;

	}
	private boolean startsComparisonExpression(Token token) {
		return startsAdditiveExpression(token);
	}

	// additiveExpression -> multiplicativeExpression [+ multiplicativeExpression]*  (left-assoc)
	private ParseNode parseAdditiveExpression() {
		if(!startsAdditiveExpression(nowReading)) {
			return syntaxErrorNode("additiveExpression");
		}

		ParseNode left = parseMultiplicativeExpression();
		while(nowReading.isLextant(Punctuator.ADD) || nowReading.isLextant(Punctuator.SUBTRACT)) {
			Token additiveToken = nowReading;
			readToken();
			ParseNode right = parseMultiplicativeExpression();

			left = OperatorNode.withChildren(additiveToken, left, right);
		}
		return left;
	}
	private boolean startsAdditiveExpression(Token token) {
		return startsMultiplicativeExpression(token);
	}

	// multiplicativeExpression -> atomicExpression [MULT atomicExpression]*  (left-assoc)
	private ParseNode parseMultiplicativeExpression() {
		if(!startsMultiplicativeExpression(nowReading)) {
			return syntaxErrorNode("multiplicativeExpression");
		}

		ParseNode left = parseAtomicExpression();
		while(nowReading.isLextant(Punctuator.MULTIPLY) || nowReading.isLextant(Punctuator.DIVIDE)){
			Token multiplicativeToken = nowReading;
			readToken();
			ParseNode right = parseAtomicExpression();

			left = OperatorNode.withChildren(multiplicativeToken, left, right);
		}


		return left;
	}
	private boolean startsMultiplicativeExpression(Token token) {
		return startsAtomicExpression(token);
	}

	// atomicExpression -> unaryExpression | literal | typecastExpression
	private ParseNode parseAtomicExpression() {

		if(!startsAtomicExpression(nowReading)) {
			return syntaxErrorNode("atomic expression");
		}

		ParseNode expression;
		if(startsparseArrayLiteralOrAccess(nowReading)) {
			expression = parseArrayLiteralOrAccess();
		} else if(startsTypecastExpression(nowReading)) {
			expression = parseTypecastExpression();
		} else if(startsBracketsExpression(nowReading)) {
			expression = parseBracketsExpression();
		}
		else if(startsArrayInstantiation(nowReading)) {
			expression = parseArrayInstantiation();
		}
		/*else if(startsFunctionInvocation(nowReading)) {
			return parseFunctionInvocation();
		}*/
		else if(startsLiteral(nowReading)) {
			expression = parseLiteral();
		}
		else  {
			expression = parseUnaryExpression();

		}

		return expression;
	}
	private ParseNode parseArrayExpression() {

		if(!startsExpression(nowReading)) {
			return syntaxErrorNode("expression");
		}
		if(startsComparisonExpression(nowReading)) {
			return parseComparisonExpression();
		}
		else if(startsparseArrayLiteralOrAccess(nowReading)) {
			return parseArrayLiteralOrAccess();
		}
		else if(startsArrayInstantiation(nowReading)) {
			return parseArrayInstantiation();
		}
		 else {
			return syntaxErrorNode("expression");
		}
	}

	private boolean startsHighestPrecedence(Token token) {
		return startsBracketsExpression(token) || startsLiteral(token) || startsTypecastExpression(token) || startsArrayInstantiation(token) || startsFunctionDefinition(token) ||startsparseArrayLiteralOrAccess(token) ;
	}
	private ParseNode parseHighestPrecedence(){

		if (!startsHighestPrecedence(nowReading)) {
			return syntaxErrorNode("typecast expression");
		}
		ParseNode expression;
		if(startsparseArrayLiteralOrAccess(nowReading)) {
			expression = parseArrayLiteralOrAccess();
		} else if(startsTypecastExpression(nowReading)) {
			expression = parseTypecastExpression();
		} else if(startsBracketsExpression(nowReading)) {
			expression = parseBracketsExpression();
		}
		else if(startsArrayInstantiation(nowReading)) {
			expression = parseArrayInstantiation();
		} else {
			expression = parseLiteral();
		}
		return expression;
	}

	private boolean startsAtomicExpression(Token token) {

		return  startsUnaryExpression(token) || startsBracketsExpression(token) || startsLiteral(token) || startsTypecastExpression(token) || startsArrayInstantiation(token) || startsparseArrayLiteralOrAccess(token) || startsFunctionDefinition(token);
	}

	// typecastExpression -> < type > ( expression )
	private ParseNode parseTypecastExpression() {
		//ln("Attempting to parse typecast expression: " + nowReading.getLexeme());
		if (!startsTypecastExpression(nowReading)) {
			return syntaxErrorNode("typecast expression");
		}
		Token startToken = nowReading;  // Remember the starting token for constructing the TypecastNode
		expect(Punctuator.LESSER);
		Token typeToken = nowReading;
		readToken();
		expect(Punctuator.GREATER);
		expect(Punctuator.OPEN_PARENTHESES);
		ParseNode expression = parseExpression();
		expect(Punctuator.CLOSE_PARENTHESES);

		// Create a new TypecastNode and add the expression as its child
		TypecastNode node = new TypecastNode(startToken, typeToken, expression);
		node.appendChild(expression);

		return node;
	}

	private boolean startsTypecastExpression(Token token) {
		return token.isLextant(Punctuator.LESSER);
	}

	// bracketExpression -> ( expression )
	private ParseNode parseBracketsExpression() {
		if (!startsBracketsExpression(nowReading)) {
			return syntaxErrorNode("brackets expression");
		}
		Token startToken = nowReading;  // Remember the starting token for constructing the BracketsNode
		expect(Punctuator.OPEN_PARENTHESES);
		ParseNode expression = parseExpression();//reads expression by calling readtoken
		expect(Punctuator.CLOSE_PARENTHESES);


		// Create a new BracketNode and add the expression
		BracketNode node = new BracketNode(startToken, expression);

//		PrimitiveType targetType = (PrimitiveType) expression.getType();
		node.setType(expression.getType());//potentially redundant
//
//
		node.appendChild(expression);



		return node;
	}
	private boolean startsBracketsExpression(Token token) {
		return token.isLextant(Punctuator.OPEN_PARENTHESES);
	}

	// unaryExpression			-> UNARYOP atomicExpression
	private ParseNode parseUnaryExpression() {

		if(!startsUnaryExpression(nowReading)) {
			return syntaxErrorNode("unary expression");
		}
		Token operatorToken = nowReading;
		if(operatorToken.isLextant(Keyword.LENGTH)){
			Token lengthToken = nowReading;
			readToken();
			ParseNode arrayExpression = parseArrayExpression();
			return ArrayLengthNode.withChildren(lengthToken, arrayExpression);
		}
		readToken();

		ParseNode child = parseAtomicExpression();

		return OperatorNode.withChildren(operatorToken, child);
	}
	private boolean startsUnaryExpression(Token token) {

		return token.isLextant(Punctuator.SUBTRACT) || token.isLextant(Punctuator.ADD) || token.isLextant(Punctuator.NOT) || token.isLextant(Keyword.LENGTH);
	}

	// literal -> number | identifier | booleanConstant
	private ParseNode parseLiteral() {
		if(!startsLiteral(nowReading)) {
			return syntaxErrorNode("literal");
		}
		if(startsIdentifier(nowReading)) {
			return parseIdentifier();
		}
		if(startsIntLiteral(nowReading)) {
			return parseIntLiteral();
		}
		if(startsFloatLiteral(nowReading)) {
			return parseFloatLiteral();
		}
		if(startsCharLiteral(nowReading)) {
			return parseCharLiteral();
		}

		if(startsBooleanLiteral(nowReading)) {
			return parseBooleanLiteral();
		}
		if(startsStringLiteral(nowReading)) {
			return parseStringLiteral();
		}


		return syntaxErrorNode("literal");
	}

	private boolean startsLiteral(Token token) {
		return startsIntLiteral(token) || startsFloatLiteral(token) || startsCharLiteral(token) ||
				startsIdentifier(token) || startsBooleanLiteral(token) || startsStringLiteral(token);
	}


	private ParseNode parseCharLiteral() {
		if(!startsCharLiteral(nowReading)) {
			return syntaxErrorNode("char constant");
		}
		readToken();
		return new CharacterConstantNode(previouslyRead);  // You'll need to create this Node type
	}
	// float literal (number)
	private ParseNode parseFloatLiteral() {
		if(!startsFloatLiteral(nowReading)) {
			return syntaxErrorNode("float constant");
		}
		readToken();
		return new FloatConstantNode(previouslyRead);  // You'll need to create this Node type
	}
	private boolean startsCharLiteral(Token token) {
		return token instanceof CharacterToken;
	}
	private boolean startsFloatLiteral(Token token) {
		return token instanceof FloatToken;
	}
	// number (literal)
	private ParseNode parseIntLiteral() {
		if(!startsIntLiteral(nowReading)) {
			return syntaxErrorNode("integer constant");
		}

		readToken();
		return new IntegerConstantNode(previouslyRead);
	}
	private boolean startsIntLiteral(Token token) {
		return token instanceof NumberToken;
	}

	private boolean startsStringLiteral(Token token) {
		return token instanceof StringToken;
	}

	private ParseNode parseStringLiteral() {
		if(!startsStringLiteral(nowReading)) {
			return syntaxErrorNode("string constant");
		}
		readToken();
		return new StringConstantNode(previouslyRead);  // You'll need to create this Node type
	}


	// identifier (terminal)
	private ParseNode parseIdentifier() {
		if(!startsIdentifier(nowReading)) {
			return syntaxErrorNode("identifier");
		}
		//Token token = nowReading;
		readToken();
		if (nowReading.isLextant(Punctuator.OPEN_PARENTHESES) && !startsType(scanner.peekToken(0))){
			return parseFunctionInvocation(new IdentifierNode(previouslyRead));
		}
		return new IdentifierNode(previouslyRead);
	}
	private boolean startsIdentifier(Token token) {
		return token instanceof IdentifierToken;
	}

	// boolean literal
	private ParseNode parseBooleanLiteral() {
		if(!startsBooleanLiteral(nowReading)) {
			return syntaxErrorNode("boolean constant");
		}
		readToken();
		return new BooleanConstantNode(previouslyRead);
	}
	private boolean startsBooleanLiteral(Token token) {
		return token.isLextant(Keyword.TRUE, Keyword.FALSE);
	}

	private void readToken() {
		previouslyRead = nowReading;
		nowReading = scanner.next();
	}

	// if the current token is one of the given lextants, read the next token.
	// otherwise, give a syntax error and read next token (to avoid endless looping).
	private void expect(Lextant ...lextants ) {
		if(!nowReading.isLextant(lextants)) {
			syntaxError(nowReading, "expecting " + Arrays.toString(lextants));
		}
		readToken();
	}
	private ErrorNode syntaxErrorNode(String expectedSymbol) {
		syntaxError(nowReading, "expecting " + expectedSymbol);
		ErrorNode errorNode = new ErrorNode(nowReading);
		readToken();
		return errorNode;
	}
	private void syntaxError(Token token, String errorDescription) {
		String message = "" + token.getLocation() + " " + errorDescription;
		error(message);
	}
	private void error(String message) {
		TanLogger log = TanLogger.getLogger("compiler.Parser");
		log.severe("syntax error: " + message);
	}
}

