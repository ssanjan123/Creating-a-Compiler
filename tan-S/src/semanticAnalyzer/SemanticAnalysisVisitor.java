package semanticAnalyzer;

import java.util.Arrays;
import java.util.List;

import lexicalAnalyzer.Lextant;
import logging.TanLogger;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import parseTree.nodeTypes.*;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import symbolTable.Binding;
import symbolTable.Scope;
import tokens.LextantToken;
import tokens.Token;

class SemanticAnalysisVisitor extends ParseNodeVisitor.Default {
	@Override
	public void visitLeave(ParseNode node) {
		throw new RuntimeException("Node class unimplemented in SemanticAnalysisVisitor: " + node.getClass());
	}
	
	///////////////////////////////////////////////////////////////////////////
	// constructs larger than statements
	@Override
	public void visitEnter(ProgramNode node) {
		enterProgramScope(node);
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
	@SuppressWarnings("unused")
	private void enterSubscope(ParseNode node) {
		Scope baseScope = node.getLocalScope();
		Scope scope = baseScope.createSubscope();
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
		if(node.child(0) instanceof ErrorNode) {
			node.setType(PrimitiveType.ERROR);
			return;
		}

		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);

		Type declarationType = initializer.getType();
		node.setType(declarationType);

		identifier.setType(declarationType);

		if(identifier.getLocalScope().containsBinding(identifier.getToken().getLexeme())) {
			logError("variable \"" + identifier.getToken().getLexeme() + "\" already defined at " + identifier.getToken().getLocation());
		}
		else {
			addBinding(identifier, declarationType);
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
		FunctionSignature signature = FunctionSignature.signatureOf(operator, childTypes);

		if(signature.accepts(childTypes)) {
			node.setType(signature.resultType());
		}
		else {
			typeCheckError(node, childTypes);
			node.setType(PrimitiveType.ERROR);
		}
	}

	private Lextant operatorFor(OperatorNode node) {
		LextantToken token = (LextantToken) node.getToken();
		return token.getLextant();
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
	public void visit(NewlineNode node) {
	}
	@Override
	public void visit(SpaceNode node) {
	}
	///////////////////////////////////////////////////////////////////////////
	// IdentifierNodes, with helper methods
	@Override
	public void visit(IdentifierNode node) {
		if(!isBeingDeclared(node)) {		
			Binding binding = node.findVariableBinding();
			
			node.setType(binding.getType());
			node.setBinding(binding);
		}
		// else parent DeclarationNode does the processing.
	}
	@Override
	public void visitLeave(ConstDeclarationNode node) {
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

		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode expression = node.child(1);

		if(identifier.getType() != expression.getType()) {
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
	}

	private void addBinding(IdentifierNode identifierNode, Type type) {
		Scope scope = identifierNode.getLocalScope();
		Binding binding;

		if (identifierNode.getParent() instanceof ConstDeclarationNode) {
			binding = scope.createBinding(identifierNode, type, false);
		} else if (identifierNode.getParent() instanceof VarDeclarationNode) {
			binding = scope.createBinding(identifierNode, type, true);
		} else {
			throw new RuntimeException("Unexpected parent node type");
		}

		identifierNode.setBinding(binding);
	}


	private boolean isBeingDeclared(IdentifierNode node) {
		ParseNode parent = node.getParent();
		return (parent instanceof DeclarationNode) && (node == parent.child(0));
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
}