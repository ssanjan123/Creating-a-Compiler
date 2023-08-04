package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class CallNode extends ParseNode {
    public CallNode(Token token) {
        super(token);
    }

    public CallNode(ParseNode node) {
        super(node);
    }


    ///////////////////////////////////////////////////////////
    // boilerplate for visitors and factory methods

    public void accept(ParseNodeVisitor visitor) {
            visitor.visitEnter(this);
            super.visitChildren(visitor);
            visitor.visitLeave(this);
        }

    public static CallNode withChildren(Token token, ParseNode functionInvocation) {
        CallNode node = new CallNode(token);
        node.appendChild(functionInvocation);
        return node;
    }
}
