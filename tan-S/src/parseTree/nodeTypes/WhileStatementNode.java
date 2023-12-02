package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class WhileStatementNode extends ParseNode {
    public WhileStatementNode(Token token) {
        super(token);
    }

    public WhileStatementNode(ParseNode node) {
        super(node);
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        visitChildren(visitor);
        visitor.visitLeave(this);
    }

}
