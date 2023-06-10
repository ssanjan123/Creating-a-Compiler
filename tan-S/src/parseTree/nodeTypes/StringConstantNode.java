package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.PrimitiveType;
import tokens.StringToken;
import tokens.Token;

public class StringConstantNode extends ParseNode {
    private PrimitiveType type;

    public StringConstantNode(Token token) {
        super(token);
        this.type = PrimitiveType.STRING;
        assert(token instanceof StringToken);
    }

    public StringConstantNode(ParseNode node) {
        super(node);
    }

////////////////////////////////////////////////////////////
// attributes

    public String getValue() {
        return stringToken().getValue();
    }

    public StringToken stringToken() {
        return (StringToken)token;
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
