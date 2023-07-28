package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ParameterListNode extends ParseNode {
    public ParameterListNode(Token token) {
        super(token);
    }

    public ParameterListNode(ParseNode node) {
        super(node);
    }
    // other methods...
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
    // other methods...
}

