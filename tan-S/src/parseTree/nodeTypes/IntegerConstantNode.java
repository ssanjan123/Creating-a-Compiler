package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.PrimitiveType;
import tokens.NumberToken;
import tokens.Token;

public class IntegerConstantNode extends ParseNode {
	private PrimitiveType type;
	public IntegerConstantNode(Token token) {
		super(token);
		this.type = PrimitiveType.INTEGER;
		assert(token instanceof NumberToken);
	}
	public IntegerConstantNode(ParseNode node) {
		super(node);
	}

////////////////////////////////////////////////////////////
// attributes
	
	public int getValue() {
		return numberToken().getValue();
	}

	public NumberToken numberToken() {
		return (NumberToken)token;
	}
	@Override
	public PrimitiveType getType() {
		return this.type;
	}
///////////////////////////////////////////////////////////
// accept a visitor
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visit(this);
	}

}
