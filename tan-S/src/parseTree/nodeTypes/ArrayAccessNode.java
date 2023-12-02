package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ArrayAccessNode extends ParseNode {
    public ArrayAccessNode(Token token) {
        super(token);
    }

    public ArrayAccessNode(ParseNode node) {
        super(node);
    }

    public ParseNode getArrayExpressionNode() {
        return this.child(0);
    }
    public static ArrayAccessNode withChildren(ParseNode... children) {
        ArrayAccessNode node = new ArrayAccessNode(children[0].getToken());
        for (ParseNode child : children) {
            node.appendChild(child);
        }
        return node;
    }


    public ParseNode getIndexExpressionNode() {
        return this.child(1);
    }

    public void accept(ParseNodeVisitor visitor) {
        visitor.visitEnter(this);
        super.visitChildren(visitor);
        visitor.visitLeave(this);
    }
}
