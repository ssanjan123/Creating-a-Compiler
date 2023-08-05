package parseTree;

import parseTree.nodeTypes.*;
import parseTree.nodeTypes.IfStatementNode;

// Visitor pattern with pre- and post-order visits
public interface ParseNodeVisitor {
	
	// non-leaf nodes: visitEnter and visitLeave
	void visitEnter(OperatorNode node);
	void visitLeave(OperatorNode node);
	int getActualValue(ParseNode node);
	void visitEnter(MainBlockNode node);
	void visitLeave(MainBlockNode node);
	void visitEnter(BlockStatementNode node);
	void visitLeave(BlockStatementNode node);
	void visitEnter(DeclarationNode node);
	void visitLeave(DeclarationNode node);
	void visitLeave(ArrayTypeNode  node);
	void visitLeave(ArrayInstantiationNode   node);
	void visitLeave(ArrayLengthNode   node);
	void visitLeave(ArrayAccessNode   node);
	void visitLeave(ArrayLiteralNode   node);
	void visitLeave(PrimitiveTypeNode   node);

	void visitEnter(ParseNode node);
	void visitLeave(ParseNode node);
	
	void visitEnter(PrintStatementNode node);
	void visitLeave(PrintStatementNode node);
	
	void visitEnter(ProgramNode node);
	void visitLeave(ProgramNode node);


	// leaf nodes: visitLeaf only
	void visit(BooleanConstantNode node);
	void visit(ErrorNode node);
	void visit(IdentifierNode node);
	void visit(IntegerConstantNode node);
	void visit(NewlineNode node);
	void visit(SpaceNode node);
	void visit(CharacterConstantNode node);
	void visit(StringConstantNode node);
	void visit(ArrayTypeNode  node);
	void visit(PrimitiveTypeNode  node);
	void visit(ArrayInstantiationNode  node);
	void visit(ArrayLengthNode  node);
	void visit(ArrayAccessNode   node);
	void visit(TabNode node);
	void visit(FloatConstantNode node);
	//void visit(BreakNode node);
	//void visit(ContinueNode node);

	void visitEnter(TypecastNode node);
	void visitLeave(TypecastNode node);
	void visitEnter(ConstDeclarationNode node);
	void visitLeave(ConstDeclarationNode node);

	void visitEnter(VarDeclarationNode node);
	void visitLeave(VarDeclarationNode node);

	void visitEnter(AssignmentNode node);
	void visitLeave(AssignmentNode node);
	void visitEnter(FunctionDefinitionNode node);
	void visitLeave(FunctionDefinitionNode node);
	void visitLeave(ParameterSpecificationNode node);
	void visitEnter(ParameterSpecificationNode node);
	void visitLeave(ParameterListNode node);
	void visitEnter(ReturnStatementNode node);
	void visitLeave(ReturnStatementNode node);
	public void visitLeave(FunctionInvocationNode node);
	public void visitEnter(CallNode node);
	public void visitLeave(CallNode node);
	public void visitLeave(ArgumentListNode node);

	void visitEnter(BracketNode node);
	void visitLeave(BracketNode node);

	void visitEnter(IfStatementNode node);
	void visitLeave(IfStatementNode node);
	void visitEnter(WhileStatementNode node);
	void visitLeave(WhileStatementNode node);
	void visitEnter(ForStatementNode node);
	void visitLeave(ForStatementNode node);

	void visitEnter(BreakNode node);
	void visitLeave(BreakNode node);
	void visitEnter(ContinueNode node);
	void visitLeave(ContinueNode node);

	//void visit(BreakNode );

	public static class Default implements ParseNodeVisitor
	{
		public int getActualValueI(ParseNode node) {
			if (node instanceof IntegerConstantNode) {
				IntegerConstantNode constantNode = (IntegerConstantNode) node;
				return constantNode.getValue();
			} else if (node instanceof FloatConstantNode) {
				FloatConstantNode constantNode = (FloatConstantNode) node;
				return (int) constantNode.getValue();
			} else if (node instanceof BooleanConstantNode) {
				BooleanConstantNode constantNode = (BooleanConstantNode) node;
				return constantNode.getValue() ? 1 : 0;
			}else if (node instanceof CharacterConstantNode) {
				CharacterConstantNode constantNode = (CharacterConstantNode) node;
				return (char) constantNode.getValue();
			}
			else {
				// Handle other node types if necessary
				return 0; // Default value
			}
		}
		public float getActualValueF(ParseNode node) {
			if (node instanceof IntegerConstantNode) {
				IntegerConstantNode constantNode = (IntegerConstantNode) node;
				return constantNode.getValue();
			} else if (node instanceof FloatConstantNode) {
				FloatConstantNode constantNode = (FloatConstantNode) node;
				return (float) constantNode.getValue();
			} else if (node instanceof BooleanConstantNode) {
				BooleanConstantNode constantNode = (BooleanConstantNode) node;
				return constantNode.getValue() ? 1 : 0;
			} else {
				// Handle other node types if necessary
				return 0; // Default value
			}
		}

