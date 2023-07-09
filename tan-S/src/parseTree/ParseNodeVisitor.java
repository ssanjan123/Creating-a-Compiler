package parseTree;

import parseTree.nodeTypes.*;
import parseTree.nodeTypes.IfStatementNode;

// Visitor pattern with pre- and post-order visits
public interface ParseNodeVisitor {
	
	// non-leaf nodes: visitEnter and visitLeave
	void visitEnter(OperatorNode node);
	void visitLeave(OperatorNode node);
	
	void visitEnter(MainBlockNode node);
	void visitLeave(MainBlockNode node);
	void visitEnter(BlockStatementNode node);
	void visitLeave(BlockStatementNode node);
	void visitEnter(DeclarationNode node);
	void visitLeave(DeclarationNode node);

	
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
	void visit(TabNode node);

	void visit(FloatConstantNode node);
	void visitEnter(TypecastNode node);
	void visitLeave(TypecastNode node);
	void visitEnter(ConstDeclarationNode node);
	void visitLeave(ConstDeclarationNode node);

	void visitEnter(VarDeclarationNode node);
	void visitLeave(VarDeclarationNode node);

	void visitEnter(AssignmentNode node);
	void visitLeave(AssignmentNode node);

	void visitEnter(BracketNode node);
	void visitLeave(BracketNode node);

	void visitEnter(IfStatementNode node);
	void visitLeave(IfStatementNode node);
	void visitEnter(WhileStatementNode node);
	void visitLeave(WhileStatementNode node);

    public static class Default implements ParseNodeVisitor
	{
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
	}
}
