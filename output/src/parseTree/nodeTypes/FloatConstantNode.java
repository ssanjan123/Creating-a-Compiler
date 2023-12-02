package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.PrimitiveType;
import tokens.FloatToken;
import tokens.Token;

public class FloatConstantNode extends ParseNode {
    private PrimitiveType type;
    public FloatConstantNode(Token token) {
        super(token);
        this.type = PrimitiveType.FLOAT;
        assert(token instanceof FloatToken);
    }
    public FloatConstantNode(ParseNode node) {
        super(node);
    }

    ////////////////////////////////////////////////////////////////
    // attributes

    public float getValue() {
        return floatToken().getValue();
    }

    public FloatToken floatToken() {
        return (FloatToken)token;
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