		public void defaultVisit(ParseNode node) {	}
		public void defaultVisitEnter(ParseNode node) {
			defaultVisit(node);
		}
		public void defaultVisitLeave(ParseNode node) {
			defaultVisit(node);
		}		
		public void defaultVisitForLeaf(ParseNode node) {
			defaultVisit(node);
		}
		
		public void visitEnter(OperatorNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(OperatorNode node) {
			defaultVisitLeave(node);
		}

		@Override
		public int getActualValue(ParseNode node) {
			return 0;
		}

		public void visitEnter(DeclarationNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(DeclarationNode node) {
			defaultVisitLeave(node);
		}					
		public void visitEnter(MainBlockNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(MainBlockNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(BlockStatementNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(BlockStatementNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(ParseNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(ParseNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(PrintStatementNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(PrintStatementNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(ProgramNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(ProgramNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(ConstDeclarationNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(ConstDeclarationNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(TypecastNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(TypecastNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(VarDeclarationNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(VarDeclarationNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(FunctionDefinitionNode  node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(FunctionDefinitionNode  node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ParameterSpecificationNode  node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(ParameterSpecificationNode  node) {
			defaultVisitLeave(node);
		}

		public void visitLeave(ParameterListNode  node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(ReturnStatementNode  node) {
			defaultVisitLeave(node);
		}

		public void visitLeave(ReturnStatementNode  node) {
			defaultVisitLeave(node);
		}

		public void visitLeave(FunctionInvocationNode node) {
			defaultVisitLeave(node);
		}
		public void visitEnter(CallNode node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(CallNode node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ArgumentListNode node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ArrayTypeNode  node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ArrayInstantiationNode node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ArrayLengthNode node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ArrayAccessNode  node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(ArrayLiteralNode   node) {
			defaultVisitLeave(node);
		}
		public void visitLeave(PrimitiveTypeNode   node) {
			defaultVisitLeave(node);
		}


		public void visitEnter(AssignmentNode node) {
			defaultVisitEnter(node);
		}
		public void visitLeave(AssignmentNode node) {
			defaultVisitLeave(node);
		}

		public void visit(BooleanConstantNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(ErrorNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(IdentifierNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(CharacterConstantNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(StringConstantNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(ArrayTypeNode  node) {
			defaultVisitForLeaf(node);
		}
		public void visit(PrimitiveTypeNode   node) {
			defaultVisitForLeaf(node);
		}
		public void visit(ArrayInstantiationNode    node) {
			defaultVisitForLeaf(node);
		}
		public void visit(ArrayLengthNode    node) {
			defaultVisitForLeaf(node);
		}
		public void visit(ArrayAccessNode     node) {
			defaultVisitForLeaf(node);
		}

		public void visit(IntegerConstantNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(FloatConstantNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(NewlineNode node) {
			defaultVisitForLeaf(node);
		}	
		public void visit(SpaceNode node) {
			defaultVisitForLeaf(node);
		}
		public void visit(TabNode node){
			defaultVisitForLeaf(node);
		}
//		public void visit(BreakNode node){
//			defaultVisitForLeaf(node);
//		}
//		public void visit(ContinueNode node){
//			defaultVisitForLeaf(node);
//		}

		public void visitEnter(BracketNode node)  {
			defaultVisitEnter(node);
		}
		public void visitLeave(BracketNode node)  {
			defaultVisitLeave(node);
		}

		public void visitEnter(IfStatementNode node)  {
			defaultVisitEnter(node);
		}
		public void visitLeave(IfStatementNode node)  {
			defaultVisitLeave(node);
		}

		public void visitEnter(WhileStatementNode node)  {
			defaultVisitEnter(node);
		}
		public void visitLeave(WhileStatementNode node)  {
			defaultVisitLeave(node);
		}

		public void visitEnter(ForStatementNode node)  {
			defaultVisitEnter(node);
		}
		public void visitLeave(ForStatementNode node)  {
			defaultVisitLeave(node);
		}

		public void visitEnter(BreakNode node)  {
			defaultVisitEnter(node);
		}
		public void visitLeave(BreakNode node)  {
			defaultVisitEnter(node);
		}

		public void visitEnter(ContinueNode node)  {
			defaultVisitLeave(node);
		}
		public void visitLeave(ContinueNode node)  {
			defaultVisitLeave(node);
		}
	}
}
