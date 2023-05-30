package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.IdentifierToken;
import tokens.Token;

public class AssignmentNode extends ParseNode {

    public AssignmentNode(Token token) {
        super(token);
        assert(token instanceof IdentifierToken);
    }

    public static AssignmentNode withChildren(ParseNode target, ParseNode value) {
        AssignmentNode node = new AssignmentNode(target.getToken());
        node.appendChild(target);
        node.appendChild(value);
        return node;
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
