package parser;

import java.util.Arrays;

import logging.TanLogger;
import parseTree.*;
import parseTree.nodeTypes.*;
import parseTree.nodeTypes.IfStatementNode;
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

	////////////////////////////////////////////////////////////
	// "program" is the start symbol S
	// S -> MAIN mainBlock

	// S -> main blockStatement
	private ParseNode parseProgram() {
		if(!startsProgram(nowReading)) {
			return syntaxErrorNode("program");
		}
		ParseNode program = new ProgramNode(nowReading);

		expect(Keyword.MAIN);
		ParseNode mainBlock = parseBlockStatement();
		program.appendChild(mainBlock);

		if(!(nowReading instanceof NullToken)) {
			return syntaxErrorNode("end of program");
		}

		return program;
	}
	private boolean startsProgram(Token token) {
		return token.isLextant(Keyword.MAIN);
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
		if (startsPrintStatement(nowReading)) {
			return parsePrintStatement();
		}
		if (startsAssignmentStatement(nowReading)) {
			return parseAssignmentStatement();
		}
		if (startsBlockStatement(nowReading)) {
			return parseBlockStatement();
		}
		if (startsIfStatement(nowReading)) {
			return parseIfStatement();
		}
		if (startsWhileStatement(nowReading)) {
			return parseWhileStatement();
		}
		return syntaxErrorNode("statement");
	}

	private boolean startsStatement(Token token) {
		return startsPrintStatement(token) ||
				startsDeclaration(token) ||
				startsAssignmentStatement(token) ||
				startsBlockStatement(token) ||
				startsIfStatement(token) ||
				startsWhileStatement(token);
	}


	// assignmentStmt -> identifier := expression TERMINATOR
	private ParseNode parseAssignmentStatement() {
		if(!startsAssignmentStatement(nowReading)) {
			return syntaxErrorNode("assignment statement");
		}
		ParseNode identifier = parseIdentifier();
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

	private ParseNode parseWhileStatement(){
		if(!startsWhileStatement(nowReading)) {
			return syntaxErrorNode("While");
		}
		//we don't read token and we dont set anything equal to token

		ParseNode WhileNode = new WhileStatementNode(nowReading);
		expect(Keyword.WHILE);

		ParseNode expression = parseBracketsExpression();
		WhileNode.appendChild(expression);//first child is boolean constant node
		for (ParseNode node : expression.getChildren()){
			System.out.println(node);
		}

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
//		for (ParseNode node : expression.getChildren()){
//			System.out.println(node);
//		}

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
	private ParseNode parseExpression() {
		//System.out.println("Attempting to parse expression: " + nowReading.getLexeme());
		if(!startsExpression(nowReading)) {
			return syntaxErrorNode("expression");
		}
		//return parseComparisonExpression();
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

		if(startsTypecastExpression(nowReading)) {
			return parseTypecastExpression();
		}if(startsBracketsExpression(nowReading)) {
			return parseBracketsExpression();
		}
		if(startsUnaryExpression(nowReading)) {
			return parseUnaryExpression();
		}
		return parseLiteral();
	}

	private boolean startsAtomicExpression(Token token) {
		return startsLiteral(token) || startsUnaryExpression(token) || startsTypecastExpression(token) || startsBracketsExpression(token);
	}

	// typecastExpression -> < type > ( expression )
	private ParseNode parseTypecastExpression() {
		//System.out.println("Attempting to parse typecast expression: " + nowReading.getLexeme());
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
		readToken();
		ParseNode child = parseAtomicExpression();
		
		return OperatorNode.withChildren(operatorToken, child);
	}
	private boolean startsUnaryExpression(Token token) {
		return token.isLextant(Punctuator.SUBTRACT) || token.isLextant(Punctuator.ADD) || token.isLextant(Punctuator.NOT);
	}

	// literal -> number | identifier | booleanConstant
	private ParseNode parseLiteral() {
		if(!startsLiteral(nowReading)) {
			return syntaxErrorNode("literal");
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
		if(startsIdentifier(nowReading)) {
			return parseIdentifier();
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
		readToken();
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

