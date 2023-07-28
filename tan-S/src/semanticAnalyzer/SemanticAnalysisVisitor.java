package semanticAnalyzer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import asmCodeGenerator.runtime.RunTime;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import logging.TanLogger;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import parseTree.nodeTypes.TypecastNode;
import parseTree.nodeTypes.*;
import parseTree.nodeTypes.IfStatementNode;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.signatures.FunctionSignatures;
import semanticAnalyzer.types.ArrayType;
import semanticAnalyzer.signatures.PromotedSignature;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import symbolTable.*;
import tokens.LextantToken;
import tokens.Token;

import javax.lang.model.type.ErrorType;

class SemanticAnalysisVisitor extends ParseNodeVisitor.Default {

	private final int MAX_NUM_PROMOTIONS = 2;

	@Override
	public void visitLeave(ParseNode node) {
		if(node instanceof BlockStatementNode)
			return;
		//System.out.println("Unhandled ParseNode class: " + node.getClass());  // Debug message
		throw new RuntimeException("Node class unimplemented in SemanticAnalysisVisitor: " + node.getClass());
	}

	///////////////////////////////////////////////////////////////////////////
	// constructs larger than statements
	@Override
	public void visitEnter(BlockStatementNode node) {
		if(node.getParent() instanceof ProgramNode) {
			Scope scope = Scope.createLocalProgramScope();
			node.setScope(scope);
		}
		else if(node.getParent() instanceof FunctionDefinitionNode) {
			// If the block statement is a function body, enter a procedure scope
			//System.out.print("vE Block");
			enterProcedureScope(node);
		} else {
			//System.out.print("vE Block");
			// Otherwise, enter a subscope
			enterSubscope(node);
		}
	}

	@Override
	public void visitLeave(BlockStatementNode node) {
		//System.out.print("vL Block ");
		//System.out.print(node.getParent());
		leaveScope(node);


	}
	@Override
	public void visitEnter(ProgramNode node) {
		node.rearrangeChildren();
		enterProgramScope(node);
		for(ParseNode child: node.getChildren()) {
			if(child instanceof ConstDeclarationNode && child.getToken().isLextant(Keyword.SUBR)) {
				ConstDeclarationNode func = (ConstDeclarationNode) child;
				ParseNode typeNode = func.child(1).child(0);
				IdentifierNode identifier = (IdentifierNode) func.child(0);
				Type funcType = typeNode.getType();
				addBinding(identifier, funcType);
				//System.out.println("\ntype: " + identifier );
			}
		}
	}
	public void visitLeave(ProgramNode node) {


		leaveScope(node);
	}
	public void visitEnter(MainBlockNode node) {
	}
	public void visitLeave(MainBlockNode node) {
	}
	
	
	///////////////////////////////////////////////////////////////////////////
	// helper methods for scoping.
	private void enterProgramScope(ParseNode node) {
		Scope scope = Scope.createProgramScope();
		node.setScope(scope);
	}
	//@SuppressWarnings("unused")
	private void enterSubscope(ParseNode node) {
		Scope baseScope = node.getLocalScope();
		Scope scope = baseScope.createSubscope();
		node.setScope(scope);
	}
	private void enterParameterScope(ParseNode node) {
		Scope baseScope = node.getLocalScope();
		Scope scope = baseScope.createParameterScope();
		node.setScope(scope);
	}

	private void enterProcedureScope(ParseNode node) {
		Scope baseScope = node.getLocalScope();
		Scope scope = baseScope.createProcedureScope();
		node.setScope(scope);
	}


	private void leaveScope(ParseNode node) {
		node.getScope().leave();
	}
	
	///////////////////////////////////////////////////////////////////////////
	// statements and declarations
	@Override
	public void visitLeave(PrintStatementNode node) {
	}
	@Override
	public void visitLeave(DeclarationNode node) {
		//System.out.print("weelll");
		if(node.child(0) instanceof ErrorNode) {

			node.setType(PrimitiveType.ERROR);
			return;
		}

		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);

		Type declarationType = initializer.getType();
		node.setType(declarationType);

