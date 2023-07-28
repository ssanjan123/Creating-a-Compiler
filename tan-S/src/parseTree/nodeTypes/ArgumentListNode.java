package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ArgumentListNode extends ParseNode {
    public ArgumentListNode(Token token) {
        super(token);
    }

    public ArgumentListNode(ParseNode node) {
        super(node);
    }

    // other methods...
    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}