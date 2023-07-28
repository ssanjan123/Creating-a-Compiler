package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import tokens.Token;

public class PrimitiveTypeNode extends ParseNode {
    public PrimitiveTypeNode(Token token) {
        super(token);
    }

    public PrimitiveTypeNode(ParseNode node) {
        super(node);
    }
    public static PrimitiveTypeNode withTypeToken(Token token) {
        return new PrimitiveTypeNode(token);
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }

    public PrimitiveType getAssociatedPrimitiveType() {
        return PrimitiveType.getTypeForToken(token);
    }

}
