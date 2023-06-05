package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.PrimitiveType;
import tokens.CharacterToken;
import tokens.Token;

public class CharacterConstantNode extends ParseNode {
    private PrimitiveType type;
    public CharacterConstantNode(Token token) {
        super(token);
        this.type = PrimitiveType.CHARACTER;
        assert(token instanceof CharacterToken);
    }
    public CharacterConstantNode(ParseNode node) {
        super(node);
    }

////////////////////////////////////////////////////////////
// attributes

    public char getValue() {
        return characterToken().getValue();
    }

    public CharacterToken characterToken() {
        return (CharacterToken)token;
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