		identifier.setType(declarationType);
		if(	! node.getToken().isLextant(Keyword.SUBR)	) {
			//addBinding(identifier, declarationType, node.getIsStatic(), node.getIsConstant());


			if (identifier.getLocalScope().containsBinding(identifier.getToken().getLexeme())) {
				logError("variable \"" + identifier.getToken().getLexeme() + "\" already defined at " + identifier.getToken().getLocation());
			} else {
				if (declarationType != identifier.getType()) {
					logError("Type mismatch error at " + node.getToken().getLocation());
					node.setType(PrimitiveType.ERROR);
					return;
				}
				addBinding(identifier, declarationType);
			}
		}
	}


	///////////////////////////////////////////////////////////////////////////
	// expressions
	@Override
	public void visitLeave(OperatorNode node) {
		List<Type> childTypes;
		if(node.nChildren() == 1) {
			ParseNode child = node.child(0);
			childTypes = Arrays.asList(child.getType());
		}
		else {
			assert node.nChildren() == 2;
			ParseNode left  = node.child(0);
			ParseNode right = node.child(1);

			childTypes = Arrays.asList(left.getType(), right.getType());
		}

		Lextant operator = operatorFor(node);

		//old way
		//FunctionSignature signature = FunctionSignatures.signature(operator, childTypes);
		//node.setSignature(signature);



		//new way
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		List<PromotedSignature> promotedSignatures = PromotedSignature.promotedSignatures(signatures, childTypes);
		//= functionSignatures.checkAgainst
		List<List<PromotedSignature>> byNumPromotions = new ArrayList<>();
		for (int i = 0; i <= MAX_NUM_PROMOTIONS; i++){
			byNumPromotions.add(new ArrayList<PromotedSignature>());
		}

		for(PromotedSignature promotedSignature : promotedSignatures){
			byNumPromotions.get(promotedSignature.numPromotions()).add(promotedSignature);
		}


		PromotedSignature promotedSignature = selectPromotedSignature(byNumPromotions);
		for (int i = 0; i <= childTypes.size(); i++){
			if(!byNumPromotions.get(i).isEmpty()){
				promotedSignatures = byNumPromotions.get(i);
			}
			//promotedSignatures = byNumPromotions.get(0);
		}

		if (promotedSignatures.isEmpty()){
			typeCheckError(node, childTypes);
			node.setType(PrimitiveType.ERROR);
		}else if (promotedSignatures.size()>1){
			multipleInterpretationsError();
			node.setType(PrimitiveType.ERROR);
		}else{
			//PromotedSignature tempSignature = promotedSignatures.get(0);
			PromotedSignature tempSignature = promotedSignature;
			node.setType(tempSignature.resultType().concreteType());//is now concrete dont have to add.concreteType
			node.setPromotedSignature(tempSignature);
		}


	}

	private Lextant operatorFor(OperatorNode node) {
		LextantToken token = (LextantToken) node.getToken();
		return token.getLextant();
	}

	private PromotedSignature selectPromotedSignature(List<List<PromotedSignature>> byNumPromotions){
		for (int i = 0; i <= MAX_NUM_PROMOTIONS; i++){//when i = 0 it always hits  case 2
			switch (byNumPromotions.get(i).size()){
				case 0:
					//System.out.println("0");
					break;
				case 1:
					//System.out.println("1");
					return byNumPromotions.get(i).get(0);
				default:
				case 2: multipleInterpretationsError();
				//System.out.println("2");
				return PromotedSignature.nullInstance();
			}
		}
		//typeCheckError(node);
		return PromotedSignature.nullInstance();
	}


	///////////////////////////////////////////////////////////////////////////
	// simple leaf nodes
	@Override
	public void visit(BooleanConstantNode node) {
		node.setType(PrimitiveType.BOOLEAN);
	}
	@Override
	public void visit(ErrorNode node) {

		node.setType(PrimitiveType.ERROR);
	}
	@Override
	public void visit(IntegerConstantNode node) {
		node.setType(PrimitiveType.INTEGER);
	}
	@Override
	public void visit(FloatConstantNode node) {
		node.setType(PrimitiveType.FLOAT);
	}
	@Override
	public void visit(CharacterConstantNode node) {
		node.setType(PrimitiveType.CHARACTER);
	}
	@Override
	public void visit(StringConstantNode node) {
		node.setType(PrimitiveType.STRING);
	}

	@Override
	public void visit(NewlineNode node) {
	}
	@Override
	public void visit(SpaceNode node) {
	}


	///////////////////////////////////////////////////////////////////////////
	// Arrays
	@Override
	public void visitLeave(PrimitiveTypeNode node) {
		node.setType(node.getType());
	}

	@Override
	public void visitLeave(ArrayTypeNode node) {
		ParseNode subtypeNode = node.child(0);
		Type subtype = subtypeNode.getType();
		if (subtype == PrimitiveType.ERROR) {
			node.setType(PrimitiveType.ERROR);
			return;
		}
		node.setType(new ArrayType(subtype));
	}

	@Override
	public void visitLeave(ArrayInstantiationNode node) {
		ParseNode sizeExpressionNode = node.child(1);
		Type sizeExpressionType = sizeExpressionNode.getType();
		if (sizeExpressionType != PrimitiveType.INTEGER) {
			logError("Size expression for array instantiation must be an integer at " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		ParseNode arrayTypeNode = node.child(0);
		Type arrayType = arrayTypeNode.getType();
		if (arrayType instanceof ErrorType) {
			node.setType(PrimitiveType.ERROR);
			return;
		}

		node.setType(arrayType instanceof ErrorType ? PrimitiveType.ERROR : arrayType);
	}
	@Override
	public void visitLeave(ArrayLengthNode node) {
		ParseNode arrayExpressionNode = node.child(0); // Assuming the array expression is the first child
		Type arrayExpressionType = arrayExpressionNode.getType();

		if (!(arrayExpressionType instanceof ArrayType)) {
			logError("Expression is not an array at " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		node.setType(PrimitiveType.INTEGER);
	}


	@Override
	public void visitLeave(ArrayAccessNode node) {
		ParseNode indexExpressionNode = node.child(1);
		Type indexExpressionType = indexExpressionNode.getType();
		if (indexExpressionType != PrimitiveType.INTEGER) {
			logError("Array index must be an integer at " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		ParseNode arrayExpressionNode = node.child(0);
		Type arrayExpressionType = arrayExpressionNode.getType();
		if (!(arrayExpressionType instanceof ArrayType)) {
			logError("Expression is not an array at " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		node.setType(arrayExpressionType instanceof ArrayType ? ((ArrayType) arrayExpressionType).getSubtype() : PrimitiveType.ERROR);
	}
	@Override
	public void visitLeave(ArrayLiteralNode node) {
		if(node.nChildren() == 0) {
			logError("Empty array literal at " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		Type firstChildType = node.child(0).getType();

		if(firstChildType instanceof ArrayType || firstChildType instanceof ArrayInstantiationNode) {
			for (ParseNode child : node.getChildren()) {
				if (child instanceof ArrayLiteralNode) {
					visitLeave((ArrayLiteralNode) child);
					if (!child.getType().equals(firstChildType)) {
						logError("All array elements in array literal must have the same type at " + node.getToken().getLocation());
						node.setType(PrimitiveType.ERROR);
						return;
					}
				} else if (!(child.getType().equals(firstChildType))) {
					logError("All array elements in array literal must have the same type at " + node.getToken().getLocation());
					node.setType(PrimitiveType.ERROR);
					return;
				}
			}
		} else {
			for (ParseNode child : node.getChildren()) {
				if (!(child.getType().equals(firstChildType))) {
					logError("All elements in array literal must have the same type at " + node.getToken().getLocation());
					node.setType(PrimitiveType.ERROR);
					return;
				}
			}
		}

		// If all elements have the same type, the type of the array literal is an array of that type.
		node.setType(new ArrayType(firstChildType));
	}


	///////////////////////////////////////////////////////////////////////////
	// Type Casting


	@Override
	public void visitLeave(TypecastNode node) {
		//System.out.println("Entering visitLeave(TypecastNode node)");  // Start debug message
		// get the type to cast to
		PrimitiveType targetType = node.getType();

		// get the expression
		ParseNode expression = node.getExpressionNode();
		PrimitiveType sourceType = (PrimitiveType) expression.getType();

		// check if the cast is valid
		if (!isValidCast(sourceType, targetType)) {
			logError("Invalid cast from " + sourceType + " to " + targetType + " at " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		// if the cast is valid, the result of the expression is the target type
		node.setType(targetType);



		//System.out.println("Exiting visitLeave(TypecastNode node)");  // End debug message
	}



	// checks if a cast from the source type to the target type is valid
	private boolean isValidCast(PrimitiveType sourceType, PrimitiveType targetType) {
		if (sourceType == targetType) {
			// any type can be cast to itself
			return true;
		}

		switch (sourceType) {
			case BOOLEAN:
				// booleans cannot be cast to any other type
				return false;
			case CHARACTER:
				// characters can be cast to integers
				return targetType == PrimitiveType.INTEGER;
			case INTEGER:
				// integers can be cast to characters and floats
				return targetType == PrimitiveType.CHARACTER || targetType == PrimitiveType.FLOAT;
			case FLOAT:
				// floats can be cast to integers
				return targetType == PrimitiveType.INTEGER;
			default:
				// by default, no cast is allowed
				return false;
		}
	}

	///////////////////////////////////////////////////////////////////////////
	// IdentifierNodes, with helper methods
	@Override
	public void visit(IdentifierNode node) {
		if(!isBeingDeclared(node)) {
			//System.out.print("Visit Identifier ");
			Binding binding = node.findVariableBinding();
			node.setType(binding.getType());
			node.setBinding(binding);
			// If the binding is still null after searching all scopes, the identifier is not defined
			if (binding == null) {
				logError("Identifier " + node.getToken().getLexeme() + " not defined");
			}

		}

		// else parent DeclarationNode does the processing.
	}


	@Override
	public void visitLeave(ConstDeclarationNode node) {
		//System.out.print("HIIII");

		if(node.child(0) instanceof ErrorNode) {

			node.setType(PrimitiveType.ERROR);
			return;
		}

		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);

		Type declarationType = initializer.getType();
		node.setType(declarationType);

		identifier.setType(declarationType);
		if(	! node.getToken().isLextant(Keyword.SUBR)	) {
			addBinding(identifier, declarationType);
		}

	}
	@Override
	public void visitLeave(VarDeclarationNode node) {
		if(node.child(0) instanceof ErrorNode) {
			node.setType(PrimitiveType.ERROR);
			return;
		}

		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);

		Type declarationType = initializer.getType();
		node.setType(declarationType);

		identifier.setType(declarationType);
		addBinding(identifier, declarationType);
	}
	@Override
	public void visitLeave(AssignmentNode node) {
		if(node.child(0) instanceof ErrorNode) {
			node.setType(PrimitiveType.ERROR);
			return;
		}

		ParseNode child = node.child(0);
		ParseNode expression = node.child(1);

		if(child instanceof IdentifierNode) {
			IdentifierNode identifier = (IdentifierNode) child;

			if(!identifier.getType().equals(expression.getType())) {
				logError("Type mismatch error at " + node.getToken().getLocation());
				node.setType(PrimitiveType.ERROR);
				return;
			}

			if(!identifier.getBinding().getMutability()) {
				logError("Cannot modify a constant variable \"" + identifier.getToken().getLexeme() + "\" at " + node.getToken().getLocation());
				node.setType(PrimitiveType.ERROR);
				return;
			}

			node.setType(identifier.getType());
		} else if (child instanceof ArrayAccessNode) {
			ParseNode indexExpressionNode = node.child(1);
			Type indexExpressionType = indexExpressionNode.getType();
			if (indexExpressionType != PrimitiveType.INTEGER) {
				logError("Array index must be an integer at " + node.getToken().getLocation());
				node.setType(PrimitiveType.ERROR);

			}else {
				// Assuming child.getType() returns the type of the array base.
				// Adjust based on your actual implementation.
				node.setType(child.getType());
			}

		}
	}




	///////////////////////////////////////////////////////////////////////////
	// Function related
	@Override
	public void visitEnter(FunctionDefinitionNode node) {
		// Enter the parameter scope
		enterParameterScope(node);
	}



	@Override
	public void visitLeave(FunctionDefinitionNode node) {
		//System.out.print(node.getScope().getSymbolTable());
		// Leave the parameter scope
		//System.out.print("leave func");
		leaveScope(node);
	}
	@Override
	public void visitLeave(ParameterListNode node) {
	/*	for(ParseNode child : node.getChildren()) {
			child.accept(this);
		}*/

	}

	@Override
	public void visitEnter(ParameterSpecificationNode node) {
		//System.out.print("Visit PAram ");
		Type type = node.child(0).getType();
		IdentifierNode identifierNode = (IdentifierNode) node.child(1);
		identifierNode.setType(type);
		//System.out.print("ID " + identifierNode);
		addBinding(identifierNode,type);
	}
	@Override
	public void visitEnter(ReturnStatementNode node) {

		node.child(0).accept(this);
	}

	@Override
	public void visitLeave(ReturnStatementNode node) {
		// Get the type of the returned expression
		Type returnType = node.child(0).getType();
		// Get the function that the return statement is inside
		FunctionDefinitionNode functionNode = getEnclosingFunction(node);
		if (functionNode == null) {
			logError("Return statement is not inside a function");
			node.setType(PrimitiveType.ERROR);
			return;
		}

		// Get the declared return type of the function
		Type functionReturnType = functionNode.child(0).getType();

		// Check that the type of the returned expression matches the return type of the function
		if (!returnType.equals(functionReturnType)) {
			logError("Return type mismatch: expected " + functionReturnType + ", got " + returnType);
			node.setType(PrimitiveType.ERROR);
			return;
		}
		else if(returnType.equals(functionReturnType)) {
			node.setType(returnType);
			node.setFunctionReturnLabel(functionNode.getReturnCodeLabel());
		}
		//System.out.print(returnType);
		node.setType(returnType);
	}

	private FunctionDefinitionNode getEnclosingFunction(ParseNode node) {
		// Walk up the parse tree until we find a FunctionDefinitionNode
		while (node != null && !(node instanceof FunctionDefinitionNode)) {
			node = node.getParent();
		}
		return (FunctionDefinitionNode) node;
	}



	@Override
	public void visitLeave(FunctionInvocationNode node) {
		// The first child is the function name, which should be an IdentifierNode
		IdentifierNode functionNameNode = (IdentifierNode) node.child(0);
		String functionName = functionNameNode.getToken().getLexeme();


		// Look up the function in the symbol table to get its type
		// This requires a symbol table or some form of scope management
		Binding functionBinding = functionNameNode.findVariableBinding();
		//System.out.print(functionBinding);
		if(functionBinding == Binding.nullInstance()) {
			// The function was not declared
			logError("Function " + functionName + " was not declared");
			node.setType(PrimitiveType.ERROR);
			return;
		}
		Type functionType = functionBinding.getType();
		node.setType(functionType);
	}




/*
	@Override
	public void visitLeave(CallStatementNode node) {
		ParseNode functionInvocationNode = node.child(0);

		if (!(functionInvocationNode.getType() == PrimitiveType.VOID)) {
			logError("The call statement can only be used with void functions");
			node.setType(PrimitiveType.ERROR);
			return;
		}

		node.setType(PrimitiveType.VOID);
	}
*/



	@Override
	public void visitLeave(BracketNode node) {
		//System.out.println("Entering visitLeave(Bracket node)");  // Start debug message
		node.setType(node.child(0).getType());
	}


	@Override
	public void visitLeave(IfStatementNode node) {

		ParseNode expression = node.child(0);
		//this version
		if (expression.getType() == PrimitiveType.FLOAT){//what happens when this is a longer expression
			logError("While statement expression not boolean " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		node.setType(PrimitiveType.BOOLEAN);

		//ParseNode ifnode = node.child(1);


		//get return of statement 1
		//currently we now that each child has been visited
	}

	@Override
	public void visitLeave(WhileStatementNode node){
		ParseNode expression = node.child(0);
		//this version
		if (expression.getType() == PrimitiveType.FLOAT){//what happens when this is a longer expression
			logError("While statement expression not boolean " + node.getToken().getLocation());
			node.setType(PrimitiveType.ERROR);
			return;
		}

		node.setType(PrimitiveType.BOOLEAN);
	}

	private void addBinding(IdentifierNode identifierNode, Type type) {
		Scope scope = identifierNode.getLocalScope();
		Binding binding;

		if (identifierNode.getParent() instanceof ConstDeclarationNode || identifierNode.getParent() instanceof ParameterSpecificationNode) {
				//if (identifierNode.getParent() instanceof ParameterSpecificationNode){System.out.print("add binding " + identifierNode);}
			binding = scope.createBinding(identifierNode, type, false);
			//System.out.print("HIIIIIIIII " + scope.getSymbolTable().hashCode());
		} else if (identifierNode.getParent() instanceof VarDeclarationNode) {
			binding = scope.createBinding(identifierNode, type, true);
		} else {
			throw new RuntimeException("Unexpected parent node type");
		}

		identifierNode.setBinding(binding);
	}


	private boolean isBeingDeclared(IdentifierNode node) {
		ParseNode parent = node.getParent();
		return (parent instanceof DeclarationNode || parent instanceof ParameterSpecificationNode)
				&& (node == parent.child(0));
	}

	
	///////////////////////////////////////////////////////////////////////////
	// error logging/printing

	private void typeCheckError(ParseNode node, List<Type> operandTypes) {
		Token token = node.getToken();
		
		logError("operator " + token.getLexeme() + " not defined for types " 
				 + operandTypes  + " at " + token.getLocation());	
	}
	private void logError(String message) {
		TanLogger log = TanLogger.getLogger("compiler.semanticAnalyzer");
		log.severe(message);
	}

	private void multipleInterpretationsError() {
		TanLogger log = TanLogger.getLogger("Multiple interpretations of operator possible");
		log.severe("multiple interpretations");
	}
}